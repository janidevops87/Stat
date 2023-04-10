
CREATE PROCEDURE SPI_IMPORT_SUSPENSE_A
		@ID	int=NULL 
AS
declare @IDENTITY 	int, 
        @v        	varchar(255),
	@IMPORTLOGID 	int,
        @Addr1       	varchar(255), 
        @Addr2       	varchar(255),
        @City        	varchar(255), 
        @State       	varchar(255), 
        @Zip         	varchar(255),
        @Donor       	varchar(255),
        @DonorTF     	bit

SET NOCOUNT ON

-- Process One at a Time
IF @ID IS NOT NULL
BEGIN
	    begin transaction IMPORT
	    select @v = convert(varchar(255),@ID)
	    print  @v
	    select @DonorTF = case upper(DONOR)
	                        when 'N' then 0
	                        else 1  -- Default is "YES"
	                      end
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;
	    insert DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor,    RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate, FullName, TiffFile, TiffDir )
	    select      IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
	                                               WHEN 0 THEN NULL
	                                               ELSE CONVERT(datetime,DOB)
	                                             END,                 FIRST,     MIDDLE,     LAST,     SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)
	                                                                                                                               WHEN 0 THEN NULL
	                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
	                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
	                                                                                                                                                            WHEN 0 THEN NULL
	                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
	                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, GETDATE(), FullName, TiffFile, 1
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;
	    select @IDENTITY = @@IDENTITY
	    select @Addr1     = ltrim(rtrim(AADDR1)),
	           @Addr2     = NULL, 
	           @City      = ltrim(rtrim(ACITY)),  
	           @State     = ltrim(rtrim(ASTATE)),  
	           @Zip       = ltrim(rtrim(AZIP))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    select          @IDENTITY,  1,          AADDR1, NULL,  ACITY, ASTATE, AZIP
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    select @Addr1     = ltrim(rtrim(BADDR1)),
	           @Addr2     = NULL, 
	           @City      = ltrim(rtrim(BCITY)),  
	           @State     = ltrim(rtrim(BSTATE)),  
	           @Zip       = ltrim(rtrim(BZIP))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    select     @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    select @Donor = ltrim(rtrim(DONOR))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Donor,'') <> ''
	    insert DMVORGAN (DMVID, ORGANTYPEID)
	    select           @IDENTITY, case ltrim(rtrim(DONOR))
	                  when 'Y' then 1                   
	           else 0
	                                end
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID   
	
	    DELETE SUSPENSE_A
	    WHERE SUSPENSE_A.ID = @ID
	    AND OK = 1
	
	    commit transaction IMPORT
END
-- Process a batch of Suspense records
ELSE
BEGIN
	
	declare cIMPORTSUSPENSE cursor for 
		SELECT ID 
		FROM SUSPENSE_A
		WHERE OK=1
	open cIMPORTSUSPENSE
	fetch next from cIMPORTSUSPENSE into @id 
	while @@fetch_status = 0
	  begin
	    begin transaction IMPORT
	    select @v = convert(varchar(255),@ID)
	    print  @v
	    select @DonorTF = case upper(DONOR)
	                        when 'Y' then 1
	                        else 0
	                      end
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;
	    insert DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor,    RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate, FullName, TiffFile, TiffDir )
	    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
	                                               WHEN 0 THEN NULL
	                                               ELSE CONVERT(datetime,DOB)
	                                             END,                 FIRST,     MIDDLE,     LAST,     SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)
	                                                                                                                               WHEN 0 THEN NULL
	                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
	                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
	                                                                                                                                                            WHEN 0 THEN NULL
	                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
	                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, GETDATE(), FullName, TiffFile, 1
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;
	    select @IDENTITY = @@IDENTITY
	    select @Addr1     = ltrim(rtrim(AADDR1)),
	           @Addr2     = NULL, 
	           @City      = ltrim(rtrim(ACITY)),  
	           @State     = ltrim(rtrim(ASTATE)),  
	           @Zip       = ltrim(rtrim(AZIP))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    select          @IDENTITY,  1,          AADDR1, NULL,  ACITY, ASTATE, AZIP
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    select @Addr1     = ltrim(rtrim(BADDR1)),
	           @Addr2     = NULL, 
	           @City      = ltrim(rtrim(BCITY)),  
	           @State     = ltrim(rtrim(BSTATE)),  
	           @Zip       = ltrim(rtrim(BZIP))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    select     @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    select @Donor = ltrim(rtrim(DONOR))
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID;   
	    if isnull(@Donor,'') <> ''
	    insert DMVORGAN (DMVID, ORGANTYPEID)
	    select           @IDENTITY, case ltrim(rtrim(DONOR))
	                  when 'Y' then 1                   
	           else 0
	                                end
	    from SUSPENSE_A
	    where SUSPENSE_A.ID = @ID   
	
	    DELETE SUSPENSE_A
	    WHERE SUSPENSE_A.ID = @ID
	    AND OK = 1
	
	    commit transaction IMPORT
	    fetch next from cIMPORTSUSPENSE into @id
	  end
	close cIMPORTSUSPENSE
	deallocate cIMPORTSUSPENSE
END
GO
