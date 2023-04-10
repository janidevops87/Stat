

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'StatEmployeeUpdate')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeUpdate'
		DROP Procedure StatEmployeeUpdate
	END
GO

PRINT 'Creating Procedure StatEmployeeUpdate'
GO
CREATE Procedure StatEmployeeUpdate
(
		@StatEmployeeID int = null output,
		@StatEmployeeFirstName varchar(50) = null,
		@StatEmployeeLastName varchar(50) = null,
		@StatEmployeeUserID varchar(50) = null,
		@StatEmployeePassword varchar(50) = null,
		@LastModified datetime = null,
		@AllowCallDelete smallint = null,
		@AllowMaintainAccess smallint = null,
		@AllowSecurityAccess smallint = null,
		@AllowLicenseAccess smallint = null,
		@PersonID int = null,		
		@StatEmployeeEmail varchar(30) = null,
		@AllowStopTimerAccess smallint = null,
		@AllowIncompleteAccess smallint = null,
		@AllowScheduleAccess smallint = null,
		@UpdatedFlag smallint = null,
		@AllowRecoveryAccess smallint = null,
		@AllowInternetAccess smallint = null,
		@IntranetSecurityLevel smallint = null,
		@AllowEmployeeMaintTC smallint = null,
		@AllowEmployeeMaintFS smallint = null,
		@AllowEmployeeMaintAdmin smallint = null,
		@AllowEmployeeScheduleTC smallint = null,
		@AllowEmployeeScheduleFS smallint = null,
		@AllowQAReview smallint = null,
		@AllowRecycleCase smallint = null,
		@AllowCloseReferral smallint = null,
		@AllowASPSave int = null,
		@AllowViewDeletedLogEvents smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@OrganizationID int = null,
		@OrganizationName nvarchar(80) = null
							
)
AS
/******************************************************************************
**	File: StatEmployeeUpdate.sql
**	Name: StatEmployeeUpdate
**	Desc: Updates StatEmployee Based on Id field 
**	Auth: Bret Knoll
**	Date: 10/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/29/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/

UPDATE
	dbo.StatEmployee 	
SET 
		StatEmployeeFirstName = @StatEmployeeFirstName,
		StatEmployeeLastName = @StatEmployeeLastName,
		StatEmployeeUserID = @StatEmployeeUserID,
		StatEmployeePassword = @StatEmployeePassword,
		LastModified = GetDate(),
		AllowCallDelete = @AllowCallDelete,
		AllowMaintainAccess = @AllowMaintainAccess,
		AllowSecurityAccess = @AllowSecurityAccess,
		AllowLicenseAccess = @AllowLicenseAccess,
		PersonID = @PersonID,
		StatEmployeeEmail = @StatEmployeeEmail,
		AllowStopTimerAccess = @AllowStopTimerAccess,
		AllowIncompleteAccess = @AllowIncompleteAccess,
		AllowScheduleAccess = @AllowScheduleAccess,
		UpdatedFlag = @UpdatedFlag,
		AllowRecoveryAccess = @AllowRecoveryAccess,
		AllowInternetAccess = @AllowInternetAccess,
		IntranetSecurityLevel = @IntranetSecurityLevel,
		AllowEmployeeMaintTC = @AllowEmployeeMaintTC,
		AllowEmployeeMaintFS = @AllowEmployeeMaintFS,
		AllowEmployeeMaintAdmin = @AllowEmployeeMaintAdmin,
		AllowEmployeeScheduleTC = @AllowEmployeeScheduleTC,
		AllowEmployeeScheduleFS = @AllowEmployeeScheduleFS,
		AllowQAReview = @AllowQAReview,
		AllowRecycleCase = @AllowRecycleCase,
		AllowCloseReferral = @AllowCloseReferral,
		AllowASPSave = @AllowASPSave,
		AllowViewDeletedLogEvents = @AllowViewDeletedLogEvents,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	StatEmployeeID = @StatEmployeeID 				

GO

GRANT EXEC ON StatEmployeeUpdate TO PUBLIC
GO
