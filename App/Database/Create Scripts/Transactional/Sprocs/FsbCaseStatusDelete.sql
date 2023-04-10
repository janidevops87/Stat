IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbCaseStatusDelete')
	BEGIN
		PRINT 'Dropping Procedure FsbCaseStatusDelete'
		DROP Procedure FsbCaseStatusDelete
	END
GO

PRINT 'Creating Procedure FsbCaseStatusDelete'
GO

CREATE PROCEDURE dbo.FsbCaseStatusDelete
(
	@FsbCaseStatusId int
)
AS
/***************************************************************************************************
**	Name: FsbCaseStatusDelete
**	Desc: Delete Data from table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

DELETE FROM dbo.FsbCaseStatus
WHERE FsbCaseStatusId = @FsbCaseStatusId
GO

GRANT EXEC ON FsbCaseStatusDelete TO PUBLIC
GO
