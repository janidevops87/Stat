  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'StatEmployeeSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeSelectDataSet'
		DROP Procedure StatEmployeeSelectDataSet
	END
GO

PRINT 'Creating Procedure StatEmployeeSelectDataSet'
GO

CREATE PROCEDURE dbo.StatEmployeeSelectDataSet
(
	@StatEmployeeUserId nvarchar(50)
)
AS
/***************************************************************************************************
**	Name: StatEmployeeSelectDataSet
**	Desc: Select Data for StatEmployee
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	10/19/2010	Bret Knoll	Initial Sproc Creation
***************************************************************************************************/
	SET NOCOUNT ON
	EXEC StatEmployeeSelect @StatEmployeeUserId = @StatEmployeeUserId
	DECLARE @statEmployeeID int = 0
	SELECT @statEmployeeID  = StatEmployeeID 
	FROM StatEmployee 
	WHERE StatEmployeeUserID = @StatEmployeeUserId
	
	EXEC StatEmployeeRoleSelect @StatEmployeeId = @statemployeeID
		
	
	
GO

GRANT EXEC ON StatEmployeeSelectDataSet TO PUBLIC
GO