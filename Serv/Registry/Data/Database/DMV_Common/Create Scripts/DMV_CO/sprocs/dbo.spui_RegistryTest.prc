SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spui_RegistryTest    Script Date: 5/14/2007 10:02:45 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_RegistryTest]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_RegistryTest]
GO





CREATE PROCEDURE spui_RegistryTest
	@pvDMVID 	AS INT 		= NULL,
	@pvLASTNAME 	AS VARCHAR(25) 	= NULL,
	@pvFIRSTNAME 	AS VARCHAR(20) 	= NULL,
	@pvMIDDLENAME	AS VARCHAR(20) 	= NULL,
	@pvGENDER 	AS VARCHAR(1) 	= NULL,
	@pvSSN 		AS VARCHAR(11) 	= NULL,
	@pvDOB 		AS SMALLDATETIME = NULL,
	@pvRACE 	AS INT 		= NULL,
	@pvRADDR	AS VARCHAR(40)	= NULL,
	@pvRCITY	AS VARCHAR(25)	= NULL,
	@pvRSTATE	AS VARCHAR(2)	= NULL,
	@pvRZIP		AS VARCHAR(10)	= NULL,
	@pvMADDR	AS VARCHAR(40)	= NULL,
	@pvMCITY	AS VARCHAR(25)	= NULL,
	@pvMSTATE	AS VARCHAR(2)	= NULL,
	@pvMZIP		AS VARCHAR(10)	= NULL,
	@pvPHONE	AS VARCHAR(10)	= NULL,
	@pvLICENSE	AS VARCHAR(9)	= NULL,
	@pvDONOR	AS VARCHAR(1)	= NULL,
	@pvDMVDONOR	AS VARCHAR(1)	= NULL,
	@pvCOMMENTS	AS VARCHAR(200)	= NULL,
	@pvSOURCECODE	AS VARCHAR(10)	= NULL,
	@pvUSERID	AS INT		= NULL,	
	@pvSIGNATUREDATE AS SMALLDATETIME= NULL,
	@pvRegistryID	AS INT		= NULL
	
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- turn off record counts
SET NOCOUNT ON

DECLARE @CURRENTID 		AS INT,
	@CURRENTRESIDENTIALID 	AS INT,
	@CURRENTMAILINGID 	AS INT,
	@RegistryID		AS INT,
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
	SELECT @pvSOURCECODE	= CASE	WHEN @pvSOURCECODE = '' THEN NULL
					ELSE @pvSOURCECODE
				  END
	SELECT @pvUSERID	= CASE	WHEN @pvUSERID = 0 THEN NULL
					ELSE @pvUSERID
				  END
	SELECT @pvRegistryID	= CASE	WHEN @pvRegistryID = 0 THEN NULL
					ELSE @pvRegistryID
				  END

-- determine if this record is an insert or an update
IF @pvRegistryID = 0
BEGIN
	SELECT	@CURRENTID = R.ID 
	FROM 	Registry R
	WHERE	((DOB		LIKE @pvDOB	   OR ISNULL(@pvDOB, 	  '')='')
	AND   	(FirstName      LIKE @pvFirstName  OR ISNULL(@pvFirstName,  '')='')
	AND   	(MiddleName     LIKE @pvMiddleName OR ISNULL(@pvMiddleName, '')='')	
	AND   	(LastName	LIKE @pvLastName   OR ISNULL(@pvLastName,   '')=''))
END
ELSE
BEGIN
	SELECT @CURRENTID = @pvRegistryID
END
	

SELECT @pvLastName, @pvFirstName, @pvMiddleName, @pvDOB, @pvRegistryID





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

