/******************************************************************************
**		File: ReferralDataMigration_ReferralDonorRecNumberSearchable.sql
**		Name: Migrate Data to New Referral Table Column: ReferralDonorRecNumberSearchable
**		Desc: Populates data in the new referral table column 
**				ReferralDonorRecNumberSearchable (with invalid characters removed)
**
**		Auth: Mike Berenson
**		Date: 6/18/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      6/18/2019	Mike Berenson		initial
*******************************************************************************/

IF EXISTS(SELECT 1 FROM Referral WHERE ReferralDonorRecNumberSearchable IS NULL AND ReferralDonorRecNumber IS NOT NULL)
BEGIN
	PRINT 'MIGRATING Table - Referral. Copying from ReferralDonorRecNumber to ReferralDonorRecNumberSearchable.';

	UPDATE Referral
	SET ReferralDonorRecNumberSearchable = dbo.RemoveSpecialChars(ReferralDonorRecNumber)
	WHERE ReferralDonorRecNumberSearchable IS NULL
	AND ReferralDonorRecNumber IS NOT NULL;
END

GO