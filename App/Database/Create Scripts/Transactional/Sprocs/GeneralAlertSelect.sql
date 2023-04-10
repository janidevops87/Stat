 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GeneralAlertSelect')
	BEGIN
		PRINT 'Dropping Procedure GeneralAlertSelect'
		DROP Procedure GeneralAlertSelect
	END
GO

PRINT 'Creating Procedure GeneralAlertSelect'
GO
CREATE Procedure GeneralAlertSelect
AS
/******************************************************************************
**	File: GeneralAlertSelect.sql
**	Name: GeneralAlertSelect
**	Desc: Selects multiple rows of FSBCase Based on parameters
**	Auth: Tanvir Ather
**	Date: 3/4/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	3/4/2009		Tanvir Ather			Initial Sproc Creation
*******************************************************************************/

SELECT * FROM dbo.GeneralAlert
ORDER BY GeneralAlertExpires DESC
GO

GRANT EXEC ON GeneralAlertSelect TO PUBLIC
GO
