IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure InsertStatEmployee'
		DROP  Procedure  InsertStatEmployee
	END

GO

PRINT 'Creating Procedure InsertStatEmployee'
GO
CREATE Procedure InsertStatEmployee
    @StatEmployeeID int = NULL , 
    @StatEmployeeFirstName varchar(50) = NULL , 
    @StatEmployeeLastName varchar(50) = NULL , 
    @StatEmployeeUserID varchar(50) = NULL , 
    @StatEmployeePassword varchar(50) = NULL , 
    @AllowCallDelete smallint = NULL , 
    @AllowMaintainAccess smallint = NULL , 
    @AllowSecurityAccess smallint = NULL , 
    @AllowLicenseAccess smallint = NULL , 
    @PersonID int = NULL , 
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
**		File: InsertStatEmployee.sql
**		Name: InsertStatEmployee
**		Desc: 
**
**		This template can be customized:
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

INSERT 
	StatEmployee 
	( 
		StatEmployeeFirstName,
		StatEmployeeLastName,
		StatEmployeeUserID,
		StatEmployeePassword,
		AllowCallDelete,
		AllowMaintainAccess,
		AllowSecurityAccess,
		AllowLicenseAccess,
		PersonID,
		StatEmployeeEmail,
		AllowStopTimerAccess,
		AllowIncompleteAccess,
		AllowScheduleAccess,
		AllowRecoveryAccess,
		AllowInternetAccess,
		IntranetSecurityLevel,
		AllowEmployeeMaintTC,
		AllowEmployeeMaintFS,
		AllowEmployeeMaintAdmin,
		AllowEmployeeScheduleTC,
		AllowEmployeeScheduleFS,
		AllowQAReview,
		AllowRecycleCase,
		AllowCloseReferral,
		AllowASPSave,
		AllowViewDeletedLogEvents	
	) 
VALUES 
	(
		@StatEmployeeFirstName, 
		@StatEmployeeLastName, 
		@StatEmployeeUserID, 
		@StatEmployeePassword, 
		@AllowCallDelete, 
		@AllowMaintainAccess, 
		@AllowSecurityAccess, 
		@AllowLicenseAccess, 
		@PersonID, 
		@StatEmployeeEmail, 
		@AllowStopTimerAccess, 
		@AllowIncompleteAccess, 
		@AllowScheduleAccess, 
		@AllowRecoveryAccess, 
		@AllowInternetAccess, 
		@IntranetSecurityLevel, 
		@AllowEmployeeMaintTC, 
		@AllowEmployeeMaintFS, 
		@AllowEmployeeMaintAdmin, 
		@AllowEmployeeScheduleTC, 
		@AllowEmployeeScheduleFS, 
		@AllowQAReview, 
		@AllowRecycleCase, 
		@AllowCloseReferral, 
		@AllowASPSave, 
		@AllowViewDeletedLogEvents	 
	) 


SELECT 
	StatEmployeeID,
	StatEmployeeFirstName,
	StatEmployeeLastName,
	StatEmployeeUserID,
	StatEmployeePassword,
	AllowCallDelete,
	AllowMaintainAccess,
	AllowSecurityAccess,
	AllowLicenseAccess,
	PersonID,
	StatEmployeeEmail,
	AllowStopTimerAccess,
	AllowIncompleteAccess,
	AllowScheduleAccess,
	AllowRecoveryAccess,
	AllowInternetAccess,
	IntranetSecurityLevel,
	AllowEmployeeMaintTC,
	AllowEmployeeMaintFS,
	AllowEmployeeMaintAdmin,
	AllowEmployeeScheduleTC,
	AllowEmployeeScheduleFS,
	AllowQAReview,
	AllowRecycleCase,
	AllowCloseReferral,
	AllowASPSave,
	AllowViewDeletedLogEvents

FROM 
	StatEmployee 
WHERE 
	StatEmployeeID = SCOPE_IDENTITY()


GO

GRANT EXEC ON InsertStatEmployee TO PUBLIC

GO
