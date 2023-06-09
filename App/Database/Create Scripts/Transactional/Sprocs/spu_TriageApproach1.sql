SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_TriageApproach1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_TriageApproach1]
GO


CREATE PROCEDURE spu_TriageApproach1
	@CallId int

AS

DECLARE @SecondaryApproached int,
		@SecondaryApproachedBy int,
		@SecondaryApproachOutcome int,
		@SecondaryConsent int,
		@ReferralApproachTypeId int,
		@ReferralApproachedByPersonID int,
		@ReferralGeneralConsent int,
		@TempAppOutcome int,
		@SecondaryHospitalApproach int,
		@SecondaryHospitalApproachedBy int,
		@SecondaryHospitalOutcome int,
		@UpdateBlankValues int


--GET SECONDARY APPROACH/CONSENT VALUES
SELECT @SecondaryApproached =  sa.SecondaryApproached,
	@SecondaryApproachedBy  =  sa.SecondaryApproachedBy,
	@SecondaryApproachOutcome =  sa.SecondaryApproachOutcome,
	@SecondaryConsent =  sa.SecondaryConsented,
	@SecondaryHospitalApproach =  sa.SecondaryHospitalApproach,
	@SecondaryHospitalApproachedBy =  sa.SecondaryHospitalApproachedBy,
	@SecondaryHospitalOutcome =  sa.SecondaryHospitalOutcome,
	@ReferralApproachTypeId = r.ReferralApproachTypeId,				--7/18/03 drh - Initialize Triage values with existing value
	@ReferralApproachedByPersonID = r.ReferralApproachedByPersonID,		--7/18/03 drh - Initialize Triage values with existing value
	@ReferralGeneralConsent = r.ReferralGeneralConsent				--7/18/03 drh - Initialize Triage values with existing value
FROM SecondaryApproach sa
JOIN Referral r ON sa.CallId = r.CallId
WHERE sa.CallId = @CallId

--IF INFORMED APPROACH DONE IS "YES" AND INFORMED APPROACH OUTCOME IS NOT BLANK, USE INFORMED APPROACH; OTHERWISE, USE HOSPITAL APPROACH
IF ISNULL(@SecondaryApproached, -1) = 1 AND (ISNULL(@SecondaryApproachOutcome, -1) <> -1)
BEGIN
	--TRIAGE APPROACH TYPE IS "POST REF, DECOUPLED"
	SELECT @ReferralApproachTypeId = 5
	SELECT @ReferralApproachedByPersonID = CASE WHEN ISNULL(@SecondaryApproachedBy, -1) = -1 THEN 0 ELSE @SecondaryApproachedBy END	--Note: SecondaryApproachedBy uses -1 for blank values, but ReferralApproachedByPersonId uses 0 for blank values
	
	SELECT @ReferralGeneralConsent = CASE ISNULL(@SecondaryApproachOutcome, -1)
						WHEN -1 THEN -1	--When SecondaryApproachOutcome is blank, then ReferralGeneralConsent is blank
						WHEN 1 THEN 2	--When SecondaryApproachOutcome = "Yes - Verbal", then ReferralGeneralConsent = "Yes - Verbal"
						WHEN 2 THEN 1	--When SecondaryApproachOutcome = "Yes - Written", then ReferralGeneralConsent = "Yes - Written"
						WHEN 3 THEN 3	--When SecondaryApproachOutcome = "No", then ReferralGeneralConsent = "No"
						WHEN 4 THEN 3	--When SecondaryApproachOutcome = "Undecided", then ReferralGeneralConsent = "No"
					       END
END
ELSE
BEGIN
	--IF HOSPITAL APPROACH IS BLANK, DO NOT UPDATE TRIAGE APPROACH INFORMATION (IE. USE EXISTING VALUES); OTHERWISE, USE HOSPITAL APPROACH
	IF ISNULL(@SecondaryHospitalApproach, -1) <> -1
	BEGIN
		SELECT @ReferralApproachTypeId = ISNULL(@SecondaryHospitalApproach, -1)
		SELECT @ReferralApproachedByPersonID = CASE WHEN ISNULL(@SecondaryHospitalApproachedBy, -1) = -1 THEN 0 ELSE @SecondaryHospitalApproachedBy END	--Note: SecondaryHospitalApproachedBy uses -1 for blank values, but ReferralApproachedByPersonId uses 0 for blank values
		SELECT @ReferralGeneralConsent = ISNULL(@SecondaryHospitalOutcome, -1)
	END
END

--UPDATE THE REFERRAL WITH THE NEW TRIAGE APPROACH VALUES
UPDATE Referral
SET ReferralApproachTypeId = ISNULL(@ReferralApproachTypeId, -1),
	ReferralApproachedByPersonID = ISNULL(@ReferralApproachedByPersonID, 0),
	ReferralGeneralConsent = ISNULL(@ReferralGeneralConsent, -1)
WHERE CallId = @CallId



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

