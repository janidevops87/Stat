 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_Import_All_ImportDonor')
	BEGIN
		PRINT 'Dropping Procedure sps_Import_All_ImportDonor'
		DROP  Procedure  sps_Import_All_ImportDonor
	END

GO

PRINT 'Creating Procedure sps_Import_All_ImportDonor'
GO


CREATE PROCEDURE sps_IMPORT_All_ImportDonor AS
/******************************************************************************
**		File: 
**		Name: sps_Import_All_ImportDonor
**		Desc: This sproc will import the donors into the dmv tables
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**      @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)
	    @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @ArchivePresent varchar(255),
        @PreviousDonorState varchar(255),
        @PreviousLicenseState varchar(255),
        @DonorTF     bit							-----------
**
**		Auth: unknown
**		Date: unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		09/05/2007  Thien Ta 			Added code for PreviousDonorStatus	 
**      
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
        @ArchivePresent varchar(255),
        @PreviousDonorState varchar(255),
        @PreviousLicenseState varchar(255),
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
    insert DMV ( IMPORTLOGID, SSN,  License, DOB,                 FirstName, MiddleName, LastName, Suffix, Gender, Donor,    RenewalDate,                 DeceasedDate,                       CSORState, CSORLicense, CreateDate,PreviousDonorState)
    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
                                               WHEN 0 THEN NULL
                                               ELSE CONVERT(datetime,DOB)
                                             END,                 FIRST,     MIDDLE,     LAST,     SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)
                                                                                                                               WHEN 0 THEN NULL
                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
                                                                                                                                                            WHEN 0 THEN NULL
                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE()),PreviousDonorState
     from IMPORT
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
    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
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
    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Donor = ltrim(rtrim(DONOR))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Donor,'') <> ''
    insert DMVORGAN (DMVID, ORGANTYPEID)
    select           @IDENTITY, case ltrim(rtrim(DONOR))
                  when 'Y' then 1                   
           else 0
                                end
    from IMPORT
    where IMPORT.ID = @ID;   
    commit transaction IMPORT
    CHECKPOINT -- bjk 07/01/03 add checkpoint
    fetch next from cIMPORT into @id
  end
close cIMPORT
deallocate cIMPORT
GO







GO

GRANT EXEC ON sps_Import_All_ImportDonor TO PUBLIC

GO
