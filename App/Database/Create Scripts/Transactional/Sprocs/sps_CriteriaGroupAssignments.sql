SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CriteriaGroupAssignments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CriteriaGroupAssignments]
GO






/****** Object:  Stored Procedure dbo.sps_CriteriaGroupAssignments    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_CriteriaGroupAssignments 	
		@vState		varchar(2)		= null
AS
DECLARE
		@vStateID	int
SELECT		@vStateID = StateID 
FROM		State
WHERE		StateAbbrv = @vState
/************************************************************************/
/*	ORGAN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS OrganCriteriaGroup
INTO 		#TempOrgan
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 1 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	BONE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS BoneCriteriaGroup
INTO 		#TempBone
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 2 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	TISSUE								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS TissueCriteriaGroup
INTO 		#TempTissue
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 3 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	SKIN								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS SkinCriteriaGroup
INTO 		#TempSkin
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 4 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	VALVES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS ValvesCriteriaGroup
INTO 		#TempValves
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 5 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	EYES								*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS EyesCriteriaGroup
INTO 		#TempEyes
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 6 OR CriteriaOrganization.CriteriaID = null)
/************************************************************************/
/*	RESEARCH							*/
/************************************************************************/
SELECT DISTINCT Organization.OrganizationID, 
		Criteria.CriteriaGroupName AS ResearchCriteriaGroup
INTO 		#TempResearch
FROM 		Organization
LEFT JOIN 	CriteriaOrganization ON Organization.OrganizationID = CriteriaOrganization.OrganizationID
LEFT JOIN 	Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
WHERE 		Organization.StateID = @vStateID	
AND 		(DonorCategoryID = 7 OR CriteriaOrganization.CriteriaID = null)
        
SELECT 		OrganizationName, 
		OrganizationAddress1 + "  " + OrganizationAddress2 AS OrganizationAddress, 
		OrganizationCity, 
		CountyName, 
		StateAbbrv, 
		OrganizationZipCode, 
		OrganizationTypeName, 
		"(" + PhoneAreaCode + ") " + PhonePrefix + "-" + PhoneNumber AS Phone, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', StateName, 
		OrganCriteriaGroup, 
		BoneCriteriaGroup, 
		TissueCriteriaGroup, 
		SkinCriteriaGroup, 
		ValvesCriteriaGroup, 
		EyesCriteriaGroup, 
		ResearchCriteriaGroup
		
FROM 		Organization 
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
WHERE		Organization.StateID = @vStateID
ORDER BY	Organization.OrganizationName





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

