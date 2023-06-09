SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperGender    Script Date: 5/14/2007 10:02:42 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupUpperGender]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupUpperGender]
GO





-- sp_helptext CREATE PROCEDURE IMPORT_DataCleanupUpperGender AS
CREATE PROCEDURE sps_IMPORT_A_DataCleanupUpperGender AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
begin transaction IMPORT_A
  update IMPORT_A
  set Gender = upper(Gender)
commit transaction IMPORT_A

CHECKPOINT



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

