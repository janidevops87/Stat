 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonorRegistry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_IMPORT_All_ImportDonorRegistry'
	drop procedure [dbo].[sps_IMPORT_All_ImportDonorRegistry]
End
GO

	PRINT 'Creating sps_IMPORT_All_ImportDonorRegistry'
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorRegistry] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorRegistry.sql
**		Name: sps_IMPORT_All_ImportDonorRegistry
**		Desc: 
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
**		Auth: ccarroll
**		Date: 12/02/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		09/1/2006	ccarroll			Added LEFT trim for name fields (FIRST,MIDDLE,LAST) due to data received from DMV
**		12/02/2010  ccarroll			Moved to VS Registry database. added LEFT trim for Addr1(40), City(35), State(2), Zip(10) on BAddress
**										(AADDR1)Added CASE statement if over 40 char truncate to 37 and add '...' 
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
                        when 1 then 1
                        else 0
                      end
    from IMPORT
    where IMPORT.ID = @ID;
    insert REGISTRY (ImportLogID, CAID, SSN, License, DOB, FirstName, MiddleName, LastName, Suffix, FullName, Gender, Limitations, LimitationsOther, Email, DMVDonor, Donor, DonorConfirmed, DeleteFlag, LastModified, DeceasedDate, CreateDate)
    select  @IMPORTLOGID, CAID, NULL, LICENSE,
                 CASE ISDATE(DOB)
                 WHEN 0 THEN NULL
                 ELSE CONVERT(datetime,DOB)
                 END,
                 LEFT(FIRST,20), LEFT(MIDDLE,20), LEFT(LAST,25), SUFFIX, FULLNAME, GENDER, LIMITATIONS, LIMITATIONSOTHER, EMAIL, 0, @DonorTF, @DonorTF, 0,
                 CASE ISDATE(RENEWALDATE)
                 WHEN 0 THEN NULL
                 ELSE CONVERT(datetime,RENEWALDATE)
                 END,
 
                 CASE ISDATE(DECEASEDDATE)
                 WHEN 0 THEN NULL
                 ELSE CONVERT(datetime,DECEASEDDATE)
                 END, ISNULL(CREATEDATE,GETDATE())
    from IMPORT
    where IMPORT.ID = @ID;
    select @IDENTITY = @@IDENTITY
    select @Addr1     = ltrim(rtrim(LEFT(AADDR1, 40))),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(LEFT(ACITY, 35))),  
           @State     = ltrim(rtrim(LEFT(ASTATE, 2))),  
           @Zip       = ltrim(rtrim(LEFT(AZIP, 10)))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert REGISTRYADDR (REGISTRYID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,
					1,
					CASE WHEN LEN(AADDR1) > 40
						 THEN LEFT(AADDR1, 37) + '...'
						 ELSE AADDR1
					END AS AADDR1,
					NULL,
					ACITY,
					ASTATE,
					AZIP
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
    insert REGISTRYADDR (REGISTRYID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Donor = ltrim(rtrim(DONOR))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Donor,'') <> ''
    insert REGISTRYORGAN (REGISTRYID, ORGANTYPEID)
    select           @IDENTITY, case ltrim(rtrim(DONOR))
                  when 1 then 1                   
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


