IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ReportRule')
	BEGIN
		PRINT 'Dropping Table ReportRule'
		DROP  Table ReportRule
	END
GO

/******************************************************************************
**		File: 
**		Name: ReportRule
**		Desc: 
**
**		This template can be customized:
**              
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

PRINT 'Creating Table ReportRule'
GO
CREATE TABLE ReportRule
(
	[ReportRuleID] [int] NOT NULL ,
	[ReportID] [int] NULL ,
	[RoleID] [int] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [datetime] NULL 
) 
ON 
	[PRIMARY]
GO

GRANT SELECT ON ReportRule TO PUBLIC

GO
