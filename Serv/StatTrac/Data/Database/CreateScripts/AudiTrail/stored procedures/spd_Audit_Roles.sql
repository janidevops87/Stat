IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spd_Audit_Roles')
	BEGIN
		PRINT 'Dropping Procedure spd_Audit_Roles'
		DROP  Procedure  spd_Audit_Roles
	END

GO

PRINT 'Creating Procedure spd_Audit_Roles'
GO
CREATE Procedure spd_Audit_Roles
	@pkc1 int
AS

/******************************************************************************
**		File: spd_Audit_Roles.sql
**		Name: spd_Audit_Roles
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




GO

GRANT EXEC ON spd_Audit_Roles TO PUBLIC

GO
