SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO
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
**		07/10/2015	Seth Buxton			reduce TOP() to 1000
**		07/14/2015	Seth Buxton			increase TOP() to 25000
******************************************************************************/
declare @@IMPORTLOGID int
select @@IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
	WHILE EXISTS (SELECT TOP(1) 1	FROM DMV
									JOIN IMPORT ON DMV.LICENSE = IMPORT.LICENSE)
	BEGIN
	begin transaction ARCHIVE
	  insert DMVARCHIVE
	  SELECT TOP(25000)	
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
	 		@@IMPORTLOGID, 1, 
			DMV.FirstName_Display, 
			DMV.MiddleName_Display, 
			DMV.LastName_Display
	  from DMV
	  JOIN IMPORT ON DMV.LICENSE = IMPORT.LICENSE
	  where not exists (SELECT 1 FROM DMVARCHIVE WHERE DMV.ID = DMVARCHIVE.ID)
  
	insert DMVARCHIVEADDR
	  SELECT 
		DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
		DMVADDR.[Addr1], DMVADDR.[Addr2], DMVADDR.[City], DMVADDR.[State], 
		DMVADDR.[Zip], DMVADDR.[UserID], DMVADDR.[LastModified], 
		DMVADDR.[CreateDate] 
	  from DMV
	  JOIN DMVADDR		ON DMV.ID = DMVADDR.DMVID
	  JOIN DMVARCHIVE	ON DMV.ID = DMVARCHIVE.ID
	  JOIN IMPORT		ON DMV.LICENSE = IMPORT.LICENSE
	  where not exists(SELECT 1 FROM DMVARCHIVEADDR where DMVARCHIVEADDR.ID = DMVADDR.ID  )

	  insert DMVARCHIVEORGAN
	  SELECT
		DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
		DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
		from DMV
	  	JOIN DMVORGAN	ON DMV.ID = DMVORGAN.DMVID
		JOIN DMVARCHIVE ON DMV.ID = DMVARCHIVE.ID
		where not exists(SELECT 1 FROM DMVARCHIVEORGAN where DMVORGAN.ID = DMVARCHIVEORGAN.ID  )
	  
	   delete DMVORGAN
		from DMV
		join DMVORGAN			ON DMV.ID = DMVORGAN.DMVID
		JOIN DMVARCHIVEORGAN	ON DMV.ID = DMVARCHIVEORGAN.DMVArchiveID
	
      
	   delete from DMVADDR
		from DMV
		JOIN DMVADDR		ON DMV.ID = DMVADDR.DMVID
		JOIN DMVARCHIVEADDR	ON DMV.ID = DMVARCHIVEADDR.DMVArchiveID

	   delete from DMV
		from DMV
		JOIN DMVARCHIVE	ON DMV.ID = DMVARCHIVE.ID 
		commit transaction ARCHIVE
	END




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

