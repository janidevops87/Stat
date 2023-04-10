  

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AdministrationOrganizationSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure AdministrationOrganizationSearchSelect'
		DROP Procedure AdministrationOrganizationSearchSelect
	END
GO

PRINT 'Creating Procedure AdministrationOrganizationSearchSelect'
GO
CREATE Procedure AdministrationOrganizationSearchSelect
(
		@OrganizationID INT 
		
)
AS
/******************************************************************************
**	File: AdministrationOrganizationSearchSelect.sql
**	Name: AdministrationOrganizationSearchSelect
**	Desc: Selects multiple rows of Criteria Based on Id  fields 
**	Auth: Bret	
**	Date: 06/17/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	06/17/2011		Bret					Initial Sproc Creation
**	01/29/2015		Bret					Modified the sproc to not return any results if the organization 
**											exists in all groups.
*********************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON; 
	-- Declare Search Params 
	DECLARE
		@City nvarchar(30),
		@StateId int,
		@CountyId int,
		@AreaCode nvarchar(3),
		@SourceCodeId int;
	
	DECLARE @OrganizationList Table
	(
		ListId INT,
		FieldValue NVARCHAR(100)
	);
	
	-- fill the parameters
	SELECT
		@City = Organization.OrganizationCity,
		@StateId =  Organization.StateID,
		@CountyId = Organization.CountyID,
		@AreaCode = Phone.PhoneAreaCode,
		@SourceCodeId = SourceCodeOrganization.SourceCodeID
	FROM Organization
	LEFT JOIN OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	AND OrganizationPhone.SubLocationID = 60 -- MAIN
	LEFT JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
	LEFT JOIN SourceCodeOrganization ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID
	WHERE Organization.OrganizationID = @OrganizationID;

	-- add the organization to the list if it exists in all groups
	-- if the organization does not exist in all groups results set will be returned
	-- if the organization does exist in all groups no results will be returned.
	INSERT @OrganizationList
	SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName 
	FROM Organization 
	JOIN SourceCodeOrganization ON  Organization.OrganizationID = SourceCodeOrganization.OrganizationID
	JOIN CriteriaOrganization ON  Organization.OrganizationID = CriteriaOrganization.OrganizationID
	JOIN ServiceLevel30Organization ON  Organization.OrganizationID = ServiceLevel30Organization.OrganizationID
	JOIN ScheduleGroupOrganization ON  Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID
	JOIN AlertOrganization ON  Organization.OrganizationID = AlertOrganization.OrganizationID
	AND Organization.OrganizationID = @OrganizationID
	AND SourceCodeOrganization.SourceCodeID = @SourceCodeId;

	IF NOT EXISTS (SELECT * FROM @OrganizationList)		
	BEGIN
		-- City & State
		INSERT @OrganizationList
		SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName 
		FROM Organization 
		JOIN SourceCodeOrganization ON  Organization.OrganizationID = SourceCodeOrganization.OrganizationID
		WHERE Organization.OrganizationCity = @City
		AND Organization.StateID = @StateId
		AND Organization.OrganizationID <> @OrganizationID
		AND SourceCodeOrganization.SourceCodeID = @SourceCodeId
		AND Organization.OrganizationTypeID > 1;
	END	
	IF NOT EXISTS (SELECT * FROM @OrganizationList)		
	BEGIN
		
		-- County & State
		INSERT @OrganizationList
		SELECT DISTINCT Organization.OrganizationID, 
		Organization.OrganizationName 
		FROM  Organization 
		JOIN SourceCodeOrganization ON  Organization.OrganizationID = SourceCodeOrganization.OrganizationID
		WHERE Organization.CountyID = @CountyId
		AND Organization.StateID = @StateId
		AND Organization.OrganizationID <> @OrganizationID
		AND SourceCodeOrganization.SourceCodeID = @SourceCodeId
		AND Organization.OrganizationTypeID > 1;
		
	END	
	IF NOT EXISTS (SELECT * FROM @OrganizationList)		
	BEGIN

		-- Area & State
		INSERT @OrganizationList
		SELECT DISTINCT Organization.OrganizationID, 
		Organization.OrganizationName 
		FROM  Organization 
		JOIN OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
		JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID
		JOIN SourceCodeOrganization ON  Organization.OrganizationID = SourceCodeOrganization.OrganizationID
		WHERE Organization.StateID = @StateId
		AND Organization.OrganizationID <> @OrganizationID
		AND Phone.PhoneAreaCode = @AreaCode
		AND SourceCodeOrganization.SourceCodeID = @SourceCodeId
		AND Organization.OrganizationTypeID > 1;
	END	
	IF NOT EXISTS (SELECT * FROM @OrganizationList)		
	BEGIN

		-- State
		INSERT @OrganizationList
		SELECT DISTINCT Organization.OrganizationID, 
		Organization.OrganizationName 
		FROM  Organization 
		JOIN SourceCodeOrganization ON  Organization.OrganizationID = SourceCodeOrganization.OrganizationID
		WHERE Organization.StateID = @StateId
		AND Organization.OrganizationID <> @OrganizationID
		AND SourceCodeOrganization.SourceCodeID = @SourceCodeId
		AND Organization.OrganizationTypeID > 1;
	END	

	SELECT
		ListId,
		FieldValue
	FROM @OrganizationList
	WHERE ListId <> @OrganizationID;
	
GO

GRANT EXEC ON AdministrationOrganizationSearchSelect TO PUBLIC
GO
