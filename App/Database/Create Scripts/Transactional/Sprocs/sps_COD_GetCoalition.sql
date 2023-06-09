SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_GetCoalition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_GetCoalition]
GO


CREATE PROCEDURE sps_COD_GetCoalition 
	@zip varchar(5)

AS

-- Declare necessary variables
DECLARE @organizationID int,
	@personTypeID int

SELECT @personTypeID = PersonTypeID
FROM PersonType
WHERE PersonTypeName = 'Coalition Contact'

-- We want a record returned if the zip code exists, but it doesn't have a mapping, therefore, we use LEFT joins

SELECT Distinct Organization.OrganizationID, 
	Organization.OrganizationName, 
	Zip.ZipCityUSPSPreferred, 
	Zip.StateID, 
	State.StateName, 
	Person.PersonID,
	Person.PersonFirst, 
	Person.PersonLast, 
	Phone.PhoneAreaCode, 
	Phone.PhonePrefix, 
	Phone.PhoneNumber
FROM Zip
LEFT JOIN CODMap ON CODMap.CountyFIPS = Zip.ZipCountyFIPS AND CODMap.StateID = Zip.StateID
LEFT JOIN Organization ON Organization.OrganizationID = CODMap.OrganizationID
LEFT JOIN Person ON Person.OrganizationID = CODMap.OrganizationID and Person.PersonTypeID = @personTypeID
LEFT JOIN PersonPhone ON PersonPhone.PersonID = Person.PersonID
LEFT JOIN Phone ON Phone.PhoneID = PersonPhone.PhoneID
LEFT JOIN State ON State.StateID = CODMap.StateID
WHERE Zip.Zip = @zip






























GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

