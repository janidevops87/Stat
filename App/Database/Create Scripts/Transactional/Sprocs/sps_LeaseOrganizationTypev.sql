SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LeaseOrganizationTypev]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LeaseOrganizationTypev]
GO


CREATE PROCEDURE sps_LeaseOrganizationTypev
	@OrgID Integer 
 AS

Select Code as 'Code'
From LeaseType, LeaseOrganization
Where LeaseOrganizationID = @OrgID
AND (leasetype.ID & leaseOrganization.leaseorganizationtype <> 0)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

