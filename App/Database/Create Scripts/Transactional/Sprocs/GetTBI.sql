SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTBI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure GetTBI'
	drop procedure [dbo].[GetTBI]
End
go


CREATE    PROCEDURE GetTBI
		@CallID				int
		
AS
	
/******************************************************************************
**		File: GetTBI.sql
**		Name: GetTBI
**		Desc: This procedure 
**		
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@CallID				int
**
**
**		Auth: Christopher Carroll
**		Date: 05/31/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------

*******************************************************************************/

/* Get TBI Information */

	SELECT	SecondaryTBINumber,
			SecondaryTBIAssignmentNotNeeded,
			SecondaryTBIComment
	FROM SecondaryTBI
	WHERE CallID = @CallID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - GetTBI create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - GetTBI procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




