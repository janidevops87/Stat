PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:6/20/2012 10:00:46 AM-- -- --  
-- D:/Statline/StatTrac/Serv/Dev/Registry/Data/Database/DMV_Common/Create Scripts/DMV_NE/sprocs/GetDMVVerification_select.sql
-- D:/Statline/StatTrac/Serv/Dev/Registry/Data/Database/DMV_Common/Create Scripts/DMV_NE/sprocs/sps_IMPORT_All_ImportDonorFull.sql

PRINT 'D:\Statline\StatTrac\Serv\Dev\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\GetDMVVerification_select.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDMVVerification_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDMVVerification_select]
	PRINT 'Dropping Procedure: GetDMVVerification_select'
END
	PRINT 'Creating Procedure: GetDMVVerification_select'
GO


CREATE PROCEDURE [dbo].[GetDMVVerification_select]
	@SourceID int = NULL
AS
/******************************************************************************
**		File: GetDMVVerification_select.sql
**		Name: GetDMVVerification_select
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
**		Date: 01/11/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------		--------	------------------------------------------
**		01/11/2011		ccarroll	initial release
**		06/20/2012		ccarroll	Removed time from Renewal date
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT
		RTRIM(IsNull(DMV.FirstName, '')) + ' ' +
		CASE WHEN LEN(IsNull(DMV.MiddleName, '')) > 0 THEN RTRIM(DMV.MiddleName) + ' ' ELSE '' END + 
		RTRIM(IsNull(DMV.LastName, '')) AS 'VerificationFullName',
		CONVERT(varchar, DMV.DOB, 101) AS 'VerificationDOB',
		IsNull(DMVAddr.Addr1, '')AS 'VerificationResidentialAddress',
		RTRIM(DMVAddr.City) + ', ' +
		RTRIM(DMVAddr.State) + ', ' +
		RTRIM(DMVAddr.Zip) AS 'VerificationCityStateZip',
		'' AS 'VerificationLimitation',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN 'Date of Registry activity: ' + CONVERT(varchar, DMV.CreateDate, 101) + ' ' + CONVERT(varchar, DMV.CreateDate, 108) 
			 ELSE 'Renewal Date: ' + CONVERT(varchar, DMV.RenewalDate, 101)  END AS 'VerificationSignatureDate',
		RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'VerificationForm',
		CASE WHEN LEN(IsNull(DMV.License, '')) > 0 
		THEN RTRIM(DMV.License) 
		ELSE CAST(DMV.ID AS varchar)
		END AS 'VerificationStateID'


FROM	DMV
LEFT	JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND (DMVAddr.AddrTypeID = 1)	
LEFT	JOIN DMV_Common.dbo.RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = DMVAddr.State

WHERE
		DMV.ID = @SourceID

GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\sps_IMPORT_All_ImportDonorFull.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_IMPORT_All_ImportDonorFull]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull]
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonorFull'
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonorFull'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.sql
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 07/20/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		07/20/2009	ccarroll	initial
**		05/14/2012	ccarroll	Changed to import IssueDate as Renewal date
*******************************************************************************/
declare @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)
declare @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit
        
select @IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
declare cIMPORT cursor for 
  select IMPORT.ID
  from IMPORT
open cIMPORT
fetch next from cIMPORT into @id 
while @@fetch_status = 0
  begin
    begin transaction IMPORT
    select @v = convert(varchar(255),@ID)
    print  @v
    select @DonorTF = case upper(DONOR)
                        when 'Y' then 1
                        else 0
                      end
    from IMPORT
    where IMPORT.ID = @ID;
    insert DMVTempTable ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor,  RenewalDate,                 DeceasedDate, CSORState, CSORLicense, LastModified, CreateDate, PreviousDonorState, RaceID, SendInfoFlag)
    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
                                               WHEN 0 THEN NULL
                                               ELSE CONVERT(datetime,DOB)
                                             END,                 FIRST,     MIDDLE,     LAST,     SUFFIX, GENDER, @DonorTF,  
																															CASE ISDATE(ISSUEDATE) -- Used for printing labels
                                                                                                                               WHEN 0 THEN NULL
                                                                                                                               ELSE CONVERT(datetime, ISSUEDATE)
                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
                                                                                                                                                            WHEN 0 THEN NULL
                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, GetDate(), ISNULL(Import.CREATEDATE,GETDATE()), PreviousDonorState, Race.RaceID, SendInfoFlag
    from IMPORT
    LEFT JOIN Race ON Race.RaceDMVCode = Import.RaceDMVCode
    where IMPORT.ID = @ID;
    select @IDENTITY = @@IDENTITY
    select @Addr1     = ltrim(rtrim(AADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(ACITY)),  
           @State     = ltrim(rtrim(ASTATE)),  
           @Zip       = ltrim(rtrim(AZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVAddrTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  1,          AADDR1, NULL,  ACITY, ASTATE, AZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Addr1     = ltrim(rtrim(BADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(BCITY)),  
           @State     = ltrim(rtrim(BSTATE)),  
           @Zip       = ltrim(rtrim(BZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVAddrTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    --select @Donor = ltrim(rtrim(DONOR))
    --from IMPORT
    --where IMPORT.ID = @ID;   
    --if isnull(@Donor,'') <> ''
    --insert DMVORGAN (DMVID, ORGANTYPEID)
    --select           @IDENTITY, case ltrim(rtrim(DONOR))
    --              when 'Y' then 1                   
    --       else 0
    --                            end
    --from IMPORT
    --where IMPORT.ID = @ID;   
    commit transaction IMPORT
    fetch next from cIMPORT into @id
  end
close cIMPORT
deallocate cIMPORT





GO
