IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteReportRule')
	BEGIN
		PRINT 'Dropping Procedure DeleteReportRule'
		DROP  Procedure  DeleteReportRule
	END

GO

PRINT 'Creating Procedure DeleteReportRule'
GO
CREATE Procedure DeleteReportRule
	@ReportRuleID int , 
	@ReportID int = NULL , 
	@RoleID int = NULL , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: 
**		Name: DeleteReportRule
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret
**		Date: Knoll
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
*******************************************************************************/
DECLARE 
	@FunctionID INT
SELECT 
	@FunctionID = PermissionID 
FROM 
	Permission 
WHERE 
	FUNCTIONID = @ReportID

UPDATE 
	ReportRule 
SET 
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 4 ), -- 4 Delete  
	LastModified = GETDATE() 
WHERE 
	ReportRuleID = @ReportRuleID

DELETE 
	ReportRule 
WHERE 
	ReportRuleID = @ReportRuleID


DELETE 
	WebPersonPermission
WHERE 
	PermissionID = @FunctionID
AND 
	WebPersonID IN
	(
		SELECT WebPersonID FROM USERROLES WHERE RoleID = @ROLEID
	)

AND WebPersonID NOT IN
	(
		SELECT WebPersonID 	
		FROM UserRoles 
		JOIN ReportRule ON ReportRule.RoleID = UserRoles.RoleID
		WHERE UserRoles.RoleID <> @ROLEID
		AND ReportID = @ReportID
	)




GO

GRANT EXEC ON DeleteReportRule TO PUBLIC

GO
