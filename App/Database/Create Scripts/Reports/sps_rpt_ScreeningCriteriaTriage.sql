
PRINT 'Dropping Procedure sps_rpt_ScreeningCriteriaTriage';
DROP PROCEDURE IF EXISTS sps_rpt_ScreeningCriteriaTriage;
GO

PRINT 'Creating Procedure sps_rpt_ScreeningCriteriaTriage';
GO

CREATE PROCEDURE sps_rpt_ScreeningCriteriaTriage
(		
	@OrganizationID     int,
	@CriteriaID			int	= NULL
)
AS  

/******************************************************************************
**		File: sps_rpt_ScreeningCriteriaTriage.sql
**		Name: sps_rpt_ScreeningCriteriaTriage
**		Desc: returns a list of CriteriaGroups, DonorCategories, and Organizations
**				with Indications
**              
**		Return values:
** 
**		Called by:   Screening Criteria - Triage.rdl
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: Mike Berenson 
**		Date: 12/07/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		12/07/2020	Mike Berenson		Initial Creation
**		07/12/2021	James Gerberich		Added filter for Criteria Group.
**											TFS 74086
*******************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

    SELECT DISTINCT 
        o.OrganizationName,
        c.CriteriaID, 
        c.CriteriaGroupName, 
        dc.DonorCategoryName,
        CONVERT(VARCHAR(255),c.CriteriaMaleLowerAge) + 
           CASE WHEN c.CriteriaMaleLowerAgeUnit = CriteriaMaleUpperAgeUnit THEN '-'
                WHEN c.CriteriaMaleLowerAgeUnit IS NULL                    THEN '-'
                ELSE                                                          ' ' + c.CriteriaMaleLowerAgeUnit + ' to '
           END + CONVERT(VARCHAR(255),c.CriteriaMaleUpperAge) + ' ' + CONVERT(VARCHAR(255),c.CriteriaMaleUpperAgeUnit) AS CriteriaMaleAge,
        CONVERT(VARCHAR(255),c.CriteriaFemaleLowerAge) + 
           CASE WHEN c.CriteriaFemaleLowerAgeUnit = c.CriteriaFemaleUpperAgeUnit THEN '-'
                WHEN c.CriteriaFemaleLowerAgeUnit IS NULL                        THEN '-'
                ELSE                                                                  ' ' + c.CriteriaFemaleLowerAgeUnit + ' to '
           END + CONVERT(VARCHAR(255),c.CriteriaFemaleUpperAge) + ' ' + CONVERT(VARCHAR(255),c.CriteriaFemaleUpperAgeUnit) AS CriteriaFemaleAge,
        CASE    WHEN  c.CriteriaLowerWeight IS NULL AND c.CriteriaLowerWeight IS NULL THEN ''
                ELSE CONVERT(VARCHAR(255),c.CriteriaLowerWeight) + '-' + CONVERT(VARCHAR(255),c.CriteriaUpperWeight) + ' kg'
          END AS CriteriaWeight,
        i.IndicationID,
        i.IndicationName, 
        i.IndicationNote
	FROM 
        DonorCategory dc 
        INNER JOIN Criteria c                   ON c.DonorCategoryID = dc.DonorCategoryID
        INNER JOIN CriteriaScheduleGroup csg    ON csg.CriteriaID = c.CriteriaID 
        INNER JOIN ScheduleGroup sg             ON sg.ScheduleGroupID = csg.ScheduleGroupID
        INNER JOIN Organization o               ON o.OrganizationID = sg.OrganizationID
        LEFT JOIN CriteriaIndication ci         ON ci.CriteriaID = c.CriteriaID
        INNER JOIN Indication i                 ON i.IndicationID = ci.IndicationID 
    WHERE 
        c.CriteriaStatus = 1
        AND o.OrganizationID = @OrganizationID
		AND	(
				@CriteriaID IS NULL
			OR	c.CriteriaID = @CriteriaID
			);

END
GO

GRANT EXECUTE ON sps_rpt_ScreeningCriteriaTriage TO PUBLIC;
GO