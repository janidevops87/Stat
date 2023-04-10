IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ScheduleGroupContactRequired')
	BEGIN
		PRINT 'Dropping Procedure sps_ScheduleGroupContactRequired'
		DROP  Procedure  sps_ScheduleGroupContactRequired
	END
GO

PRINT 'Creating Procedure sps_ScheduleGroupContactRequired'
GO

CREATE Procedure sps_ScheduleGroupContactRequired
	@CallID						int = Null,
	@OrganizationID				int = Null
AS
/******************************************************************************
**		File: sps_ScheduleGroupContactRequired.sql
**		Name: sps_ScheduleGroupContactRequired
**		Desc: This sproc is used to retrieve a list of organizations 
**			  where potential contact is required.
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
**		Auth: christopher carroll
**		Date: 10/10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      11/21/2008		ccarroll			Initial release
*******************************************************************************/

DECLARE @OrganCriteriaID AS Int
DECLARE @BoneCriteriaID AS Int
DECLARE @TissueCriteriaID AS Int
DECLARE	@SkinCriteriaID AS Int
DECLARE @ValvesCriteriaID AS Int
DECLARE @EyesCriteriaID AS Int
DECLARE @OtherCriteriaID AS Int


CREATE Table #TempCallCriteria 
(
	ID Int IDENTITY(1,1),
	CriteriaID Int Null,
	CategoryID Int Null,
	CategoryName varchar(15) Null
)

SELECT 
		@OrganCriteriaID =	sq.OrganCriteriaID,
		@BoneCriteriaID =	sq.BoneCriteriaID,
		@TissueCriteriaID = sq.TissueCriteriaID,
		@SkinCriteriaID =	sq.SkinCriteriaID,
		@ValvesCriteriaID = sq.ValvesCriteriaID,
		@EyesCriteriaID =	sq.EyesCriteriaID,
		@OtherCriteriaID =	sq.OtherCriteriaID
FROM (
		SELECT * 
		FROM CallCriteria 
		WHERE CallID = IsNull(@CallID, 0)
	)sq 
			
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@OrganCriteriaID, 1, 'Organ') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@BoneCriteriaID, 2, 'Bone') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@TissueCriteriaID, 3, 'Tissue') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@SkinCriteriaID, 4, 'Skin') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@ValvesCriteriaID, 5, 'Valves') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@EyesCriteriaID, 6, 'Eyes') 
INSERT INTO #TempCallCriteria (CriteriaID, CategoryID, CategoryName) VALUES (@OtherCriteriaID, 7, 'Other') 

--SELECT * FROM #TempCallCriteria


/* Select potential contact required list
Ref: modStatQuery.QueryCriteriaScheduleGroup(pvForm, vCriteriaScheduleGroups) */
SELECT	--DISTINCT
		--cc.ID,
		cc.CriteriaID,
		cc.CategoryID,
		cc.CategoryName,
		CriteriaScheduleGroup.ScheduleGroupID,
		ScheduleGroup.ScheduleGroupName,
		Organization.OrganizationName,
		IsNull(CriteriaScheduleGroupOrgan, 0) AS 'CriteriaScheduleGroupOrgan',
		IsNull(CriteriaScheduleGroupBone , 0) AS 'CriteriaScheduleGroupBone',
		IsNull(CriteriaScheduleGroupTissue, 0) AS 'CriteriaScheduleGroupTissue',
		IsNull(CriteriaScheduleGroupSkin, 0) AS 'CriteriaScheduleGroupSkin',
		IsNull(CriteriaScheduleGroupValves, 0) AS 'CriteriaScheduleGroupValves',
		IsNull(CriteriaScheduleGroupEyes, 0) AS 'CriteriaScheduleGroupEyes',
		IsNull(CriteriaScheduleGroupResearch, 0) AS 'CriteriaScheduleGroupResearch',
		IsNull(ScheduleGroup.OrganizationID, 0) AS 'OrganizationID',
		IsNull(CriteriaScheduleNoContactOnDny, 0) AS 'CriteriaScheduleNoContactOnDny',
		IsNull(CriteriaScheduleContactOnCnsnt, 0) AS 'CriteriaScheduleContactOnCnsnt',
		IsNull(CriteriaScheduleContactOnAprch, 0) AS 'CriteriaScheduleContactOnAprch',
		IsNull(CriteriaScheduleContactOnCrnr, 0) AS 'CriteriaScheduleContactOnCrnr',
		IsNull(CriteriaScheduleContactOnStatSec, 0) AS 'CriteriaScheduleContactOnStatSec',
		IsNull(CriteriaScheduleContactOnStatCnsnt, 0) AS 'CriteriaScheduleContactOnStatCnsnt',
		IsNull(CriteriaScheduleContactOnCoronerOnly, 0) AS 'CriteriaScheduleContactOnCoronerOnly'
FROM #TempCallCriteria cc
JOIN CriteriaScheduleGroup ON cc.CriteriaID = CriteriaScheduleGroup.CriteriaID 
JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
JOIN ScheduleGroupOrganization ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID

WHERE ScheduleGroupOrganization.OrganizationID = IsNull(@OrganizationID, ScheduleGroupOrganization.OrganizationID)
--AND CriteriaScheduleGroupOrgan = 1
ORDER BY CategoryID


DROP TABLE #TempCallCriteria




GO

