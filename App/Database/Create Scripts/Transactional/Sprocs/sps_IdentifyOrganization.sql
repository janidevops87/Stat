SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IdentifyOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IdentifyOrganization]
GO


CREATE PROCEDURE sps_IdentifyOrganization

	@pvUserOrgID		int 	= 0

AS


   SELECT	OrganizationID, 
            		OrganizationName, 
            		StateAbbrv + ' - ' + OrganizationCity AS Location, 
            		OrganizationTypeID 
   FROM 	Organization 
   JOIN 		State ON State.StateID = Organization.StateID 
   WHERE 	OrganizationID = @pvUserOrgID
   ORDER BY 	StateAbbrv, OrganizationCity


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

