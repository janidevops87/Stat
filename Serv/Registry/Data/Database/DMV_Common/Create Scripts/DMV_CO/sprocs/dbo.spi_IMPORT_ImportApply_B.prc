SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_B    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportApply_B]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportApply_B]
GO





CREATE PROCEDURE spi_IMPORT_ImportApply_B AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set LAST = b.LAST,
    FIRST  = b.FIRST,
    MIDDLE = b.MIDDLE,
    SUFFIX  = b.SUFFIX
from IMPORT i, IMPORT_B b
where i.LICENSE = b.LICENSE
insert IMPORT(IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DOB)
select        IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DOB
from IMPORT_B
where LICENSE NOT IN (select LICENSE
                      from IMPORT)





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

