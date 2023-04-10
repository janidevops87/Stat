IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FamilyServicesSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure FamilyServicesSelectDataSet'
		DROP Procedure FamilyServicesSelectDataSet
	END
GO

PRINT 'Creating Procedure FamilyServicesSelectDataSet'
GO

CREATE PROCEDURE dbo.FamilyServicesSelectDataSet
(
	@StatEmployeeId int,
	@CallId int
)
AS
/***************************************************************************************************
**	Name: FamilyServicesSelectDataSet
**	Desc: Select Data for FamilyServices
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

DECLARE @OrganizationId int
Select @OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeId)

IF EXISTS(SELECT * FROM dbo.GetCallIdByOrganizationId(@OrganizationId) WHERE CallId = @CallId)
BEGIN
	EXEC dbo.FsbCaseSelect @CallId
	EXEC dbo.FsbCaseStatusSelect @CallId
END
GO

GRANT EXEC ON FamilyServicesSelectDataSet TO PUBLIC
GO
