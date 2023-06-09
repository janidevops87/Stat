SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralDataViewAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDataViewAccess]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralDataViewAccess    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralDataViewAccess

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
			AccessOrgans, 
			AccessBone,
			AccessTissue,
			AccessSkin,
			AccessValves,
			AccessEyes,
			AccessResearch
    	FROM 		WebReportGroupSourceCode
    	WHERE 	WebReportGroupID = @vReportGroupID
	AND		SourceCodeID = @vSourceCodeID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

