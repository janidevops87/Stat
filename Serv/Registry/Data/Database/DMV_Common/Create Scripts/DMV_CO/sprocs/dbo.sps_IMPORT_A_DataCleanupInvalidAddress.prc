SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidAddress    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]
GO





CREATE PROCEDURE sps_IMPORT_A_DataCleanupInvalidAddress AS
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
select @suspect = 'Invalid Address IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
commit transaction IMPORT_A

CHECKPOINT



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

