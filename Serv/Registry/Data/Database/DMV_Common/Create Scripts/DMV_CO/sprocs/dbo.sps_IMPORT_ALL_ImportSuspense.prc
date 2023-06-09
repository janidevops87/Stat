SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_ALL_ImportSuspense    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_ALL_ImportSuspense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_ALL_ImportSuspense]
GO





-- sp_helpTEXT IMPORT_ImportSuspense
CREATE PROCEDURE sps_IMPORT_ALL_ImportSuspense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

Begin Transaction IMPORT
  set identity_insert IMPORT on
  insert IMPORT(ID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE)
  select        ID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE
  from SUSPENSE
  where OK = 1
  delete from SUSPENSE
  where OK = 1
  set identity_insert IMPORT off
commit transaction IMPORT
CHECKPOINT -- bjk 07/01/03 add checkpoint




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

