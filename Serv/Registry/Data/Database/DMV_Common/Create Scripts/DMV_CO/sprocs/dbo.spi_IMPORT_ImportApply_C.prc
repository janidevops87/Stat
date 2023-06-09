SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_C    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportApply_C]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportApply_C]
GO





CREATE PROCEDURE spi_IMPORT_ImportApply_C AS
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
set AADDR1 = c.AADDR1,
    ACITY  = c.ACITY,
    ASTATE = c.ASTATE,
    AZIP   = c.AZIP,
    BADDR1 = c.BADDR1,
    BCITY  = c.BCITY,
    BSTATE = c.BSTATE,
    BZIP   = c.BZIP
from IMPORT i, IMPORT_C c
where i.LICENSE = c.LICENSE
insert IMPORT(IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP)
select        IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP
from IMPORT_C
where LICENSE NOT IN (select LICENSE
                      from IMPORT)





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

