SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_GetNationalCoalition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_GetNationalCoalition]
GO


CREATE PROCEDURE sps_COD_GetNationalCoalition 

AS

-- The OrganizationUserCode for the National Coalition must always be '000'
-- This stored procedure should return the Organization ID for the National Coalition
SELECT a.OrganizationID
FROM Organization a, OrganizationType b
WHERE UPPER(b.OrganizationTypeName) = 'COALITION'
AND b.OrganizationTypeID = a. OrganizationTypeID
AND a.OrganizationUserCode = '000'



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

