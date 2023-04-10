 
IF OBJECT_ID (N'dbo.fn_rpt_ReferralDateTimeConversion') IS NOT NULL
    DROP FUNCTION dbo.fn_rpt_ReferralDateTimeConversion
GO

CREATE FUNCTION dbo.fn_rpt_ReferralDateTimeConversion
	(
	@CallID INT = NULL,	
	@ReferralStartDateTime DATETIME = NULL, 
	@ReferralEndDateTime DATETIME = NULL,
	@CardiacStartDateTime DATETIME = NULL,
	@CardiacEndDateTime DATETIME = NULL,
	@DisplayMT INT = NULL
	)
RETURNS 	@finalTable TABLE
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
**		--------	--------		-------------------------------------------
**		04/24/2008	BRET			Initial 
*******************************************************************************/
BEGIN
DECLARE @subQueryTable TABLE
	(
		CallID int,
		CallDateTime datetime,
		ReferralDonorDeathDateTime datetime
	)

-- Grab the initial set of data by expanding the date range	
INSERT 	@subQueryTable
		SELECT 
			Call.CallID,
			dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT) 'CallDateTime',		
			CASE WHEN Referral.ReferralDonorDeathDate IS NULL THEN '01/01/00'
			ELSE
			CONVERT(DATETIME,ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '01/01/00') + ' ' + CASE WHEN ISNULL(ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]' /*(LEN(ISNULL(ReferralDonorDeathTime, '')) < 8) */ THEN '00:00' ELSE ISNULL(substring( ReferralDonorDeathTime,1, 5 ), '00:00')END) 
			END 'ReferralDonorDeathDateTime'
		FROM 
			Call 
		JOIN 
			Referral ON Referral.CallID = Call.CallID 
		JOIN 
			Organization ON Organization.ORganizationID = referral.referralcallerorganizationID
		WHERE
			Call.Calldatetime BETWEEN
			DATEADD(HH, -4, ISNULL(@ReferralStartDateTime, CallDateTime)) 
			AND DATEADD(HH, 4, ISNULL(@ReferralEndDateTime, CallDateTime))			
		AND 
			( Referral.ReferralDonorDeathDate BETWEEN
			ISNULL(DATEADD(D, -1, @CardiacStartDateTime), ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '01/01/00 00:00')) AND 
			ISNULL(DATEADD(D, +1, @CardiacEndDateTime), ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '01/01/00 00:00')) 
			OR
			Referral.ReferralDonorDeathDate IS NULL
			)
			
		AND 
			ISNULL(@CallID, call.callID) = call.CallID	

-- Now grab the exact dataset
				
INSERT @finalTable
	SELECT 
		CallID, 
		CallDateTime		
	FROM @subQueryTable subQuery
 
	WHERE 
			CallDateTime BETWEEN IsNull(@ReferralStartDateTime, CallDateTime)
			AND IsNull(@ReferralEndDateTime, CallDateTime)
	AND		ReferralDonorDeathDateTime BETWEEN IsNull(@CardiacStartDateTime, ReferralDonorDeathDateTime)
			AND IsNull(@CardiacEndDateTime, ReferralDonorDeathDateTime)
	RETURN
END

GO
