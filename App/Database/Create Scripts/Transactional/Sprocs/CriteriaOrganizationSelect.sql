IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaOrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaOrganizationSelect'
		DROP Procedure CriteriaOrganizationSelect
	END
GO

PRINT 'Creating Procedure CriteriaOrganizationSelect'
GO
CREATE Procedure [dbo].[CriteriaOrganizationSelect]
(		
		@CriteriaID int = null,
		@OrganizationID int = null,
		@OrganizationName varchar(80) = NULL, 
		@StateId int = NULL, 
		@OrganizationTypeId int = NULL, 
		@ContractedStatlineClient bit = NULL, 
		@DisplayAllOrganizations bit = 0, 
		@AdministrationGroupFieldValue nvarchar(125)= NULL,
		@CountyID int = null,
		@GetSelected int = 1 --- used to select only current active organization for the criteria						
)
AS
/******************************************************************************
**	File: CriteriaOrganizationSelect.sql
**	Name: CriteriaOrganizationSelect
**	Desc: Selects multiple rows of CriteriaOrganization Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/16/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
**  06/17/2011		Bret				added GetSelected
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @TEMPCriteriaOrganization TABLE
	(
		CriteriaOrganizationID int NULL,
		CriteriaID int NULL,
		OrganizationID int NULL,
		LastModified datetime NULL,		
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL,
		OrganizationName VARCHAR(80),
		OrganizationCity VARCHAR(30),
		StateAbbrv VARCHAR(4),
		OrganizationType VARCHAR(50),
		Hidden BIT,
		IDCOLUMN INT IDENTITY(-1, -1)

	) 
	
IF (@GetSelected = 1) 
BEGIN
	--- FIRST SELECT SELECTED VALUES INTO A TEMP TABLE
	INSERT @TEMPCriteriaOrganization
	SELECT
		CriteriaOrganization.CriteriaOrganizationID,
		CriteriaOrganization.CriteriaID,
		Organization.OrganizationID,
		CriteriaOrganization.LastModified,		
		CriteriaOrganization.LastStatEmployeeID,
		CriteriaOrganization.AuditLogTypeID,
		Organization.OrganizationName,
		Organization.OrganizationCity,
		State.StateAbbrv,
		OrganizationType.OrganizationTypeName,
		0 AS 'Hidden'		
	
	FROM 
		dbo.CriteriaOrganization
	JOIN 
		Organization ON CriteriaOrganization.OrganizationID = Organization.OrganizationID	 
	LEFT JOIN 
		OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	LEFT JOIN 
		State ON Organization.StateID =  State.StateID		
	WHERE 
		CriteriaOrganization.CriteriaID = ISNULL(@CriteriaID, CriteriaOrganization.CriteriaID)
END
IF (@GetSelected = 0) 
BEGIN
-- NEXT ADD THE RECORDS NOT SELECTED
	IF (@CriteriaID IS NOT NULL)
	BEGIN
		INSERT 
			@TEMPCriteriaOrganization
		SELECT
			CriteriaOrganization.CriteriaOrganizationID, 
			COALESCE(CriteriaOrganization.CriteriaID, @CriteriaID),
			Organization.OrganizationID,
			COALESCE(CriteriaOrganization.LastModified, GETDATE()),		
			COALESCE(CriteriaOrganization.LastStatEmployeeID, -1),
			COALESCE(CriteriaOrganization.AuditLogTypeID, 0),
			Organization.OrganizationName,
			Organization.OrganizationCity,
			State.StateAbbrv,
			OrganizationType.OrganizationTypeName,
			1 AS 'Hidden'			
		FROM 
			Organization 
			
		LEFT JOIN 
			CriteriaOrganization ON CriteriaOrganization.OrganizationID = Organization.OrganizationID	
			
		LEFT JOIN 
			State ON Organization.StateID =  State.StateID
		LEFT JOIN 
			OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
		WHERE 
			CriteriaOrganization.CriteriaID = @CriteriaID
		AND
					CriteriaOrganization.CriteriaOrganizationID IS NULL
		AND
			(
			@StateID IS NULL
			OR 
			State.StateID = @StateID
			)
							
	END
END
	-- finally select the values from the temp table note.
	-- intellsense does not know the columns of the temp table
	SELECT
		COALESCE(CriteriaOrganizationID, IDCOLUMN) AS CriteriaOrganizationID,
		CriteriaID,
		OrganizationID,
		LastModified,		
		IsNull(LastStatEmployeeID, -1) AS LastStatEmployeeID,
		IsNull(AuditLogTypeID, 0) AS AuditLogTypeID,
		OrganizationName,
		OrganizationCity,
		StateAbbrv,
		OrganizationType,
		Hidden
	FROM 
		@TEMPCriteriaOrganization
	ORDER BY
		CriteriaID,
		OrganizationName

GO


