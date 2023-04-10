SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Set_ServiceLevelAutoBillable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure spu_Set_ServiceLevelAutoBillable'
	DROP PROCEDURE [dbo].[spu_Set_ServiceLevelAutoBillable]
END
GO

PRINT 'Creating Procedure spu_Set_ServiceLevelAutoBillable'
GO

CREATE    PROCEDURE spu_Set_ServiceLevelAutoBillable
		@ServiceLevelID		int = Null,
		@BillSecondary		smallint = Null,
		@BillFamilyApproach	smallint = Null,
		@BillMedSoc		smallint = Null,
		@BillApproachOnly smallint = Null
AS

/******************************************************************************
**		File: spu_Set_ServiceLevelAutoBillable.sql
**		Name: spu_Set_ServiceLevelAutoBillable
**		Desc: This procedure sets the AutoBill secondary status for
**		      ServiceLevelBillSecondaryManualEnable,
**		      ServiceLevelBillFamilyApproachManualEnable,
**		      ServiceLevelBillMedSocManualEnable
**			  Instructions for usage found at end
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
**		06/19/2008	ccarroll		Added BillApproachOnly to SeviceLevel set
*******************************************************************************/
	Update ServiceLevel SET ServiceLevelBillSecondaryManualEnable = ISNULL(@BillSecondary, 0),
				ServiceLevelBillFamilyApproachManualEnable = ISNULL(@BillFamilyApproach, 0),
				ServiceLevelBillMedSocManualEnable = ISNULL(@BillMedSoc, 0),
				ServiceLevelBillApproachOnly = ISNULL(@BillApproachOnly, 0)
	WHERE ServiceLevelID = ISNULL(@ServiceLevelID,0)

/*
Instructions for disabling StatTrac 8.4 AutoBill feature 
	1. Find the servicelevel(s) to change
	2. Run the sproc to change the values 



1. To find servicelevels, use the following SELECT query:

	SELECT * FROM ServiceLevel WHERE ServiceLevelGroupName LIKE 'CA- OneLegacy/Transplantline All' AND ServiceLevelStatus in (1, 0)

	This query will return servicelevels which have a Status of both 0 and 1.
	Two servicelevelID's should be returned. run the sproc for both servicelevelIDs.
	When a serviceLevelStatus is set to 0, it is currently in use.

2. Executing the Sproc

Usage example:
	exec spu_Set_ServiceLevelAutoBillable 6643, -1, -1, -1, 0


Sproc Input detail(possible values):
	@ServiceLevelID		int = Null,
	@BillSecondary		(0, -1),
	@BillFamilyApproach	(0, -1),
	@BillMedSoc		(0, -1),
	@BillApproachOnly (0, -1)

Notes:
	If an input value is set to -1, it indicates that auto billing feature will become inactive (pre 8.4 release.) If a value is set to zero(default), it indicates
	that auto billing feature (outlined in StatTrac 8.4 requirement 3.2) will become active. The only exception is to BillApproachOnly where
	-1 turns BillApproachOnly on. To set the billing feature to pre 8.4 release,
	the value needs to be set to -1 (turns the feature off.)
	
	ServiceLevelBillApproachOnly - When this feature is turned on (-1) Bill Secondary
	counts are disabled. This is primarily used when the organization is a ME/Coroner and
	the only billing counts will be from family approaches. See StatTrac 8.4.6 requirements
	Automatic Billing for Family Services, rev.2
	
Examples:

	a. exec spu_Set_ServiceLevelAutoBillable 6643, -1, 0, 0, 0
	- Sets Bill Secondary to pre 8.4 release (manually enable)

	b. exec spu_Set_ServiceLevelAutoBillable 6643, 0, -1, 0, 0
	- Sets Bill Family Approach to pre 8.4 release (manually enable)

	c. exec spu_Set_ServiceLevelAutoBillable 6643, 0, 0, -1, 0
	- Sets Bill Med Soc to pre 8.4 release (manually enable)

	d. exec spu_Set_ServiceLevelAutoBillable 6643, 0, 0, -1, -1
	- Sets Auto Bill Secondary On
	- Sets Auto Bill Family Approach On
	- Sets Auto Bill Med Soc Off (pre 8.4 release)
	- Sets Bill Approach Only On
	
*/




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
