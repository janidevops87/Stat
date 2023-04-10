IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetAvailableReportsForRole')
	BEGIN
		PRINT 'Dropping Procedure GetAvailableReportsForRole'
		DROP  Procedure  GetAvailableReportsForRole
	END

GO

PRINT 'Creating Procedure GetAvailableReportsForRole'
GO
CREATE Procedure GetAvailableReportsForRole
	@RoleId		INT,
	@WebPersonId INT	
AS

/******************************************************************************
**		File: GetAvailableReportsForRole.sql
**		Name: GetAvailableReportsForRole
**		Desc: Loads reports not assigned to the report
**
**		Called by:  Admin and Roles storedprocedures
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
	Report.ReportID, Report.ReportVirtualURL, Report.ReportDisplayName
FROM         
	Report 
WHERE     
	(ReportID NOT IN 
		(
		SELECT	ReportID
		FROM	ReportRule
		WHERE   (RoleID = @RoleId))
	)
AND
	(ReportId > 194)
AND
	(ReportId IN
		(
			SELECT	ReportID
			FROM	Report
			WHERE	@StatlineUser = 1
			UNION
			SELECT  ReportRule.ReportID
			FROM       UserRoles 
			INNER JOIN	ReportRule ON UserRoles.RoleID = ReportRule.RoleID
			WHERE     (UserRoles.WebPersonID = @WebPersonId)
		)
	

	)



GO

GRANT EXEC ON GetAvailableReportsForRole TO PUBLIC

GO
