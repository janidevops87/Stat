SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ServiceLevelAutoBillable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'dropping procedure sps_ServiceLevelAutoBillable'
	drop procedure [dbo].[sps_ServiceLevelAutoBillable]
End
PRINT 'creating procedure sps_ServiceLevelAutoBillable'
GO


CREATE    PROCEDURE sps_ServiceLevelAutoBillable
		@ServiceLevelID		int

AS

/******************************************************************************
**		File: sps_ServiceLevelAutoBillable.sql
**		Name: sps_ServiceLevelAutoBillable
**		Desc: This procedure returns the AutoBill secondary status for
**		      ServiceLevelBillSecondaryManualEnable,
**		      ServiceLevelBillFamilyApproachManualEnable,
**		      ServiceLevelBillMedSocManualEnable,
**			  ServiceLevelBillApproachOnly
**
**		      If the returned value is true, manual billing is enabled which
**		      restores functionally to pre StatTrac 8.4 release. When returned
**		      values are False(0), the AutoBill feature will be enabled.
**			  The exception is when ServiceLevelBillApproachOnly is set to -1
**			  which will disable the Bill Secondary feature in StatTrac. 
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Outputs
**		----------						-----------
**		@ServiceLevelID int
**
**		Auth: Christopher Carroll
**		Date: 05/29/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		06/18/2008	ccarroll		Added ServiceLevelBillApproachOnly
*******************************************************************************/
	SELECT  ISNULL(ServiceLevelBillSecondaryManualEnable, 0) AS 'BillSecondary',
		ISNULL(ServiceLevelBillFamilyApproachManualEnable, 0) AS 'FamilyApproachManua',
		ISNULL(ServiceLevelBillMedSocManualEnable, 0) AS 'BillMedSocManual',
		ISNULL(ServiceLevelBillApproachOnly, 0) AS 'BillApproachOnly'
	FROM ServiceLevel
	WHERE ServiceLevelID = ISNULL(@ServiceLevelID,0)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO