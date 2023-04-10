IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'GetCriteriaData')
	BEGIN
		PRINT 'Dropping Procedure GetCriteriaData';
		PRINT GETDATE();
		DROP PROCEDURE GetCriteriaData;
	END
GO

PRINT 'Creating Procedure GetCriteriaData'
PRINT GETDATE();
GO
CREATE Procedure GetCriteriaData
	@CriteriaID				INT = NULL,
	@OrganizationID			INT = NULL,
	@DonorCategoryID		INT = NULL,
	@SourceCodeID			INT = NULL,
	@CriteriaStatusID		SMALLINT = NULL	
AS

/******************************************************************************
**		File: GetCriteriaData.sql
**		Name: GetCriteriaData
**		Desc: Queries the datbase for criteria data
**
**              
**		Return values: CriteriaID & CriteriaName
** 
**		Called by:   ModStatQuery.QueryCategoryGroupsApplicable
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**		Auth: Mike Berenson
**		Date: 3/5/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		
**		
*******************************************************************************/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	IF @CriteriaID IS NULL
	BEGIN
		SELECT DISTINCT CriteriaOrganization.CriteriaID, Criteria.CriteriaGroupName 
		FROM Criteria (nolock) 
			JOIN CriteriaOrganization (nolock) ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID 
			JOIN CriteriaSourceCode (nolock) ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID 
		WHERE 
			(@OrganizationID IS NULL OR CriteriaOrganization.OrganizationID = @OrganizationID)
		AND (@DonorCategoryID IS NULL OR Criteria.DonorCategoryID = @DonorCategoryID)
		AND (@SourceCodeID IS NULL OR CriteriaSourceCode.SourceCodeID = @SourceCodeID)
		AND (@CriteriaStatusID IS NULL OR Criteria.CriteriaStatus = @CriteriaStatusID)
		ORDER BY Criteria.CriteriaGroupName ASC;
	END
	ELSE
	BEGIN
		SELECT DISTINCT Criteria.CriteriaID, Criteria.CriteriaGroupName 
		FROM Criteria (nolock) 
		WHERE CriteriaID = @CriteriaID;
	END

GO

GRANT EXEC ON GetCriteriaData TO PUBLIC;
GO
