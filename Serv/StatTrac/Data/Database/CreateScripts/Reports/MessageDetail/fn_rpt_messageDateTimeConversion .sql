SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_rpt_MessageDateTimeConversion]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_rpt_MessageDateTimeConversion]
GO


CREATE FUNCTION dbo.fn_rpt_MessageDateTimeConversion
	(
	@CallID INT = NULL,	
	@MessageStartDateTime DATETIME = NULL, 
	@MessageEndDateTime DATETIME = NULL,
	@DisplayMT INT = NULL
	)
RETURNS 	@finalTable TABLE
	(
		CallID int,
		CallDateTime datetime
	)
AS 
/******************************************************************************
**		File: fn_rpt_MessageDateTimeConversion.sql
**		Name: fn_rpt_MessageDateTimeConversion
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
			CallDateTime, calldate Date and Time, and CallID
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
**		Auth: jth 
**		Date: 5/20/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**		05/20/2008	jth			Initial 
*******************************************************************************/
BEGIN

DECLARE @subQueryTable TABLE
	(
		CallID int,
		CallDateTime datetime
		
	)

INSERT 	@subQueryTable
		SELECT 
			Call.CallID,
			dbo.fn_rpt_ConvertDateTime(ISNULL(Message.organizationID, 194), Call.CallDateTime, @DisplayMT) 'CallDateTime'
		From Call 
		JOIN 
			Message ON Message.CallID = Call.CallID 
		LEFT JOIN 
			Organization ON Organization.OrganizationID = Message.organizationID

		Where Call.Calldatetime BETWEEN
			DATEADD(HH, -4, ISNULL(@MessageStartDateTime, CallDateTime)) 
			AND DATEADD(HH, 4, ISNULL(@MessageEndDateTime, CallDateTime))	
			AND ISNULL(@CallID, call.callID) = call.CallID	
-- Now grab the exact dataset
				
INSERT @finalTable
	SELECT 
		CallID, 
		CallDateTime
	FROM @subQueryTable subQuery
 	
	WHERE 
			CallDateTime BETWEEN IsNull(@MessageStartDateTime, CallDateTime)
			AND IsNull(@MessageEndDateTime, CallDateTime)
			AND ISNULL(@CallID, callID) = CallID	
	
	RETURN
END


