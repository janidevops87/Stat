SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralDataUpdateAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDataUpdateAccess]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralDataUpdateAccess    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralDataUpdateAccess

	@vReportGroupID	int		= null,
	@vCallID	int		= null

AS

DECLARE
	@vSourceCodeID	int


	/* First get the source code id of the selected callid */

	SELECT	@vSourceCodeID = SourceCodeID
	FROM		Call
	WHERE	CallID = @vCallID
	

	SELECT 	WebReportGroupSourceCodeID, 
			AccessOrgansUpdate, 
			AccessBoneUpdate,
			AccessTissueUpdate,
			AccessSkinUpdate,
			AccessValvesUpdate,
			AccessEyesUpdate,
			AccessResearchUpdate
    	FROM 		WebReportGroupSourceCode
    	WHERE 	WebReportGroupID = @vReportGroupID
	AND		SourceCodeID = @vSourceCodeID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

