SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_QUpdatedReferralEventsLO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_QUpdatedReferralEventsLO]
GO





CREATE     PROCEDURE sps_QUpdatedReferralEventsLO
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vLeaseOrgID		Int, 
	@vTZ			varchar(2),
	@vReturnLimit 		Int = 0

AS

/*
06/02/2006 ccarroll - Added to StatTrac 80 Ref. requirement 4.9.2, LO - Lease Organization
This stored procedure will display referrals in the update tab when a review
of the referral becomes necessary. Selection is based on both Consent and Recovery
outcomes.
*/

IF @vReturnLimit > 0
     BEGIN
	SET ROWCOUNT @vReturnLimit 

	-- Limit the date range to 10 days, since only 200 are coming back anyway
	IF DateDiff(d, @vStartDate, @vEndDate) > 10
	    BEGIN
		SET @vStartDate = DateAdd(d, -10, @vEndDate)
	    END

	SET ROWCOUNT @vReturnLimit
    END

             SELECT DISTINCT
			Call.CallID,
			Call.CallNumber,
			MAX(LogEvent.LogEventDateTime) AS 'CallDateTime',  
			Referral.ReferralDonorName,
			Organization.OrganizationName,
			PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
			ReferralType.ReferralTypeName, 
			SourceCodeName,
			StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,
			Person.OrganizationID
 
	FROM		Call
	JOIN		Referral ON Referral.CallID = Call.CallID 
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN       LogEvent ON LogEvent.CAllID = Call.CallID 
	LEFT JOIN	FSCase ON FSCase.CallID = Call.CallID
	LEFT JOIN 	ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT JOIN	ReferralType AS PrevReferralType ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT JOIN	StatEmployee s ON s.StatEmployeeID = Call.CallSaveLastByID
	LEFT JOIN	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN 	Person ON Person.PersonID = StatEmployee.PersonID 

	LEFT JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	LEFT JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
	AND		WebReportGroupOrg.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE           LogEvent.LogEventDateTime between @vStartDate  AND  @vEndDate

	AND		WebReportGroup.OrgHierarchyParentID = @vLeaseOrgID

        AND	      (
                        (Select Count(LogEventID) from LogEvent where LogEvent.CallID = Call.CallID AND LogEvent.LogEventTypeID = 2) > 1 --Incoming Call
	OR		LogEvent.LogEventTypeID = 7 -- Consent OutCome
	OR		LogEvent.LogEventTypeID = 8 -- Recovery OutCome
	OR		LogEvent.LogEventTypeID = 24 -- Case Update
                       )

	AND		ISNULL(Referral.ReferralQAReviewComplete,0) <> -1 --Exclude completed QA Reviews

	AND	      (
			FSCase.CallID IS NULL
	OR		FSCase.FSCaseFinalDateTime IS NOT NULL
		       )
	GROUP BY	Call.CallID,
			Call.CallNumber,
			CallDateTime,  
			Referral.ReferralDonorName,
			Organization.OrganizationName,
			PrevReferralType.ReferralTypeName,
			ReferralType.ReferralTypeName, 
			SourceCode.SourceCodeName,
			StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName,
			Person.OrganizationID

	ORDER BY 	CallDateTime DESC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

