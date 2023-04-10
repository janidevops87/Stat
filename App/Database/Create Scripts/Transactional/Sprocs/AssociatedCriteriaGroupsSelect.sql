
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AssociatedCriteriaGroupsSelect')
	BEGIN
		PRINT 'Dropping Procedure AssociatedCriteriaGroupsSelect'
		DROP Procedure AssociatedCriteriaGroupsSelect
	END
GO

PRINT 'Creating Procedure AssociatedCriteriaGroupsSelect'
GO
CREATE Procedure AssociatedCriteriaGroupsSelect
(
		@IndicationID int = null
)
AS
/******************************************************************************
**	File: AssociatedCriteriaGroupsSelect.sql
**	Name: AssociatedCriteriaGroupsSelect
**	Desc: Selects multiple rows of Associated Criteria Groups Based on Id  field 
**	Auth: ccarroll
**	Date: 12/03/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/03/2009		ccarroll				Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	
	SELECT DISTINCT
		CallType.CallTypeName AS 'CallType',
		DonorCategory.DonorCategoryName AS 'TriageCategory',
		Criteria.CriteriaGroupName AS 'CriteriaGroup',
		CASE WHEN Organization.OrganizationName	IS NULL THEN 'N/A'ELSE
			  Organization.OrganizationName END	   AS 'Processor/FSCategory'
	FROM Criteria
	JOIN CriteriaIndication ON CriteriaIndication.CriteriaID = Criteria.CriteriaID
	LEFT JOIN DonorCategory ON DonorCategory.DonorCategoryID = Criteria.DonorCategoryID
	LEFT JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
	LEFT JOIN CallType ON CallType.CallTypeID = SourceCode.SourceCodeCallTypeID
	LEFT JOIN CriteriaProcessor ON CriteriaProcessor.CriteriaID = Criteria.CriteriaID
	LEFT JOIN Organization ON Organization.OrganizationID = CriteriaProcessor.OrganizationID
	WHERE CriteriaIndication.IndicationID = ISNull(@IndicationID, 0)
		AND Criteria.CriteriaStatus = 0
	ORDER BY 
			Criteria.CriteriaGroupName