IF OBJECT_ID('Api.GetReferralMedication') IS NOT NULL 
DROP FUNCTION Api.GetReferralMedication;
GO

CREATE FUNCTION Api.GetReferralMedication
(
	@referralId INT,
	@medicationType varchar(100)
)
RETURNS TABLE
AS

RETURN(
	SELECT
		MedicationName As Name
    FROM
		Medication
    JOIN
		SecondaryMedication ON SecondaryMedication.MedicationID = Medication.MedicationID
    JOIN
		Referral ON SecondaryMedication.CallID = Referral.CallID 
    WHERE
		ReferralID = @referralId
    AND
		@medicationType IS NULL OR MedicationTypeUse = @medicationType
);
	
GO