 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Import_Adds]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spi_Import_Adds]
	PRINT 'Dropping Procedure: spi_Import_Adds'
END
	PRINT 'Creating Procedure: spi_Import_Adds'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spi_Import_Adds]
/******************************************************************************
**		File: spi_Import_Adds.sql
**		Name: spi_Import_Adds
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
**		09/02/2009	ccarroll	HS 18760 replaced Import_Deletes with Import_Adds in t-cursor
**								Import_Deletes reference caused updates to occur for deleted records
**								while ignoring corresponding IDs in the Import_Adds file.								
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

SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

DECLARE cIMPORT CURSOR FOR 
	SELECT Import_Adds.ID
		FROM Import_Adds
OPEN cIMPORT

FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@fetch_status = 0
      BEGIN
	BEGIN TRANSACTION IMPORT

 	SELECT @v = Convert(varchar(255),@ID)
	PRINT  @v
	SELECT @DonorTF = CASE Upper(DONOR)
			WHEN 'Y' THEN 1
                      		ELSE 0
                      		END
    		FROM Import_Adds
		WHERE Import_Adds.ID = @ID; 

	-- Check for existing DMV records with a matching License number
	SET @matchCount = (SELECT Count(*) FROM DMV WHERE DMV.License = (SELECT License FROM Import_Adds WHERE Import_Adds.ID = @ID)); 

	IF @matchCount > 0 
	     BEGIN
		-- Matching existing records found, set the donor value to 1, and update any other information
		UPDATE DMV SET
			IMPORTLOGID = @IMPORTLOGID,
			DOB = CASE ISDATE(Import_Adds.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,Import_Adds.DOB) END,                 
			FirstName = Import_Adds.First,
			MiddleName = Import_Adds.Middle,
			LastName = Import_Adds.Last,
			Suffix = Import_Adds.Suffix,
			Gender = Import_Adds.Gender,
			Donor = 1, -- Force Donor status YES
			PreviousDonorState = DMV.Donor, -- record previous donor status
			LastModified = GetDate(),                 
			FirstName_Display = Import_Adds.FirstName_Display,
			MiddleName_Display = Import_Adds.MiddleName_Display,
			LastName_Display = Import_Adds.LastName_Display
			FROM DMV
			JOIN Import_Adds
			ON DMV.License = Import_Adds.License
			WHERE Import_Adds.ID = @id

		-- Delete any existing address records for found deletes
		DELETE FROM DMVAddr 
			WHERE DmvId IN
			(SELECT DMV.[ID] 
				FROM DMV JOIN Import_Adds 
				ON DMV.License = Import_Adds.License 
				WHERE Import_Adds.[ID] = @id)

		-- Set @Identity variable to allow for insertion of new addresses below
		SET @IDENTITY = (SELECT TOP 1 DMV.[ID] 
				FROM DMV JOIN Import_Adds 
				ON DMV.License = Import_Adds.License 
				WHERE Import_Adds.[ID] = @id)

	     END

	ELSE
	     BEGIN
		-- Insert basic info into DMV record from Import_Adds
		INSERT DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, SignupDate, RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate, FirstName_Display, MiddleName_Display, LastName_Display)
    			SELECT @IMPORTLOGID, NULL, LICENSE, 
				CASE ISDATE(DOB)
	                                       		WHEN 0 THEN NULL
             	                           		ELSE CONVERT(datetime,DOB)
             	                           		END,                 
				FIRST,  MIDDLE,  LAST, SUFFIX, GENDER, 1,   -- Force donor status YES
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
				FROM Import_Adds
				WHERE Import_Adds.ID = @ID;

		-- Get Identity of record just inserted
    		SELECT @IDENTITY = @@IDENTITY;
	     END

	-- Get the main address variables
	SELECT @Addr1     = ltrim(rtrim(AADDR1)),
           		@Addr2     = NULL, 
          		@City      = ltrim(rtrim(ACITY)),  
           		@State     = ltrim(rtrim(ASTATE)),  
           		@Zip       = ltrim(rtrim(AZIP))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   

	-- Insert them as Type 1 address into DMVAddr table
    	IF Isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    		SELECT @IDENTITY,  1, AADDR1, NULL,  ACITY, ASTATE, AZIP
    			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   

	-- Get the mailing address variables
    	SELECT @Addr1     = ltrim(rtrim(BADDR1)),
           		@Addr2     = NULL, 
          		@City      = ltrim(rtrim(BCITY)),  
           		@State     = ltrim(rtrim(BSTATE)),  
           		@Zip       = ltrim(rtrim(BZIP))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   

	-- Insert them as Type 2 address into DMVAddr table
    	IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    		SELECT  @IDENTITY,  2,  BADDR1, NULL,  BCITY, BSTATE, BZIP
			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   


	-- Commented out DMVOrgan filling table.  Not currently needed 1/25/05 - SAP
/*    	SELECT @Donor = ltrim(rtrim(DONOR))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   
	IF isnull(@Donor,'') <> ''
    	INSERT DMVORGAN (DMVID, ORGANTYPEID)
    		SELECT  @IDENTITY, 
			CASE ltrim(rtrim(DONOR))
		                  	WHEN 'Y' THEN 1                   
				ELSE 0
                                		END
			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   */

	COMMIT TRANSACTION IMPORT;

    	CHECKPOINT -- bjk 07/01/03 add checkpoint

	FETCH NEXT FROM cIMPORT INTO @id
     END

CLOSE cIMPORT
DEALLOCATE cIMPORT
;