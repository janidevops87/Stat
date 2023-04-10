IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spd_Audit_UserRoles')
	BEGIN
		PRINT 'Dropping Procedure spd_Audit_UserRoles'
		DROP  Procedure  spd_Audit_UserRoles
	END

GO

PRINT 'Creating Procedure spd_Audit_UserRoles'
GO
CREATE Procedure spd_Audit_UserRoles
	@pkc1 int,
	@pkc2 int
AS

/******************************************************************************
**		File: 
**		Name: spd_Audit_UserRoles
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

GRANT EXEC ON spd_Audit_UserRoles TO PUBLIC

GO
