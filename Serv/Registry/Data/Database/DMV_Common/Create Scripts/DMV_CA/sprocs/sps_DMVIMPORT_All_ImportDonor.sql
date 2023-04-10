if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_All_ImportDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_All_ImportDonor'
	drop procedure [dbo].[sps_DMVIMPORT_All_ImportDonor]
End
GO

	PRINT 'Creating sps_DMVIMPORT_All_ImportDonor'
GO



CREATE  PROCEDURE sps_DMVIMPORT_All_ImportDonor AS
/******************************************************************************
**		File: sps_DMVIMPORT_All_ImportDonor.sql
**		Name: sps_DMVIMPORT_All_ImportDonor
**		Desc: This sporc is used to add deltas (DMVImport) to the following tables:
**			1. DMV
**			2. DMVADDR
**			3. DMVOrgan 	
**
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
declare @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)
declare @DMVIMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit
select @DMVIMPORTLOGID = ID
from DMVIMPORTLOG
where upper(RunStatus) = 'LOADING'
declare cDMVIMPORT cursor for 
  select DMVIMPORT.ID
  from DMVIMPORT
open cDMVIMPORT
fetch next from cDMVIMPORT into @id 
while @@fetch_status = 0
  begin
    begin transaction DMVIMPORT
/*
    select @v = convert(varchar(255),@ID)
    print  @v
    select @DonorTF = case upper(DONOR)
                        when 'Y' then 1
                        else 0
                      end
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;
*/

    insert DMV (DMVIMPORTLOGID,
			 CAID,
			 SSN,
			 License,
			 DOB,
			 FirstName,
			 MiddleName,
			 LastName,
			 Suffix,
			 Gender,
			 Donor,
			 CountyCode,
			 Importdate,
			 DeceasedDate,
			 CSORState,
			 CSORLicense,
			 LastModified,
			 CreateDate,
			 FullName)

    select		@DMVIMPORTLOGID,
			CAST(CAID AS INT),
			NULL,
			LEFT(LICENSE,9),
			CASE ISDATE(DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DOB) END,
			LEFT(FIRST,20),
			LEFT(MIDDLE,20),
			LEFT(LAST,25),
			SUFFIX,
			GENDER,
			CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END AS 'DONOR',
			COUNTYCODE,
			CASE ISDATE(IMPORTDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,IMPORTDATE) END,
			CASE ISDATE(DECEASEDDATE)WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
			CAST(CSORSTATE AS varchar(2)),
			CAST(CSORLICENSE AS varchar(25)),
			CASE ISDATE(CREATEDATE) WHEN 1 THEN GetDate() ELSE Null END,
			ISNULL(CREATEDATE,GetDate()), 
			FULLNAME


    from DMVIMPORT
    where DMVIMPORT.ID = @ID;


    select @IDENTITY = @@IDENTITY
    select @Addr1     = ltrim(rtrim(AADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(ACITY)),  
           @State     = ltrim(rtrim(ASTATE)),  
           @Zip       = ltrim(rtrim(AZIP))
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   

    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDR (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)

    select		@IDENTITY,
			1,
			AADDR1,
			NULL,
			ACITY,
			ASTATE,
			AZIP
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   
    select @Addr1     = ltrim(rtrim(BADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(BCITY)),  
           @State     = ltrim(rtrim(BSTATE)),  
           @Zip       = ltrim(rtrim(BZIP))
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   
   
 if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDR (
			DMVID,
			ADDRTYPEID,
			Addr1,
			Addr2,
			City,
			State,
			Zip)

    select		@IDENTITY,
			2,
			BADDR1,
			NULL,
			BCITY,
			BSTATE,
			BZIP
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   

    select @Donor = ltrim(rtrim(DONOR))
    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   

    if isnull(@Donor,'') <> ''
    insert DMVORGAN (
			DMVID,
			ORGANTYPEID)

    select		@IDENTITY,
			CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END

    from DMVIMPORT
    where DMVIMPORT.ID = @ID;   
    commit transaction DMVIMPORT
    CHECKPOINT 
    fetch next from cDMVIMPORT into @id
  end
close cDMVIMPORT
deallocate cDMVIMPORT



GO



