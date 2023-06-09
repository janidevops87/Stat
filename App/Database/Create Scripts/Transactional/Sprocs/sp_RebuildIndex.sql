SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RebuildIndex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RebuildIndex]
GO






CREATE    Procedure sp_RebuildIndex 
	@RebuildAll int	=0

AS

        -- 1. Replace MSDB.DBO._ReferralProdIndexStatus with current databases name.
        -- declare variables
        
        -- check for table in MSDB with name of databaseindexstatus ie _ReferralProdIndexStatus
        -- TableName, LastRun  
	
	--	DROP TABLE [MSDB].[dbo].[_ReferralProdIndexStatus]
	--	GO
        --	CREATE TABLE [MSDB].[dbo].[_ReferralProdIndexStatus] (
	--	[TableName] [varchar] (50) NULL ,
	--	[IndexName] [varchar] (100) null,	
	--	[LastRun] [smalldatetime] NULL 
        --	) ON [PRIMARY]
        --	GO
	 

	DECLARE	@tableName	varchar(50)
	DECLARE @indexName	varchar(100)
        DECLARE @LastRun        smalldatetime

        SELECT @LastRun = null


        -- declare cursor of tablenames in database
	DECLARE	idx_cursor	CURSOR
	FOR
		SELECT	distinct a.name, b.name
		FROM	sysobjects a,sysindexes b
		WHERE	a.type = 'U'
		AND	a.id = b.id
		AND	b.indid > 0
		AND	(
			b.indid not in (0, 255) 
			AND (INDEXPROPERTY ( b.id , b.name , 'IsStatistics' ) <> 1 
			AND INDEXPROPERTY ( b.id , b.name , 'IsHypothetical' ) <> 1) 
			)
	
		ORDER BY 1	

	OPEN	idx_cursor
	

	fetch next from idx_cursor into @tableName, @indexName

	while @@fetch_status = 0
	  BEGIN
            
            -- check for table name in databaseindexstatus table
            -- if last index rebuild is greater than 1 week rebuild index
            SELECT	@LastRun = LastRun 
	    FROM 	MSDB.DBO._ReferralProdIndexStatus 
	    WHERE 	TableName = @tableName
	    AND		IndexName = @indexName
 
            If @LastRun is null 
                 BEGIN
                   INSERT MSDB.DBO._ReferralProdIndexStatus Values(@tableName, @indexName,GetDate())
			PRINT("DBCC DBREINDEX ([" + @tableName + "], [" + @indexName +"])")
              	    EXEC ("DBCC DBREINDEX ([" + @tableName + "], [" + @indexName +"])")

                   -- Exit while Loop
		   IF @RebuildAll = 0 BREAK
                 END   

            If DATEDIFF(D,@LastRun,GetDate()) > 6
                 BEGIN
                   UPDATE MSDB.DBO._ReferralProdIndexStatus SET LastRun = GetDate() WHERE TableName = @tableName and IndexName = @indexName
			PRINT("DBCC DBREINDEX ([" + @tableName + "], [" + @indexName +"])")
              	    EXEC ("DBCC DBREINDEX ([" + @tableName + "], [" + @indexName +"])")
		   -- Exit while Loop
                   IF @RebuildAll = 0 BREAK
                 END   
	    
            FETCH NEXT FROM idx_cursor INTO @tableName, @indexName
            SELECT @LastRun = null
	    --WAITFOR DELAY '000:00:30'
		
	  END
	DEALLOCATE idx_cursor


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

