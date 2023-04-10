IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'UserRoles')
	BEGIN
		PRINT 'Dropping Table UserRoles'
		DROP  Table UserRoles
	END
GO

/******************************************************************************
**		File: 
**		Name: UserRoles
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

PRINT 'Creating Table UserRoles'
GO
CREATE TABLE UserRoles
(
	[WebPersonID] [int] NOT NULL ,
	[RoleID] [int] NOT NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [datetime] NULL 
) 
ON 
	[PRIMARY]
GO

GRANT SELECT ON UserRoles TO PUBLIC

GO
