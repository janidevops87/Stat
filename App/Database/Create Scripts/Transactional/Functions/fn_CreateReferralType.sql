IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'FN' AND name = 'fn_CreateReferralType')
	BEGIN
		PRINT 'Dropping Function fn_CreateReferralType';
		DROP Function fn_CreateReferralType;
	END
GO

PRINT 'Creating Function fn_CreateReferralType';
GO 

CREATE FUNCTION dbo.fn_CreateReferralType 
(
	@RecoveryId		INT,
	@ConsentId		INT,
	@AppropriateId	INT,
	@ApproachId		INT
)  
RETURNS BIT
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_CreateReferralType
**		Desc: 
**
**		This function determines whether a referral should be set to a new 
**		ReferralType based on recovery, consent, appropriate, and approach values.
** 
**		Called by:  
**      UpdateCurrentReferralType.sql (called by StatSave.UpdateCurrentReferralType)
**
**		Auth: Mike Berenson
**		Date: 12/4/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
BEGIN

	--Check Recovery
	IF @RecoveryId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Consent
	IF @ConsentId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Approach
	IF @ApproachId = 1
	BEGIN
		RETURN 1;
	END
	ELSE IF @ApproachId <> 1 AND @ApproachId <> -1
	BEGIN
		RETURN 0;
	END;

	--Check Appropriate
	IF @AppropriateId = 1
	BEGIN
		RETURN 1;
	END;

	RETURN 0;

END;
GO


