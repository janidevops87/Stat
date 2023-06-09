SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_ImportLog1    Script Date: 5/14/2007 10:02:44 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_ImportLog1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_ImportLog1]
GO





CREATE PROCEDURE spu_IMPORT_ImportLog1 AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsTotal               int
select @@RecordsTotal = count(IMPORT_A.ID)
from IMPORT_A
select @@RecordsTotal = @@RecordsTotal + count(IMPORT_B.ID)
from IMPORT_B
select @@RecordsTotal = @@RecordsTotal + count(IMPORT_C.ID)
from IMPORT_C
update IMPORTLOG
set RecordsTotal              = @@RecordsTotal
where RunStatus = 'LOADING'





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

