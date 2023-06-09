SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetNDRICallSheetDefaults]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetNDRICallSheetDefaults]
GO


CREATE PROCEDURE sps_GetNDRICallSheetDefaults
	@CallId as int

AS

SELECT c.CallId, 
	c.CallDateTime, p.PersonFirst + ' ' + p.PersonLast as 'Coordinator Name', 
	r.ReferralDonorAge, r.ReferralDonorAgeUnit, r.ReferralDonorRaceID, r.ReferralDonorGender, 
	s.SecondaryPatientABO, s.SecondaryCOD, s.SecondaryCODOther, r.ReferralDonorDeathDate, 
	r.ReferralDonorDeathTime, s.SecondaryMedicalHistory as 'Other Diseases', 
	CASE s.SecondaryHistorySubstanceAbuse
		WHEN -1 THEN 0
		WHEN 3 THEN 0
		ELSE s.SecondaryHistorySubstanceAbuse
	END, 
	o.OrganizationName as 'Attending Hospital', 
	pn.PersonFirst + ' ' + pn.PersonLast as 'Attending Nurse', 
	pm.PersonFirst + ' ' + pm.PersonLast as 'Attending MD', s.SecondaryMDAttendingPhone, 
	s.SecondaryFuneralHomeName
FROM Call c
	JOIN Referral r ON c.CallId = r.CallId 
	JOIN Secondary s ON c.CallId = s.CallId 
	JOIN SecondaryApproach sa ON c.CallId = sa.CallId 
	LEFT JOIN Person p ON sa.SecondaryApproachedBy = p.PersonId
	LEFT JOIN Organization o ON r.ReferralCallerOrganizationID = o.OrganizationId
	LEFT JOIN Person pn ON r.ReferralCallerPersonID = pn.PersonId
	LEFT JOIN Person pm ON r.ReferralAttendingMD = pm.PersonId
WHERE c.CallId = @CallId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

