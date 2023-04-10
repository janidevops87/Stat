 -- GENERATES EVERYTHING YOU NEED FOR UPDATE SPROC

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
		,@PKC1_DATATYPE VARCHAR(50)
		,@BINARY_WIDTH VARCHAR(50) 
		,@CHARACTER_MAXIMUM_LENGTH INT
		
		,@BitValue int
		,@count int
		,@subStart int
		,@subEnd int
		
		,@TableName VARCHAR(8000)
		,@SprocName	VARCHAR(8000)
		,@MySproc VARCHAR(8000)

		,@BitMapLogic VARCHAR(8000)
		,@CaseStuff VARCHAR(8000)
		,@ReviewStuff VARCHAR(8000)
		
		
		,@ProcParams VARCHAR(8000)
		,@Columns VARCHAR(8000)
		,@Values VARCHAR(8000)
		,@AlwaysNeeded VARCHAR(8000)		
		,@TableSchemaName VARCHAR(250)
		,@BuildDate VARCHAR(30)
		

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

-- I always forget what these are....
/*SELECT CHAR(10)
SELECT CHAR(44) --> , 
SELECT CHAR(32)
SELECT CHAR(64) --> @*/

SELECT @BuildDate = CONVERT(VARCHAR(25), GETDATE(), 101)

-- Change @TableName to relevant table. ------
--Change the Schema and Table every time
SET @TableSchemaName = 'DBO'
SET @TableName = 'BillTo'
IF UPPER(@TableSchemaName) != 'DBO'
	SET @SprocName = @TableSchemaName + '_spu_Audit_'  + @TableName
ELSE
	SET @SprocName = 'spu_Audit_'  + @TableName


SET @I = 1
SET @count  = 1
SET @subStart  = 0
SET @subEnd  = 1
SET @bitValue = 0

SET @ProcParams = ''
SET @Columns = ''
SET @Values = ''
SET @BitMapLogic = ''
SET @CaseStuff = ''
SET @PKC1_DATATYPE = ''
SET @BINARY_WIDTH = ''

SET NOCOUNT ON

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
SELECT @BINARY_WIDTH = @Row_Count/8 + 1

-- FOR EACH COLUMN, DO SOME STUFF.
WHILE @I < @Row_Count
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
		 
	SET @Count = @Count + 1

	SELECT 
		@ORDINAL_POSITION = ORDINAL_POSITION
		,@COLUMN_NAME = COLUMN_NAME
		,@DATA_TYPE = DATA_TYPE
		,@CHARACTER_MAXIMUM_LENGTH = CHARACTER_MAXIMUM_LENGTH 
	FROM #TempColumns WHERE TEMPIndex = @I

		-- PARAMETERS -----------------------------------------------------------------------------
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
		AS VARCHAR(150))
 
		-- COLUMNS -----------------------------------------------------------------------------
		SELECT @Columns = 
		CASE 
			WHEN @I > 1 THEN @Columns + CHAR(10) 
			ELSE @Columns END
		+ CAST(
		CASE
			WHEN @ORDINAL_POSITION > 1 THEN CHAR(44)
			ELSE CHAR(32)
		END
		 + '"' + @COLUMN_NAME + '"'  	
		AS VARCHAR(50))
			
		-- VALUES --------------------------------------------------------------------------------
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
			 + CHAR(64)+ @COLUMN_NAME  + CHAR(32) 
		AS VARCHAR(50))
		
		-- CASE STUFF ---------------------------------------------------------------------------------	
		SELECT @CaseStuff =	
		CASE 
			WHEN @I = 1 THEN '@PKC1,' 
			ELSE @CaseStuff + 
				CHAR(10) + 'CASE WHEN SUBSTRING(@Bitmap, ' + CONVERT(VARCHAR, @subStart) + ', '  
				+ CONVERT(VARCHAR, @subEnd) + ') & ' + CONVERT(VARCHAR, @bitValue) + ' = ' + CONVERT(VARCHAR, @bitValue) + 
				 
				CASE 		
   					WHEN @Data_Type like '%ntext%' THEN ' AND ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1000)), '''') = ''''' + ' THEN ''ILB'' '
					WHEN @Data_Type like '%char%' THEN ' AND ISNULL(@' + @Column_Name + ', '''') = ''''' + ' THEN ''ILB'' '
					WHEN @Data_Type like '%date%' THEN ' AND ISNULL(@' + @Column_Name + ', '''') = ''''' + ' THEN ''1900-01-01'' '
					WHEN @Data_Type like '%int' or @Data_Type like 'numeric' or @Data_Type like 'float'  or @Data_Type like 'decimal' or @Data_Type like 'tiny' THEN ' AND ISNULL(@' + @Column_Name + ', 0) = 0' + ' THEN -2'
					WHEN @Data_Type like '%uniqueidentifier' THEN ' AND ISNULL(@' + @Column_Name + ', ''FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'') = ''FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF''' + ' THEN ''FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'' '
					WHEN @Data_Type like '%bit' THEN ' AND ISNULL(@' + @Column_Name + ', 0) = 0 THEN 0'
					ELSE CHAR(10)+ 'DataType = ' + @Data_Type + CHAR(10) -- FOR DEBUGGING. DID I MISS ANY DATATYPES????
				END
				 + 
				CASE
					WHEN @I < @Row_Count-1 THEN ' ELSE @' + @Column_Name + ' END,'
					ELSE ' ELSE @' + @Column_Name + ' END'
				END				
		END
		
		
-- Review STUFF ---------------------------------------------------------------------------------
		SELECT @ReviewStuff =	
		CASE 
			WHEN @I = 1 THEN 'DECLARE @CheckForBlank VARCHAR(250); ' +
							 'SELECT @CheckForBlank = ' 
			ELSE @ReviewStuff + 
				CASE 		
 					WHEN @Data_Type like '%ntext%' THEN 'ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					WHEN @Data_Type like '%char%' THEN 'ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					WHEN @Data_Type like '%date%' THEN 'ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					WHEN @Data_Type like '%int' or @Data_Type like 'numeric' or @Data_Type like 'float'  or @Data_Type like 'decimal' or @Data_Type like 'tiny' THEN 'ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					WHEN @Data_Type like '%uniqueidentifier' THEN ' + ISNULL(CAST(@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					WHEN @Data_Type like '%bit' THEN 'ISNULL((@' + @Column_Name + ' AS VARCHAR(1)), '''')'
					ELSE CHAR(10)+ 'DataType = ' + @Data_Type + CHAR(10) -- FOR DEBUGGING. DID I MISS ANY DATATYPES????
			     END
			      +
			    CASE
					WHEN @I < @Row_Count-1 THEN ' + '
					ELSE '--If the only chnage to the record is date time --it is a review not update.	IF @CheckForBlank IS NULL BEGIN	SET @AuditLogTypeID = 2	END'
				END	
			  
		END			


SET @AlwaysNeeded = '
--For Tables the do not have LastStatEmployeeID
--we will hard code the ID to be a user named
--legacy data for the FDA audits.

SET @LastStatEmployeeID = Coalesce(@LastStatEmployeeID,2241);  '

		
		
		
		
		-- BITMAP LOGIC ------------------------------------------------------------------------------		 
		SELECT @BitMapLogic =	
		CASE 
			WHEN @I > 2 THEN @BitMapLogic + CHAR(10) + 'AND SUBSTRING(@Bitmap, ' + CONVERT(VARCHAR, @subStart) + ', '  + CONVERT(VARCHAR, @subEnd) + ') & ' + CONVERT(VARCHAR, @bitValue) + ' <> ' + CONVERT(VARCHAR, @bitValue)
			ELSE 'SUBSTRING(@Bitmap, ' + CONVERT(VARCHAR, @subStart) + ', ' + CONVERT(VARCHAR, @subEnd) + ') & ' + CONVERT(VARCHAR, @bitValue) + ' <> ' + CONVERT(VARCHAR, @bitValue)
		END		
		+ ' --' + @COLUMN_NAME  + CHAR(32)  
		
		-- PRIMARY KEY -------------------------------------------------------------------------------		
		SELECT @PKC1_DATATYPE =	
		CASE 
			WHEN @I = 1 THEN @Data_Type
			ELSE @PKC1_DATATYPE
		END		

 		
		-- ADD ONE TO @I ------------------------------------------------------------------------;
		SET @I = @I+1
END

SET @ProcParams = @ProcParams + CHAR(10) + ',@PKC1 ' + @PKC1_DATATYPE 
SET @ProcParams = @ProcParams + CHAR(10) + ',@Bitmap binary(' + @BINARY_WIDTH + ')'
-- SELECT @ProcParams

SET NOCOUNT OFF

-- GENERATE THE BOILERPLATE TEXT AND PUT IN THE COLUMNS -----------------------------------------------------------------
SET @mysproc = 
'/******************************************************************************
**		File: 
**		Name: ' + @SprocName + '.sql
**		Desc: 
**
**		Date:					Author:				Description:
**		--------				--------			-------------------------------------------
**		'+@BuildDate +'		Steve Barron		Update Audit records for ' + @TableSchemaName + '.' + @TableName +
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
	 
SET @mysproc = @mysproc + @ProcParams +

'
)
AS
IF NOT (' +
@BitmapLogic + 
'
) 
BEGIN 
insert into ' + @TableSchemaName + '.' + @TableName +
'
(
' + @Columns +
'
)' +

'
VALUES 
( 
'
+ @CaseStuff --@Values  -- @CaseStuff
+ '
)' +
'
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
'

--SELECT @Columns
--SELECT @Values
--SELECT * FROM #BitMap 
--SELECT @BitMapLogic
--SELECT @CaseStuff

SELECT @mysproc AS SPROC
SELECT @ReviewStuff AS ReviewStuff
SELECT @CaseStuff AS CASESTUFF
SELECT @AlwaysNeeded AS ALWAYSNEEDED

DROP TABLE #TempColumns
DROP TABLE #BitMap