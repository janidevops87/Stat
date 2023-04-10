

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectServiceLevelByCallId')
	BEGIN
		PRINT 'Dropping Procedure SelectServiceLevelByCallId';
		PRINT GETDATE();
		DROP Procedure SelectServiceLevelByCallId;
	END
GO

PRINT 'Creating Procedure SelectServiceLevelByCallId';
PRINT GETDATE();
GO
CREATE Procedure SelectServiceLevelByCallId
(
		@CallId int
)
AS
/******************************************************************************
**	File: SelectServiceLevelByCallId.sql
**	Name: SelectServiceLevelByCallId
**	Desc: Select service level by CallId
**	Auth: Pam Scheichenost
**	Date: 10/16/2019
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/16/2019		Pam Scheichenost		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT ServiceLevelId 
	from CallCriteria 
	WHERE CallID = @CallId;
	
GO

GRANT EXEC ON SelectServiceLevelByCallId TO PUBLIC;
GO
