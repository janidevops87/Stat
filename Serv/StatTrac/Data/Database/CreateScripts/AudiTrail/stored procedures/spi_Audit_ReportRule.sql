IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Audit_ReportRule')
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_ReportRule'
		DROP  Procedure  spi_Audit_ReportRule
	END

GO

PRINT 'Creating Procedure spi_Audit_ReportRule'
GO
CREATE Procedure spi_Audit_ReportRule
	@1 int , -- ReportRuleID
	@2 int , -- ReportID
	@3 int , -- RoleID
	@4 int , -- LastStatEmployeeID
	@5 int , -- AuditLogTypeID
	@6 datetime  -- LastModified
AS

/******************************************************************************
**		File: spi_Audit_ReportRule.sql
**		Name: spi_Audit_ReportRule
**		Desc: 
**
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
**		--------	--------			------------------------------------------
**		11/12/2007	Bret Knoll			initial
*******************************************************************************/


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
	@1, -- ReportRuleID
	@2, -- ReportID
	@3, -- RoleID
	@4, -- LastStatEmployeeID
	@5, -- AuditLogTypeID
	@6 -- LastModified	
	) 


GO

GRANT EXEC ON spi_Audit_ReportRule TO PUBLIC

GO
