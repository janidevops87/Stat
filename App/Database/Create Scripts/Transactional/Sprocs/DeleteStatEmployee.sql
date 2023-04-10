IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure DeleteStatEmployee'
		DROP  Procedure  DeleteStatEmployee
	END

GO

PRINT 'Creating Procedure DeleteStatEmployee'
GO
CREATE Procedure DeleteStatEmployee
    @StatEmployeeID int = NULL 
AS

/******************************************************************************
**		File: DeleteStatEmployee.sql
**		Name: DeleteStatEmployee
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**       StatTrac
**      
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      06/11/2007	Bret Knoll			8.4.3.9 LogEvent Delete
*******************************************************************************/

DELETE 
	StatEmployee 
WHERE 
	StatEmployeeID = @StatEmployeeID


GO

GRANT EXEC ON DeleteStatEmployee TO PUBLIC

GO
