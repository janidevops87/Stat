SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidLicense    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupInvalidLicense]
GO





--sp_helptext IMPORT_DataCleanupInvalidLicense
CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid DMV License Number IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where isnull(LICENSE,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where isnull(LICENSE,'') = ''
commit transaction IMPORT_A

CHECKPOINT -- bjk 07/01/03 add checkpoint



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

