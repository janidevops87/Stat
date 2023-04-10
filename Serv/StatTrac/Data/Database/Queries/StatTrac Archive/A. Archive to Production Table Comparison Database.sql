 --- This script compare _ReferralArchive to _ReferralProdReport to ensure table names, columns and column sizes are accurate.
 
 
 -- Appendix A:     Archive-to-Production Table Comparison.sql
-- Script:  Archive-to-Production Table Comparison.sql


-- Look for tables containing "Callid"
--Use _ReferralProd
go

DECLARE @tblInfo TABLE (ColumnName VARCHAR(128),
			TableName VARCHAR (128),
			[Id] integer,
			ArcTableName VARCHAR (128),
			ArcId integer )

DECLARE @tablesOnly VARCHAR(1)
DECLARE @fieldView VARCHAR(1) 
DECLARE @eachTable VARCHAR(1)

SET @tablesOnly = 'N'  -- Set this to 'Y' to view table-only comparison

SET @fieldView = 'Y'  -- Set this to 'Y' to view each field in the tables, side-by-side

SET @eachTable = 'N'  -- Set this to 'Y' to view each set of tables, original and archive, in two separate queries


INSERT INTO @tblInfo (ColumnName, TableName, [ID])
SELECT 	_ReferralProdReport.DBO.syscolumns.name as ColumnName, 
	_ReferralProdReport.dbo.sysobjects.name as TableName,
	sysobjects.id

FROM 	syscolumns 

	JOIN sysobjects  
	ON sysobjects.id = syscolumns.id

WHERE sysobjects.xtype = 'U'
	AND (syscolumns.name Like '%callid%' OR syscolumns.name = 'referralId')
	AND _ReferralProdReport.DBO.sysobjects.name NOT LIKE 'archive%'
	AND _ReferralProdReport.DBO.sysobjects.name NOT LIKE 'Audit%'
;

UPDATE @tblInfo SET ArcId = (SELECT id FROM _ReferralProdArchive.DBO.sysobjects WHERE _ReferralProdArchive.DBO.sysobjects.name = tablename);

UPDATE @tblInfo SET ArcTableName = (SELECT name FROM _ReferralProdArchive.DBO.sysobjects WHERE _ReferralProdArchive.DBO.sysobjects.id = ArcId);

If @tablesOnly = 'Y' 
	BEGIN
		-- Run this query to show tables missing in Archive
		SELECT TableName, IsNull(ArcTableName, '*** MISSING ***'), *
		FROM @tblInfo
		ORDER BY tableName
	END


If @fieldView = 'Y'
	BEGIN
		-- Run this query to show fields and data types in original tables, compared with archive tables
		SELECT 	TI.TableName, 
			SY.name AS ColumnName, 
			ST.name AS DataType, 
			SY.length,
			(SELECT arcCol.length FROM _ReferralProdArchive.DBO.syscolumns arcCol WHERE arcCol.name = SY.name AND arcCol.id = TI.arcId) AS ArcLength,
			(SELECT arcType.name FROM _ReferralProdArchive.DBO.systypes arcType JOIN _ReferralProdArchive.DBO.syscolumns arcCol ON arcType.usertype = arcCol.usertype WHERE arcCol.name = SY.name AND arcCol.id = TI.arcId) AS ArcType,
			(SELECT arcCol.name FROM _ReferralProdArchive.DBO.syscolumns arcCol WHERE arcCol.name = SY.name AND arcCol.id = TI.arcId) AS ArcColumn,
			(SELECT SY.length - arcCol.length FROM _ReferralProdArchive.DBO.syscolumns arcCol WHERE arcCol.name = SY.name AND arcCol.id = TI.arcId) AS SizeDiff

			
	
		FROM @tblInfo TI
			JOIN _ReferralProdReport.DBO.syscolumns SY
				ON TI.id = SY.id
			JOIN _ReferralProdReport.DBO.systypes ST
				ON SY.usertype = ST.usertype 
		ORDER BY tablename,columnname;
	END

If @eachTable = 'Y'
	BEGIN
		-- Run this query to show fields and data types in original tables
		SELECT 	TI.TableName, 
			SY.name AS ColumnName, 
			ST.name AS DataType, 
			SY.length
		FROM @tblInfo TI
			JOIN syscolumns SY
				ON TI.id = SY.id
			JOIN systypes ST
				ON SY.usertype = ST.usertype 
		ORDER BY tablename,columnname;

		-- Run this query to show fields and data types in ARCHIVE tables
		SELECT 	TI.ArcTableName, 
			SY.name AS ColumnName, 
			ST.name AS DataType, 
			SY.length
		FROM @tblInfo TI
			JOIN syscolumns SY
				ON TI.ArcId = SY.id
			JOIN systypes ST
				ON SY.usertype = ST.usertype 
		ORDER BY tablename,columnname;
	END