IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralTypeActive')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralTypeActive'
		DROP  Procedure  sps_rpt_ReferralTypeActive
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralTypeActive'
GO
CREATE Procedure sps_rpt_ReferralTypeActive

AS

/******************************************************************************
**		File: sps_rpt_ReferralTypeActive.sql
**		Name: sps_rpt_ReferralTypeActive
**		Desc: This sproc returns a list of active referral types
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
**		Date: 08/31/2007 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/31/2007		ccarroll				initial
*******************************************************************************/

	SELECT 0 AS 'ReferralTypeID', 'All' AS 'ReferralTypeName' -- Default

	UNION ALL

	SELECT ReferralTypeID, ReferralTypeName FROM ReferralType
	WHERE Inactive = 0


GO
