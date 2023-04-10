SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ProcurementOrganizations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ProcurementOrganizations]
GO



CREATE  PROCEDURE SPS_ProcurementOrganizations AS

SELECT OrganizationID, OrganizationName 
FROM Organization
-- bjk 01/06/04 removed to add Seacoast Hospice as a Customer
-- WHERE OrganizationTypeID = 1
ORDER BY OrganizationName






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

