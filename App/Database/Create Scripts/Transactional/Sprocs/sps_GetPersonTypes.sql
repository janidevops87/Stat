SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetPersonTypes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetPersonTypes]
GO


CREATE PROCEDURE sps_GetPersonTypes

/*
  Returns a list of all PersonTypes, ordered by name.
  Used by CreateAcctAdmin.sls
  Created 3/25/05 by Scott Plummer 

*/

AS

SELECT PersonTypeId, PersonTypeName 
	FROM PersonType 
	ORDER BY PersonTypeName;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

