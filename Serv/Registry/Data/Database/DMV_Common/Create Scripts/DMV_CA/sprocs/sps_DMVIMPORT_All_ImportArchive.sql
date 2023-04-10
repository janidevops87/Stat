if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_All_ImportArchive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_All_ImportArchive'
	drop procedure [dbo].[sps_DMVIMPORT_All_ImportArchive]
End
GO

	PRINT 'Creating sps_DMVIMPORT_All_ImportArchive'
GO

CREATE  PROCEDURE sps_DMVIMPORT_All_ImportArchive AS
/******************************************************************************
**		File: sps_DMVIMPORT_A_DataCleanupUpperDonor.sql
**		Name: sps_DMVIMPORT_A_DataCleanupUpperDonor
**		Desc: This sp archives rows replaced by the update. If a record exists in the import file with
**			a license number matching a record in the DMV table, it is removed from the DMV and placed
**			in the Archive with notes on why it was archived. For example, if donor status changed, it
**			is tagged as 5 to indicate donor status change (See table: DMVArchiveType for list of options)
**			Archived records equal donor updated records. 
**
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/

declare @@DMVIMPORTLOGID int
SELECT @@DMVIMPORTLOGID = ID
FROM DMVIMPORTLOG
WHERE upper(RunStatus) = 'LOADING'

BEGIN transaction ARCHIVE
  INSERT DMVARCHIVE
  SELECT	
  		DMV.ID,
  		DMV.DMVImportLogID,
		DMV.CAID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB,
		DMV.FirstName,
		DMV.MiddleName,
		DMV.LastName,
		DMV.Suffix,
		DMV.Gender,
		DMV.Donor,
		DMV.CountyCode, 
		DMV.ImportDate,
		DMV.RenewalDate, 
		DMV.DeceasedDate,
		DMV.CSORState,
		DMV.CSORLicense,
		DMV.UserID,
		DMV.LastModified,
		DMV.CreateDate,
		DMV.FullName,
	 	@@DMVIMPORTLOGID, -- DisplacedBy 
		CASE WHEN (CASE UPPER(DMVIMPORT.DONOR) WHEN 'Y' THEN 1 ELSE 0 END <> DMV.DONOR) THEN 5 ELSE 1 END -- ArchiveType
  FROM  DMV, DMVIMPORT
  WHERE DMV.LICENSE = DMVIMPORT.LICENSE
  
  INSERT DMVARCHIVEADDR
  SELECT 
		DMVADDR.[ID],
		DMVADDR.[DMVID],
		DMVADDR.[AddrTypeID],
		DMVADDR.[Addr1],
		DMVADDR.[Addr2],
		DMVADDR.[City],
		DMVADDR.[State], 
		DMVADDR.[Zip],
		DMVADDR.[UserID],
		DMVADDR.[LastModified],
		DMVADDR.[CreateDate] 
  FROM  DMV, DMVADDR, DMVIMPORT
  WHERE DMV.ID = DMVADDR.DMVID
  AND   DMV.LICENSE = DMVIMPORT.LICENSE

  INSERT DMVARCHIVEORGAN
  SELECT
		DMVORGAN.[ID],
		DMVORGAN.[DMVID],
		DMVORGAN.[OrganTypeID],
		DMVORGAN.[LastModified],
		DMVORGAN.[CreateDate] 
  FROM  DMV, DMVORGAN, DMVIMPORT
  WHERE DMV.ID = DMVORGAN.DMVID
  AND   DMV.LICENSE = DMVIMPORT.LICENSE

--Remove records which will be replaced
  DELETE FROM DMVOrgan
  FROM DMV, DMVOrgan, DMVIMPORT
  WHERE DMV.ID = DMVOrgan.DMVID
  AND   DMV.LICENSE = DMVIMPORT.LICENSE
  DELETE FROM DMVADDR
  FROM  DMV, DMVADDR, DMVIMPORT
  WHERE DMV.ID = DMVADDR.DMVID
  AND   DMV.LICENSE = DMVIMPORT.LICENSE
  DELETE FROM DMV
  FROM  DMV, DMVIMPORT
  WHERE DMV.LICENSE = DMVIMPORT.LICENSE 

COMMIT TRANSACTION ARCHIVE
CHECKPOINT


GO



