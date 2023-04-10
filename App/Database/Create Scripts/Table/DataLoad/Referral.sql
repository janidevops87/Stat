  /***************************************************************************************************
**	Name: Referral
**	Desc: Update Referal table with Secondary LSA data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	09/02/2011	ccarroll		Initial Script Creation
***************************************************************************************************/


SET NOCOUNT ON

IF EXISTS ( /* First check if column to update exists yet */
			SELECT * from syscolumns where id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralDonorLSADate'
			)
BEGIN
	/* then check for existing data */
	IF (SELECT COUNT(*) FROM Referral WHERE LEN(CAST(ReferralDonorLSADate AS varchar)) > 0) = 0
	BEGIN

	PRINT 'Updating Referral LSA date-time values from Secondary records...' 
	UPDATE Referral
		SET
			Referral.ReferralDonorLSADate = Secondary.SecondaryLSADate,
			Referral.ReferralDonorLSATime = Secondary.SecondaryLSATime
		FROM Referral 
		JOIN Secondary ON Referral.CallID = Secondary.CallID
		WHERE Secondary.SecondaryLSADate is Not Null
	PRINT 'Update complete.'  
	END
END