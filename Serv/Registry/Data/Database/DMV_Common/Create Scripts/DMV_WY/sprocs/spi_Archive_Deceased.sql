IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Archive_Deceased')
	BEGIN
		PRINT 'Dropping Procedure spi_Archive_Deceased'
		DROP  Procedure  spi_Archive_Deceased
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

PRINT 'Creating Procedure spi_Archive_Deceased'
GO
CREATE Procedure spi_Archive_Deceased
	@ArchiveReason INT = 2

AS

/******************************************************************************
**		File: 
**		Name: spi_Archive_Deceased
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		------------------------------
**      09/18/07	Bret Knoll		Wyoming Donor Status Change
*******************************************************************************/
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
		@ArchiveReason 
  from DMV
    where ISNULL(DMV.DeceasedDate, '')<> ''
  
   insert DMVARCHIVEADDR
    select DMVADDR.* from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
 
 insert DMVARCHIVEORGAN
    select DMVORGAN.* from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMVORGAN
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMVADDR
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMV
    from DMV, IMPORT
    where ISNULL(DMV.DeceasedDate, '')<> ''
 commit transaction ARCHIVE
 CHECKPOINT -- bjk 07/01/03 add checkpoint








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO

GRANT EXEC ON spi_Archive_Deceased TO PUBLIC

GO
