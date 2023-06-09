SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_EditWebUserAcct]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_EditWebUserAcct]
GO


CREATE PROCEDURE sps_EditWebUserAcct (@webPersonId integer = 0)
/*
  Given a WebPersonId, gets information from Person and WebPerson tables for use in CreateAcctAdmin.sls
  Created 3/18/05  by Scott Plummer

*/

AS


SELECT WP.WebPersonId, WP.PersonId, WP.WebPersonUserName, WebPersonPassword, 
	WP.Access, PE.PersonFirst, PE.PersonLast, PE.PersonTypeId,
	PE.OrganizationId, OG.OrganizationName
FROM WebPerson WP
JOIN Person PE ON WP.PersonId = PE.PersonId
JOIN Organization OG ON PE.OrganizationId = OG.OrganizationId
WHERE WebPersonId = @webPersonId;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

