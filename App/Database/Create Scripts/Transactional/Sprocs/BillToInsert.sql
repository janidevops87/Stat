IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[BillToInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[BillToInsert]
			PRINT 'Dropping Procedure: BillToInsert'
	END

PRINT 'Creating Procedure: BillToInsert'
GO

CREATE PROCEDURE [dbo].[BillToInsert]
(
	@BillToID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@Name nvarchar(100) = NULL,
	@Address1 nvarchar(80) = NULL,
	@Address2 nvarchar(80) = NULL,
	@City nvarchar(30) = NULL,
	@StateID int = NULL,
	@State varchar(50) = NULL,
	@PostalCode nvarchar(10) = NULL,
	@CountryID int = NULL,
	@CountryName varchar(50) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeId int = NULL,
	@AuditLogTypeId int = NULL
)
/******************************************************************************
**		File: BillToInsert.sql
**		Name: BillToInsert
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/6/2009	bret	initial
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [BillTo]
	(
		[OrganizationID],
		[Name],
		[Address1],
		[Address2],
		[City],
		[StateID],
		[PostalCode],
		[CountryID],
		[LastModified],
		[LastStatEmployeeId],
		[AuditLogTypeId]
	)
	VALUES
	(
		@OrganizationID,
		@Name,
		@Address1,
		@Address2,
		@City,
		@StateID,
		@PostalCode,
		@CountryID,
		@LastModified,
		@LastStatEmployeeId,
		@AuditLogTypeId
	)

	SELECT @BillToID = SCOPE_IDENTITY();

	RETURN @@Error
GO