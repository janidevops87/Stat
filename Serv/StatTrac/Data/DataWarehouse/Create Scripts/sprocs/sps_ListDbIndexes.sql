SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListDbIndexes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListDbIndexes]
GO

CREATE PROCEDURE sps_ListDbIndexes

AS

/*
  Returns a list of tables in a database along with the indexes attached to them.
  Created 3/9/05 by Scott Plummer

*/
SET NOCOUNT ON

DECLARE @tblName varchar(50)


CREATE TABLE #idxtab
	(
	table_name Varchar(255),
	index_name Varchar(255),
	index_description Varchar(255),
	index_keys Varchar(255)
	)

DECLARE tblList CURSOR FOR SELECT [name] FROM sysobjects WHERE xtype = 'U' ORDER BY [name]

OPEN tblList

FETCH NEXT FROM tblList INTO @tblName

	--Print @tblName

-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
WHILE @@FETCH_STATUS = 0
BEGIN

   -- Insert the
   INSERT INTO #idxtab (index_name, index_description, index_keys)
		exec sp_helpindex @tblName;
   -- Update the table with the name of the most recently queried table.
   UPDATE #idxtab SET [table_name] = @tblName WHERE [table_name] IS NULL;

   -- This is executed as long as the previous fetch succeeds.
   FETCH NEXT FROM tblList INTO @tblName;
	--Print @tblName
END

DEALLOCATE tblList


(SELECT [table_name], 
	CASE RIGHT(index_description, 7) 
		WHEN ' on IDX' THEN 'IDX'
		ELSE RIGHT(index_description, 7)
		END AS index_location, index_name, index_description, index_keys 
	FROM #idxtab)
UNION
(SELECT [name] AS [table_name],
	'' AS index_location,
	'---'AS index_name, '---' AS index_description, '---' AS index_keys 
	FROM sysobjects WHERE xtype = 'U'
	AND [name] NOT IN
	(SELECT DISTINCT [table_name] FROM #idxtab))

ORDER BY [table_name], index_location DESC, index_name;

DROP TABLE #idxtab
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

