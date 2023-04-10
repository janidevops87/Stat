IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbCaseStatusSelect')
	BEGIN
		PRINT 'Dropping Procedure FsbCaseStatusSelect'
		DROP Procedure FsbCaseStatusSelect
	END
GO

PRINT 'Creating Procedure FsbCaseStatusSelect'
GO

CREATE PROCEDURE dbo.FsbCaseStatusSelect
(
	@CallId int
)
AS
/***************************************************************************************************
**	Name: FsbCaseStatusSelect
**	Desc: Update Data in table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	fcs.FsbCaseStatusId,
	fcs.CallId,
	fcs.LastStatEmployeeId,
	ISNULL(LastStatEmployee.StatEmployeeFirstName + ' ', '')  + ISNULL(LastStatEmployee.StatEmployeeLastName, '') AS LastStatEmployeeName,
	fcs.LastModified,
	fcs.FamilyServicesCoordinatorId,
	ISNULL(FamilyServicesCoordinator.PersonFirst + ' ', '')  + ISNULL(FamilyServicesCoordinator.PersonLast, '') AS FamilyServicesCoordinatorName,
	fcs.ListFsbStatusId,
	fcs.Comment
FROM dbo.FsbCaseStatus fcs
	INNER JOIN dbo.StatEmployee LastStatEmployee ON fcs.LastStatEmployeeId = LastStatEmployee.StatEmployeeId
	LEFT JOIN dbo.Person FamilyServicesCoordinator ON fcs.FamilyServicesCoordinatorId = FamilyServicesCoordinator.PersonId
WHERE fcs.CallId = @CallId
ORDER BY fcs.LastModified DESC
GO

GRANT EXEC ON FsbCaseStatusSelect TO PUBLIC
GO
