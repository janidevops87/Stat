/******************************************************************************
**		File: NORS_VerificationForm_Update.sql
**		Name: NORS_VerificationForm_Update
**		Desc: This cursor updates all states to the same verification form
**			  for a single Registry Owner.
**              
**		Return values: 
**		
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------
**		08/31/2011	ccarroll		Initial
*******************************************************************************/

SET NOCOUNT ON

DECLARE @RegitryOwnerStateConfigID int

DECLARE @LegalHeaderText varchar(2000)
DECLARE @LegalIntroText varchar(2000)
DECLARE @LegalText varchar(2000)
DECLARE @LegalDescriptionText varchar(2000)

DECLARE @WebLegalHeader varchar(2000)
DECLARE @WebLegalIntroText varchar(2000)
DECLARE @WebLegalText varchar(2000)
DECLARE @WebLegalDescriptionText varchar(2000)

/* Define new values for Verification Form*/
SET @LegalHeaderText = '<strong>Donor Registry of Nebraska Verification</strong>'
SET	@LegalIntroText = ''
SET	@LegalText = 'The individual named below has registered to be included in the Donor Registry of Nebraska established by the Revised Anatomical Gift Act, Neb.Rev.Stat. §71-4822 <i>et seq.</i>(the “Act”). This is an authorization for anatomical gifts to be made upon the donor''s death.'
SET	@LegalDescriptionText = '<p>Under the Act, an anatomical gift made by the donor before death does not require the consent of any other person.  The Act authorizes medical examination necessary to assure the medical suitability of the anatomical gift.  Representatives of Nebraska Organ Recovery System (“NORS”), the Lions Eye Bank of Nebraska and their designees are authorized to examine or remove copies of medical records, obtain blood and tissue samples for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift.
</p><p>The recovery of donated organs and tissues may be conducted at a surgical facility designated by NORS.</p>'

SET	@WebLegalHeader = '<strong>Donor Registry of Nebraska Verification</strong>'
SET	@WebLegalIntroText = ''
SET	@WebLegalText = 'The individual named below has registered to be included in the Donor Registry of Nebraska established by the Revised Anatomical Gift Act, Neb.Rev.Stat. §71-4822 <i>et seq.</i>(the “Act”). This is an authorization for anatomical gifts to be made upon the donor''s death.'
SET	@WebLegalDescriptionText = '<p>Under the Act, an anatomical gift made by the donor before death does not require the consent of any other person.  The Act authorizes medical examination necessary to assure the medical suitability of the anatomical gift.  Representatives of Nebraska Organ Recovery System (“NORS”), the Lions Eye Bank of Nebraska and their designees are authorized to examine or remove copies of medical records, obtain blood and tissue samples for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift.
</p><p>The recovery of donated organs and tissues may be conducted at a surgical facility designated by NORS.</p>'


/* Define scope of cursor */
DECLARE getRegistryOwnerStatConfig_cursor CURSOR FOR

		SELECT RegistryOwnerStateConfigID FROM RegistryOwnerStateConfig
		JOIN RegistryOwner ON RegistryOwner.RegistryOwnerID = RegistryOwnerStateConfig.RegistryOwnerID
		WHERE RegistryOwnerName = 'NORS'

OPEN getRegistryOwnerStatConfig_cursor

FETCH NEXT
	FROM getRegistryOwnerStatConfig_cursor INTO @RegitryOwnerStateConfigID

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Update State Verification Forms
	UPDATE RegistryOwnerStateConfig
		SET
			--DMV Verification Text
			LegalHeaderText = @LegalHeaderText,
			LegalIntroText = @LegalIntroText,
			LegalText = @LegalText,
			LegalDescriptionlText = @LegalDescriptionText,
			--Web Verification Text
			WebLegalHeader = @WebLegalHeader,
			WebLegalIntroText = @WebLegalIntroText,
			WebLegalText = @WebLegalText,
			WebLegalDescriptionlText = @WebLegalDescriptionText,
			
			--AuditTrail Update
			LastModified = GetDate(),
			LastStatEmployeeID = 1100,
			AuditLogTypeID = 3 -- Modify
			
	WHERE RegistryOwnerStateConfigID = @RegitryOwnerStateConfigID


FETCH NEXT
	FROM getRegistryOwnerStatConfig_cursor INTO @RegitryOwnerStateConfigID
END
CLOSE getRegistryOwnerStatConfig_cursor
DEALLOCATE getRegistryOwnerStatConfig_cursor

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

