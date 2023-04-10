IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAProcessStep]
	PRINT 'Dropping Procedure: UpdateQAProcessStep'
END
	PRINT 'Creating Procedure: UpdateQAProcessStep'
GO

CREATE PROCEDURE [dbo].[UpdateQAProcessStep]
(
	@QAProcessStepID int,
	@OrganizationID int = NULL,
	@QAProcessStepDescription varchar(255) = NULL,
	@QAProcessStepActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAProcessStep.sql
**		Name: UpdateQAProcessStep
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/22/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/22/2009	ccarroll	initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QAProcessStep]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QAProcessStepDescription] = IsNull(@QAProcessStepDescription, QAProcessStepDescription),
		[QAProcessStepActive] = IsNull(@QAProcessStepActive, QAProcessStepActive),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAProcessStepID] = @QAProcessStepID

	RETURN @@Error
GO

