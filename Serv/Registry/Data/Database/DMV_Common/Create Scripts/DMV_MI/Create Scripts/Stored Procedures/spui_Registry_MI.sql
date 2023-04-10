/*
spui_Registry_MI
Created 2/2/2005 by Scott Plummer
Derived from spui_Registry for special requirements by MI
*/

CREATE PROCEDURE spui_Registry_MI
 @pvDMVID  AS INT   = NULL,
 @pvLASTNAME  AS VARCHAR(25)  = NULL,
 @pvFIRSTNAME  AS VARCHAR(20)  = NULL,
 @pvMIDDLENAME AS VARCHAR(20)  = NULL,
 @pvGENDER  AS VARCHAR(1)  = NULL,
 @pvSSN   AS VARCHAR(11)  = NULL,
 @pvDOB   AS SMALLDATETIME = NULL,
 @pvRACE  AS INT   = NULL,
 @pvRADDR AS VARCHAR(40) = NULL,
 @pvRCITY AS VARCHAR(25) = NULL,
 @pvRSTATE AS VARCHAR(2) = NULL,
 @pvRZIP  AS VARCHAR(10) = NULL,
 @pvMADDR AS VARCHAR(40) = NULL,
 @pvMCITY AS VARCHAR(25) = NULL,
 @pvMSTATE AS VARCHAR(2) = NULL,
 @pvMZIP  AS VARCHAR(10) = NULL,
 @pvPHONE AS VARCHAR(10) = NULL,
 @pvLICENSE AS VARCHAR(9) = NULL,
 @pvDONOR AS VARCHAR(1) = NULL,
 @pvDMVDONOR AS VARCHAR(1) = NULL,
 @pvCOMMENTS AS VARCHAR(200) = NULL,
 @pvSOURCECODE AS VARCHAR(10) = NULL,
 @pvUSERID AS INT  = NULL, 
 @pvSIGNATUREDATE AS SMALLDATETIME= NULL,
 @pvRegistryID AS INT  = NULL,
 @pvDonorConfirmed AS VARCHAR(1) ='0',
 @pvOnLineDate AS SMALLDATETIME=NULL,
-- Added for changes 2/2005 - SAP
 @pvInfoSource AS VARCHAR(1) = NULL,
 @pvInfoSourceDesc AS VARCHAR(25) = NULL,
 @pvWitnessType1 AS VARCHAR(1) = NULL,
 @pvWitnessType2 AS VARCHAR(1) = NULL,
 @pvReligion AS VARCHAR(1) = NULL,
 @pvSuffix AS VARCHAR(4) = NULL,
 @pvApt AS VARCHAR(20) = NULL,
 @pvNewsletter AS VARCHAR(1) = '0',
 @pvActive AS VARCHAR(1) = '1',
-- Added to record birth month 6/7/05 - SAP
 @pvBirthMonth AS INTEGER = 0
 
AS


-- turn off record counts
SET NOCOUNT ON
DECLARE @CURRENTID   AS INT,
 @CURRENTRESIDENTIALID  AS INT,
 @CURRENTMAILINGID  AS INT,
 @RegistryResult  AS VARCHAR(50),
 @ResidentialResult AS VARCHAR(50),
 @MailingResult  AS VARCHAR(50)
-- clean up data
 SELECT @pvDMVID  = CASE  WHEN @pvDMVID = 0 THEN NULL 
     ELSE @pvDMVID 
      END
 SELECT @pvMIDDLENAME = CASE WHEN @pvMIDDLENAME ='' THEN NULL 
     WHEN CHARINDEX('.',RIGHT(@pvMIDDLENAME,1)) > 0 THEN UPPER(LEFT(@pvMIDDLENAME, LEN(@pvMIDDLENAME) - 1) + REPLACE(RIGHT(@pvMIDDLENAME,1),'.',''))
     ELSE UPPER(@pvMIDDLENAME)
      END   
 SELECT @pvLASTNAME  = UPPER(@pvLASTNAME )
 SELECT @pvFIRSTNAME  = UPPER(@pvFIRSTNAME ) 
 SELECT @pvGENDER = CASE @pvGENDER 
     WHEN '' THEN NULL 
     ELSE @pvGENDER 
      END
 SELECT @pvSSN  = CASE WHEN @pvSSN = '' THEN NULL
     ELSE @pvSSN
      END
 SELECT @pvRACE  = CASE WHEN @pvRACE = 0 THEN NULL
     ELSE @pvRACE
      END
 SELECT @pvRADDR  = CASE WHEN @pvRADDR = '' THEN NULL
     ELSE @pvRADDR
      END
 SELECT @pvRCITY  = CASE WHEN @pvRCITY = '' THEN NULL
     ELSE @pvRCITY
      END
 SELECT @pvRSTATE = CASE WHEN @pvRSTATE = '' THEN NULL
     ELSE @pvRSTATE
      END
 SELECT @pvRZIP  = CASE WHEN @pvRZIP = '' THEN NULL
     ELSE @pvRZIP
      END
 SELECT @pvMADDR  = CASE WHEN @pvMADDR = ''THEN NULL
     ELSE @pvMADDR
      END
 SELECT @pvMCITY  = CASE WHEN @pvMCITY = ''THEN NULL
     ELSE @pvMCITY
      END
 SELECT @pvMSTATE = CASE WHEN @pvMSTATE = '' THEN NULL
     ELSE @pvMSTATE
      END
 SELECT @pvMZIP  = CASE WHEN @pvMZIP = '' THEN NULL
     ELSE @pvMZIP
      END
 SELECT @pvPHONE  = CASE WHEN @pvPHONE = ''THEN NULL
     ELSE @pvPHONE
      END
 SELECT @pvLICENSE = CASE WHEN @pvLICENSE = '' THEN NULL
     ELSE @pvLICENSE
      END
 SELECT @pvCOMMENTS = CASE WHEN @pvCOMMENTS = '' THEN NULL
     ELSE @pvCOMMENTS
      END
 SELECT @pvSOURCECODE = CASE WHEN @pvSOURCECODE = '' THEN NULL
     ELSE @pvSOURCECODE
      END
 SELECT @pvUSERID = CASE WHEN @pvUSERID = 0 THEN NULL
     ELSE @pvUSERID
      END
 SELECT @pvRegistryID = CASE WHEN @pvRegistryID = 0 THEN NULL
     ELSE @pvRegistryID
      END
 SELECT @pvInfoSource = CASE WHEN @pvInfoSource = '' THEN NULL
     ELSE @pvInfoSource
       END
 SELECT @pvWitnessType1 = CASE WHEN @pvWitnessType1 = '' THEN NULL
     ELSE @pvWitnessType1
       END
 SELECT @pvWitnessType2 = CASE WHEN @pvWitnessType2 = '' THEN NULL
     ELSE @pvWitnessType2
       END
 SELECT @pvReligion = CASE WHEN @pvReligion = '' THEN NULL
     ELSE @pvReligion
       END

-- determine if this record is an insert or an update
IF @pvRegistryID IS NULL AND @pvDonorConfirmed = 1
BEGIN
 SELECT @CURRENTID = R.ID 
 FROM  Registry R
 WHERE ((DOB  LIKE @pvDOB    OR ISNULL(@pvDOB,    '')='')
 AND    (FirstName      LIKE @pvFirstName  OR ISNULL(@pvFirstName,  '')='')
 AND    (MiddleName     LIKE @pvMiddleName OR ISNULL(@pvMiddleName, '')='')
 AND (LastName LIKE @pvLastName   OR ISNULL(@pvLastName,   '')=''))
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
   [SSN]   = @pvSSN,
   [DOB]   = @pvDOB,
   [FirstName] = @pvFIRSTNAME,
   [MiddleName] = @pvMIDDLENAME,
   [LastName] = @pvLASTNAME,   
   [Gender] = @pvGENDER,
   [Race]   = @pvRACE,
   [Phone] = @pvPHONE,
   [Comment] = @pvCOMMENTS,
   [DMVID] = @pvDMVID,
   [License] = @pvLICENSE,
   [DMVDonor] = CAST(@pvDMVDONOR AS BIT),
   [Donor] = CAST(@pvDONOR AS BIT),
   [DonorConfirmed] = @pvDonorConfirmed,
   [SourceCode]  = @pvSOURCECODE,
   [SignatureDate] = @pvSIGNATUREDATE,
   [UserID]  = @pvUSERID,
   [InfoSource] = @pvInfoSource,
   [InfoSourceDesc] = @pvInfoSourceDesc,
   [WitnessType1] = @pvWitnessType1,
   [WitnessType2] = @pvWitnessType2,
   [Religion] = @pvReligion,
   [Suffix] = @pvSuffix ,
   [Newsletter] = CAST(@pvNewsletter AS BIT),
   [Active] = CAST(@pvActive AS BIT),
   [BirthMonth] = @pvBirthMonth
     
 WHERE  ID = @CURRENTID
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
 EXEC spui_RegistryAddr_MI 
  @CURRENTID,
  1,
  @pvRADDR,
  @pvApt,
  @pvRCITY,
  @pvRSTATE,
  @pvRZIP,
  @pvUSERID,
  @ResidentialResult OUTPUT
/* -- Second address commented out - not used.  2/2/1005 - SAP
 -- import / update mailing address
 EXEC SPUI_REGISTRYADDR    
  @CURRENTID,
  2,
  @pvMADDR,
  @pvApt
  @pvMCITY,
  @pvMSTATE,
  @pvMZIP,
  @pvUSERID,
  @MailingResult OUTPUT  
  */
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
   [OnlineRegDate],
   [InfoSourceDesc],
   [WitnessType1],
   [WitnessType2],
   [Religion],
   [Suffix],
   [Newsletter],
   [Active],
   [BirthMonth]
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
  @pvDonorConfirmed,
  @pvSOURCECODE,
  @pvSIGNATUREDATE,
  @pvUSERID,
  GetDate(),
  0,
  @pvOnLineDate,
  @pvInfoSourceDesc,
  @pvWitnessType1,
  @pvWitnessType2,
  @pvReligion,
  @pvSuffix,
  CAST(@pvNewsletter AS BIT),
  CAST(@pvActive AS BIT),
  @pvBirthMonth
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
  
 EXEC spui_RegistryAddr_MI
  @CurrentID,
  1,
  @pvRADDR,
  @pvApt,
  @pvRCITY,
  @pvRSTATE,
  @pvRZIP,
  @pvUSERID,
  @ResidentialResult OUTPUT
/* -- Second address commented out - not used.  2/2/1005 - SAP
 EXEC spui_RegistryAddr_MI    
  @CurrentID,
  2,
  @pvMADDR,
  @pvApt,
  @pvMCITY,
  @pvMSTATE,
  @pvMZIP,
  @pvUSERID,
  @MailingResult OUTPUT */
END
-- return the result fields
SELECT 
 @CurrentID  AS 'ID',
 @RegistryResult AS 'Registry',
 @ResidentialResult AS 'Residential',
 @MailingResult  AS 'Mailing'
GO
