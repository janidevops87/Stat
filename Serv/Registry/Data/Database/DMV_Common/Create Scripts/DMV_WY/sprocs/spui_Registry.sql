SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spui_Registry    Script Date: 5/14/2007 10:02:45 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_Registry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)

PRINT 'Dropping Procedure spui_Registry'
drop procedure [dbo].[spui_Registry]
GO

PRINT 'Creating Procedure spui_Registry'
GO

CREATE  PROCEDURE spui_Registry
	@pvDMVID 	AS INT 		= NULL,
	@pvLASTNAME 	AS VARCHAR(25) 	= NULL,
	@pvFIRSTNAME 	AS VARCHAR(20) 	= NULL,
	@pvMIDDLENAME	AS VARCHAR(20) 	= NULL,
	@pvGENDER 	AS VARCHAR(1) 	= NULL,
	@pvSSN 		AS VARCHAR(11) 	= NULL,
	@pvDOB 		AS SMALLDATETIME = NULL,
	@pvRACE 	AS INT 		= NULL,
	@pvRADDR	AS VARCHAR(40)	= NULL,
	@pvRADDR2	AS VARCHAR(20)	= NULL,
	@pvRCITY	AS VARCHAR(25)	= NULL,
	@pvRSTATE	AS VARCHAR(2)	= NULL,
	@pvRZIP		AS VARCHAR(10)	= NULL,
	@pvMADDR	AS VARCHAR(40)	= NULL,
	@pvMADDR2	AS VARCHAR(20)	= NULL,
	@pvMCITY	AS VARCHAR(25)	= NULL,
	@pvMSTATE	AS VARCHAR(2)	= NULL,
	@pvMZIP		AS VARCHAR(10)	= NULL,
	@pvPHONE	AS VARCHAR(10)	= NULL,
	@pvLICENSE	AS VARCHAR(9)	= NULL,
	@pvDONOR	AS VARCHAR(1)	= NULL,
	@pvDMVDONOR	AS VARCHAR(1)	= NULL,
	@pvDonorConfirmed AS VARCHAR(1) = NULL,
	@pvCOMMENTS	AS VARCHAR(200)	= NULL,
	@pvEventCategoryID AS INT	= NULL,
	@pvEventCateogrySpecifyText AS VARCHAR(255),	
	@pvEventSubCategoryID AS INT = NULL,
	@pvEventSubCategorySpecifyText AS VARCHAR(255),
	@pvUSERID	AS INT			= NULL,
	@pvSIGNATUREDATE AS SMALLDATETIME= NULL,
	@pvRegistryID	AS INT		= NULL,
	@pvOnLineDate	AS SMALLDATETIME= NULL
	
AS
/*
/******************************************************************************
**		File: 
**		Name: [spui_Registry]
**		Desc: This sproc will import the donors into the registry tables
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**    @pvDMVID 	AS INT 		= NULL,
	@pvLASTNAME 	AS VARCHAR(25) 	= NULL,
	@pvFIRSTNAME 	AS VARCHAR(20) 	= NULL,
	@pvMIDDLENAME	AS VARCHAR(20) 	= NULL,
	@pvGENDER 	AS VARCHAR(1) 	= NULL,
	@pvSSN 		AS VARCHAR(11) 	= NULL,
	@pvDOB 		AS SMALLDATETIME = NULL,
	@pvRACE 	AS INT 		= NULL,
	@pvRADDR	AS VARCHAR(40)	= NULL,
	@pvRADDR2	AS VARCHAR(20)	= NULL,
	@pvRCITY	AS VARCHAR(25)	= NULL,
	@pvRSTATE	AS VARCHAR(2)	= NULL,
	@pvRZIP		AS VARCHAR(10)	= NULL,
	@pvMADDR	AS VARCHAR(40)	= NULL,
	@pvMADDR2	AS VARCHAR(20)	= NULL,
	@pvMCITY	AS VARCHAR(25)	= NULL,
	@pvMSTATE	AS VARCHAR(2)	= NULL,
	@pvMZIP		AS VARCHAR(10)	= NULL,
	@pvPHONE	AS VARCHAR(10)	= NULL,
	@pvLICENSE	AS VARCHAR(9)	= NULL,
	@pvDONOR	AS VARCHAR(1)	= NULL,
	@pvDMVDONOR	AS VARCHAR(1)	= NULL,
	@pvDonorConfirmed AS VARCHAR(1) = NULL,
	@pvCOMMENTS	AS VARCHAR(200)	= NULL,
	@pvEventCategoryID AS Int = NULL,
	@pvEventCateogrySpecifyText, AS VARCHAR(255),	
	@pvEventSubCategoryID AS Int = NULL,
	@pvEventSubCategorySpecifyText AS VARCHAR(255),
	@pvUSERID	AS INT		= NULL,	
	@pvSIGNATUREDATE AS SMALLDATETIME= NULL,
	@pvRegistryID	AS INT		= NULL,
	@pvOnLineDate	AS SMALLDATETIME= NULL							-----------
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
************************************************************************  
* 4/21/2006 - ccarroll Added additional address inserts per request of DA.
* Ref. Requirements Documentation: CO/WY Registry changes.
* Fields affected: addr2
************************************************************************  
************************************************************************  
**		 09/05/2007	Thien Ta 			Added code to update PreviousDonorStatus
**       Ref. Requirements Documentation: CO/WY Registry changes Previous Donor status
************************************************************************  
* 12/17/2007 - ccarroll added Event Category for registry donors per request of CODA.
* Ref. Requirements Documentation: CO/WY Registry changes.
*******************************************************************************/

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A.
	
*/
-- turn off record counts
SET NOCOUNT ON

DECLARE @CURRENTID 		AS INT,
	@CURRENTRESIDENTIALID 	AS INT,
	@CURRENTMAILINGID 	AS INT,
	@RegistryResult		AS VARCHAR(50),
	@ResidentialResult	AS VARCHAR(50),
	@MailingResult		AS VARCHAR(50)

-- clean up data
	SELECT @pvDMVID 	= CASE 	WHEN @pvDMVID = 0 THEN NULL 
					ELSE @pvDMVID 
				  END
	SELECT @pvMIDDLENAME	= CASE	WHEN @pvMIDDLENAME ='' THEN NULL 
					WHEN CHARINDEX('.',RIGHT(@pvMIDDLENAME,1)) > 0 THEN UPPER(LEFT(@pvMIDDLENAME, LEN(@pvMIDDLENAME) - 1) + REPLACE(RIGHT(@pvMIDDLENAME,1),'.',''))
					ELSE UPPER(@pvMIDDLENAME)
				  END			
	SELECT @pvLASTNAME 	= UPPER(@pvLASTNAME )
	SELECT @pvFIRSTNAME 	= UPPER(@pvFIRSTNAME )	
	SELECT @pvGENDER	= CASE @pvGENDER 
					WHEN '' THEN NULL 
					ELSE @pvGENDER 
				  END
	SELECT @pvSSN		= CASE	WHEN @pvSSN = '' THEN NULL
					ELSE @pvSSN
				  END
	SELECT @pvRACE		= CASE	WHEN @pvRACE = 0 THEN NULL
					ELSE @pvRACE
				  END
	SELECT @pvRADDR		= CASE	WHEN @pvRADDR = '' THEN NULL
					ELSE @pvRADDR
				  END
	SELECT @pvRADDR2	= CASE	WHEN @pvRADDR2 = '' THEN NULL
					ELSE @pvRADDR2
				  END
	SELECT @pvRCITY		= CASE	WHEN @pvRCITY = '' THEN NULL
					ELSE @pvRCITY
				  END
	SELECT @pvRSTATE	= CASE	WHEN @pvRSTATE = '' THEN NULL
					ELSE @pvRSTATE
				  END
	SELECT @pvRZIP		= CASE	WHEN @pvRZIP = '' THEN NULL
					ELSE @pvRZIP
				  END
	SELECT @pvMADDR		= CASE	WHEN @pvMADDR = ''THEN NULL
					ELSE @pvMADDR
				  END
	SELECT @pvMADDR2	= CASE	WHEN @pvMADDR2 = ''THEN NULL
					ELSE @pvMADDR2
				  END
	SELECT @pvMCITY		= CASE	WHEN @pvMCITY = ''THEN NULL
					ELSE @pvMCITY
				  END
	SELECT @pvMSTATE	= CASE	WHEN @pvMSTATE = '' THEN NULL
					ELSE @pvMSTATE
				  END
	SELECT @pvMZIP		= CASE	WHEN @pvMZIP = '' THEN NULL
					ELSE @pvMZIP
				  END
	SELECT @pvPHONE		= CASE	WHEN @pvPHONE = ''THEN NULL
					ELSE @pvPHONE
				  END
	SELECT @pvLICENSE	= CASE	WHEN @pvLICENSE = '' THEN NULL
					ELSE @pvLICENSE
				  END
	SELECT @pvCOMMENTS	= CASE	WHEN @pvCOMMENTS = '' THEN NULL
					ELSE @pvCOMMENTS
				  END

	SELECT @pvUSERID	= CASE	WHEN @pvUSERID = 0 THEN NULL
					ELSE @pvUSERID
				  END
	SELECT @pvRegistryID	= CASE	WHEN @pvRegistryID = 0 THEN NULL
					ELSE @pvRegistryID
				  END

-- determine if this record is an insert or an update
IF @pvRegistryID IS NULL --AND @pvDonorConfirmed = 1
BEGIN
	 
	SELECT	@CURRENTID = R.ID 
	FROM 	Registry R
	WHERE	((DOB		LIKE @pvDOB	   OR ISNULL(@pvDOB, 	  '')='')
	AND   	(FirstName      LIKE @pvFirstName  OR ISNULL(@pvFirstName,  '')='')
	AND   	(MiddleName     LIKE @pvMiddleName OR ISNULL(@pvMiddleName, '')='')
	AND	(LastName	LIKE @pvLastName   OR ISNULL(@pvLastName,   '')=''))
END
ELSE
BEGIN
	SELECT @CURRENTID = @pvRegistryID
END
	

-- if @CURRENTID is greater than 0 update the record
IF @CURRENTID > 0
BEGIN

	
	UPDATE [REGISTRY] 

	SET  
		 [SSN]	 	= @pvSSN,
		 [DOB]	 	= @pvDOB,
		 [FirstName]	= @pvFIRSTNAME,
		 [MiddleName]	= @pvMIDDLENAME,
		 [LastName]	= @pvLASTNAME,		 
		 [Gender]	= @pvGENDER,
		 [Race]	 	= @pvRACE,
		 [Phone]	= @pvPHONE,
		 [Comment]	= @pvCOMMENTS,
		 [DMVID]	= @pvDMVID,
		 [License]	= @pvLICENSE,
		 [DMVDonor]	= CAST(@pvDMVDONOR AS BIT),
		 [Donor]	= CAST(@pvDONOR AS BIT),
		 [DonorConfirmed] = CAST(@pvDonorConfirmed AS BIT),
		 [SignatureDate] = @pvSIGNATUREDATE,
		 [UserID]	 = @pvUSERID,
		 [PreviousDonorStateDMVDonor] = DMVDonor,
		 [PreviousDonorStateDonor] = Donor,
		 [PreviousDonorStateDonorConfirmed]= DonorConfirmed
	from Registry  

	WHERE 	ID = @CURRENTID

	-- determine status of update
	IF @@ERROR = 0
	BEGIN
		SELECT @RegistryResult = 'Registry record  ' + CAST(@CURRENTID AS VARCHAR(10) ) + ' was succesfully updated'
	END
	ELSE
	BEGIN
		SELECT @RegistryResult = 'An error occured while updating record  ' + CAST(@CURRENTID AS VARCHAR(10) ) + ' '
	END

	-- import / update residential address
	EXEC SPUI_REGISTRYADDR	
		@CURRENTID,
		1,
		@pvRADDR,
		@pvRADDR2,
		@pvRCITY,
		@pvRSTATE,
		@pvRZIP,
		@pvUSERID,
		@ResidentialResult OUTPUT
	-- import / update mailing address
	EXEC SPUI_REGISTRYADDR				
		@CURRENTID,
		2,
		@pvMADDR,
		@pvMADDR2,
		@pvMCITY,
		@pvMSTATE,
		@pvMZIP,
		@pvUSERID,
		@MailingResult OUTPUT

	-- ccarroll 12/17/2007 Added for Event Category insert/update
	EXEC SPUI_EventRegistry
		@CURRENTID,
		@pvEventCategoryID,
		@pvEventSubCategoryID,
		@pvEventCateogrySpecifyText,	
		@pvEventSubCategorySpecifyText ;
		
END
ELSE
BEGIN

	INSERT INTO [REGISTRY] 
	( 
		 [SSN],
		 [DOB],
		 [FirstName],
		 [MiddleName],
		 [LastName],
		 [Gender],
		 [Race],		 
		 [Phone],
		 [Comment],
		 [DMVID],
		 [License],
		 [DMVDonor],
		 [Donor],
		 [DonorConfirmed],
		 [SourceCode],		 
		 [SignatureDate],
		 [UserID],
		 [CreateDate],
		 [DeleteFlag],
		 [OnlineRegDate]
	) 

	VALUES 
		(
		
		@pvSSN,
		@pvDOB,
		@pvFIRSTNAME,
		@pvMIDDLENAME,
		@pvLASTNAME,
		@pvGENDER,
		@pvRACE,
		@pvPHONE,
		@pvCOMMENTS,		
		@pvDMVID,		
		@pvLICENSE,
		CAST(@pvDMVDONOR AS BIT),
		CAST(@pvDONOR AS BIT),
		CASE @pvDonorConfirmed WHEN '0' THEN Null WHEN '1' THEN 1 END,
		Null,
		@pvSIGNATUREDATE,
		@pvUSERID,
		GetDate(),
		0,
		@pvOnLineDate
		)
		
	-- determine status of update
	IF @@ERROR = 0
	BEGIN
		SELECT @CurrentID = @@IDENTITY
		SELECT @RegistryResult = 'Registry record  ' + CAST(@CurrentID AS VARCHAR(10) ) + ' was succesfully created'
	END
	ELSE
	BEGIN
		SELECT @CurrentID = @@IDENTITY
		SELECT @RegistryResult = 'An error occured while inserting record  ' + CAST(@CurrentID AS VARCHAR(10) ) + ' '
	END

		
	EXEC SPUI_REGISTRYADDR
		@CurrentID,
		1,
		@pvRADDR,
		@pvRADDR2,
		@pvRCITY,
		@pvRSTATE,
		@pvRZIP,
		@pvUSERID,
		@ResidentialResult OUTPUT

	EXEC SPUI_REGISTRYADDR				
		@CurrentID,
		2,
		@pvMADDR,
		@pvMADDR2,
		@pvMCITY,
		@pvMSTATE,
		@pvMZIP,
		@pvUSERID,
		@MailingResult OUTPUT

	-- ccarroll 12/17/2007 Added for Event Category insert/update
	EXEC SPUI_EventRegistry
		@CURRENTID,
		@pvEventCategoryID,
		@pvEventSubCategoryID,
		@pvEventCateogrySpecifyText,	
		@pvEventSubCategorySpecifyText ;		
		
END

-- return the result fields
SELECT 
	@CurrentID 	AS 'ID',
	@RegistryResult AS 'Regisry',
	@ResidentialResult AS 'Residential',
	@MailingResult 	AS 'Mailing'
GO
