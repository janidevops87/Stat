SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineHospitalContactPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineHospitalContactPerson]
GO

CREATE PROCEDURE sps_OnlineHospitalContactPerson 
				@OrgID as int



 AS

SELECT Person.PersonID, CASE WHEN Person.Inactive = 1 THEN Person.PersonFirst+' '+PersonLast + ' (Inactive)' ELSE Person.PersonFirst+' '+PersonLast END  
AS Person, PersonType.PersonTypeName FROM Person JOIN Organization ON Organization.OrganizationID = Person.OrganizationID JOIN PersonType 
ON PersonType.PersonTypeID = Person.PersonTypeID WHERE Person.OrganizationID =@OrgID  AND Person.Inactive = 0 
ORDER BY PersonFirst, PersonLast
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

