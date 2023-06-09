SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FacilityAssignments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FacilityAssignments]
GO





-- sps_FacilityAssignments 30




/****** Object:  Stored Procedure dbo.sps_FacilityAssignments    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_FacilityAssignments 	
		@vStateID		int 	= null
AS
/************************************************************************/
/*	ORGAN								*/
/************************************************************************/
SELECT 
DISTINCT 
		Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS OrganAssigned
INTO		#TempOrgan
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 	Criteria.DonorCategoryID = 1
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	BONE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS BoneAssigned
INTO		#TempBone
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 2
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	TISSUE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS TissueAssigned
INTO		#TempTissue
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID

	
WHERE 		Criteria.DonorCategoryID = 3
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	SKIN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS SkinAssigned
INTO		#TempSkin
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID

	
WHERE 		Criteria.DonorCategoryID = 4
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	VALVES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ValvesAssigned
INTO		#TempValves
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID

WHERE 		Criteria.DonorCategoryID = 5
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	EYES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS EyesAssigned
INTO		#TempEyes
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID

	
WHERE 		Criteria.DonorCategoryID = 6
AND 		Organization.StateID = @vStateID
/************************************************************************/
/*	RESEARCH							*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ResearchAssigned
INTO		#TempResearch
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID 
JOIN 		ScheduleGroup ON  ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
JOIN 		Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID = ScheduleGroup.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON CriteriaScheduleGroup.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON Criteria.CriteriaID = CriteriaScheduleGroup.CriteriaID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 7
AND 		Organization.StateID = @vStateID
        


SELECT 
DISTINCT	
		OrganizationName, 
		OrganizationAddress1,
		OrganizationAddress2, 
		OrganizationCity, 
		CountyName, 
		StateAbbrv, 
		OrganizationZipCode, 
		OrganizationTypeName, 
		'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS Phone, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
		StateName,
		OrganAssigned,
		BoneAssigned,		
		TissueAssigned,
		SkinAssigned,
		ValvesAssigned,
		EyesAssigned,
		ResearchAssigned
		
FROM 		Organization 
		JOIN County ON Organization.CountyID = County.CountyID
		JOIN Phone ON Organization.PhoneID = Phone.PhoneID 
		JOIN State ON Organization.StateID = State.StateID
		JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
		LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
		
		LEFT JOIN #TempOrgan ON #TempOrgan.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempBone ON #TempBone.OrganizationID = Organization.OrganizationID
 		LEFT JOIN #TempTissue ON #TempTissue.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempSkin ON #TempSkin.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempValves ON #TempValves.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempEyes ON #TempEyes.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempResearch ON #TempResearch.OrganizationID = Organization.OrganizationID
                
WHERE	        Organization.StateID = @vStateID 
AND             OrganizationType.OrganizationTypeName Is Not Null
ORDER BY	OrganizationType.OrganizationTypeName


DROP TABLE #TempOrgan
DROP TABLE #TempBone
DROP TABLE #TempTissue
DROP TABLE #TempSkin
DROP TABLE #TempValves
DROP TABLE #TempEyes
DROP TABLE #TempResearch

-- sps_FacilityAssignments 30






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

