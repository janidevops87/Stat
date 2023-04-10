SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SecondaryAutoBillFamilyApproach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spu_SecondaryAutoBillFamilyApproach]
	PRINT 'Dropping Procedure: spu_SecondaryAutoBillFamilyApproach'
End
GO

PRINT 'Creating Procedure: spu_SecondaryAutoBillFamilyApproach'
GO

CREATE    PROCEDURE spu_SecondaryAutoBillFamilyApproach
	@CallID		int,
	@StatEmployeeID	int

AS

/******************************************************************************
**		File: spu_SecondaryAutoBillFamilyApproach.sql
**		Name: spu_SecondaryAutoBillFamilyApproach
**		Desc: This procedure updates case billing information when a Family Approach event is added in StatTrac.
**              
**		Return values:
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@CallID 		int
**		@StatEmployeeID		int
**
**		Auth: Christopher Carroll
**		Date: 05/22/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		07/30/2008	ccarroll		Prevent StatEmployeeID and FSCaseBillApproachDateTime
**									from updating after initial update per AutoBill requirement 3.3.2  
*******************************************************************************/

DECLARE @CountBillable int

SET @CountBillable = (SELECT IsNull(FSCaseBillApproachCount,0)
		       FROM FSCase
		       WHERE CallID = @CallID
			)

SELECT @CountBillable = (@CountBillable + 1)

IF (SELECT isNull(FSCaseBillApproachUserID, 0) FROM FSCase WHERE CallID = @CallID) = 0
	BEGIN 
		UPDATE FSCase
			SET FSCaseBillApproachUserID = @StatEmployeeID,
				FSCaseBillApproachDateTime = GetDate(),
				FSCaseBillApproachCount = @CountBillable
			WHERE CallID = @CallID
	END

ELSE
	BEGIN
		UPDATE FSCase
			SET	FSCaseBillApproachCount = @CountBillable
			WHERE CallID = @CallID
	END


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
