SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_AuditBuildOneToMany]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_AuditBuildOneToMany]
GO


CREATE PROCEDURE spu_AuditBuildOneToMany
	@AuditLogId varchar(100),
	@FieldName varchar(100),		--Audit field
	@RecordTypeId varchar(100),		--Audit Log record type id
	@StageTable varchar(100),		--Audit staging table
	@RefTable varchar(100) = '',		--Audit field reference table (optional)
	@RefFieldId varchar(100) = '',		--Audit field reference table id field (optional)
	@RefFieldName varchar(100) = '',	--Audit field reference table name field (optional)
	@FieldDefault varchar(100) = "''",		--Audit field default value
	@PrintTestQuery int = 0			--Test Query


AS

DECLARE @vQuery  varchar(8000)

SET NOCOUNT ON
SET QUOTED_IDENTIFIER OFF

	--Note: This query 

	SET @vQuery = CASE @PrintTestQuery 
				WHEN 1 THEN ""
				WHEN 0 THEN "INSERT AuditLogDetail(AuditLogId, AuditLogDetailFieldName, AuditLogDetailPreviousValue, AuditLogDetailNewValue)" + CHAR(13)
			END

	SET @vQuery = @vQuery + "SELECT al.AuditLogId as 'AuditLogId'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "'" + @FieldName + "' as 'AuditLogDetailFieldName'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "NULL as 'AuditLogDetailPreviousValue'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "ISNULL(ref1." + @RefFieldName + ", '') as 'AuditLogDetailNewValue'" + CHAR(13)
	SET @vQuery = @vQuery + "FROM AuditLog al" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "JOIN " + @StageTable + " stg1 ON al.AuditLogId = stg1.AuditLogId" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "LEFT JOIN " + @RefTable + " ref1 ON stg1." + @FieldName + " = ref1." + @RefFieldId + CHAR(13)
	SET @vQuery = @vQuery + "WHERE al.AuditLogRecordTypeId = " + @RecordTypeId + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogTypeId = 3" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogStatusId = 2" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg1.AuditLogTypeId = 3" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogId = " + @AuditLogId + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg1." + @RefFieldId + " NOT IN " + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "(SELECT stg2." + @RefFieldId + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "FROM AuditLog al2" + CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "JOIN " + @StageTable + " stg2 ON al2.AuditLogId = stg2.AuditLogId" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "WHERE al2.AuditLogRecordTypeId = " + @RecordTypeId + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogTypeId = 3" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogStatusId = 2" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg2.AuditLogTypeId = 5" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogId = " + @AuditLogId + ")"

--PRINT THE QUERY IF TESTING
IF @PrintTestQuery = 1
	SELECT @vQuery as 'Dynamic One-To-Many Query - ADDED'


--EXECUTE THE QUERY
EXEC ( @vQuery )
	

	--Note: This type inserts detail records for modifications; Value fields contain actual staging field value
		--Use this query for text fields where the actual text is stored in the field

	SET @vQuery = CASE @PrintTestQuery 
				WHEN 1 THEN ""
				WHEN 0 THEN "INSERT AuditLogDetail(AuditLogId, AuditLogDetailFieldName, AuditLogDetailPreviousValue, AuditLogDetailNewValue)" + CHAR(13)
			END

	SET @vQuery = @vQuery + "SELECT al.AuditLogId as 'AuditLogId'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "'" + @FieldName + "' as 'AuditLogDetailFieldName'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "ISNULL(ref1." + @RefFieldName + ", '') as 'AuditLogDetailPreviousValue'," + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "NULL as 'AuditLogDetailNewValue'" + CHAR(13)
	SET @vQuery = @vQuery + "FROM AuditLog al" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "JOIN " + @StageTable + " stg1 ON al.AuditLogId = stg1.AuditLogId" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "LEFT JOIN " + @RefTable + " ref1 ON stg1." + @FieldName + " = ref1." + @RefFieldId + CHAR(13)
	SET @vQuery = @vQuery + "WHERE al.AuditLogRecordTypeId = " + @RecordTypeId + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogTypeId = 3" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogStatusId = 2" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg1.AuditLogTypeId = 5" + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND al.AuditLogId = " + @AuditLogId + CHAR(13) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg1." + @RefFieldId + " NOT IN " + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "(SELECT stg2." + @RefFieldId + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "FROM AuditLog al2" + CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "JOIN " + @StageTable + " stg2 ON al2.AuditLogId = stg2.AuditLogId" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "WHERE al2.AuditLogRecordTypeId = " + @RecordTypeId + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogTypeId = 3" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogStatusId = 2" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND stg2.AuditLogTypeId = 3" + CHAR(13) + CHAR(9) + CHAR(9)
	SET @vQuery = @vQuery + "AND al2.AuditLogId = " + @AuditLogId + ")"

--PRINT THE QUERY IF TESTING
IF @PrintTestQuery = 1
	SELECT @vQuery as 'Dynamic One-To-Many Query - REMOVED'


--EXECUTE THE QUERY
EXEC ( @vQuery )



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

