IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Audit_ReportRule')
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_ReportRule'
		DROP procedure [dbo].[spu_Audit_ReportRule]
	END
GO

PRINT 'Creating Procedure spu_Audit_ReportRule'
GO
CREATE Procedure spu_Audit_ReportRule
	@c1 int, -- ReportRuleID
	@c2 int, -- ReportID
	@c3 int, -- RoleID
	@c4 int, -- LastStatEmployeeID
	@c5 int, -- AuditLogTypeID
	@c6 datetime, -- LastModified
	@pkc1 int, 
	@bitmap binary(1)

AS
/******************************************************************************
**		File: spu_Audit_ReportRule.sql
**		Name: spu_Audit_ReportRule
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@lastStatEmployeeID int,
		@auditLogTypeID int

IF (
	SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- ReportRuleID
	OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- ReportID
	OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- RoleID
	OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- LastStatEmployeeID
	OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- AuditLogTypeID
	-- IGNORE LASTModified OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(LastModified, GetDate()),
		@lastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c5, AuditLogTypeID)
	FROM
		ReportRule
	WHERE 
		ReportRuleID = @pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
	IF
		(
			@auditLogTypeID IN (2, 3) -- do not change type if it is a delete
			AND
			(
				SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ReportRuleID
				AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- ReportID
				AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- RoleID
				--AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- AuditLogTypeID
				--AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- LastStatEmployeeID
			)
			AND 
				SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
		)
	BEGIN
		SET @auditLogTypeID = 2	-- Review
	END
	ELSE
	BEGIN
		SET @auditLogTypeID = 3	-- Modify
	END
	INSERT 
		ReportRule 
		( 
			ReportRuleID,
			ReportID,
			RoleID,
			LastStatEmployeeID,
			AuditLogTypeID,
			LastModified	
		) 
	VALUES 
		( 
			@pkc1, -- ReportRuleID
			CASE WHEN /*ReportID*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, -1) IN ( -1, 0) THEN -2 ELSE @c2 END,
			CASE WHEN /*RoleID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
			ISNULL(@c4, @lastStatEmployeeID), -- LastStatEmployeeID
			@auditLogTypeID, -- AuditLogTypeID
			ISNULL(@c6, @LastModified) -- LastModified
		) 
	
END



GO

GRANT EXEC ON spu_Audit_ReportRule TO PUBLIC

GO
