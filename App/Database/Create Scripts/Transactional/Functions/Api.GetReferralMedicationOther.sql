IF OBJECT_ID('Api.GetReferralMedicationOther') IS NOT NULL 
DROP FUNCTION Api.GetReferralMedicationOther;
GO

CREATE FUNCTION Api.GetReferralMedicationOther
(
	@referralId INT,
	@medicationType varchar(100)
)
RETURNS TABLE
AS

RETURN(
	SELECT
		SecondaryMedicationOtherName AS Name,
		SecondaryMedicationOtherDose AS Dose,
		SecondaryMedicationOtherStartDate AS StartDate,
		SecondaryMedicationOtherEndDate AS EndDate
    FROM
		SecondaryMedicationOther
	JOIN
		Referral
	ON  SecondaryMedicationOther.CallID = Referral.CallID 
    WHERE
		ReferralID = @referralId
    AND
		SecondaryMedicationOtherTypeUse = @medicationType
);
	
GO