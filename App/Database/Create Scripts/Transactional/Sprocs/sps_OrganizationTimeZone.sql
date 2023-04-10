SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OrganizationTimeZone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OrganizationTimeZone]
GO






/****** Object:  Stored Procedure dbo.sps_OrganizationTimeZone    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_OrganizationTimeZone

	@vOrgID	int		= null

AS 

	SELECT TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone'
	from Organization 
	join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
	where OrganizationID = @vOrgID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

