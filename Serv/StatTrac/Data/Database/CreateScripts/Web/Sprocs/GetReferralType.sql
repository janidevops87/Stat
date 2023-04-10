IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralType')
	BEGIN
		PRINT 'Dropping Procedure GetReferralType'
		DROP  Procedure  GetReferralType
	END

GO

PRINT 'Creating Procedure GetReferralType'
GO
CREATE Procedure GetReferralType
	@ReportGroupID	INT = NULL,
	@SourceCodeID INT = NULL
AS

/******************************************************************************
**		File: GetReferralType.sql
**		Name: GetReferralType
**		Desc: Obtains a list of Referral Types from the ReferralType table.
**
**              
**		Return values:
** 
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 9/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		9/10/2007	Bret Knoll			Release Referral Summary
**		11/25/2008	Bret Knoll			WI 2364 Pending Referrals Requires paramter set ReferralTypes
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON 
DECLARE 
			@AccessTypeOTE INT,
			@AccessTypeTE INT,
			@AccessTypeEOnly INT,
			@AccessTypeRuleout INT

	SELECT 	TOP 1
			@AccessTypeOTE = AccessTypeOTE,
			@AccessTypeTE = AccessTypeTE,
			@AccessTypeEOnly = AccessTypeEOnly,
			@AccessTypeRuleout = AccessTypeRuleout	
    FROM 	WebReportGroupSourceCode 
	WHERE 	WebReportGroupSourceCode.WebReportGroupID = ISNULL(@ReportGroupID,WebReportGroupSourceCode.WebReportGroupID) 
	AND		SourceCodeID = ISNULL(@SourceCodeID, SourceCodeID)

SELECT 
	ReferralTypeID,
	ReferralTypeName 
FROM 
	ReferralType
WHERE
	Inactive = 0
AND 
(
	ReferralTypeID = CASE WHEN @AccessTypeOTE = 1 THEN 1 ELSE -1 END
	OR
	ReferralTypeID = CASE WHEN @AccessTypeTE = 1 THEN 2 ELSE -1 END
	OR
	ReferralTypeID = CASE WHEN @AccessTypeEOnly = 1 THEN 3 ELSE -1 END
	OR
	ReferralTypeID = CASE WHEN @AccessTypeRuleout = 1 THEN 4 ELSE -1 END
	
)		

GO

GRANT EXEC ON GetReferralType TO PUBLIC

GO
