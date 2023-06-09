SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachList]
GO






/****** Object:  Stored Procedure dbo.sps_ApproachList    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_ApproachList
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID		int		= null,
	@vReferralTypeID	int		= null
AS

IF @vReferralTypeID = 1

	SELECT
	CONVERT(varchar(8), CallDateTime,1) AS FCONSDATE, 
	Person.PersonFirst AS FCONSFNAME, 
	Person.PersonLast AS FCONSLNAME, 
	FCONSTITLE = 
	CASE 	PersonTypeName
		WHEN 'Nurse' THEN 'RN'
		WHEN 'Physician' THEN 'MD'
		ELSE PersonTypeName
	END,
	Organization.OrganizationName AS FCONSOURCE, 
	SubLocation.SubLocationName + ' ' + Referral.ReferralCallerSubLocationLevel AS FAPHYSUNIT, 
	Organization.OrganizationAddress1 AS FCONSADDR, 
	Organization.OrganizationCity AS FCONSCITY, 
	State.StateAbbrv AS FCONSSTATE, 
	Organization.OrganizationZipCode AS FCONSZIP, 
	Referral.ReferralDonorName AS FDNAME
 
	FROM Call 
	JOIN Referral ON Call.CallID = Referral.CallID
	JOIN Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
	JOIN State ON Organization.StateID = State.StateID 
	LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
	JOIN Person ON Referral.ReferralApproachedByPersonID = Person.PersonID
	JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 

	JOIN WebReportGroupOrg ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID
	WHERE Person.PersonFirst <> 'Unknown'
	AND Call.CallDateTime >= @vStartDate	 
	AND Call.CallDateTime <= @vEndDate
	AND Referral.ReferralOrganApproachID = 1 AND Referral.ReferralOrganConversionID <> 1
	AND WebReportGroupOrg.WebReportGroupID = @vReportGroupID

	ORDER BY Call.CallDateTime




ELSE IF @vReferralTypeID = 2 

	SELECT
	CONVERT(varchar(8), CallDateTime,1) AS FCONSDATE, 
	Person.PersonFirst AS FCONSFNAME, 
	Person.PersonLast AS FCONSLNAME, 
	FCONSTITLE = 
	CASE 	PersonTypeName
		WHEN 'Nurse' THEN 'RN'
		WHEN 'Physician' THEN 'MD'
		ELSE PersonTypeName
	END,
	Organization.OrganizationName AS FCONSOURCE, 
	SubLocation.SubLocationName + ' ' + Referral.ReferralCallerSubLocationLevel AS FAPHYSUNIT, 
	Organization.OrganizationAddress1 AS FCONSADDR, 
	Organization.OrganizationCity AS FCONSCITY, 
	State.StateAbbrv AS FCONSSTATE, 
	Organization.OrganizationZipCode AS FCONSZIP, 
	Referral.ReferralDonorName AS FDNAME
 
	FROM Call 
	JOIN Referral ON Call.CallID = Referral.CallID
	JOIN Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
	JOIN State ON Organization.StateID = State.StateID 
	LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
	JOIN Person ON Referral.ReferralApproachedByPersonID = Person.PersonID
	JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 

	JOIN WebReportGroupOrg ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID
	WHERE Person.PersonFirst <> 'Unknown'
	AND Call.CallDateTime >= @vStartDate	 
	AND Call.CallDateTime <= @vEndDate

	AND WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND 	((Referral.ReferralBoneApproachID = 1 AND Referral.ReferralBoneConversionID <> 1) OR
		(Referral.ReferralTissueApproachID = 1 AND Referral.ReferralTissueConversionID <> 1) OR
		(Referral.ReferralSkinApproachID = 1 AND Referral.ReferralSkinConversionID <> 1) OR
		(Referral.ReferralValvesApproachID = 1 AND Referral.ReferralValvesConversionID <> 1))

	ORDER BY Call.CallDateTime



ELSE IF @vReferralTypeID = 3 


	SELECT
	CONVERT(varchar(8), CallDateTime,1) AS FCONSDATE, 
	Person.PersonFirst AS FCONSFNAME, 
	Person.PersonLast AS FCONSLNAME, 
	FCONSTITLE = 
	CASE 	PersonTypeName
		WHEN 'Nurse' THEN 'RN'
		WHEN 'Physician' THEN 'MD'
		ELSE PersonTypeName
	END,
	Organization.OrganizationName AS FCONSOURCE, 
	SubLocation.SubLocationName + ' ' + Referral.ReferralCallerSubLocationLevel AS FAPHYSUNIT, 
	Organization.OrganizationAddress1 AS FCONSADDR, 
	Organization.OrganizationCity AS FCONSCITY, 
	State.StateAbbrv AS FCONSSTATE, 
	Organization.OrganizationZipCode AS FCONSZIP, 
	Referral.ReferralDonorName AS FDNAME

 
	FROM Call 
	JOIN Referral ON Call.CallID = Referral.CallID
	JOIN Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
	JOIN State ON Organization.StateID = State.StateID 
	LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
	JOIN Person ON Referral.ReferralApproachedByPersonID = Person.PersonID
	JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 

	JOIN WebReportGroupOrg ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID
	WHERE Person.PersonFirst <> 'Unknown'
	AND Call.CallDateTime >= @vStartDate	 
	AND Call.CallDateTime <= @vEndDate
	AND Referral.ReferralEyesTransApproachID = 1 AND Referral.ReferralEyesTransConversionID <> 1
	AND WebReportGroupOrg.WebReportGroupID = @vReportGroupID

	ORDER BY Call.CallDateTime




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

