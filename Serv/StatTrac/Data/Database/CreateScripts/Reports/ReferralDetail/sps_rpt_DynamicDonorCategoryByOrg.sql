if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_DynamicDonorCategoryByOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_rpt_DynamicDonorCategoryByOrg'
	drop procedure [dbo].[sps_rpt_DynamicDonorCategoryByOrg]
END

PRINT 'Creating Procedure sps_rpt_DynamicDonorCategoryByOrg'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sps_rpt_DynamicDonorCategoryByOrg

     @vOrganizationID int =null,
     @vSourceCodeName varchar(20) = null

AS
/******************************************************************************
**		File: sps_rpt_DynamicDonorCategoryByOrg.sql
**		Name: sps_rpt_DynamicDonorCategoryByOrg
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: unknown
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/03/2009	ccarroll			initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Category TABLE
(
	CategoryID Int Identity (1,1),
	CategoryName Varchar(100)
)

DECLARE @DynamicCategory TABLE
(
	DynamicCategoryID Int,
	DynamicCategoryName Varchar(100)
)

/* Enter default StatTrac category values */
INSERT INTO @Category (CategoryName) VALUES('Organ')
INSERT INTO @Category (CategoryName) VALUES('Bone')
INSERT INTO @Category (CategoryName) VALUES('Tissue')
INSERT INTO @Category (CategoryName) VALUES('Skin')
INSERT INTO @Category (CategoryName) VALUES('Valves')
INSERT INTO @Category (CategoryName) VALUES('Eyes')
INSERT INTO @Category (CategoryName) VALUES('Other')

INSERT INTO @DynamicCategory
		SELECT	DISTINCT
					Criteria.DonorCategoryID,
					DynamicDonorCategory.DynamicDonorCategoryName
		FROM
					Criteria
		JOIN		CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
		JOIN		SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
		JOIN		CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
		JOIN		DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
		WHERE		
				OrganizationID = @vOrganizationID
				AND	PATINDEX(@vSourceCodeName, SourceCode.SourceCodeName) > 0
				AND	CriteriaStatus = 1

SELECT 
		CategoryID,
		IsNull(DynamicCategoryName, CategoryName) AS 'DynamicDonorCategoryName'
FROM @Category Category
LEFT JOIN @DynamicCategory DynamicCategory ON DynamicCategory.DynamicCategoryID = Category.CategoryID
ORDER BY CategoryID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 

