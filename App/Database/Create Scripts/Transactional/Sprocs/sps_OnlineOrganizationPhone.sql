SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineOrganizationPhone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineOrganizationPhone]
GO




CREATE PROCEDURE sps_OnlineOrganizationPhone 
			@vOrganizationID as int


 AS

select Organization.OrganizationID,Organization.OrganizationName,Phone.PhoneAreaCode,Phone.PhonePrefix,Phone.PhoneNumber from Organization JOIN Phone ON Phone.PhoneID = Organization.PhoneID where Organization.OrganizationID =  @vOrganizationID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

