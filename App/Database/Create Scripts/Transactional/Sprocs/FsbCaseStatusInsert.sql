IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'FsbCaseStatusInsert')
	BEGIN
		PRINT 'Dropping Procedure FsbCaseStatusInsert'
		DROP Procedure FsbCaseStatusInsert
	END
GO

PRINT 'Creating Procedure FsbCaseStatusInsert'
GO

CREATE PROCEDURE dbo.FsbCaseStatusInsert
(
	@FsbCaseStatusId int output,
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
**	Name: FsbCaseStatusInsert
**	Desc: Insert Data into table FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.FsbCaseStatus
(
	CallId,
	LastStatEmployeeId,
	LastModified,
	FamilyServicesCoordinatorId,
	ListFsbStatusId,
	Comment
)
VALUES
(
	@CallId,
	@LastStatEmployeeId,
	IsNull(@LastModified, GetUtcDate()),
	@FamilyServicesCoordinatorId,
	@ListFsbStatusId,
	@Comment
)

-- Return the new identity value
SET @FsbCaseStatusId = @@Identity

GO

GRANT EXEC ON FsbCaseStatusInsert TO PUBLIC
GO
