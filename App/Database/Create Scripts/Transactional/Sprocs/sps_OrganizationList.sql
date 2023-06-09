SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OrganizationList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OrganizationList]
GO






/****** Object:  Stored Procedure dbo.sps_OrganizationList    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_OrganizationList 
AS
SELECT 	OrganizationName, 
	OrganizationAddress1 + "  " + OrganizationAddress2 AS OrganizationAddress, 
	OrganizationCity, 
	CountyName, 
	StateAbbrv, 
	OrganizationZipCode, 
	OrganizationTypeName, 
	"(" + PhoneAreaCode + ") " + PhonePrefix + "-" + PhoneNumber AS Phone, 
	TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
	StateName, 
	Organization.StateID, Organization.OrganizationTypeID, 
	ProviderNumber
FROM 	Organization 
	LEFT JOIN County ON Organization.CountyID = County.CountyID
	LEFT JOIN Phone ON Organization.PhoneID = Phone.PhoneID 
	LEFT JOIN State ON Organization.StateID = State.StateID
	LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	
ORDER BY OrganizationTypeName ASC, OrganizationName ASC




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

