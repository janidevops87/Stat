SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateDBUsage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateDBUsage]
GO



Create Procedure sp_UpdateDBUsage 
	@RebuildAll int	=0

AS

        -- 1. Replace MSDB.DBO._ReferralProdUpdateDBUsageStatus with current databases name.
        -- declare variables
        
        -- check for table in MSDB with name of databaseindexstatus ie _ReferralProdUpdateDBUsageStatus
        -- TableName, LastRun  
	
        --     CREATE TABLE [MSDB].[dbo].[_ReferralProdUpdateDBUsageStatus] (
	--    [TableName] [varchar] (50) NULL ,
	--    [IndexName] [varchar] (100) null,	
	--    [LastRun] [smalldatetime] NULL 
        --     ) ON [PRIMARY]
        --     GO
	 

	DECLARE	@tableName	varchar(50)
	DECLARE @indexName	varchar(100)
        DECLARE @LastRun        smalldatetime
	DECLARE @dbName		varchar(50)
	DECLARE @indexID	varchar(3)

	--Set @dbName 
	SELECT @dbName = DB_Name()

	
        SELECT @LastRun = null


        -- declare cursor of tablenames in database
	DECLARE	idx_cursor	CURSOR
	FOR
		SELECT	distinct a.name, b.name, b.indid
		FROM	sysobjects a,sysindexes b
		WHERE	a.type = 'U'
		AND	a.id = b.id
		AND	b.indid > 0
	OPEN	idx_cursor


	fetch next from idx_cursor into @tableName, @indexName, @indexID

	while @@fetch_status = 0
	  BEGIN
            
            -- check for table name in databaseindexstatus table
            -- if last index rebuild is greater than 1 week rebuild index
            SELECT	@LastRun = LastRun 
	    FROM 	MSDB.DBO._ReferralProdUpdateDBUsageStatus 
	    WHERE 	TableName = @tableName
	    AND		IndexName = @indexName
 
            If @LastRun is null 
                 BEGIN
                   INSERT MSDB.DBO._ReferralProdUpdateDBUsageStatus Values(@tableName, @indexName,GetDate())
              	   EXEC ("DBCC UPDATEUSAGE (" + @dbName + ", " + @tableName + ", " + @indexID +")")
                   -- Exit while Loop
		   IF @RebuildAll = 0 BREAK
                 END   

            If DATEDIFF(WW,@LastRun,GetDate()) > 1
                 BEGIN
                   UPDATE MSDB.DBO._ReferralProdUpdateDBUsageStatus SET LastRun = GetDate() WHERE TableName = @tableName
              	   EXEC ("DBCC UPDATEUSAGE (" + @dbName + ", " + @tableName + ", " + @indexID +")")
		   -- Exit while Loop
                   IF @RebuildAll = 0 BREAK
                 END   
	    
            FETCH NEXT FROM idx_cursor INTO @tableName, @indexName,@indexID
            SELECT @LastRun = null
	  END
	DEALLOCATE idx_cursor


             




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

