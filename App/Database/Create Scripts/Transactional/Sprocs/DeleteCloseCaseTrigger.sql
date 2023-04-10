IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteCloseCaseTrigger]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteCloseCaseTrigger]
	PRINT 'Dropping Procedure: DeleteCloseCaseTrigger'
END
	PRINT 'Creating Procedure: DeleteCloseCaseTrigger'
GO

CREATE PROCEDURE [dbo].[DeleteCloseCaseTrigger]
(
	@CloseCaseTriggerID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteCloseCaseTrigger.sql
**		Name: DeleteCloseCaseTrigger
**		Desc:  Used on StatFile
**
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	Bret Knoll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [CloseCaseTrigger]
	WHERE  
		[CloseCaseTriggerID] = @CloseCaseTriggerID

	RETURN @@Error
GO
