 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[BillToUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[BillToUpdate]
	PRINT 'Dropping Procedure: BillToUpdate'
END
	PRINT 'Creating Procedure: BillToUpdate'
GO

CREATE PROCEDURE [dbo].[BillToUpdate]
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
**		File: BillToUpdate.sql
**		Name: BillToUpdate
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
	
	UPDATE [BillTo]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[Name] = IsNull(@Name, Name),
		[Address1] = IsNull(@Address1, Address1),
		[Address2] = IsNull(@Address2, Address2),
		[City] = IsNull(@City, City),
		[StateID] = IsNull(@StateID, StateID),
		[PostalCode] = IsNull(@PostalCode, PostalCode),
		[CountryID] = IsNull(@CountryID, CountryID),
		[LastModified] = IsNull(@LastModified, LastModified),
		[LastStatEmployeeId] = IsNull(@LastStatEmployeeId, LastStatEmployeeId),
		[AuditLogTypeId] = IsNull(@AuditLogTypeId, AuditLogTypeId)
	WHERE 
		[BillToID] = @BillToID

	RETURN @@Error
GO