
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_DataCleanupReplaceEmptyString]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_DataCleanupReplaceEmptyString'
	drop procedure [dbo].[spu_DMVIMPORT_DataCleanupReplaceEmptyString]
End
GO

	PRINT 'Creating spu_DMVIMPORT_DataCleanupReplaceEmptyString'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE spu_DMVIMPORT_DataCleanupReplaceEmptyString AS
/******************************************************************************
**		File: spu_DMVIMPORT_DataCleanupReplaceEmptyString.sql
**		Name: spu_DMVIMPORT_DataCleanupReplaceEmptyString
**		Desc: Cleans data by replacing empty strings
**
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/
declare @tbl as varchar(255), 
        @col as varchar(255), 
        @sql as varchar(255)
declare cIMPORTTBL cursor for 
 select TableName
   from DMVIMPORTFILES 
   order by WorkOrder
open cIMPORTTBL
fetch next from cIMPORTTBL into @tbl 
 while @@fetch_status = 0
 begin
   RAISERROR (@tbl,1,1)with LOG
      declare cIMPORT cursor for 
         Select c.name 
         from sysobjects o, syscolumns c
         where c.id = o.id
         and o.name = @tbl
         and c.name <> 'ID'
         order by c.colid
      open cIMPORT
      fetch next from cIMPORT into @col 
      while @@fetch_status = 0
        begin
   select @sql = "update " + @tbl + " set " + @col + " = NULL where rtrim(ltrim(" + @col + ")) = ''"
   exec (@sql)
   fetch next from cIMPORT into @col
        end
     close cIMPORT
     deallocate cIMPORT
     fetch next from cIMPORTTBL into @tbl 
  end
close cIMPORTTBL
deallocate cIMPORTTBL

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
