IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure UpdateStatEmployee'
		DROP  Procedure  UpdateStatEmployee
	END

GO

PRINT 'Creating Procedure UpdateStatEmployee'
GO
CREATE Procedure UpdateStatEmployee
    @StatEmployeeID int = NULL, 
    @StatEmployeeFirstName varchar(50) = NULL , 
    @StatEmployeeLastName varchar(50) = NULL , 
    @StatEmployeeUserID varchar(50) = NULL , 
    @StatEmployeePassword varchar(50) = NULL , 
    @AllowCallDelete smallint = NULL , 
    @AllowMaintainAccess smallint = NULL , 
    @AllowSecurityAccess smallint = NULL , 
    @AllowLicenseAccess smallint = NULL , 
    @PersonID int , 
    @StatEmployeeEmail varchar(30) = NULL , 
    @AllowStopTimerAccess smallint = NULL , 
    @AllowIncompleteAccess smallint = NULL , 
    @AllowScheduleAccess smallint = NULL , 
    @AllowRecoveryAccess smallint = NULL , 
    @AllowInternetAccess smallint = NULL , 
    @IntranetSecurityLevel smallint = NULL , 
    @AllowEmployeeMaintTC smallint = NULL , 
    @AllowEmployeeMaintFS smallint = NULL , 
    @AllowEmployeeMaintAdmin smallint = NULL , 
    @AllowEmployeeScheduleTC smallint = NULL , 
    @AllowEmployeeScheduleFS smallint = NULL , 
    @AllowQAReview smallint = NULL , 
    @AllowRecycleCase smallint = NULL , 
    @AllowCloseReferral smallint = NULL , 
    @AllowASPSave int = NULL , 
    @AllowViewDeletedLogEvents smallint = NULL

AS

/******************************************************************************
**		File: UpdateStatEmployee.sql
**		Name: UpdateStatEmployee
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**       StatTrac
**      
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      06/11/2007	Bret Knoll			8.4.3.9 LogEvent Delete
*******************************************************************************/

UPDATE 
	StatEmployee 
SET   
	StatEmployeeFirstName = @StatEmployeeFirstName, 
	StatEmployeeLastName = @StatEmployeeLastName, 
	StatEmployeeUserID = @StatEmployeeUserID, 
	StatEmployeePassword = @StatEmployeePassword, 
	LastModified = GetDate(), 
	AllowCallDelete = ISNULL(@AllowCallDelete, AllowCallDelete), 
	AllowMaintainAccess = ISNULL(@AllowMaintainAccess, AllowMaintainAccess), 
	AllowSecurityAccess = ISNULL(@AllowSecurityAccess, AllowSecurityAccess), 
	AllowLicenseAccess = ISNULL(@AllowLicenseAccess, AllowLicenseAccess), 
	StatEmployeeEmail = @StatEmployeeEmail, 
	AllowStopTimerAccess = ISNULL(@AllowStopTimerAccess, AllowStopTimerAccess), 
	AllowIncompleteAccess = ISNULL(@AllowIncompleteAccess, AllowIncompleteAccess), 
	AllowScheduleAccess = ISNULL(@AllowScheduleAccess, AllowScheduleAccess), 
	AllowRecoveryAccess = ISNULL(@AllowRecoveryAccess, AllowRecoveryAccess), 
	AllowInternetAccess = ISNULL(@AllowInternetAccess, AllowInternetAccess), 
	IntranetSecurityLevel = ISNULL(@IntranetSecurityLevel, IntranetSecurityLevel), 
	AllowEmployeeMaintTC = ISNULL(@AllowEmployeeMaintTC, AllowEmployeeMaintTC), 
	AllowEmployeeMaintFS = ISNULL(@AllowEmployeeMaintFS, AllowEmployeeMaintFS), 
	AllowEmployeeMaintAdmin = ISNULL(@AllowEmployeeMaintAdmin, AllowEmployeeMaintAdmin), 
	AllowEmployeeScheduleTC = ISNULL(@AllowEmployeeScheduleTC, AllowEmployeeScheduleTC), 
	AllowEmployeeScheduleFS = ISNULL(@AllowEmployeeScheduleFS, AllowEmployeeScheduleFS), 
	AllowQAReview = ISNULL(@AllowQAReview, AllowQAReview), 
	AllowRecycleCase = ISNULL(@AllowRecycleCase, AllowRecycleCase), 
	AllowCloseReferral = ISNULL(@AllowCloseReferral, AllowCloseReferral), 
	AllowASPSave = ISNULL(@AllowASPSave, AllowASPSave), 
	AllowViewDeletedLogEvents = ISNULL(@AllowViewDeletedLogEvents, AllowViewDeletedLogEvents) 
WHERE 
	PersonID = @PersonID




GO

GRANT EXEC ON UpdateStatEmployee TO PUBLIC

GO
