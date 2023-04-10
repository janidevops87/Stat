 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertReportRule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertReportRule]
print 'dropping procedure InsertReportRule'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
print 'creating procedure InsertReportRule'
GO
CREATE PROCEDURE [InsertReportRule]
	(
	@ReportID 	[int],
	@RoleID 	[int],
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null	

	 )

AS 
/******************************************************************************
**		File: InsertReportRule.sql
**		Name: InsertReportRule
**		Desc: Insert new report role 
**
**              
** 
**		Called by:   Reporting Site
**              
**
**		Auth: Bret Knoll
**		Date: 9/26/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    9/26/2007		Bret Knoll			initial 
**	  11/12/2007	Bret Knoll			Add fields for AuditTrail
*******************************************************************************/
DECLARE
	@FunctionID INT
SELECT @FunctionID = PermissionID FROM Permission WHERE FUNCTIONID = @ReportID

INSERT  
	[ReportRule] 
	( 
	[ReportID],
	[RoleID],
	[LastStatEmployeeID],
	[AuditLogTypeID],
	[LastModified]) 
 
VALUES 
	( 
	 @ReportID,
	 @RoleID,
	 @LastStatEmployeeID,
	 ISNULL(@AuditLogTypeID, 1), -- 1	Create
	 GetDate()
	 )

-- UPDATE the legacy report sites access permissions
INSERT WebPersonPermission (WebPersonID, PermissionID)
SELECT 
	WebPersonID,
	@FunctionID
FROM 
	UserRoles
WHERE
	RoleID = @RoleID
AND
	WebPersonID NOT IN
	(	-- What users have access to the report 
		SELECT 
			wpp.WebPersonID
		FROM 
			dbo.WebPersonPermission wpp 
		WHERE 
			webpersonid = UserRoles.WebPersonID
		AND 
			PermissionID = @FunctionID			
	)

-- update the persons navigation permissions
SELECT 
	@FunctionID = PermissionID 
FROM 
	Permission 
WHERE 
	PermissionName = (

	SELECT	DISTINCT 'Navigation: ' +	CASE 
										WHEN ReportTypeName = 'Custom Reports' THEN 'Custom'
										WHEN ReportTypeName = 'Referral Stats' THEN 'Ref Stats'
										ELSE ReportTypeName 
										END

	FROM	Report r
	JOIN	ReportType rt ON rt.ReportTypeID = r.ReportTypeID
	WHERE	ReportID = @REPORTID)

INSERT WebPersonPermission (WebPersonID, PermissionID)
SELECT 
	WebPersonID,
	@FunctionID
FROM 
	UserRoles
WHERE
	RoleID = @RoleID
AND
	WebPersonID NOT IN
	(	-- What users have access to the report 
		SELECT 
			wpp.WebPersonID
		FROM 
			dbo.WebPersonPermission wpp 
		WHERE 
			webpersonid = UserRoles.WebPersonID
		AND 
			PermissionID = @FunctionID			
	)


	 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

