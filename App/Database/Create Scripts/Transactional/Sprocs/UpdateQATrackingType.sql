IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQATrackingType]
	PRINT 'Dropping Procedure: UpdateQATrackingType'
END
	PRINT 'Creating Procedure: UpdateQATrackingType'
GO

CREATE PROCEDURE [dbo].[UpdateQATrackingType]
(
	@QATrackingTypeID int,
	@OrganizationID int = NULL,
	@QATrackingTypeDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQATrackingType.sql
**		Name: UpdateQATrackingType
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
	
	UPDATE [QATrackingType]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QATrackingTypeDescription] = IsNull(@QATrackingTypeDescription, QATrackingTypeDescription),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QATrackingTypeID] = @QATrackingTypeID

	RETURN @@Error
GO