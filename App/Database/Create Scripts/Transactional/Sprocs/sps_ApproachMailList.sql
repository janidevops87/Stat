SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachMailList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachMailList]
GO



/****** Object:  Stored Procedure dbo.sps_ApproachMailList    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_ApproachMailList
	@vReportGroupID		int		= null

AS

	SELECT DISTINCT
	Person.PersonFirst AS FCONSFNAME, 
	Person.PersonLast AS FCONSLNAME, 
	FCONSTITLE = 
	CASE 	PersonTypeName
		WHEN 'Nurse' THEN 'RN'
		WHEN 'Physician' THEN 'MD'
		ELSE PersonTypeName
	END,
	Organization.OrganizationName AS FCONSOURCE, 
	--SubLocation.SubLocationName + ' ' + Referral.ReferralCallerSubLocationLevel AS FAPHYSUNIT, 
	Organization.OrganizationAddress1 AS FCONSADDR, 
	Organization.OrganizationCity AS FCONSCITY, 
	State.StateAbbrv AS FCONSSTATE, 
	Organization.OrganizationZipCode AS FCONSZIP

	FROM      Person
	JOIN      Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN      State ON Organization.StateID = State.StateID

	JOIN      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	LEFT JOIN OrganizationPhone ON Organization.OrganizationId= OrganizationPhone.OrganizationId
	LEFT JOIN Phone ON OrganizationPhone.PhoneID =Phone.PhoneId


	WHERE Person.PersonFirst <> 'Unknown'
	AND      WebReportGroupOrg.WebReportGroupID = @vReportGroupID
        AND      Person.Inactive = 0
        AND      RIGHT(PersonLast, 1) = '*'


	ORDER BY Organization.OrganizationName, Person.PersonLast






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

