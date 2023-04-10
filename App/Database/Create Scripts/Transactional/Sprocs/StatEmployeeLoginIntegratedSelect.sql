IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'StatEmployeeLoginIntegratedSelect')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeLoginIntegratedSelect';
		DROP Procedure StatEmployeeLoginIntegratedSelect;
	END
GO

PRINT 'Creating Procedure StatEmployeeLoginIntegratedSelect';
GO

CREATE PROCEDURE dbo.StatEmployeeLoginIntegratedSelect
(
	@StatEmployeeUserID varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: StatEmployeeLoginIntegratedSelect
**	Desc: Select employee data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------		--------------------------------------------------------------------
**	10/22/2019	Pam Scheichenost	Initial Sproc Creation 
***************************************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
SELECT StatEmployeeID, 
	PersonFirst + ' ' + PersonLast, 
	Person.PersonID, 
	Person.PersonTypeID
FROM StatEmployee 
JOIN Person ON Person.PersonID = StatEmployee.PersonID 
JOIN Organization ON Organization.OrganizationID = Person.OrganizationID 
WHERE 1=1 
AND StatEmployeeUserID = @StatEmployeeUserID
AND Person.Inactive = 0 
AND (Organization.OrganizationID = 194 or Organization.OrganizationLO = -1); 	
	
GO

GRANT EXEC ON StatEmployeeLoginIntegratedSelect TO PUBLIC;
GO
