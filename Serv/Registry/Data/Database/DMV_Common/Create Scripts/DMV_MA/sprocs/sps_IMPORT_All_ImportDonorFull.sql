 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_IMPORT_All_ImportDonorFull]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull]
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonorFull'
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonorFull'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[sps_IMPORT_All_ImportDonorFull]
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.SQL
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc:
**
** 
**		Called by:   
**			DMV DTS Import 
**              
**
**		Auth: ccarroll	
**		Date: 06/12/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**    06/12/2009	ccarroll		Initial
*******************************************************************************/
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

declare @ID			 int, 
        @IDENTITY	 int, 
        @v			 varchar(255),
		@IMPORTLOGID int,
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
    insert DMVTempTable ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, RenewalDate, DeceasedDate,  CSORState, CSORLicense, LastModified, CreateDate, PreviousDonorState)
    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
                                               WHEN 0 THEN NULL
                                               ELSE CONVERT(datetime,DOB)
                                             END,        LEFT(FIRST,20), LEFT(MIDDLE,20), LEFT(LAST,25),  SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)

                                                                                                                                WHEN 0 THEN NULL
                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
                                                                                                                                                            WHEN 0 THEN NULL
                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, LastModified, ISNULL(CREATEDATE,GETDATE()), PreviousDonorState
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
    insert DMVADDRTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
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
    insert DMVADDRTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
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
    CHECKPOINT 
    fetch next from cIMPORT into @id
  end
close cIMPORT
deallocate cIMPORT
