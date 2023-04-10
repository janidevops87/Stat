
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_DataCleanupTrimBlanks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_DataCleanupTrimBlanks'
	drop procedure [dbo].[spu_DMVIMPORT_DataCleanupTrimBlanks]
End
GO

	PRINT 'Creating spu_DMVIMPORT_DataCleanupTrimBlanks'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE spu_DMVIMPORT_DataCleanupTrimBlanks AS
/******************************************************************************
**		File: spu_DMVIMPORT_DataCleanupTrimBlanks.sql
**		Name: spu_DMVIMPORT_DataCleanupTrimBlanks
**		Desc: Cleans and trims blanks
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
	 and c.name <> 'MIDDLE'
         order by c.colid
      open cIMPORT
      fetch next from cIMPORT into @col 
      while @@fetch_status = 0
        begin
	select @sql = "update " + @tbl + " set " + @col + " = rtrim(ltrim(" + @col + "))"   
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

