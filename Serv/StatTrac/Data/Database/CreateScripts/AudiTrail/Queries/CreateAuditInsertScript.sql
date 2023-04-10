-- GENERATES EVERYTHING YOU NEED FOR INSERT..

IF object_id('tempdb..#TempColumns') IS NOT NULL
BEGIN
   DROP TABLE #TempColumns
END

IF object_id('tempdb..#BitMap') IS NOT NULL
BEGIN
   DROP TABLE #BitMap
END

DECLARE @I as int
		,@Row_Count int
		,@ORDINAL_POSITION INT
		,@COLUMN_NAME VARCHAR(50)
		,@DATA_TYPE VARCHAR(50)
		,@CHARACTER_MAXIMUM_LENGTH INT
		
		,@BitValue int
		,@count int
		,@subStart int
		,@subEnd int
		
		,@TableName VARCHAR(8000)
		,@SprocName	VARCHAR(8000)
		,@MySproc VARCHAR(8000)

		,@ProcParams VARCHAR(8000)
		,@Columns VARCHAR(8000)
		,@Values VARCHAR(8000)
		,@TableSchemaName VARCHAR(250)
		,@BuildDate VARCHAR(30)

SET NOCOUNT ON
SET @I = 1

CREATE TABLE #BitMap 
	(
		id INT IDENTITY(1,1),
		colorder int,
		subStart int,
		subEnd int,
		bitValue int
	)

CREATE TABLE #TempColumns
(
	TEMPIndex int identity(1,1) not null
	,ORDINAL_POSITION INT
	,COLUMN_NAME VARCHAR(50)
	,DATA_TYPE VARCHAR(50)
	,CHARACTER_MAXIMUM_LENGTH INT
)

set @count  = 1
set @subStart  = 0
set @subEnd  = 1
set @bitValue = 0
WHILE @count  <= 350
BEGIN
	SET @BitValue = 
		CASE 
			WHEN @BitValue = 0 THEN 1 
			WHEN @BitValue >= 128 THEN 1
		ELSE @BitValue + @BitValue END

	SET @subStart = 
		CASE
			WHEN @BitValue = 1 THEN @SubStart + 1
		ELSE @subStart END
	

	INSERT #BitMap
	VALUES(@count, @subStart, @subEnd, @bitValue)

	SET @Count = @Count + 1
END

SELECT @BuildDate = CONVERT(VARCHAR(25), GETDATE(), 101)
SET @ProcParams = ''
SET @Columns = ''
SET @Values = ''
SET @I = 1
--Change the Schema and Table every time
SET @TableSchemaName = 'DBO'
SET @TableName = 'Alert'
IF UPPER(@TableSchemaName) != 'DBO'
	SET @SprocName = @TableSchemaName + '_spi_Audit_'  + @TableName
ELSE
	SET @SprocName = 'spi_Audit_'  + @TableName



INSERT INTO #TempColumns
(	ORDINAL_POSITION 
	,COLUMN_NAME 
	,DATA_TYPE 
	,CHARACTER_MAXIMUM_LENGTH 
)

SELECT
	 IC.ORDINAL_POSITION
	,IC.COLUMN_NAME
	,IC.DATA_TYPE
	,IC.CHARACTER_MAXIMUM_LENGTH
FROM information_schema.columns IC 
WHERE	SUBSTRING(IC.table_name,1,2) != 'VW' AND
		SUBSTRING(IC.table_name,1,3 )!= 'sys' AND
		SUBSTRING(IC.table_name,1,3 )!= 'syn' AND 
		IC.TABLE_NAME = @TableName AND
		IC.TABLE_SCHEMA = @TableSchemaName
ORDER BY IC.TABLE_NAME, ORDINAL_POSITION

SELECT @Row_Count = COUNT(*) + 1 FROM #TempColumns

WHILE @I < @Row_Count
BEGIN

	SELECT 
		@ORDINAL_POSITION = ORDINAL_POSITION
		,@COLUMN_NAME = COLUMN_NAME
		,@DATA_TYPE = DATA_TYPE
		,@CHARACTER_MAXIMUM_LENGTH = CHARACTER_MAXIMUM_LENGTH 
	FROM #TempColumns WHERE TEMPIndex = @I

	SELECT @ProcParams = 
	CASE 
		WHEN @I > 1 THEN @ProcParams + CHAR(10) 
		ELSE @ProcParams 
	END
		+CAST(
		CASE
			WHEN @ORDINAL_POSITION > 1 THEN CHAR(44)
			ELSE CHAR(32)
		END
		 + CHAR(64)+ @COLUMN_NAME+ CHAR(32) + @DATA_TYPE +
			CASE
				WHEN @CHARACTER_MAXIMUM_LENGTH IS NULL THEN CHAR(32)
				WHEN @DATA_TYPE = 'ntext' THEN CHAR(32)
				ELSE CHAR(40) + CAST(@CHARACTER_MAXIMUM_LENGTH as VARCHAR(4)) + CHAR(41)
			END		
		AS VARCHAR(50))

	SELECT @Columns = 
	CASE WHEN @I > 1 THEN @Columns + CHAR(10) ELSE @Columns END
		+CAST(
		CASE
			WHEN @ORDINAL_POSITION > 1 THEN CHAR(44)
			ELSE CHAR(32)
		END
		 + '"' + @COLUMN_NAME + '"' -- +  -- + @DATA_TYPE +
			--CASE
			--	WHEN @CHARACTER_MAXIMUM_LENGTH IS NULL THEN CHAR(32)
			--	ELSE CHAR(40) + CAST(@CHARACTER_MAXIMUM_LENGTH as VARCHAR(4)) + CHAR(41)
			--END		
		AS VARCHAR(50))
			
	 -- select char(10)
	 -- select char(32)
	 -- select char(44) ,
	 -- select char(64) @

		SELECT @Values = 
		CASE 
			WHEN @I > 1 THEN @Values + CHAR(10) 
			ELSE @Values 
		END
		+CAST(
		CASE
			WHEN @ORDINAL_POSITION > 1 THEN CHAR(44)
			ELSE CHAR(32)
		END
		 + 
		 CASE WHEN @COLUMN_NAME = 'AuditLogTypeID' THEN '1'
			ELSE CHAR(64)+ @COLUMN_NAME
		 END		  
	      + CHAR(32) 
		AS VARCHAR(50))
		

		-- ADD ONE TO @I ----------------------;
		SET @I = @I+1

END

SET NOCOUNT OFF


SET @mysproc = 
'/******************************************************************************
**		File: 
**		Name: ' + @SprocName + '.sql
**		Desc: 
**
**		Date:				Author:				Description:
**		--------			--------			-------------------------------------------
**		'+@BuildDate +' 	Steve Barron		Insert Audit records for ' + @TableSchemaName + '.' + @TableName +
'**		
*******************************************************************************/' +


'SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON   
GO 
if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[' +
@SprocName +
']'') and OBJECTPROPERTY(id,N''IsProcedure'') = 1) BEGIN drop procedure [dbo].[' +
@SprocName + ']'  +
'PRINT ''Drop Sproc: ' + @SprocName + '''
END 
GO ' +

'PRINT ''Create Sproc: ' + @SprocName + '''
GO

create procedure "' + @SprocName + '"' 
+ '
(
' 
	 

SET @mysproc = @mysproc + @ProcParams

SET @mysproc = @mysproc + 
'
)
AS
BEGIN ' +
'--Legacy Tables do not have the Last Employee ID 
--We are adding Legacy Data until the code and tables
--can be modified.
SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  ' +


'insert into ' + @TableSchemaName + '.' + @TableName +
'
(
' + @Columns +
'
)' +
'
VALUES 
( 
'
+ @Values
+ '
)' +
'
END

GO SET QUOTED_IDENTIFIER OFF 
GO SET ANSI_NULLS ON 
GO
'
-- SELECT @Columns
-- SELECT @Values
-- SELECT * FROM #BitMap 

SELECT @mysproc

DROP TABLE #TempColumns
DROP TABLE #BitMap