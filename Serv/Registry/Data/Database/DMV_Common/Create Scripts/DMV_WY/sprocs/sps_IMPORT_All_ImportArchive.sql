IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_IMPORT_All_ImportArchive')
	BEGIN
		PRINT 'Dropping Procedure sps_IMPORT_All_ImportArchive'
		DROP  Procedure  sps_IMPORT_All_ImportArchive
	END

GO

PRINT 'Creating Procedure sps_IMPORT_All_ImportArchive'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure sps_IMPORT_All_ImportArchive AS
/******************************************************************************
**		File: 
**		Name: sps_IMPORT_All_ImportArchive
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Unknown
**		Date: Unknow
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/18/07	Bret Knoll			WY Previous Donor Status Column
******************************************************************************/
declare @@IMPORTLOGID int
select @@IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
begin transaction ARCHIVE
  insert DMVARCHIVE
  select 
		DMV.ID, 
		DMV.ImportLogID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB, 
		DMV.FirstName, 
		DMV.MiddleName, 
        DMV.LastName, 
        DMV.Suffix, 
        DMV.Gender, 
        DMV.Donor, 
        DMV.RenewalDate, 
        DMV.DeceasedDate, 
        DMV.CSORState,
        DMV.CSORLicense, 
        DMV.UserID, 
        DMV.LastModified, 
        DMV.CreateDate,
		@@IMPORTLOGID, 
		1 
  from 
	DMV, IMPORT
  where DMV.LICENSE = IMPORT.LICENSE
  
insert DMVARCHIVEADDR
  select DMVADDR.* from DMV, DMVADDR, IMPORT
  where DMV.ID = DMVADDR.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE
  insert DMVARCHIVEORGAN
  select DMVORGAN.* from DMV, DMVORGAN, IMPORT
  where DMV.ID = DMVORGAN.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE
  delete from DMVORGAN
  from DMV, DMVORGAN, IMPORT
  where DMV.ID = DMVORGAN.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE
  delete from DMVADDR
  from DMV, DMVADDR, IMPORT
  where DMV.ID = DMVADDR.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE
  delete from DMV
  from DMV, IMPORT
  where DMV.LICENSE = IMPORT.LICENSE 
commit transaction ARCHIVE
 CHECKPOINT -- bjk 07/01/03 add checkpoint




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO

GRANT EXEC ON sps_IMPORT_All_ImportArchive TO PUBLIC

GO
