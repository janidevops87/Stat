IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_SetOrganizationTimeZone')
	BEGIN
		PRINT 'Dropping Procedure sp_SetOrganizationTimeZone';
		DROP Procedure sp_SetOrganizationTimeZone;
	END
GO

PRINT 'Creating Procedure sp_SetOrganizationTimeZone';
GO
CREATE Procedure sp_SetOrganizationTimeZone
AS
/******************************************************************************
**	File: sp_SetOrganizationTimeZone.sql
**	Name: sp_SetOrganizationTimeZone
**	Desc: called by sql job to updates organization timezone from new field 
**			to old field for backwards compatability
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
*******************************************************************************/

	-- Some older functionality in the reporting site uses OrganizationTimeZone to convert times
	-- One of those places is the Dispaly Time zone in the new reporting site
	update Organization 
	set OrganizationTimeZone = TimeZone.TimeZoneAbbreviation
	from Organization
	join TimeZone on Organization.TimeZoneId = TimeZone.TimeZoneID
	where OrganizationTimeZone is null;

GO
GRANT EXEC ON sp_SetOrganizationTimeZone TO PUBLIC;
GO