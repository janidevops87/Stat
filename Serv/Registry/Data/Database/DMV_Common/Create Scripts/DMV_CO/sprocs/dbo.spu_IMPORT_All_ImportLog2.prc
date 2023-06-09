SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLog2    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_All_ImportLog2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_All_ImportLog2]
GO





CREATE PROCEDURE spu_IMPORT_All_ImportLog2 AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsUpdated             int
declare @@RecordsAdded               int
select @@RecordsUpdated = count(IMPORT.ID)
from IMPORT, DMV
where IMPORT.LICENSE = DMV.LICENSE
select @@RecordsAdded = count(IMPORT.ID)
from IMPORT
where not exists(select IMPORT.LICENSE
                 from DMV where IMPORT.LICENSE = DMV.LICENSE)
update IMPORTLOG
set RecordsUpdated            = @@RecordsUpdated,
    RecordsAdded              = @@RecordsAdded
where RunStatus = 'LOADING'





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

