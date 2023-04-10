IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_HospitalAffiliations')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_HospitalAffiliations';
	DROP PROCEDURE sps_rpt_HospitalAffiliations;
END

GO

PRINT 'Creating Procedure sps_rpt_HospitalAffiliations';
GO

CREATE PROCEDURE sps_rpt_HospitalAffiliations
(		
	@OrganizationID	INT
)
AS  

/******************************************************************************
**		File: sps_rpt_HospitalAffiliations.sql
**		Name: sps_rpt_HospitalAffiliations
**		Desc: returns a list of organizations with affiliated CriteriaGroups
**				for Organs, Bone, Tissue, Skin, Valves, Eyes, and Other
**
**              
**		Return values:
** 
**		Called by:   HospitalAffiliations.rdl
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: Mike Berenson 
**		Date: 10/06/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		10/06/2020	Mike Berenson		Initial Creation
**
*******************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;
    
	DECLARE @CriteriaStatusID INT = 0; -- Current

    SELECT 
		o.OrganizationID, 
		o.OrganizationName, 
		ot.OrganizationTypeName,
		MIN(cOrgan.CriteriaGroupName) AS Organs,
		MIN(cBone.CriteriaGroupName) AS Bone,
		MIN(cTissue.CriteriaGroupName) AS Tissue,
		MIN(cSkin.CriteriaGroupName) AS Skin,
		MIN(cValves.CriteriaGroupName) AS Valves,
		MIN(cEyes.CriteriaGroupName) AS Eyes,
		MIN(cOther.CriteriaGroupName) AS Other
	FROM
		Organization o
		JOIN OrganizationType ot			ON ot.OrganizationTypeID = o.OrganizationTypeID
		JOIN WebReportGroupOrg wrgo			ON wrgo.OrganizationID = o.OrganizationID
		JOIN WebReportGroup wrg				ON wrg.WebReportGroupID = wrgo.WebReportGroupID
		LEFT JOIN CriteriaOrganization co	ON co.OrganizationID = o.OrganizationID
		LEFT JOIN Criteria cOrgan			ON cOrgan.CriteriaID = co.CriteriaID	AND cOrgan.DonorCategoryID = 1	AND cOrgan.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cBone			ON cBone.CriteriaID = co.CriteriaID		AND cBone.DonorCategoryID = 2	AND cBone.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cTissue			ON cTissue.CriteriaID = co.CriteriaID	AND cTissue.DonorCategoryID = 3 AND cTissue.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cSkin			ON cSkin.CriteriaID = co.CriteriaID		AND cSkin.DonorCategoryID = 4	AND cSkin.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cValves			ON cValves.CriteriaID = co.CriteriaID	AND cValves.DonorCategoryID = 5 AND cValves.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cEyes			ON cEyes.CriteriaID = co.CriteriaID		AND cEyes.DonorCategoryID = 6	AND cEyes.CriteriaStatus = @CriteriaStatusID
		LEFT JOIN Criteria cOther			ON cOther.CriteriaID = co.CriteriaID	AND cOther.DonorCategoryID = 7	AND cOther.CriteriaStatus = @CriteriaStatusID
	WHERE 1=1
		AND wrg.OrgHierarchyParentID = @OrganizationID
		AND PATINDEX('%All Referrals%', wrg.WebReportGroupName) > 0
	GROUP BY 
		o.OrganizationID, 
		o.OrganizationName, 
		ot.OrganizationTypeName
	ORDER BY 
		o.OrganizationName, 
		ot.OrganizationTypeName;

END
GO

GRANT EXECUTE ON sps_rpt_HospitalAffiliations TO PUBLIC;
GO