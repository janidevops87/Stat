IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_DynamicDonorCategoryByOrg]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_rpt_DynamicDonorCategoryByOrg';
	DROP PROCEDURE [dbo].[sps_rpt_DynamicDonorCategoryByOrg];
END

PRINT 'Creating Procedure sps_rpt_DynamicDonorCategoryByOrg';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS OFF;
GO

CREATE PROCEDURE [dbo].[sps_rpt_DynamicDonorCategoryByOrg]
(
	@vOrganizationID	int			= NULL,
	@vSourceCodeName	varchar(20)	= NULL
)
AS
/******************************************************************************
**	File: sps_rpt_DynamicDonorCategoryByOrg.sql
**	Name: sps_rpt_DynamicDonorCategoryByOrg
**	Desc:
**	
**	
**	Return values:
**	
**	Called by:
**	
**	Parameters:
**	Input			Output
**	----------		-----------
**	See above
**	
**	Auth: unknown
**	Date:
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:				Description:
**	--------	--------			-------------------------------------------
**	08/03/2009	ccarroll			initial
**	08/04/2020	James Gerberich		Refactored VS 69297
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT DISTINCT
	Category.DonorCategoryID,
	IsNULL(DynamicDonorCategory.DynamicDonorCategoryName, Category.DonorCategoryName) AS 'DynamicDonorCategoryName'
FROM
	DonorCategory Category
	LEFT JOIN Criteria
			JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
			JOIN CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID AND CriteriaOrganization.OrganizationID = @vOrganizationID
			JOIN CriteriaSourceCode
					JOIN SourceCode ON CriteriaSourceCode.SourceCodeID = SourceCode.SourceCodeID AND PATINDEX(@vSourceCodeName, SourceCode.SourceCodeName) > 0
				ON Criteria.CriteriaID = CriteriaSourceCode.CriteriaID
		ON Category.DonorCategoryID = Criteria.DonorCategoryID AND CriteriaStatus = 1
ORDER BY DonorCategoryID;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
