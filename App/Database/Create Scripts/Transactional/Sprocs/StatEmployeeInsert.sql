

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'StatEmployeeInsert')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeInsert'
		DROP Procedure StatEmployeeInsert
	END
GO

PRINT 'Creating Procedure StatEmployeeInsert'
GO
CREATE Procedure StatEmployeeInsert
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
**	File: StatEmployeeInsert.sql
**	Name: StatEmployeeInsert
**	Desc: Inserts StatEmployee Based on Id field 
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

INSERT	StatEmployee
	(
		StatEmployeeFirstName,
		StatEmployeeLastName,
		StatEmployeeUserID,
		StatEmployeePassword,
		LastModified,
		AllowCallDelete,
		AllowMaintainAccess,
		AllowSecurityAccess,
		AllowLicenseAccess,
		PersonID,
		StatEmployeeEmail,
		AllowStopTimerAccess,
		AllowIncompleteAccess,
		AllowScheduleAccess,
		UpdatedFlag,
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
		AllowViewDeletedLogEvents,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@StatEmployeeFirstName,
		@StatEmployeeLastName,
		@StatEmployeeUserID,
		@StatEmployeePassword,
		@LastModified,
		@AllowCallDelete,
		@AllowMaintainAccess,
		@AllowSecurityAccess,
		@AllowLicenseAccess,
		@PersonID,
		@StatEmployeeEmail,
		@AllowStopTimerAccess,
		@AllowIncompleteAccess,
		@AllowScheduleAccess,
		@UpdatedFlag,
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
		@AllowViewDeletedLogEvents,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @StatEmployeeID = SCOPE_IDENTITY()

EXEC StatEmployeeSelect @StatEmployeeID

GO

GRANT EXEC ON StatEmployeeInsert TO PUBLIC
GO
