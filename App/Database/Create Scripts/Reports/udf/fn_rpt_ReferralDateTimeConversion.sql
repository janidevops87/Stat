 
IF OBJECT_ID (N'dbo.fn_rpt_ReferralDateTimeConversion') IS NOT NULL
    DROP FUNCTION dbo.fn_rpt_ReferralDateTimeConversion
GO

CREATE FUNCTION dbo.fn_rpt_ReferralDateTimeConversion
(
	@CallID					INT = NULL,
	@ReferralStartDateTime	DATETIME = NULL, 
	@ReferralEndDateTime	DATETIME = NULL,
	@CardiacStartDateTime	DATETIME = NULL,
	@CardiacEndDateTime		DATETIME = NULL,
	@DisplayMT				INT = NULL
)
RETURNS @finalTable TABLE
(
	CallID int,
	CallDateTime datetime
)
AS 
/******************************************************************************
**		File: fn_rpt_ReferralDateTimeConversion.sql
**		Name: fn_rpt_ReferralDateTimeConversion
**		Desc: 
**
			This function is used to isolate the querying of detail data and the 
			conversion to the Referral Facility Time Zone. When the table is populated 
			with data before and after the date ranges. To do this 4 hours is subtracted 
			from the start date parameter and 4 hours is added to the end date parameter. 
			
			The data is pushed into a variable table @subQueryTable isolating by
			CallDateTime, ReferralDonorDeath Date and Time, and CallID
			
			The functions variable table is then filled based on the Parameters the user 
			requested.
			
		To Use this function:
			join against this function as if it is a table with PK of CallID. The joining Where 
			clause only has to weed out any additional parameter beyond 
			CallDateTime, ReferralDonorDeath Date and Time, and CallID
**
**
**              
**		Return values:
** 
**		Called by: storedprocedures for ReferralDetail.rdl, ReferralOutcome
**		and any report where conversion is required
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll 
**		Date: 4/24/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		04/24/2008	BRET				Initial 
**		06/01/2020	James Gerberich		Refactored
**		08/03/2020	James Gerberich		Moved dateadd functions out of WHERE clause
*******************************************************************************/
BEGIN
DECLARE @subQueryTable TABLE
(
	CallID int,
	CallDateTime datetime,
	ReferralDonorDeathDateTime datetime
);
DECLARE
	@vReferralStartDateTime	smalldatetime = (SELECT DATEADD(HH, -4, @ReferralStartDateTime)),
	@vReferralEndDateTime	smalldatetime = (SELECT DATEADD(HH, 4, @ReferralEndDateTime)),
	@vCardiacStartDateTime	smalldatetime = (SELECT DATEADD(D, -1, @CardiacStartDateTime)),
	@vCardiacEndDateTime	smalldatetime = (SELECT DATEADD(D, 1, @CardiacEndDateTime))

INSERT 	@subQueryTable
SELECT 
	[Call].CallID,
	dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, [Call].CallDateTime, @DisplayMT) 'CallDateTime',	
	CASE WHEN Referral.ReferralDonorDeathDate IS NULL THEN '01/01/00'
	ELSE
	CONVERT(DATETIME,ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '01/01/00') + ' ' 
	+ CASE 
		WHEN ISNULL(ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]'
		THEN '00:00' 
		ELSE ISNULL(substring( ReferralDonorDeathTime,1, 5 ), '00:00')
		END) 
	END 'ReferralDonorDeathDateTime'
FROM 
	Referral
	INNER JOIN [Call] ON Referral.CallID = [Call].CallID 
WHERE
	[Call].CallId = @CallID
OR	(
		@CallID IS NULL
	AND	(
			(
				@vReferralStartDateTime IS NULL
			OR	CallDateTime >= @vReferralStartDateTime
			)
		AND	(
				@vReferralEndDateTime IS NULL
			OR	CallDateTime <= @vReferralEndDateTime
			)
		)
	AND (--- TODO: Review Referral.ReferralDonorDeathDate conversion to date
			(
				@vCardiacStartDateTime IS NULL
			OR	Referral.ReferralDonorDeathDate >= @vCardiacStartDateTime
			)
		AND	(
				@vCardiacEndDateTime IS NULL
			OR	Referral.ReferralDonorDeathDate <= @vCardiacEndDateTime
			)
		)
	);

-- Now grab the exact dataset

INSERT @finalTable
SELECT 
	CallID, 
	CallDateTime		
FROM @subQueryTable subQuery
WHERE
	(
		(
			@ReferralStartDateTime IS NULL
		OR	CallDateTime >= @ReferralStartDateTime
		)
	AND (
			@ReferralEndDateTime IS NULL
		OR	CallDateTime <= @ReferralEndDateTime
		)
	)
AND	(
		(
			@CardiacStartDateTime IS NULL
		OR	ReferralDonorDeathDateTime >= @CardiacStartDateTime
		)
	AND (
			@CardiacEndDateTime IS NULL
		OR	ReferralDonorDeathDateTime <= @CardiacEndDateTime
		)
	);
		
RETURN
END

GO
