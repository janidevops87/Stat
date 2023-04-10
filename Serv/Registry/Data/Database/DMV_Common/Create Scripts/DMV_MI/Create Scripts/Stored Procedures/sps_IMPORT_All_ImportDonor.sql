
CREATE PROCEDURE sps_IMPORT_All_ImportDonor AS
/*
 Designed AND Developed 01/2003
 Legal Information...
  c1996-2003 Statline, LLC. All rights reserved. 
  Statline is a registered trademark of Statline, LLC in the U.S.A. 
  7555 East Hampden Avenue, Ste. 104, 
  Denver, CO 80231. 
  1-888-881-7828. 
*/
DECLARE @ID       int, 
        @IDENTITY int, 
        @v        varchar(255),
	@IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit


SELECT @IMPORTLOGID = [ID]
	FROM IMPORTLOG
	WHERE upper(RunStatus) = 'LOADING';

DECLARE cIMPORT CURSOR FOR 
	SELECT IMPORT.ID FROM IMPORT

OPEN cIMPORT

FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@FETCH_status = 0
	BEGIN
	    BEGIN transaction IMPORT
    		SELECT @v = convert(varchar(255),@ID)
		PRINT  @v
		SELECT @DonorTF = CASE UPPER(DONOR)
                        		WHEN 'Y' THEN 1
                        		ELSE 0
					END
		FROM IMPORT
		WHERE IMPORT.ID = @ID;

		INSERT DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, GENDer, Donor,    RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate, FullName, TiffFile, TiffDir )
    		SELECT @IMPORTLOGID, NULL, LICENSE, 
			CASE ISDATE(DOB)
				WHEN 0 THEN NULL
				ELSE CONVERT(datetime,DOB)
				END, 
			FIRST, MIDDLE, LAST, SUFFIX, GENDER, @DonorTF, 
			CASE ISDATE(RENEWALDATE)
                        	WHEN 0 THEN NULL
				ELSE CONVERT(datetime,RENEWALDATE)
				END,
			CASE ISDATE(DECEASEDDATE)
				WHEN 0 THEN NULL
				ELSE CONVERT(datetime,DECEASEDDATE)
				END,
			CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE()), FullName, TiffFile, 1	
		FROM IMPORT
		WHERE IMPORT.ID = @ID;
		SELECT @IDENTITY = @@IDENTITY
		SELECT @Addr1 = Left(ltrim(rtrim(AADDR1)),50),  -- To avoid failed inserts from long addresses.  5/11/05 - SAP
			@Addr2 = NULL, 
			@City = Left(ltrim(rtrim(ACITY)),25),   -- To avoid failed inserts from long city names.  5/11/05 - SAP 
			@State = ltrim(rtrim(ASTATE)),  
			@Zip = ltrim(rtrim(AZIP))
		FROM IMPORT
		WHERE IMPORT.ID = @ID;   

		IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    			INSERT DMVADDR (DMVID, ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
			SELECT @IDENTITY, 1, AADDR1, NULL, ACITY, ASTATE, AZIP
    			FROM IMPORT
    			WHERE IMPORT.ID = @ID;   

		SELECT @Addr1 = Left(ltrim(rtrim(BADDR1)),50),  -- To avoid failed inserts from long addresses.  5/11/05 - SAP
			@Addr2 = NULL, 
			@City = Left(ltrim(rtrim(BCITY)),25),    -- To avoid failed inserts from long addresses.  5/11/05 - SAP
			@State = ltrim(rtrim(BSTATE)),  
			@Zip = ltrim(rtrim(BZIP))
		FROM IMPORT
		WHERE IMPORT.ID = @ID;   

		IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
			INSERT DMVADDR (DMVID, ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
			SELECT @IDENTITY,  2, BADDR1, NULL,  BCITY, BSTATE, BZIP
    			FROM IMPORT
    			WHERE IMPORT.ID = @ID;  
 
		SELECT @Donor = ltrim(rtrim(DONOR))
    		FROM IMPORT
    		WHERE IMPORT.ID = @ID; 
  
		IF isnull(@Donor,'') <> ''
    			INSERT DMVORGAN (DMVID, ORGANTYPEID)
    			SELECT @IDENTITY, CASE ltrim(rtrim(DONOR))
					WHEN 'Y' THEN 1                   
					ELSE 0
					END
			FROM IMPORT
			WHERE IMPORT.ID = @ID;   

	   COMMIT TRANSACTION IMPORT

	   FETCH NEXT FROM cIMPORT into @id
	END

CLOSE cIMPORT
DEALLOCATE cIMPORT

GO
