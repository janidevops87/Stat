SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchiveBULK    Script Date: 5/14/2007 10:02:42 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportArchiveBULK]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_All_ImportArchiveBULK]
GO





CREATE PROCEDURE sps_IMPORT_All_ImportArchiveBULK AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
begin transaction ARCHIVE 
  insert IMPORTARCHIVE_A
  select *, NULL, NULL
  from IMPORT_A
  insert IMPORTARCHIVE_B
  select *, NULL, NULL
  from IMPORT_B
  insert IMPORTARCHIVE_C
  select *, NULL, NULL
  from IMPORT_C
commit transaction ARCHIVE

CHECKPOINT



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

