SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupTrimBlanks    Script Date: 5/14/2007 10:02:44 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_DataCleanupTrimBlanks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_DataCleanupTrimBlanks]
GO





CREATE PROCEDURE spu_IMPORT_DataCleanupTrimBlanks AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
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

