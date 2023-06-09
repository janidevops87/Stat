SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupDuplicateLicense    Script Date: 5/14/2007 10:02:44 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupDuplicateLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupDuplicateLicense]
GO





CREATE PROCEDURE spu_IMPORT_B_DataCleanupDuplicateLicense AS
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
select @suspect = 'Duplicate License Number in IMPORT_B File'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select i.*, 0, @suspect
  from IMPORT_B i, (select LICENSE
                  from IMPORT_B
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  from IMPORT_B i, (select LICENSE
                  from IMPORT_B
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
commit transaction IMPORT_B

CHECKPOINT -- bjk 07/01/03 add checkpoint




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

