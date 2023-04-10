
PRINT 'Dropping Procedure sps_rpt_ScreeningCriteriaSecondary';
DROP PROCEDURE IF EXISTS sps_rpt_ScreeningCriteriaSecondary;
GO

PRINT 'Creating Procedure sps_rpt_ScreeningCriteriaSecondary';
GO

CREATE PROCEDURE sps_rpt_ScreeningCriteriaSecondary
(
	@OrganizationID     int,
	@CriteriaID			int	= NULL
)
AS

/******************************************************************************
**		File: sps_rpt_ScreeningCriteriaSecondary.sql
**		Name: sps_rpt_ScreeningCriteriaSecondary
**		Desc: returns a list of CriteriaGroups, DonorCategories, and Organizations
**				with FamilyServices Indications
**
**		Return values:
**
**		Called by:   Screening Criteria - Secondary.rdl
**
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: Mike Berenson
**		Date: 12/10/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		12/10/2020	Mike Berenson		Initial Creation
**		07/12/2021	James Gerberich		Added ability to run by Criteria Group
**											and applied the organization parameter
**											to the client, not the processor.
**											TFS 74086
*******************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

	SELECT DISTINCT
		org.OrganizationName,
		crt.CriteriaId,
		crt.CriteriaGroupName	AS 'Criteria Group',
		prc.OrganizationName	AS 'Processor',
		d.DonorCategoryName		AS 'Donor Category',
		st.SubTypeName			AS 'SubCategory',
		s.ProcessorPrecedence	AS 'Processor Order',

		CASE s.SubCriteriaMaleNotAppropriate
			WHEN -1 THEN 'N/A'
			ELSE CASE s.SubCriteriaMaleLowerAgeUnit
		          		WHEN s.SubCriteriaMaleUpperAgeUnit THEN CAST(s.SubCriteriaMaleLowerAge AS VARCHAR)
		          		ELSE CAST(s.SubCriteriaMaleLowerAge AS VARCHAR) + ' ' + s.SubCriteriaMaleLowerAgeUnit
					  END + '-' + CAST(s.SubCriteriaMaleUpperAge AS VARCHAR) + ' ' + s.SubCriteriaMaleUpperAgeUnit
		END AS 'Male Age',

		CASE s.SubCriteriaFemaleNotAppropriate
			WHEN -1 THEN 'N/A'
			ELSE CASE s.SubCriteriaFemaleLowerAgeUnit
		          		WHEN s.SubCriteriaFemaleUpperAgeUnit THEN CAST(s.SubCriteriaFemaleLowerAge AS VARCHAR)
		          		ELSE CAST(s.SubCriteriaFemaleLowerAge AS VARCHAR) + ' ' + s.SubCriteriaFemaleLowerAgeUnit
			END + '-' + CAST(s.SubCriteriaFemaleUpperAge AS VARCHAR) + ' ' + s.SubCriteriaFemaleUpperAgeUnit
		END AS 'Female Age',

		CASE s.SubCriteriaMaleNotAppropriate
			WHEN -1 THEN 'N/A'
			ELSE CAST(s.SubCriteriaLowerWeight AS VARCHAR) + '-' + CAST(s.SubCriteriaUpperWeight AS VARCHAR) + ' kg'
		END as 'Male Weight',

		CASE s.SubCriteriaFemaleNotAppropriate
			WHEN -1 THEN 'N/A'
			ELSE CAST(s.SubCriteriaFemaleLowerWeight AS VARCHAR) + '-' + CAST(s.SubCriteriaFemaleUpperWeight AS VARCHAR) + ' kg'
		END AS 'Female Weight',

		fsi.FSIndicationName							AS 'Indicator',
		fsa.FSAppropriateName							AS 'R/O Reason',
		ISNULL(fsc.FSConditionName, 'AUTOMATIC R/O')	AS 'Indicator Note'
	FROM
		Criteria crt
		JOIN DonorCategory d					ON crt.DonorCategoryId = d.DonorCategoryId
		JOIN SubCriteria s						ON crt.CriteriaId = s.CriteriaId AND crt.DonorCategoryID = s.DonorCategoryID
		JOIN Organization prc					ON s.ProcessorId = prc.OrganizationId
		JOIN SubType st							ON s.SubTypeId = st.SubTypeId
		JOIN ProcessorCriteria_ConditionalRO pc ON s.SubCriteriaId = pc.SubCriteriaId
		JOIN FSIndication fsi					ON pc.FSIndicationId = fsi.FSIndicationId
		JOIN FSAppropriate fsa					ON pc.FSAppropriateId = fsa.FSAppropriateId
		LEFT JOIN FSCondition fsc				ON pc.FSConditionId = fsc.FSConditionId
		JOIN CriteriaScheduleGroup crtSg		ON crt.CriteriaId = crtSg.CriteriaID
		JOIN ScheduleGroup sg					ON crtSg.ScheduleGroupID = sg.ScheduleGroupID
		JOIN Organization org					ON sg.OrganizationID = org.OrganizationID
	WHERE
		crt.CriteriaStatus = 1
		AND	org.OrganizationID = @OrganizationID
		AND	(
				@CriteriaID IS NULL
			OR	crt.CriteriaID = @CriteriaID
			);

END
GO

GRANT EXECUTE ON sps_rpt_ScreeningCriteriaSecondary TO PUBLIC;
GO