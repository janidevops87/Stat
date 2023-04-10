IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetStatEmployeeByWebPersonID')
	BEGIN
		PRINT 'DROPPING Procedure  GetStatEmployeeByWebPersonID'
		
		DROP  Procedure  GetStatEmployeeByWebPersonID
	END
	PRINT 'CREATING Procedure  GetStatEmployeeByWebPersonID'
GO

CREATE Procedure GetStatEmployeeByWebPersonID
	(
		@webPersonID int = null
	)


/******************************************************************************
**		File: GetStatEmployeeByWebPersonID.sql
**		Name: GetStatEmployeeByWebPersonID
**		Desc: 
**
** 
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 10/30/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		10/30/08	Bret Knoll			Gets the Detail of a WebPersonID
*******************************************************************************/
AS

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
	StatEmployee.AllowViewDeletedLogEvents
	FROM         
	StatEmployee 
	INNER JOIN
	Person ON StatEmployee.PersonID = Person.PersonID 
	INNER JOIN
	WebPerson ON Person.PersonID = WebPerson.PersonID
	WHERE     (WebPerson.WebPersonID = @webPersonID)

GO


