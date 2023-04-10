IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralCauseOfDeathActive')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralCauseOfDeathActive'
		DROP  Procedure  sps_rpt_ReferralCauseOfDeathActive
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralCauseOfDeathActive'
GO
CREATE Procedure sps_rpt_ReferralCauseOfDeathActive

AS

/******************************************************************************
**		File: sps_rpt_ReferralCauseOfDeathActive.sql
**		Name: sps_rpt_ReferralCauseOfDeathActive
**		Desc: This sproc returns a list of active referral CauseOfDeaths
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 11/27/2007 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      11/27/2007		ccarroll				initial
*******************************************************************************/

	SELECT 0 AS 'CauseOfDeathID', 'All' AS 'CauseOfDeathName' -- Default
	UNION ALL

	SELECT CauseOfDeathID, CauseOfDeathName FROM CauseOfDeath
	WHERE Inactive = 0


GO
