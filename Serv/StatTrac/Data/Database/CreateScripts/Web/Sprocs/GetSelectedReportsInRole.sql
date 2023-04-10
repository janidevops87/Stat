IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetSelectedReportsInRole')
	BEGIN
		PRINT 'Dropping Procedure GetSelectedReportsInRole'
		DROP  Procedure  GetSelectedReportsInRole
	END

GO

PRINT 'Creating Procedure GetSelectedReportsInRole'
GO
CREATE Procedure GetSelectedReportsInRole
	@RoleId		INT,
	@WebPersonId INT	
AS

/******************************************************************************
**		File: GetSelectedReportsInRole.sql
**		Name: GetSelectedReportsInRole
**		Desc: Loads reports assigned to the report 
**
**		Called by:  Admin and Roles 
**              
**		Author:		Bret Knoll
**		Create date: 04/04/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/04/08	Bret Knoll			Initial
*******************************************************************************/
-- determine if the user making the change is statline 
DECLARE @StatlineUser bit
SELECT 
	@StatlineUser =	dbo.IsStatline(@WebPersonId)

SELECT     
	ReportRule.ReportRuleID, 
	ReportRule.ReportID, 
	ReportRule.RoleID, 
	Report.ReportVirtualURL, 
	Report.ReportDisplayName, 
    ReportRule.LastStatEmployeeID, 
    ReportRule.AuditLogTypeID
FROM	Report 
LEFT OUTER JOIN
	ReportRule ON Report.ReportID = ReportRule.ReportID AND ReportRule.RoleID = @RoleId
WHERE     
	(ReportRule.ReportID > 194)
AND
	(ReportRule.ReportID IN
		(--- ReportRule.ReportID IN
			SELECT	ReportID
			FROM	Report
			WHERE	@StatlineUser = 1
			UNION
			SELECT  ReportRule.ReportID
			FROM       UserRoles 
			INNER JOIN	ReportRule ON UserRoles.RoleID = ReportRule.RoleID
			WHERE     (UserRoles.WebPersonID = @WebPersonId)
		)--- ReportRule.ReportID IN
	)




GO

GRANT EXEC ON GetSelectedReportsInRole TO PUBLIC

GO
