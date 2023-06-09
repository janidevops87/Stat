SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralTypeViewAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralTypeViewAccess]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralTypeViewAccess    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralTypeViewAccess

	@vUserOrgID	int	= null

AS

DECLARE

	@AccessTypeOTE		smallint,
	@AccessTypeTE		smallint,
	@AccessTypeEOnly	smallint,
	@AccessTypeRuleout	smallint

IF @vUserOrgID <> 194 

	SELECT 	@AccessTypeOTE = AccessTypeOTE,
			@AccessTypeTE = AccessTypeTE,
			@AccessTypeEOnly = AccessTypeEOnly,
			@AccessTypeRuleout = AccessTypeRuleout
	
    	FROM 		WebReportGroupSourceCode 
	JOIN 		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	OrgHierarchyParentID = @vUserOrgID
	AND		WebReportGroupMaster = 1

ELSE

	SELECT 	@AccessTypeOTE = 1,
			@AccessTypeTE = 1,
			@AccessTypeEOnly = 1,
			@AccessTypeRuleout = 1


	SELECT	ReferralTypeID, ReferralTypeName,
		CASE ReferralTypeID
			WHEN 1 THEN @AccessTypeOTE
			WHEN 2 THEN @AccessTypeTE
			WHEN 3 THEN @AccessTypeEOnly
			WHEN 4 THEN @AccessTypeRuleout
		END

	FROM 	ReferralType





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

