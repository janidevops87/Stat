IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbCaseStatusUpdate')
	BEGIN
		PRINT 'Dropping Procedure FsbCaseStatusUpdate'
		DROP Procedure FsbCaseStatusUpdate
	END
GO

PRINT 'Creating Procedure FsbCaseStatusUpdate'
GO

CREATE PROCEDURE dbo.FsbCaseStatusUpdate
(
	@FsbCaseStatusId int,
	@CallId int,
	@LastStatEmployeeId int,
	@LastStatEmployeeName varchar(100),
	@LastModified datetime = null,
	@FamilyServicesCoordinatorId int = null,
	@FamilyServicesCoordinatorName varchar(100),
	@ListFsbStatusId smallint = null,
	@Comment nvarchar(200) = null
)
AS
/***************************************************************************************************
**	Name: FsbCaseStatusUpdate
**	Desc: Update Data in table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.FsbCaseStatus
SET
	CallId = @CallId,
	LastStatEmployeeId = @LastStatEmployeeId,
	LastModified = IsNull(@LastModified, GetUtcDate()),
	FamilyServicesCoordinatorId = @FamilyServicesCoordinatorId,
	ListFsbStatusId = @ListFsbStatusId,
	Comment = @Comment
WHERE
	FsbCaseStatusId = @FsbCaseStatusId
GO

GRANT EXEC ON FsbCaseStatusUpdate TO PUBLIC
GO
