 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'OrganizationSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure OrganizationSelectDataSet'
		DROP Procedure OrganizationSelectDataSet
	END
GO

PRINT 'Creating Procedure OrganizationSelectDataSet'
PRINT GETDATE()
GO

CREATE PROCEDURE dbo.OrganizationSelectDataSet
(
		@StatEmployeeId int,
		@OrganizationId int,	
		@AllPermissions bit = 0,
		@ContactId int = 0,
		@Inactive bit = 0
)
AS
/***************************************************************************************************
**	Name: OrganizationSelectDataSet
**	Desc: Select Data for OrganizationProperties
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation
**	11/02/2010	Bret Knoll		Add WebPerson and StatEmployee
***************************************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	DECLARE 
		@userOrganizationId int
	--set organizationID of contactID is set
	if(@OrganizationId < 1 and @ContactId > 0)
	BEGIN
		SELECT @OrganizationId = Person.OrganizationID FROM Person WHERE Person.PersonID = @ContactId
	END	
	
	SELECT @userOrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeId)
	
	EXEC dbo.OrganizationSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.BillToSelect @OrganizationId  = @OrganizationId		
	EXEC dbo.OrganizationAliasSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationASPSettingSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationCaseReviewSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationDashBoardTimerSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationDisplaySettingSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationDuplicateSearchRuleSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationFsSourceCodeSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationSourceCodeSelect @OrganizationId  = @OrganizationId	
	EXEC dbo.OrganizationPhoneSelect @OrganizationId  = @OrganizationId		
	EXEC dbo.PersonSelectDataSet @OrganizationID = @OrganizationId, @Inactive = @Inactive
	
GO

GRANT EXEC ON OrganizationSelectDataSet TO PUBLIC
GO