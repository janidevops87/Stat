SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_UpdatedReferralEvents')
	BEGIN
		PRINT 'Dropping Procedure sps_UpdatedReferralEvents'
		DROP  Procedure  sps_UpdatedReferralEvents
	END

GO

PRINT 'Creating Procedure sps_UpdatedReferralEvents'
GO
CREATE Procedure sps_UpdatedReferralEvents
	@vStartDate			datetime = null,
	@vEndDate			datetime = null,
	@vTZ				varchar(2),
	@CallNumber			varchar(15) = null,
	@Location			varchar(80) = null,
	@State				varchar(2) = null,
	@PatientFirst		varchar(40) = null,
	@PatientLast		varchar(40) = null,
	@ReferralType		varchar(50) = null,
	@PreReferralType	varchar(50) = null,
	@SourceCodeName		varchar(10) = null,
	@TcName				varchar(50) = null,
	@vReturnLimit 		Int = 0

AS

/******************************************************************************
**		File: sps_UpdatedReferralEvents.sql
**		Name: sps_UpdatedReferralEvents
**		Desc: StatTrac 80 Ref. requirement 4.9.2
**			  This stored procedure will display referrals in the update tab when a review
**			  of the referral becomes necessary. Selection is based on both Consent and Recovery
**			  outcomes.
**
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 06/02/2006
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		06/02/2006  ccarroll			initial
**		08/03/2006	ccarroll			Changed to display LogEventDateTime as CallDateTime
**		07/17/2007  ccarroll			optimized performance of table joins
**		10/03/2007  ccarroll			added new parameters and removed from SQL from StatTrac
**		10/16/2007	ccarroll			removed online events and ASP referrals
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


			IF @vReturnLimit > 0
				BEGIN
				SET ROWCOUNT @vReturnLimit

				/* Limit the date range to 10 days, since only 200 are coming back anyway */
						IF DateDiff(d, @vStartDate, @vEndDate) > 10
							BEGIN
							SET @vStartDate = DateAdd(d, -10, @vEndDate)
							END

				SET ROWCOUNT @vReturnLimit
				END
   
			/* Allow wildcard search */
			/* CallNumber */
				IF ISNull(@CallNumber, '') <> ''
					BEGIN
						SET @CallNumber = @CallNumber + '%'
					END
				ELSE
					BEGIN
						SET @CallNumber = Null
					END

			/* Location */
				IF ISNull(@Location, '') <> ''
					BEGIN
						SET @Location = @Location + '%'
					END
				ELSE
					BEGIN
						SET @Location = Null
					END

			/* State */
				IF IsNull(@State, '') <> ''
					BEGIN
						SET @State = @State + '%'
					END
				ELSE
					BEGIN
						SET @State = Null
					END

			/* PatientFirst */
				IF IsNull(@PatientFirst, '') <> ''
					BEGIN
						SET @PatientFirst = @PatientFirst + '%'
					END
				ELSE
					BEGIN
						SET @PatientFirst = Null
					END

			/* PatientLast */
				IF ISNull(@PatientLast, '') <> ''
					BEGIN
						SET @PatientLast = @PatientLast + '%'
					END
				ELSE
					BEGIN
						SET @PatientLast = Null
					END

			/* ReferralType */
				IF ISNull(@ReferralType, '') <> ''
					BEGIN
						SET @ReferralType = @ReferralType + '%'
					END
				ELSE
					BEGIN
						SET @ReferralType = Null
					END

			/* PreReferralType */
				IF ISNull(@PreReferralType, '') <> ''
					BEGIN
						SET @PreReferralType = @PreReferralType + '%'
					END
				ELSE
					BEGIN
						SET @PreReferralType = Null
					END

			/* SourceCodeName */
				IF ISNull(@SourceCodeName, '') <> ''
					BEGIN
						SET @SourceCodeName = @SourceCodeName + '%'
					END
				ELSE
					BEGIN
						SET @SourceCodeName = Null
					END
					
			/* TcName */
				IF ISNull(@TcName, '') <> ''
					BEGIN
						SET @TcName = @TcName + '%'
					END
				ELSE
					BEGIN
						SET @TcName = Null
					END


             SELECT DISTINCT
			Call.CallID,
			Call.CallNumber,
			MAX(LogEvent.LastModified) AS 'CallDateTime', 
			Referral.ReferralDonorName,
			Organization.OrganizationName,
			PreReferralType.ReferralTypeName AS PrevReferralTypeName,
			ReferralType.ReferralTypeName,
			SourceCode.SourceCodeName,
			StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,
			PO.OrganizationID

	FROM		Call
	JOIN		LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN	Referral ON Referral.CallID = Call.CallID
	LEFT JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN	State ON State.StateID = Organization.StateID
	LEFT JOIN	FSCase ON FSCase.CallID = Call.CallID
	LEFT JOIN	ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID
	LEFT JOIN	ReferralType AS PreReferralType ON PreReferralType.ReferralTypeId = Referral.ReferralTypeID

	LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.CallSaveLastByID /* was Call.CallSaveLastByID OR LogEvent.LastStatEmployeeID*/
	LEFT JOIN 	Person ON Person.PersonID = StatEmployee.PersonID
	/* added join for Person that took the call */
	LEFT JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	

	WHERE   LogEvent.LastModified > @vStartDate 
	AND		LogEvent.LastModified < @vEndDate

	/* Search (wildcards permitted) - CallNumber */
	AND PATINDEX(IsNull(@CallNumber, IsNull(Call.CallNumber, 0)), IsNull(Call.CallNumber, 0)) > 0

	/* Search (wildcards permitted) - Location */
	AND PATINDEX(IsNull(@Location, IsNull(Organization.OrganizationName, 0)), IsNull(Organization.OrganizationName, 0)) > 0
	
	/* Search (wildcards permitted) - State */
	AND PATINDEX(IsNull(@State, IsNull(State.StateAbbrv, 0)), IsNull(State.StateAbbrv, 0)) > 0

	/* Search (wildcards permitted) - PatientFirst */
	AND PATINDEX(IsNull(@PatientFirst, IsNull(Referral.ReferralDonorFirstName, 0)), IsNull(Referral.ReferralDonorFirstName, 0)) > 0

	/* Search (wildcards permitted) - PatientLast */
	AND PATINDEX(IsNull(@PatientLast, IsNull(Referral.ReferralDonorLastName, 0)), IsNull(Referral.ReferralDonorLastName, 0)) > 0

	/* Search (wildcards permitted) - ReferralType */
	AND PATINDEX(IsNull(@ReferralType, IsNull(ReferralType.ReferralTypeName, 0)), IsNull(ReferralType.ReferralTypeName, 0)) > 0

	/* Search (wildcards permitted) - PreReferralType */
	AND PATINDEX(IsNull(@PreReferralType, IsNull(PreReferralType.ReferralTypeName, 0)), IsNull(PreReferralType.ReferralTypeName, 0)) > 0

	/* Search (wildcards permitted) - SourceCodeName */
	AND PATINDEX(IsNull(@SourceCodeName, IsNull(SourceCode.SourceCodeName, 0)), IsNull(SourceCode.SourceCodeName, 0)) > 0

	/* Search (wildcards permitted) - TcName */
	AND PATINDEX(IsNull(@TcName, IsNull(StatEmployee.StatEmployeeFirstName, 0)), IsNull(StatEmployee.StatEmployeeFirstName, 0)) > 0


	AND		ISNULL(Referral.ReferralQAReviewComplete,0) = 1 --Show referrals waiting for QA Review (StatLine)
	AND	      (
				FSCase.CallID IS NULL
				OR FSCase.FSCaseFinalDateTime IS NOT NULL
		      )

	AND		LogEvent.StatEmployeeID <> '77' -- Online event update
	AND		Call.StatemployeeID <> 888  --T.T OnlineHospital Referral

--	AND		IsNull(PO.OrganizationLO, 0) <> -1
--	AND		(PO.OrganizationLOTriageEnabled = 0 AND PO.OrganizationLO <> -1)
    AND    (
               (Select Count(LogEventID) from LogEvent where LogEvent.CallID = Call.CallID AND LogEvent.LogEventTypeID = 2) > 1 --Incoming Call
				OR	LogEvent.LogEventTypeID IN (7, 8, 24) -- 7.Consent Outcome, 8.Recovery Outcome, 24.Case Update
           )

	GROUP BY	Call.CallID,
			Call.CallNumber,
			CallDateTime, 
			Referral.ReferralDonorName,
			Organization.OrganizationName,
			PreReferralType.ReferralTypeName,
			ReferralType.ReferralTypeName,
			SourceCode.SourceCodeName,
			StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName,
			PO.OrganizationID

	ORDER BY 	CallDateTime DESC


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

