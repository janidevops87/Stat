 SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTBIAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure GetTBIAccess'
	drop procedure [dbo].[GetTBIAccess]
End
go


CREATE    PROCEDURE GetTBIAccess
		@UserServiceLevelID				int
		
AS
	
/******************************************************************************
**		File: GetTBIAccess.sql
**		Name: GetTBIAccess.sql
**		Desc:  This procedure queries Secondary ServiceLevel to see if TBI is visible. 
**		
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@UserServiceLevelID					int
**
**
**		Auth: Christopher Carroll
**		Date: 06/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------

*******************************************************************************/

/* Get TBI ServiceLevel */

	SELECT CASE ISNULL(Visible,0) WHEN -1 THEN 1 ELSE 0 END AS 'TBIAccess'
	FROM ServiceLevelSecondaryCtls
	WHERE ServiceLevelID = @UserServiceLevelID
	and ControlName LIKE 'SecondaryTBINumber'	
	
	



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - GetTBIAccess create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - GetTBIAccess procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




