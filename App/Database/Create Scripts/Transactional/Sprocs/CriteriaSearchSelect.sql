 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSearchSelect'
		DROP Procedure CriteriaSearchSelect
	END
GO

PRINT 'Creating Procedure CriteriaSearchSelect'
GO
CREATE Procedure CriteriaSearchSelect
(
		@OrganizationID INT,
		@SourceCodeID INT,
		@DonorCategoryID INT,
		@CriteriaStatus INT
)
AS
/******************************************************************************
**	File: CriteriaSearchSelect.sql
**	Name: CriteriaSearchSelect
**	Desc: Selects multiple rows of Criteria Based on Id  fields 
**	Auth: ccarroll	
**	Date: 05/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/13/2011		ccarroll				Initial Sproc Creation
**  06/15/2011		ccarroll				Changed CriteriaStatus from Working to Current
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	DECLARE @CriteriaID int = 0
	DECLARE @CriteriaTable Table 
	(
		CriteriaID int
	)
	INSERT @CriteriaTable
	SELECT CriteriaOrganization.CriteriaID
	FROM CriteriaOrganization 
	JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID 
	JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = CriteriaOrganization.CriteriaID 
	JOIN DonorCategory ON Criteria.DonorCategoryId = DonorCategory.DonorCategoryId 
	WHERE CriteriaOrganization.OrganizationID = @OrganizationID 
	AND CriteriaSourceCode.SourceCodeID = @SourceCodeID
	AND Criteria.CriteriaStatus = @CriteriaStatus
	AND Criteria.DonorCategoryID = @DonorCategoryID
	

	-- take the first
	SELECT TOP 1 @CriteriaID = CriteriaID FROM @CriteriaTable
	
	IF (@CriteriaID > 0 )
	BEGIN
		EXEC CriteriaSelectDataSet @CriteriaID = @CriteriaID, @DonorCategoryID = @DonorCategoryID
	END

	
GO

GRANT EXEC ON CriteriaSearchSelect TO PUBLIC
GO
