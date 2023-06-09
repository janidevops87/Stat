SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetOrgSCList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetOrgSCList]
GO


CREATE PROCEDURE sps_GetOrgSCList

@SC		varchar(20)	=null,
@RefType	int		=null

AS

DECLARE	@RefStart	int
DECLARE	@RefLast	int

--Gather Referral Type Data
If @RefType <> 0
	BEGIN
		SELECT @RefStart = @RefType
		SELECT @RefLast = @RefType
	END
ELSE
	BEGIN
		SELECT @RefStart = @RefType
		SELECT @RefLast = MAX(OrganizationTypeID)
		FROM OrganizationType
	END

--If a Source Code is selected.
IF @SC <> 'All Source Codes'
BEGIN
	SELECT 	SourceCode.SourceCodeName,
		'(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber AS Phone,
		Organization.OrganizationName,
		Organization.OrganizationAddress1,
		Organization.OrganizationCity,
		County.CountyName,	
		Organization.OrganizationZipCode,
		OrganizationType.OrganizationTypeName
	FROM 	SourceCode
	JOIN 	SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID
	JOIN	Organization ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID
	JOIN	Phone ON Phone.PhoneID = Organization.PhoneID
	JOIN 	County ON County.CountyID = Organization.CountyID
	JOIN	OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
	WHERE 	SourceCodeName = @SC AND (OrganizationType.OrganizationTypeID BETWEEN @RefStart AND @RefLast)
	ORDER BY OrganizationTypeName ASC
END 
ELSE 
BEGIN
	SELECT 	'(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber AS Phone,
		Organization.OrganizationName,
		Organization.OrganizationAddress1,
		Organization.OrganizationCity,
		County.CountyName,	
		Organization.OrganizationZipCode,
		OrganizationType.OrganizationTypeName
	FROM 	Organization
	JOIN	Phone ON Phone.PhoneID = Organization.PhoneID
	JOIN 	County ON County.CountyID = Organization.CountyID
	JOIN	OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
	WHERE 	(OrganizationType.OrganizationTypeID BETWEEN @RefStart AND @RefLast)
	ORDER BY OrganizationTypeName, OrganizationName ASC
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

