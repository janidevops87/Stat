SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FacilityAssignmentsSC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FacilityAssignmentsSC]
GO




/****** Object:  Stored Procedure dbo.sps_FacilityAssignmentsSC    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_FacilityAssignmentsSC 	
		@vSourceCodeID	int
AS
/************************************************************************/
/*	ORGAN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS OrganAssigned,
		SourceCodeName
INTO		#TempOrgan
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
JOIN		SourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 1
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	BONE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS BoneAssigned,
		SourceCodeName
INTO		#TempBone
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
JOIN		SourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 2
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	TISSUE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS TissueAssigned
INTO		#TempTissue
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 3
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	SKIN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS SkinAssigned
INTO		#TempSkin
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 4
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	VALVES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ValvesAssigned
INTO		#TempValves
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 5
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	EYES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS EyesAssigned
INTO		#TempEyes
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 6
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	RESEARCH							*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ResearchAssigned
INTO		#TempResearch
FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
	
WHERE 		Criteria.DonorCategoryID = 7
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
        
SELECT DISTINCT	OrganizationName, 
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
		#TempOrgan.SourceCodeName,
		OrganAssigned,
		BoneAssigned,		
		TissueAssigned,
		SkinAssigned,
		ValvesAssigned, 
		EyesAssigned,
		ResearchAssigned
		
FROM 		SourceCodeOrganization
		JOIN Organization ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID
		LEFT JOIN County ON Organization.CountyID = County.CountyID
		LEFT JOIN Phone ON Organization.PhoneID = Phone.PhoneID 
		LEFT JOIN State ON Organization.StateID = State.StateID
		LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
		LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
		
		LEFT JOIN #TempOrgan ON #TempOrgan.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempBone ON #TempBone.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempTissue ON #TempTissue.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempSkin ON #TempSkin.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempValves ON #TempValves.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempEyes ON #TempEyes.OrganizationID = Organization.OrganizationID
		LEFT JOIN #TempResearch ON #TempResearch.OrganizationID = Organization.OrganizationID
		
WHERE	OrganizationType.OrganizationTypeName Is Not Null
AND		SourceCodeOrganization.SourceCodeID = @vSourceCodeID
ORDER BY	OrganizationType.OrganizationTypeName







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

