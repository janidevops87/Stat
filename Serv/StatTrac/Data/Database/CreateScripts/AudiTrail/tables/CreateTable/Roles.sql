IF NOT  EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'Roles')
	BEGIN
		
		

/******************************************************************************
**		File: 
**		Name: Roles
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

PRINT 'Creating Table Roles'
CREATE TABLE Roles
(
	[RoleID] [int] NOT NULL ,
	[RoleName] [nvarchar] (256) NULL ,
	[RoleDescription] [nvarchar](250) NULL,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [datetime] NULL,
	[Inactive] [smallint] NULL    
)
ON
	[PRIMARY]
END
GO

GRANT SELECT ON Roles TO PUBLIC

GO
