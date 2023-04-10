 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleSearchSelect'
		DROP Procedure ScheduleSearchSelect
	END
GO

PRINT 'Creating Procedure ScheduleSearchSelect'
GO
CREATE Procedure ScheduleSearchSelect
(
		@OrganizationID int
)
AS
/******************************************************************************
**	File: ScheduleSearchSelect.sql
**	Name: ScheduleSearchSelect
**	Desc: Selects multiple rows of Schedule Based on Id  fields 
**	Auth: ccarroll	
**	Date: 05/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/13/2011		ccarroll				Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	DECLARE @ScheduleID int = 0
	DECLARE @ScheduleTable Table
	(
		ScheduleID int
	)
	
	-- search by city AND State
	INSERT @ScheduleTable
	SELECT DISTINCT Schedule.ScheduleID FROM Schedule
	JOIN ScheduleGroupOrganization ON Schedule.ScheduleID = ScheduleGroupOrganization.ScheduleGroupID
	JOIN Organization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID
	AND Organization.OrganizationID <> @OrganizationID
	JOIN Organization newOrganization ON newOrganization.OrganizationCity = Organization.OrganizationCity
	AND newOrganization.StateID = Organization.StateID
	WHERE newOrganization.OrganizationID = @OrganizationID
	
	-- search by county and state
	IF NOT EXISTS(SELECT ScheduleID FROM @ScheduleTable)
	BEGIN		
		print 'county'
		INSERT @ScheduleTable
		SELECT DISTINCT Schedule.ScheduleID FROM Schedule
		JOIN ScheduleGroupOrganization ON Schedule.ScheduleID = ScheduleGroupOrganization.ScheduleGroupID
		JOIN Organization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID
		AND Organization.OrganizationID <> @OrganizationID
		JOIN Organization newOrganization ON newOrganization.CountyID = Organization.CountyID
		AND newOrganization.StateID = Organization.StateID
		WHERE newOrganization.OrganizationID = @OrganizationID
	END
	-- search by area code and state
	IF NOT EXISTS(SELECT ScheduleID FROM @ScheduleTable)
	BEGIN		
		PRINT 'Search by Phone Area Code'
		
		INSERT @ScheduleTable
		SELECT DISTINCT Schedule.ScheduleID FROM Schedule
		JOIN ScheduleGroupOrganization ON Schedule.ScheduleID = ScheduleGroupOrganization.ScheduleGroupID
		JOIN Organization ON ScheduleGroupOrganization.OrganizationID = Organization.OrganizationID
		AND Organization.OrganizationID <> @OrganizationID
		JOIN OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
		JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID
		
		JOIN Organization newOrganization ON newOrganization.StateID = Organization.StateID
		
		JOIN OrganizationPhone newOrganizationPhone ON newOrganization.OrganizationID = newOrganizationPhone.OrganizationID
		JOIN Phone newPhone ON newOrganizationPhone.PhoneID = newPhone.PhoneID
		 
		AND Phone.PhoneAreaCode = newPhone.PhoneAreaCode
		
		WHERE newOrganization.OrganizationID = @OrganizationID
	END
	-- search by state only
	IF NOT EXISTS(SELECT ScheduleID FROM @ScheduleTable)
	BEGIN		
		print 'Search by State'
		INSERT @ScheduleTable
		SELECT DISTINCT Schedule.ScheduleID FROM Schedule
		JOIN ScheduleGroupOrganization ON Schedule.ScheduleID = ScheduleGroupOrganization.ScheduleGroupID
		JOIN Organization ON ScheduleGroupOrganization.ScheduleGroupOrganizationID = Organization.OrganizationID
		AND Organization.OrganizationID <> @OrganizationID
		JOIN Organization newOrganization ON newOrganization.StateID = Organization.StateID
		WHERE newOrganization.OrganizationID = @OrganizationID	
	END
	-- take the first
	SELECT TOP 1 @ScheduleID = ScheduleID FROM @ScheduleTable
	
	IF (@ScheduleID > 0 )
	BEGIN
		EXEC ScheduleSelectDataSet @ScheduleID = @ScheduleID
	END

	
GO

GRANT EXEC ON ScheduleSearchSelect TO PUBLIC
GO
