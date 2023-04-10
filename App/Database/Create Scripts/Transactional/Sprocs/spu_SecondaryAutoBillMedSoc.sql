SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SecondaryAutoBillMedSoc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spu_SecondaryAutoBillMedSoc]
End
go


CREATE    PROCEDURE spu_SecondaryAutoBillMedSoc
	@CallID		int,
	@StatEmployeeID	int

AS

/******************************************************************************
**		File: spu_SecondaryAutoBillMedSoc.sql
**		Name: spu_SecondaryAutoBillMedSoc
**		Desc: Notes: 	This procedure updates case billing information when the DonorTrac button
**				is pressed in StatTrac.
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

*******************************************************************************/


DECLARE @CountBillable int

SET @CountBillable = (SELECT IsNull(FSCaseBillMedSocCount,0)
		       FROM FSCase
		       WHERE CallID = @CallID
			)

SELECT @CountBillable = (@CountBillable + 1)


UPDATE FSCase
	SET FSCaseBillMedSocUserID = @StatEmployeeID,
	    FSCaseBillMedSocDateTime = GetDate(),
	    FSCaseBillMedSocCount = @CountBillable
	WHERE CallID = @CallID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_SecondaryAutoBillMedSoc create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - spu_SecondaryAutoBillMedSoc created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




