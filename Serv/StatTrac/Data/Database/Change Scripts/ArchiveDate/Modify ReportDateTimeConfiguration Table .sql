 /* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
IF EXISTS
(
	select 

		so.name 'table name', 
		sc.name 'column name', 
		case 
			when st.name like '%id%' then st.name + '(' + convert(varchar, sc.length) + ')'
		else st.name
		end 
		,sc.colorder 

	from 
		sysobjects so
	join 
		syscolumns sc on sc.id = so.id 
	join 
		systypes st on st.xtype = sc.xtype
	where 
	so.xtype = 'U'
	and sc.name like 'IsArchived'
	and so.name like 'ReportDateTimeConfiguration'

)
BEGIN
	GOTO DoNotRun
END
	
	PRINT 'Creating IsArchived Column'
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	--GO
	ALTER TABLE dbo.ReportDateTimeConfiguration 
		ADD	
		IsArchived bit NOT NULL CONSTRAINT DF_ReportDateTimeConfiguration_IsArchived DEFAULT 0,
		IsDateOnly bit NOT NULL CONSTRAINT DF_ReportDateTimeConfiguration_IsDateOnly DEFAULT 0
	--GO
	COMMIT


DoNotRun:
	PRINT 'Column IsArchived Exists'


