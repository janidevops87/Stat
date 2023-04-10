 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spu_Import_Deletes]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spu_Import_Deletes]
	PRINT 'Dropping Procedure: spu_Import_Deletes'
END
	PRINT 'Creating Procedure: spu_Import_Deletes'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spu_Import_Deletes]
/******************************************************************************
**		File: spu_Import_Deletes.sql
**		Name: spu_Import_Deletes
**		Desc:  NEOB Registry, Import for CT
**
**		Called by:  
**              
**
**		Auth: unknown
**		Date: 01/24/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/24/2005	Unknown		initial
**		09/03/2009	ccarroll	Added update for previous donor status						
*******************************************************************************/
AS
DECLARE @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)

DECLARE @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit,
        @matchCount Integer

-- Get the import log ID
SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

-- Declare a cursor, opening Import_Deletes table
DECLARE cIMPORT CURSOR FOR 
	SELECT Import_Deletes.ID
		FROM Import_Deletes
OPEN cIMPORT

-- Step through Import_Deletes records
FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@fetch_status = 0
      BEGIN
	BEGIN TRANSACTION IMPORT

 	SELECT @v = Convert(varchar(255),@ID)
	PRINT  @v
	-- Set the Donor variable (1 = Y, 0 = N)
	SELECT @DonorTF = CASE Upper(DONOR)
			WHEN 'Y' THEN 1
                      		ELSE 0
                      		END
    		FROM Import_Deletes
		WHERE Import_Deletes.ID = @ID; 

	-- Check for an existing record with a matching License number.
	SET @matchCount = (SELECT Count(*) FROM DMV WHERE DMV.License = (SELECT License FROM Import_Deletes WHERE Import_Deletes.ID = @ID)); 

	IF @matchCount > 0 
	     BEGIN
		-- Matching existing records found, set the donor value to 0, and update any other information
		UPDATE DMV SET
			IMPORTLOGID = @IMPORTLOGID,
			DOB = CASE ISDATE(Import_Deletes.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,Import_Deletes.DOB) END,                 
			FirstName = Import_Deletes.First,
			MiddleName = Import_Deletes.Middle,
			LastName = Import_Deletes.Last,
			Suffix = Import_Deletes.Suffix,
			Gender = Import_Deletes.Gender,
			Donor = 0, -- Force Donor status NO
			PreviousDonorState = DMV.Donor, -- Update previous donor status
			LastModified = GetDate(),                 
			FirstName_Display = Import_Deletes.FirstName_Display,
			MiddleName_Display = Import_Deletes.MiddleName_Display,
			LastName_Display = Import_Deletes.LastName_Display
			FROM DMV
			JOIN Import_Deletes
			ON DMV.License = Import_Deletes.License
			WHERE Import_Deletes.ID = @id

		-- Delete any existing address records for found deletes
		DELETE FROM DMVAddr 
			WHERE DmvId IN
			(SELECT DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

		-- Set @Identity variable to allow for insertion of new addresses below
		SET @IDENTITY = (SELECT TOP 1DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

	     END

	ELSE
	     BEGIN
		-- Insert record of NO donor status
		INSERT DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, SignupDate, RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate, FirstName_Display, MiddleName_Display, LastName_Display)
    			SELECT @IMPORTLOGID, NULL, LICENSE, 
				CASE ISDATE(DOB)
	                                        	WHEN 0 THEN NULL
	                                        	ELSE CONVERT(datetime,DOB)
	                                        END,                 
				FIRST,  MIDDLE,  LAST, SUFFIX, GENDER, 0,  -- Force Donor status NO 
				CASE ISDATE(SIGNUPDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,SIGNUPDATE)
					END,                         
				CASE ISDATE(RENEWALDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,RENEWALDATE)
					END,                         
				CASE ISDATE(DECEASEDDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,DECEASEDDATE)
					END,                               
				CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE()),
				FirstName_Display, MiddleName_Display, LastName_Display
				FROM Import_Deletes
				WHERE Import_Deletes.ID = @ID;
	
	    		SELECT @IDENTITY = @@IDENTITY;
	    END

	--Now, insert Address records, where found, whether new or updated Delete from above
	SELECT @Addr1     = ltrim(rtrim(AADDR1)),
		@Addr2     = NULL, 
	          	@City      = ltrim(rtrim(ACITY)),  
	           	@State     = ltrim(rtrim(ASTATE)),  
	           	@Zip       = ltrim(rtrim(AZIP))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	IF Isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    		SELECT @IDENTITY,  1, AADDR1, NULL,  ACITY, ASTATE, AZIP
	    			FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   
	
	-- Insert Mailing Address records, where found
	 SELECT @Addr1     = ltrim(rtrim(BADDR1)),
	           	@Addr2     = NULL, 
	          	@City      = ltrim(rtrim(BCITY)),  
	           	@State     = ltrim(rtrim(BSTATE)),  
	           	@Zip       = ltrim(rtrim(BZIP))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	    IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    		SELECT  @IDENTITY,  2,  BADDR1, NULL,  BCITY, BSTATE, BZIP
				FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   
	
	   -- Insert Organ Donor Records, where found
	    SELECT @Donor = ltrim(rtrim(DONOR))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	    IF isnull(@Donor,'') <> ''
	    	INSERT DMVORGAN (DMVID, ORGANTYPEID)
	    		SELECT  @IDENTITY, 
				CASE ltrim(rtrim(DONOR))
			                  	WHEN 'Y' THEN 1                   
					ELSE 0
	                                		END
				FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   

	
	COMMIT TRANSACTION IMPORT;

    	CHECKPOINT -- bjk 07/01/03 add checkpoint

	FETCH NEXT FROM cIMPORT INTO @id
     END

CLOSE cIMPORT
DEALLOCATE cIMPORT
;