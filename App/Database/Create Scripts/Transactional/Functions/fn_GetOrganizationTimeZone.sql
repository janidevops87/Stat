  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetOrganizationTimeZone]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_GetOrganizationTimeZone'
		DROP Function fn_GetOrganizationTimeZone
	END
GO

PRINT 'Creating Function fn_GetOrganizationTimeZone' 
GO

CREATE FUNCTION dbo.fn_GetOrganizationTimeZone
	(
	@OrganizationID int
	)
RETURNS VARCHAR(2)
AS
	BEGIN
		DECLARE @OrgTZ VARCHAR(2)
		SELECT @OrgTZ = TimeZone.TimeZoneAbbreviation 
		from Organization 
		join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
		where OrganizationID = @OrganizationID
		
	RETURN @OrgTZ
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

