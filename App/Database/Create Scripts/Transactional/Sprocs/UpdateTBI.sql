SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateTBI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure UpdateTBI'
	drop procedure [dbo].[UpdateTBI]
End
go


CREATE    PROCEDURE UpdateTBI
		@CallID				int,
		@TBIStatEmployeeID	int,
		@TBINotNeeded		smallint,
		@TBIComment			varchar (250)
		
AS
	
/******************************************************************************
**		File: UpdateTBI.sql
**		Name: UpdateTBI
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
**		@TBIStatEmployeeID	int
**		@TBINotNeeded		smallint
**		@TBIComment			varchar(250)
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

/* Update TBI comments for reason why not needed*/

	UPDATE SecondaryTBI
	    SET	SecondaryTBIAssignmentNotNeeded = @TBINotNeeded,
			SecondaryTBIAssignmentNotNeededStatEmployeeID = @TBIStatEmployeeID,
			SecondaryTBIComment = @TBIComment,
			LastModified = GetDate(),
			AuditLogTypeID = 3
		WHERE CallID = @CallID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - UpdateTBI create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - UpdateTBI procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




