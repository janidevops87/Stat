/***************************************************************************************************
**	Name: DropSprocs
**	Desc: Drop all the Sprocs for Tcss List Sprocs. THis need to be run multiple times to delete all
**			Sproc. Becuase some will fail the first time due to foreign keys
***************************************************************************************************/

DECLARE @SqlScript nvarchar(4000),
	@SprocName varchar(200)

DECLARE @SprocList TABLE
(
	SprocName varchar(200)
)

-- Grab all the Sprocs that has Tcss in the begining
INSERT @SprocList
	SELECT name FROM sysobjects WHERE xtype='P' AND name LIKE 'Tcss%'

SELECT TOP 1 @SprocName = SprocName FROM @SprocList order by SprocName
WHILE(@SprocName IS NOT NULL)
BEGIN
	SELECT @SqlScript = 
		'IF EXISTS(SELECT * FROM sysobjects WHERE xtype=''P'' AND name = ''' + @SprocName + ''')
			DROP Procedure ' + @SprocName + '
		'

	EXEC(@SqlScript)
		
			-- delete the job from the list
	DELETE FROM @SprocList WHERE SprocName = @SprocName
	-- set the current job to null
	SELECT @SprocName = null
	-- select the next 
	SELECT top 1 @SprocName = SprocName FROM @SprocList order by SprocName
	
END
GO



/***************************************************************************************************
**	Name: DropTables
**	Desc: Drop all the tables for Tcss List tables. THis need to be run multiple times to delete all
**			table. Becuase some will fail the first time due to foreign keys
***************************************************************************************************/

DECLARE @SqlScript nvarchar(4000),
	@TableName varchar(200)

DECLARE @TableList TABLE
(
	TableName varchar(200)
)

-- Grab all the Tables that has Tcss in the begining
INSERT @TableList
	SELECT name FROM sysobjects WHERE xtype='U' AND name LIKE 'Tcss%'

SELECT TOP 1 @TableName = TableName FROM @TableList order by TableName
WHILE(@TableName IS NOT NULL)
BEGIN
	SELECT @SqlScript = 
		'IF EXISTS(SELECT * FROM sysobjects WHERE xtype=''U'' AND name = ''' + @TableName + ''')
			DROP TABLE dbo.' + @TableName + '
		'

	EXEC(@SqlScript)
		
			-- delete the job from the list
	DELETE FROM @TableList WHERE TableName = @TableName
	-- set the current job to null
	SELECT @TableName = null
	-- select the next 
	SELECT top 1 @TableName = TableName FROM @TableList order by TableName
	
END


