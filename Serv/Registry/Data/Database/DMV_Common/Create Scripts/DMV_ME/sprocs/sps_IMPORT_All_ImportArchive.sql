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

CREATE  PROCEDURE sps_IMPORT_All_ImportArchive AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportArchive.sql
**		Name: sps_IMPORT_All_ImportArchive
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll
**		Date: 01/04/2008 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		01/04/2007		ccarroll				initial
*******************************************************************************/

declare @@IMPORTLOGID int
select @@IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
begin transaction ARCHIVE
  insert DMVARCHIVE
  SELECT	DMV.ID, 
		DMV.ImportLogID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
	 	@@IMPORTLOGID, 1 
  from DMV, IMPORT
  where DMV.LICENSE = IMPORT.LICENSE
  
insert DMVARCHIVEADDR
  SELECT 
	DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
	LEFT(DMVADDR.[Addr1], 40) AS 'Addr1',
	LEFT(DMVADDR.[Addr2], 20) AS 'Addr2',
	LEFT(DMVADDR.[City], 25) AS 'City',
	LEFT(DMVADDR.[State], 2) AS 'State', 
	LEFT(DMVADDR.[Zip], 10) AS 'Zip',
	DMVADDR.[UserID],
	DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 
  from DMV, DMVADDR, IMPORT
  where DMV.ID = DMVADDR.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE

insert DMVARCHIVEORGAN
  SELECT
	DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
  from DMV, DMVORGAN, IMPORT
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
CHECKPOINT


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

