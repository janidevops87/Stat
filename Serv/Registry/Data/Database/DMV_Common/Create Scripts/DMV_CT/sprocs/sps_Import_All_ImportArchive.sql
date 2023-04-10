 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_Import_All_ImportAcchive]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_Import_All_ImportAcchive]
	PRINT 'Dropping Procedure: sps_Import_All_ImportAcchive'
END
	PRINT 'Creating Procedure: sps_Import_All_ImportAcchive'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sps_Import_All_ImportAcchive]
/******************************************************************************
**		File: sps_Import_All_ImportAcchive.sql
**		Name: sps_Import_All_ImportAcchive
**		Desc:  NEOB Registry, Import for CT DMV
**
**		Called by:  
**              
**
**		Auth: unknown
**		Date: 01/24/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/21/2005	Unknown		initial
**		09/02/2009	ccarroll	Removed delete section of sproc to allow for previous donor status updates								
*******************************************************************************/
AS
DECLARE @@IMPORTLOGID int

SELECT @@IMPORTLOGID = [ID]
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

BEGIN TRANSACTION ARCHIVE;

INSERT DMVARCHIVE
  SELECT	DMV.ID, 
		DMV.ImportLogID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.SignupDate, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
	 	@@IMPORTLOGID, 1,
		DMV.FirstName_Display, DMV.MiddleName_Display, DMV.LastName_Display
  FROM DMV, Import_Adds
  WHERE DMV.LICENSE = Import_Adds.LICENSE;
  
INSERT DMVARCHIVEADDR
  SELECT 
	DMVADDR.[ID], DMVADDR.[DMVID] as DMVArchiveID, DMVADDR.[AddrTypeID], 
	DMVADDR.[Addr1], DMVADDR.[Addr2], DMVADDR.[City], DMVADDR.[State], 
	DMVADDR.[Zip], DMVADDR.[UserID], DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 
  FROM DMV, DMVADDR, Import_Adds
  WHERE DMV.ID = DMVADDR.DMVID
  AND   DMV.LICENSE = Import_Adds.LICENSE;

INSERT DMVARCHIVEORGAN
  SELECT
	DMVORGAN.[ID], DMVORGAN.[DMVID] as DMVArchiveID, DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
  FROM DMV, DMVORGAN, Import_Adds
  WHERE DMV.ID = DMVORGAN.DMVID
  AND   DMV.LICENSE = Import_Adds.LICENSE;
/*
DELETE FROM DMVORGAN
  FROM DMV, DMVORGAN, Import_Adds
  WHERE DMV.ID = DMVORGAN.DMVID
  AND   DMV.LICENSE = Import_Adds.LICENSE;

DELETE FROM DMVADDR
  FROM DMV, DMVADDR, Import_Adds
  WHERE DMV.ID = DMVADDR.DMVID
  AND   DMV.LICENSE = Import_Adds.LICENSE;

DELETE FROM DMV
  FROM DMV, Import_Adds
  WHERE DMV.LICENSE = Import_Adds.LICENSE ;
*/
COMMIT TRANSACTION ARCHIVE;

CHECKPOINT

GO