IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportPendingReferralTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportPendingReferralTypeDropDown';
		DROP Procedure sps_ReportPendingReferralTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportPendingReferralTypeDropDown';
GO

CREATE PROCEDURE [dbo].[sps_ReportPendingReferralTypeDropDown]
	@ReportGroupID	int	= null
AS

/******************************************************************************
**	File: sps_ReportPendingReferralTypeDropDown.sql
**	Name: sps_ReportPendingReferralTypeDropDown
**	Desc: Populates dropdown for pending referral types in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/02/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/02/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
DECLARE
	@Results Table
		(
			ReferralTypeID		Int,
			ReferralTypeName	VarChar(10),
			AccessType			Int
		);

----------------------------------------------------------

DECLARE
	@AccessTypeOTE		smallint,
	@AccessTypeTE		smallint,
	@AccessTypeEOnly	smallint,
	@AccessTypeRuleout	smallint;

----------------------------------------------------------

IF @ReportGroupID <> 37
	SELECT
		@AccessTypeOTE		= rg.AccessTypeOTE,
		@AccessTypeTE		= rg.AccessTypeTE,
		@AccessTypeEOnly	= rg.AccessTypeEOnly,
		@AccessTypeRuleout	= rg.AccessTypeRuleout
    FROM
		WebReportGroupSourceCode rg
		JOIN SourceCode sc ON rg.SourceCodeID = sc.SourceCodeID AND sc.SourceCodeType = 1
	WHERE
		WebReportGroupID = @ReportGroupID;
ELSE
	SELECT
		@AccessTypeOTE = 1,
		@AccessTypeTE = 1,
		@AccessTypeEOnly = 1,
		@AccessTypeRuleout = 1;

----------------------------------------------------------

INSERT INTO @Results
	SELECT
		0 AS ReferralTypeID,
		'- All -' AS ReferralTypeName,
		CASE
			WHEN
				@AccessTypeOTE = 1
			AND	@AccessTypeTE = 1
			AND	@AccessTypeEOnly = 1
			AND	@AccessTypeRuleout = 1
			THEN 1
			ELSE 0
		END
UNION
	SELECT
		ReferralTypeID,
		CASE
			WHEN ReferralTypeID = 1 THEN 'Organs'
			WHEN ReferralTypeID = 2 THEN 'Tissue'
			WHEN ReferralTypeID = 3 THEN 'Eyes'
			WHEN ReferralTypeID = 4 THEN 'Ruleout'
		END AS ReferralTypeName,
		CASE ReferralTypeID
			WHEN 1 THEN @AccessTypeOTE
			WHEN 2 THEN @AccessTypeTE
			WHEN 3 THEN @AccessTypeEOnly
			WHEN 4 THEN @AccessTypeRuleout
		END
	FROM 	ReferralType;

----------------------------------------------------------

SELECT
	ReferralTypeID as [value],
	ReferralTypeName as [label]
FROM
	@Results
WHERE	
	ReferralTypeID <> 4
AND	IsNull(AccessType,0) <> 0;


GO

GRANT EXEC ON sps_ReportPendingReferralTypeDropDown TO PUBLIC;
GO
