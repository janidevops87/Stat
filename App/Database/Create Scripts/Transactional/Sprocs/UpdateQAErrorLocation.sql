IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAErrorLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAErrorLocation]
	PRINT 'Dropping Procedure: UpdateQAErrorLocation'
END
	PRINT 'Creating Procedure: UpdateQAErrorLocation'
GO

CREATE PROCEDURE [dbo].[UpdateQAErrorLocation]
(
	@QAErrorLocationID int,
	@OrganizationID int = NULL,
	@QAErrorLocationDescription varchar(255) = NULL,
	@QAErrorLocationActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAErrorLocation.sql
**		Name: UpdateQAErrorLocation
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
	
	UPDATE [QAErrorLocation]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QAErrorLocationDescription] = IsNull(@QAErrorLocationDescription, QAErrorLocationDescription),
		[QAErrorLocationActive] = IsNull(@QAErrorLocationActive, QAErrorLocationActive),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAErrorLocationID] = @QAErrorLocationID

	RETURN @@Error
GO
