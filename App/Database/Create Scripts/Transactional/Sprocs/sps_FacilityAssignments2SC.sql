SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FacilityAssignments2SC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FacilityAssignments2SC]
GO






/****** Object:  Stored Procedure dbo.sps_FacilityAssignments2SC    Script Date: 2/24/99 1:12:45 AM ******/
CREATE   PROCEDURE sps_FacilityAssignments2SC 	
		@vSourceCodeID		int
AS
/************************************************************************/
/*	ORGAN								*/
/* ccarroll 06/13/2006 - Modified for use with ntext field types (Alert)*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS OrganAssigned,
		ScheduleGroupName AS OrganSchedule,
		CriteriaMaleLowerAge AS OMLA, CriteriaMaleLowerAgeUnit AS OMLAU,
		CriteriaMaleUpperAge AS OMUA, CriteriaMaleUpperAgeUnit AS OMUAU,
		CriteriaFemaleLowerAge AS OFLA, CriteriaFemaleLowerAgeUnit AS OFLAU,
		CriteriaFemaleUpperAge AS OFUA, CriteriaFemaleUpperAgeUnit AS OFUAU,
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
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	BONE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS BoneAssigned,
		ScheduleGroupName AS BoneSchedule,
		CriteriaMaleLowerAge AS BMLA, CriteriaMaleLowerAgeUnit AS BMLAU,
		CriteriaMaleUpperAge AS BMUA, CriteriaMaleUpperAgeUnit AS BMUAU,
		CriteriaFemaleLowerAge AS BFLA, CriteriaFemaleLowerAgeUnit AS BFLAU,
		CriteriaFemaleUpperAge AS BFUA, CriteriaFemaleUpperAgeUnit AS BFUAU
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
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	TISSUE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS TissueAssigned,
		ScheduleGroupName AS TissueSchedule,
		CriteriaMaleLowerAge AS TMLA, CriteriaMaleLowerAgeUnit AS TMLAU,
		CriteriaMaleUpperAge AS TMUA, CriteriaMaleUpperAgeUnit AS TMUAU,
		CriteriaFemaleLowerAge AS TFLA, CriteriaFemaleLowerAgeUnit AS TFLAU,
		CriteriaFemaleUpperAge AS TFUA, CriteriaFemaleUpperAgeUnit AS TFUAU
INTO		#TempTissue
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
	
WHERE 		Criteria.DonorCategoryID = 3
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	SKIN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS SkinAssigned,
		ScheduleGroupName AS SkinSchedule,
		CriteriaMaleLowerAge AS SMLA, CriteriaMaleLowerAgeUnit AS SMLAU,
		CriteriaMaleUpperAge AS SMUA, CriteriaMaleUpperAgeUnit AS SMUAU,
		CriteriaFemaleLowerAge AS SFLA, CriteriaFemaleLowerAgeUnit AS SFLAU,
		CriteriaFemaleUpperAge AS SFUA, CriteriaFemaleUpperAgeUnit AS SFUAU
INTO		#TempSkin
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
	
WHERE 		Criteria.DonorCategoryID = 4
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	VALVES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ValvesAssigned,
		ScheduleGroupName AS ValvesSchedule,
		CriteriaMaleLowerAge AS VMLA, CriteriaMaleLowerAgeUnit AS VMLAU,
		CriteriaMaleUpperAge AS VMUA, CriteriaMaleUpperAgeUnit AS VMUAU,
		CriteriaFemaleLowerAge AS VFLA, CriteriaFemaleLowerAgeUnit AS VFLAU,
		CriteriaFemaleUpperAge AS VFUA, CriteriaFemaleUpperAgeUnit AS VFUAU
INTO		#TempValves
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
	
WHERE 		Criteria.DonorCategoryID = 5
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	EYES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS EyesAssigned,
		ScheduleGroupName AS EyesSchedule,
		CriteriaMaleLowerAge AS EMLA, CriteriaMaleLowerAgeUnit AS EMLAU,
		CriteriaMaleUpperAge AS EMUA, CriteriaMaleUpperAgeUnit AS EMUAU,
		CriteriaFemaleLowerAge AS EFLA, CriteriaFemaleLowerAgeUnit AS EFLAU,
		CriteriaFemaleUpperAge AS EFUA, CriteriaFemaleUpperAgeUnit AS EFUAU
INTO		#TempEyes
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
	
WHERE 		Criteria.DonorCategoryID = 6
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
-- bjk 10/24 added to resolve historical criteria
AND 		Criteria.CriteriaStatus = 1
/************************************************************************/
/*	RESEARCH							*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		OrganizationAssigned.OrganizationUserCode AS ResearchAssigned,
		ScheduleGroupName AS ResearchSchedule,
		CriteriaMaleLowerAge AS RMLA, CriteriaMaleLowerAgeUnit AS RMLAU,
		CriteriaMaleUpperAge AS RMUA, CriteriaMaleUpperAgeUnit AS RMUAU,
		CriteriaFemaleLowerAge AS RFLA, CriteriaFemaleLowerAgeUnit AS RFLAU,
		CriteriaFemaleUpperAge AS RFUA, CriteriaFemaleUpperAgeUnit AS RFUAU
INTO		#TempResearch
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
	
WHERE 		Criteria.DonorCategoryID = 7
AND		ScheduleGroupSourceCode.SourceCodeID = @vSourceCodeID
/************************************************************************/
/*	ALERT GROUP							*/
/************************************************************************/
SELECT 		Organization.OrganizationID,
		AlertGroupName, AlertMessage1, AlertMessage2, AlertScheduleMessage
INTO		#TempAlert
FROM		AlertOrganization
JOIN		Alert ON Alert.AlertID = AlertOrganization.AlertID
JOIN		Organization ON Organization.OrganizationID = AlertOrganization.OrganizationID
WHERE	AlertTypeID = 1
        
SELECT 		OrganizationName, 
		OrganizationAddress1 + '  ' + OrganizationAddress2 AS OrganizationAddress, 
		OrganizationCity, 
		CountyName, 
		StateAbbrv, 
		OrganizationZipCode, 
		OrganizationTypeName, 
		'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS Phone, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
		StateName,
		OrganAssigned, OrganSchedule, OMLA, OMUA, OFLA, OFUA,  
		BoneAssigned, BoneSchedule, BMLA, BMUA, BFLA, BFUA,
		TissueAssigned, TissueSchedule, TMLA, TMUA, TFLA, TFUA,  
		SkinAssigned, SkinSchedule, SMLA, SMUA, SFLA, SFUA, 
		ValvesAssigned, ValvesSchedule, VMLA, VMUA, VFLA, VFUA,
		EyesAssigned, EyesSchedule, EMLA, EMUA, EFLA, EFUA, 
		ResearchAssigned, ResearchSchedule, RMLA, RMUA, RFLA, RFUA,
		AlertGroupName, 
			CASE 
				WHEN AlertMessage1 IS NULL THEN ' &nbsp '
				--WHEN len(AlertMessage1) < 5 THEN ' &nbsp '
				ELSE AlertMessage1
			END AS AlertMessage1,
			CASE 
				WHEN AlertMessage2 IS NULL THEN ' &nbsp '
				--WHEN len(AlertMessage2) < 5 THEN ' &nbsp '
				ELSE AlertMessage2
			END AS AlertMessage2,
			CASE 
				WHEN AlertScheduleMessage IS NULL THEN ' &nbsp '
				--WHEN len(AlertScheduleMessage) < 5 THEN ' &nbsp '
				ELSE AlertScheduleMessage
			END AS AlertScheduleMessage,
			CASE 
				WHEN OMLAU = 'Years' THEN 'Y'
				WHEN OMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS OMLAU,
			CASE 
				WHEN OFLAU = 'Years' THEN 'Y'
				WHEN OFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS OFLAU,
			CASE 
				WHEN OMUAU = 'Years' THEN 'Y'
				WHEN OMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS OMUAU,
			CASE 
				WHEN OFUAU = 'Years' THEN 'Y'
				WHEN OFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS OFUAU,
			CASE 
				WHEN BMLAU = 'Years' THEN 'Y'
				WHEN BMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS BMLAU,
			CASE 
				WHEN BFLAU = 'Years' THEN 'Y'
				WHEN BFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS BFLAU,
			CASE 
				WHEN BMUAU = 'Years' THEN 'Y'
				WHEN BMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS BMUAU,
			CASE 
				WHEN BFUAU = 'Years' THEN 'Y'
				WHEN BFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS BFUAU,
			CASE 
				WHEN TMLAU = 'Years' THEN 'Y'
				WHEN TMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS TMLAU,
			CASE 
				WHEN TFLAU = 'Years' THEN 'Y'
				WHEN TFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS TFLAU,
			CASE 
				WHEN TMUAU = 'Years' THEN 'Y'
				WHEN TMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS TMUAU,
			CASE 
				WHEN TFUAU = 'Years' THEN 'Y'
				WHEN TFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS TFUAU,
			CASE 
				WHEN SMLAU = 'Years' THEN 'Y'
				WHEN SMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS SMLAU,
			CASE 
				WHEN SFLAU = 'Years' THEN 'Y'
				WHEN SFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS SFLAU,
			CASE 
				WHEN SMUAU = 'Years' THEN 'Y'
				WHEN SMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS SMUAU,
			CASE 
				WHEN SFUAU = 'Years' THEN 'Y'
				WHEN SFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS SFUAU,
			CASE 
				WHEN VMLAU = 'Years' THEN 'Y'
				WHEN VMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS VMLAU,
			CASE 
				WHEN VFLAU = 'Years' THEN 'Y'
				WHEN VFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS VFLAU,
			CASE 
				WHEN VMUAU = 'Years' THEN 'Y'
				WHEN VMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS VMUAU,
			CASE 
				WHEN VFUAU = 'Years' THEN 'Y'
				WHEN VFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS VFUAU,
			CASE 
				WHEN EMLAU = 'Years' THEN 'Y'
				WHEN EMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS EMLAU,
			CASE 
				WHEN EFLAU = 'Years' THEN 'Y'
				WHEN EFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS EFLAU,
			CASE 
				WHEN EMUAU = 'Years' THEN 'Y'
				WHEN EMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS EMUAU,
			CASE 
				WHEN EFUAU = 'Years' THEN 'Y'
				WHEN EFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS EFUAU,			CASE 
				WHEN RMLAU = 'Years' THEN 'Y'
				WHEN RMLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS RMLAU,
			CASE 
				WHEN RFLAU = 'Years' THEN 'Y'
				WHEN RFLAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS RFLAU,
			CASE 
				WHEN RMUAU = 'Years' THEN 'Y'
				WHEN RMUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS RMUAU,
			CASE 
				WHEN RFUAU = 'Years' THEN 'Y'
				WHEN RFUAU = 'Months' THEN 'M'
				ELSE ' &nbsp '
			END AS RFUAU,
		#TempOrgan.SourceCodeName
		
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
		LEFT JOIN #TempAlert ON #TempAlert.OrganizationID = Organization.OrganizationID
WHERE	SourceCodeOrganization.SourceCodeID = @vSourceCodeID AND #TempAlert.AlertGroupName Is Not Null
ORDER BY	#TempAlert.AlertGroupName, Organization.OrganizationName ASC




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

