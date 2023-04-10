SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTBIPrefix]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure GetTBIPrefix'
	drop procedure [dbo].[GetTBIPrefix]
End
go


CREATE    PROCEDURE GetTBIPrefix
		@CallServiceLevelID				int
		
AS
	
/******************************************************************************
**		File: GetTBIPrefix.sql
**		Name: GetTBIPrefix
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
**		@CallServiceLevelID				int
**
**
**		Auth: Christopher Carroll
**		Date: 06/05/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------

*******************************************************************************/

/* Get TBIPrefix */

	SELECT	ServiceLevelSecondaryTBIPrefix
	FROM ServiceLevelSecondary
	WHERE ServiceLevelID = @CallServiceLevelID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - GetTBIPrefix create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - GetTBIPrefix procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




