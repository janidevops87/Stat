SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_Suspense_B_CleanUpLicenseDups    Script Date: 5/14/2007 10:02:45 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Suspense_B_CleanUpLicenseDups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Suspense_B_CleanUpLicenseDups]
GO





CREATE PROCEDURE spu_Suspense_B_CleanUpLicenseDups AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
DECLARE @LICENSE AS VARCHAR(255)
DECLARE WeedOutDups CURSOR FOR
 select License from suspense_b group by License having count(License) >1 
OPEN WeedOutDups
 FETCH NEXT FROM WeedOutDups
 INTO @LICENSE
 WHILE @@FETCH_STATUS = 0 
 BEGIN
  UPDATE SUSPENSE_B
  SET OK = 1
  WHERE	LICENSE = @LICENSE
  AND 	CAST( DATEOFCHANGE + ' ' + SUBSTRING(TIMEOFCHANGE, 1, 2) + ':' + SUBSTRING(TIMEOFCHANGE, 3, 2) AS SMALLDATETIME) =  (SELECT MAX(CAST( DATEOFCHANGE + ' ' + SUBSTRING(TIMEOFCHANGE, 1, 2) + ':' + SUBSTRING(TIMEOFCHANGE, 3, 2) AS SMALLDATETIME)) FROM SUSPENSE_B WHERE LICENSE = @LICENSE)
  DELETE SUSPENSE_B WHERE LICENSE = @LICENSE AND OK <> 1
  FETCH NEXT FROM WeedOutDups
  INTO @LICENSE
 END
CLOSE WeedOutDups
DEALLOCATE WeedOutDups





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

