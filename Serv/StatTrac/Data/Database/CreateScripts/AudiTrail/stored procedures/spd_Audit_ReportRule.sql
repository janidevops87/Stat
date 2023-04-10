IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spd_Audit_ReportRule')
	BEGIN
		PRINT 'Dropping Procedure spd_Audit_ReportRule'
		DROP  Procedure  spd_Audit_ReportRule
	END

GO

PRINT 'Creating Procedure spd_Audit_ReportRule'
GO
CREATE Procedure spd_Audit_ReportRule
	@pkc1 int
AS

/******************************************************************************
**		File: 
**		Name: spd_Audit_ReportRule
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

GRANT EXEC ON spd_Audit_ReportRule TO PUBLIC

GO
