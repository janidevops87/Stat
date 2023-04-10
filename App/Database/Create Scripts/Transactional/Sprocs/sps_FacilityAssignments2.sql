 
/****** Object:  StoredProcedure [dbo].[sps_FacilityAssignments2]    Script Date: 08/01/2011 15:41:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_FacilityAssignments2]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE [dbo].[sps_FacilityAssignments2]'
	DROP PROCEDURE [dbo].[sps_FacilityAssignments2]
END
GO


GO

/****** Object:  StoredProcedure [dbo].[sps_FacilityAssignments2]    Script Date: 08/01/2011 15:41:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

PRINT 'CREATE PROCEDURE [dbo].[sps_FacilityAssignments2]'
GO
/****** Object:  Stored Procedure dbo.sps_FacilityAssignments2    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE [dbo].[sps_FacilityAssignments2]  
  @vStateID  int  = null
AS
/******************************************************************************
**		File: sps_FacilityAssignments2.SQL
**		Name: sps_FacilityAssignments2
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: unknown
**		Date: 08/01/2011
*******************************************************************************
**		Change History
*******************************************************************************
**	  Date:		Author:		Description:
**	  --------	--------	-------------------------------------------
**    Unknown			Initial
*******************************************************************************/ 
/************************************************************************/
/* ORGAN        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS OrganAssigned,
  ScheduleGroupName AS OrganSchedule,
  CriteriaMaleLowerAge AS OMLA, CriteriaMaleLowerAgeUnit AS OMLAU,
  CriteriaMaleUpperAge AS OMUA, CriteriaMaleUpperAgeUnit AS OMUAU,
  CriteriaFemaleLowerAge AS OFLA, CriteriaFemaleLowerAgeUnit AS OFLAU,
  CriteriaFemaleUpperAge AS OFUA, CriteriaFemaleUpperAgeUnit AS OFUAU
INTO  #TempOrgan
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 1
AND   Organization.StateID = @vStateID
/************************************************************************/
/* BONE        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS BoneAssigned,
  ScheduleGroupName AS BoneSchedule,
  CriteriaMaleLowerAge AS BMLA, CriteriaMaleLowerAgeUnit AS BMLAU,
  CriteriaMaleUpperAge AS BMUA, CriteriaMaleUpperAgeUnit AS BMUAU,
  CriteriaFemaleLowerAge AS BFLA, CriteriaFemaleLowerAgeUnit AS BFLAU,
  CriteriaFemaleUpperAge AS BFUA, CriteriaFemaleUpperAgeUnit AS BFUAU
INTO  #TempBone
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 2
AND   Organization.StateID = @vStateID
/************************************************************************/
/* TISSUE        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS TissueAssigned,
  ScheduleGroupName AS TissueSchedule,
  CriteriaMaleLowerAge AS TMLA, CriteriaMaleLowerAgeUnit AS TMLAU,
  CriteriaMaleUpperAge AS TMUA, CriteriaMaleUpperAgeUnit AS TMUAU,
  CriteriaFemaleLowerAge AS TFLA, CriteriaFemaleLowerAgeUnit AS TFLAU,
  CriteriaFemaleUpperAge AS TFUA, CriteriaFemaleUpperAgeUnit AS TFUAU
INTO  #TempTissue
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 3
AND   Organization.StateID = @vStateID
/************************************************************************/
/* SKIN        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS SkinAssigned,
  ScheduleGroupName AS SkinSchedule,
  CriteriaMaleLowerAge AS SMLA, CriteriaMaleLowerAgeUnit AS SMLAU,
  CriteriaMaleUpperAge AS SMUA, CriteriaMaleUpperAgeUnit AS SMUAU,
  CriteriaFemaleLowerAge AS SFLA, CriteriaFemaleLowerAgeUnit AS SFLAU,
  CriteriaFemaleUpperAge AS SFUA, CriteriaFemaleUpperAgeUnit AS SFUAU
INTO  #TempSkin
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 4
AND   Organization.StateID = @vStateID
/************************************************************************/
/* VALVES        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS ValvesAssigned,
  ScheduleGroupName AS ValvesSchedule,
  CriteriaMaleLowerAge AS VMLA, CriteriaMaleLowerAgeUnit AS VMLAU,
  CriteriaMaleUpperAge AS VMUA, CriteriaMaleUpperAgeUnit AS VMUAU,
  CriteriaFemaleLowerAge AS VFLA, CriteriaFemaleLowerAgeUnit AS VFLAU,
  CriteriaFemaleUpperAge AS VFUA, CriteriaFemaleUpperAgeUnit AS VFUAU
INTO  #TempValves
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 5
AND   Organization.StateID = @vStateID
/************************************************************************/
/* EYES        */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS EyesAssigned,
  ScheduleGroupName AS EyesSchedule,
  CriteriaMaleLowerAge AS EMLA, CriteriaMaleLowerAgeUnit AS EMLAU,
  CriteriaMaleUpperAge AS EMUA, CriteriaMaleUpperAgeUnit AS EMUAU,
  CriteriaFemaleLowerAge AS EFLA, CriteriaFemaleLowerAgeUnit AS EFLAU,
  CriteriaFemaleUpperAge AS EFUA, CriteriaFemaleUpperAgeUnit AS EFUAU
INTO  #TempEyes
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 6
AND   Organization.StateID = @vStateID
/************************************************************************/
/* RESEARCH       */
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
  OrganizationAssigned.OrganizationUserCode AS ResearchAssigned,
  ScheduleGroupName AS ResearchSchedule,
  CriteriaMaleLowerAge AS RMLA, CriteriaMaleLowerAgeUnit AS RMLAU,
  CriteriaMaleUpperAge AS RMUA, CriteriaMaleUpperAgeUnit AS RMUAU,
  CriteriaFemaleLowerAge AS RFLA, CriteriaFemaleLowerAgeUnit AS RFLAU,
  CriteriaFemaleUpperAge AS RFUA, CriteriaFemaleUpperAgeUnit AS RFUAU
INTO  #TempResearch
FROM   Organization 
JOIN   ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN   ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN   Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
  
JOIN   CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN   CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN   Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
AND   ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
 
WHERE   Criteria.DonorCategoryID = 7
AND   Organization.StateID = @vStateID
/************************************************************************/
/* ALERT GROUP       */
/************************************************************************/
SELECT Organization.OrganizationID,
  AlertGroupName, AlertMessage1, AlertMessage2, AlertScheduleMessage
INTO  #TempAlert
FROM  AlertOrganization
JOIN  Alert ON Alert.AlertID = AlertOrganization.AlertID
JOIN  Organization ON Organization.OrganizationID = AlertOrganization.OrganizationID
WHERE  Organization.StateID = @vStateID
AND  AlertTypeID = 1
        
SELECT DISTINCT OrganizationName, 
  OrganizationAddress1 + '  ' + OrganizationAddress2 AS OrganizationAddress, 
  OrganizationCity, 
  CountyName, 
  StateAbbrv, 
  OrganizationZipCode, 
  OrganizationTypeName, 
  '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS Phone, 
  TIMEZONE.TimeZoneAbbreviation 'OrganizationTimeZone', 
  StateName,
  OrganAssigned, OrganSchedule, OMLA, OMLAU, OMUA, OMUAU, OFLA, OFLAU, OFUA, OFUAU, 
  BoneAssigned, BoneSchedule, BMLA, BMLAU, BMUA, BMUAU, BFLA, BFLAU, BFUA, BFUAU, 
  TissueAssigned, TissueSchedule, TMLA, TMLAU, TMUA, TMUAU, TFLA, TFLAU, TFUA, TFUAU, 
  SkinAssigned, SkinSchedule, SMLA, SMLAU, SMUA, SMUAU, SFLA, SFLAU, SFUA, SFUAU,  
  ValvesAssigned, ValvesSchedule, VMLA, VMLAU, VMUA, VMUAU, VFLA, VFLAU, VFUA, VFUAU, 
  EyesAssigned, EyesSchedule, EMLA, EMLAU, EMUA, EMUAU, EFLA, EFLAU, EFUA, EFUAU, 
  ResearchAssigned, ResearchSchedule, RMLA, RMLAU, RMUA, RMUAU, RFLA, RFLAU, RFUA, RFUAU, 
  AlertGroupName, AlertMessage1, AlertMessage2, AlertScheduleMessage
  
FROM   Organization 
  LEFT JOIN County ON Organization.CountyID = County.CountyID
  LEFT JOIN Phone ON Organization.PhoneID = Phone.PhoneID 
  LEFT JOIN State ON Organization.StateID = State.StateID
  LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
  LEFT JOIN TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
  LEFT JOIN #TempOrgan ON #TempOrgan.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempBone ON #TempBone.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempTissue ON #TempTissue.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempSkin ON #TempSkin.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempValves ON #TempValves.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempEyes ON #TempEyes.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempResearch ON #TempResearch.OrganizationID = Organization.OrganizationID
  LEFT JOIN #TempAlert ON #TempAlert.OrganizationID = Organization.OrganizationID
WHERE  Organization.StateID = @vStateID
ORDER BY Organization.OrganizationName

GO


