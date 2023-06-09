SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sp_RebuildIndex    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RebuildIndex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RebuildIndex]
GO




Create Procedure sp_RebuildIndex 
 @RebuildAll int =0
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
        -- 1. Replace MSDB.DBO.DMV_COIndexStatus with current databases name.
        -- declare variables
        
        -- check for table in MSDB with name of databaseindexstatus ie DMV_COIndexStatus
        -- TableName, LastRun  
 
        --     CREATE TABLE [MSDB].[dbo].[DMV_COIndexStatus] (
 --    [TableName] [varchar] (50) NULL ,
 --    [IndexName] [varchar] (100) null, 
 --    [LastRun] [smalldatetime] NULL 
        --     ) ON [PRIMARY]
        --     GO
  
 DECLARE @tableName varchar(50)
 DECLARE @indexName varchar(100)
        DECLARE @LastRun        smalldatetime
        SELECT @LastRun = null
        -- declare cursor of tablenames in database
 DECLARE idx_cursor CURSOR
 FOR
  SELECT distinct a.name, b.name
  FROM sysobjects a,sysindexes b
  WHERE a.type = 'U'
  AND a.id = b.id
  AND b.indid > 0
 OPEN idx_cursor
 fetch next from idx_cursor into @tableName, @indexName
 while @@fetch_status = 0
   BEGIN
            
            -- check for table name in databaseindexstatus table
            -- if last index rebuild is greater than 1 week rebuild index
            SELECT @LastRun = LastRun 
     FROM  MSDB.DBO.DMV_COIndexStatus 
     WHERE  TableName = @tableName
     AND  IndexName = @indexName
 
            If @LastRun is null 
                 BEGIN
                   INSERT MSDB.DBO.DMV_COIndexStatus Values(@tableName, @indexName,GetDate())
                  EXEC ("DBCC DBREINDEX (" + @tableName + ", " + @indexName +")")
                   -- Exit while Loop
     IF @RebuildAll = 0 BREAK
                 END   
            If DATEDIFF(WW,@LastRun,GetDate()) > 1
                 BEGIN
                   UPDATE MSDB.DBO.DMV_COIndexStatus SET LastRun = GetDate() WHERE TableName = @tableName
                  EXEC ("DBCC DBREINDEX (" + @tableName + ", " + @indexName +")")
     -- Exit while Loop
                   IF @RebuildAll = 0 BREAK
                 END   
     
            FETCH NEXT FROM idx_cursor INTO @tableName, @indexName
            SELECT @LastRun = null
   END
 DEALLOCATE idx_cursor
             




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

