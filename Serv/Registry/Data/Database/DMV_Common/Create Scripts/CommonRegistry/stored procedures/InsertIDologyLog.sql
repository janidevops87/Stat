IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertIDologyLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertIDologyLog]
			PRINT 'Dropping Procedure: InsertIDologyLog'
	END

PRINT 'Creating Procedure: InsertIDologyLog'
GO

CREATE PROCEDURE [dbo].[InsertIDologyLog]
(
	@IDologyLogID int = NULL OUTPUT,
	@RegistryID int = NULL,
	@IDologyLogNumberID int = NULL,
	@IDologyLogRequest nvarchar(2000) = NULL,
	@IDologyLogResponse nvarchar(2000) = NULL,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: InsertIDologyLog.sql
**		Name: InsertIDologyLog
**		Desc:  Common Web Registry
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/02/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [IDologyLog]
	(
		[RegistryID],
		[IDologyLogNumberID],
		[IDologyLogRequest],
		[IDologyLogResponse],
		[CreateDate],
		[LastModified],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RegistryID,
		@IDologyLogNumberID,
		@IDologyLogRequest,
		@IDologyLogResponse,
		GetDate(), --@CreateDate
		GetDate(), --@LastModified
		1		 --Create
	)

	SELECT @IDologyLogID = SCOPE_IDENTITY();

	RETURN @@Error
GO