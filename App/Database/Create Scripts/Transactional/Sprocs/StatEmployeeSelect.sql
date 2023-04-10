IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'StatEmployeeSelect')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeSelect'
		DROP Procedure StatEmployeeSelect
	END
GO

PRINT 'Creating Procedure StatEmployeeSelect'
GO

CREATE PROCEDURE dbo.StatEmployeeSelect
(
	@StatEmployeeUserID varchar(50) = null,
	@PersonID int = null,
	@PersonTypeID int = null,
	@OrganizationID int = null,
	@Inactive bit = 0
)
AS
/***************************************************************************************************
**	Name: StatEmployeeSelect
**	Desc: Update Data in table ListFsbStatusColor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Sproc Creation 
**  09/28/2010  ccarroll		Added StatTrac User Organization items
***************************************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
SELECT
	StatEmployee.StatEmployeeID,
	StatEmployee.StatEmployeeFirstName,
	StatEmployee.StatEmployeeLastName,
	StatEmployee.StatEmployeeUserID,
	StatEmployee.StatEmployeePassword,
	StatEmployee.LastModified,
	StatEmployee.AllowCallDelete,
	StatEmployee.AllowMaintainAccess,
	StatEmployee.AllowSecurityAccess,
	StatEmployee.AllowLicenseAccess,
	StatEmployee.PersonID,
	StatEmployee.StatEmployeeEmail,
	StatEmployee.AllowStopTimerAccess,
	StatEmployee.AllowIncompleteAccess,
	StatEmployee.AllowScheduleAccess,
	StatEmployee.UpdatedFlag,
	StatEmployee.AllowRecoveryAccess,
	StatEmployee.AllowInternetAccess,
	StatEmployee.IntranetSecurityLevel,
	StatEmployee.AllowEmployeeMaintTC,
	StatEmployee.AllowEmployeeMaintFS,
	StatEmployee.AllowEmployeeMaintAdmin,
	StatEmployee.AllowEmployeeScheduleTC,
	StatEmployee.AllowEmployeeScheduleFS,
	StatEmployee.AllowQAReview,
	StatEmployee.AllowRecycleCase,
	StatEmployee.AllowCloseReferral,
	StatEmployee.AllowASPSave,
	StatEmployee.AllowViewDeletedLogEvents,
	Organization.OrganizationID,
	Organization.OrganizationName
FROM dbo.StatEmployee
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
WHERE
		(StatEmployee.StatEmployeeUserID = COALESCE(@StatEmployeeUserID, StatEmployee.StatEmployeeUserID))
	AND
		Person.PersonID = COALESCE(@PersonID, Person.PersonID)
	AND
		COALESCE(Person.PersonTypeID, 0) = COALESCE(@PersonTypeID, COALESCE(Person.PersonTypeID, 0))
	AND
		Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID)
	AND 
		(ISNULL(Person.Inactive, 0) = @Inactive)		
	
GO

GRANT EXEC ON StatEmployeeSelect TO PUBLIC
GO
