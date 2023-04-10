 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'PersonSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure PersonSelectDataSet'
		DROP Procedure PersonSelectDataSet
	END
GO

PRINT 'Creating Procedure PersonSelectDataSet'
PRINT GETDATE()
GO

CREATE PROCEDURE dbo.PersonSelectDataSet
(
		@OrganizationId int,	
		@Inactive bit = 0
)
AS
/***************************************************************************************************
**	Name: PersonSelectDataSet
**	Desc: Select Data for OrganizationProperties
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation
**	11/02/2010	Bret Knoll		Add WebPerson and StatEmployee
***************************************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	EXEC dbo.PersonSelect @OrganizationID = @OrganizationId, @Inactive = @Inactive
	EXEC dbo.PersonPhoneSelect @OrganizationID = @OrganizationId, @Inactive = @Inactive
	EXEC dbo.WebPersonSelect @organizationId = @OrganizationId, @Inactive = @Inactive
	EXEC dbo.StatEmployeeSelect @organizationId = @OrganizationId, @Inactive = @Inactive
	
GO

GRANT EXEC ON PersonSelectDataSet TO PUBLIC
GO