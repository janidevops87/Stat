IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spd_Audit_WebPerson')
	BEGIN
		PRINT 'Dropping Procedure spd_Audit_WebPerson'
		DROP  Procedure  spd_Audit_WebPerson
	END

GO

PRINT 'Creating Procedure spd_Audit_WebPerson'
GO
CREATE Procedure spd_Audit_WebPerson
	@pkc1 int
AS

/******************************************************************************
**		File: 
**		Name: spd_Audit_WebPerson
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

GRANT EXEC ON spd_Audit_WebPerson TO PUBLIC

GO
