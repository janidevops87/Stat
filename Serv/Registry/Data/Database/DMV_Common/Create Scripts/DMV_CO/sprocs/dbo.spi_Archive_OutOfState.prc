SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Archive_OutOfState    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Archive_OutOfState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Archive_OutOfState]
GO






-- sp_helptext sps_IMPORT_All_ImportArchive
-- sp_help dmvarchive select distinct RecordType from dmvarchive
-- Select * from Datadict_donor-a
CREATE  PROCEDURE spi_Archive_OutOfState AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
 declare @@IMPORTLOGID int
 select @@IMPORTLOGID = ID
 from IMPORTLOG
 where upper(RunStatus) = 'LOADING'
 
 begin transaction ARCHIVE
 insert DMVARCHIVE
    select 
 		DMV.ID, DMV.ImportLogID, DMV.SSN, DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
		@@IMPORTLOGID, 3 
    from DMV
    where ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> ''
  
   insert DMVARCHIVEADDR
    select 
	DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
	DMVADDR.[Addr1], DMVADDR.[Addr2], DMVADDR.[City], DMVADDR.[State], 
	DMVADDR.[Zip], DMVADDR.[UserID], DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 	
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
 
 insert DMVARCHIVEORGAN
    select 
	DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMVORGAN
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMVADDR
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMV
    from DMV, IMPORT
    where (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
 commit transaction ARCHIVE
CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

