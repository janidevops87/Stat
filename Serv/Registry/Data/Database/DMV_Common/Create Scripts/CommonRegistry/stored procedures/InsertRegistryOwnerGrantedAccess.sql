IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistryOwnerGrantedAccess]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistryOwnerGrantedAccess]
			PRINT 'Dropping Procedure: InsertRegistryOwnerGrantedAccess'
	END

PRINT 'Creating Procedure: InsertRegistryOwnerGrantedAccess'
GO

CREATE PROCEDURE [dbo].[InsertRegistryOwnerGrantedAccess]
(
	@RegistryOwnerGrantedAccessID int = NULL OUTPUT,
	@RegistryOwnerID int,
	@RegistryGrantedOwnerID int,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: InsertRegistryOwnerGrantedAccess.sql
**		Name: InsertRegistryOwnerGrantedAccess
**		Desc:  National Web Registry
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [RegistryOwnerGrantedAccess]
	(
		[RegistryOwnerID],
		[RegistryGrantedOwnerID],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RegistryOwnerID,
		@RegistryGrantedOwnerID,
		GetDate(), --@CreateDate,
		GetDate(), --@LastModified,
		@LastStatEmployeeID,
		1 --Create @AuditLogTypeID
	)

	SELECT @RegistryOwnerGrantedAccessID = SCOPE_IDENTITY();

	RETURN @@Error
GO