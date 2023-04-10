if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_DataCleanupReplaceEmptyString]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spu_IMPORT_DataCleanupReplaceEmptyString]
End
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE spu_IMPORT_DataCleanupReplaceEmptyString AS
/*

*/
declare @tbl as varchar(255), 
        @col as varchar(255), 
        @sql as varchar(255)
declare cIMPORTTBL cursor for 
 select TableName
   from IMPORTFILES 
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

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_DataCleanupReplaceEmptyString create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_DataCleanupReplaceEmptyString Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

