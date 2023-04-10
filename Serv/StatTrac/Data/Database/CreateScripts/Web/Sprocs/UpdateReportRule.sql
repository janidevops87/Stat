IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReportRule')
	BEGIN
		PRINT 'Dropping Procedure UpdateReportRule'
		DROP  Procedure  UpdateReportRule
	END

GO

PRINT 'Creating Procedure UpdateReportRule'
GO
CREATE Procedure UpdateReportRule
	@ReportRuleID int = NULL , 
	@ReportID int = NULL , 
	@RoleID int = NULL , 
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: 
**		Name: UpdateReportRule
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
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
*******************************************************************************/

UPDATE 
	ReportRule 
SET 
	ReportID = ISNULL(@ReportID, ReportID), 
	RoleID = ISNULL(@RoleID, RoleID), 
	LastStatEmployeeID = LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3 ), -- 3 Review  
	LastModified = GETDATE()
WHERE
	ReportRuleID = @ReportRuleID



GO

GRANT EXEC ON UpdateReportRule TO PUBLIC

GO
