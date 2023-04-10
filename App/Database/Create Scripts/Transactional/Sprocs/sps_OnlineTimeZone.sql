SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineTimeZone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineTimeZone]
GO




CREATE PROCEDURE sps_OnlineTimeZone
		
		@vOrgID	int		= null


AS

Select 
	TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone',
	OrganizationName 

FROM Organization 
LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
where OrganizationID = @vOrgID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

