IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportReferralTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportReferralTypeDropDown';
		DROP Procedure sps_ReportReferralTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportReferralTypeDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportReferralTypeDropDown]
	@ReportGroupID	INT = NULL,
	@SourceCodeID INT = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportReferralTypeDropDown.sql
**	Name: sps_ReportReferralTypeDropDown
**	Desc: Populates dropdown for report Referral type dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/23/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/23/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON ;
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
	AND		SourceCodeID = ISNULL(@SourceCodeID, SourceCodeID);

SELECT 
	ReferralTypeID as [value],
	ReferralTypeName as [label]
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
	
)	;

GO

GRANT EXEC ON sps_ReportSortTypeDropDown TO PUBLIC;
GO
