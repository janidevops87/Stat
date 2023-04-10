SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralColumnAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralColumnAccess]
GO


CREATE PROCEDURE sps_ReferralColumnAccess

	@vOrgID		int	= 0,
	@vParentID 		int	= 0 


AS


SELECT 
DISTINCT    SourceCodeID, 
            AccessOrgans, 
            AccessBone, 
            AccessTissue, 
            AccessSkin, 
            AccessValves, 
            AccessEyes, 
            AccessResearch 
FROM        WebReportGroupSourceCode 
WHERE       WebReportGroupID = @vOrgID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

