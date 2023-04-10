IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeOrganizationSelect'
		DROP Procedure SourceCodeOrganizationSelect
	END
GO

PRINT 'Creating Procedure SourceCodeOrganizationSelect'
GO
CREATE Procedure SourceCodeOrganizationSelect
(		
		@SourceCodeID int = null,
		@SearchSourceCodeID int = null,
		@GetSelected int = null,
		@OrganizationID int = null,
		@OrganizationName varchar(80) = NULL, 
		@StateId int = NULL, 
		@OrganizationTypeId int = NULL, 
		@ContractedStatlineClient bit = NULL, 
		@DisplayAllOrganizations bit = 0, 
		@AdministrationGroupFieldValue nvarchar(125)= NULL,
		@CountyID int = null						
)
AS
/******************************************************************************
**	File: SourceCodeOrganizationSelect.sql
**	Name: SourceCodeOrganizationSelect
**	Desc: Selects multiple rows of SourceCodeOrganization Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			Added this note for development build (GenerateSQL)
**  02/14/2011		ccarroll			Added option to load Available or Selected (@GetSelected)
**										Added SET NOCOUNT 
**  03/23/2011		ccarroll			Added @OrganizationName to left side (unselected)
**  04/12/2011		ccarroll			Added OrganizationType to return values
**	04/19/2011		ccarroll			Added COALESCE to Hidden Select side
**	04/21/2011		ccarroll			Added JOIN and WHERE for @AdministrationGroupFieldValue
**	05/31/2011		ccarroll			Added parameter @SearchSourceCodeID
**  06/02/2011		ccarroll			Added section for selecting records from another source code
**										and mark as unselected for current source code wi: 12486
**	06/03/2011		ccarroll			Added Organization name when searching another source code
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
IF @ContractedStatlineClient = 0
BEGIN
	SET @ContractedStatlineClient = Null
END


	
	DECLARE @TEMPSourceCodeOrganization TABLE
	(
		SourceCodeOrganizationID int NULL,
		SourceCodeID int NULL,
		OrganizationID int NULL,
		LastModified datetime NULL,		
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL,
		OrganizationName NVARCHAR(80),
		OrganizationCity NVARCHAR(30),
		StateAbbrv NVARCHAR(4),
		OrganizationType NVARCHAR(50), 
		Hidden BIT,
		IDCOLUMN INT IDENTITY(-1, -1)

	) 

/* Load the Selected side
	If @GetSelected	is null, then both sides will load */
	
IF (IsNull(@GetSelected, 1) = 1)
BEGIN
	--- FIRST SELECT SELECTED VALUES INTO A TEMP TABLE
	INSERT @TEMPSourceCodeOrganization
	SELECT
		SourceCodeOrganization.SourceCodeOrganizationID,
		SourceCodeOrganization.SourceCodeID,
		Organization.OrganizationID,
		COALESCE(SourceCodeOrganization.LastModified, GETDATE()),		
		COALESCE(SourceCodeOrganization.LastStatEmployeeID, -1),
		COALESCE(SourceCodeOrganization.AuditLogTypeID, 0),
		Organization.OrganizationName,
		Organization.OrganizationCity,
		State.StateAbbrv,
		OrganizationType.OrganizationTypeName,
		1 AS 'Hidden' --Selected		
	
	FROM 
		dbo.SourceCodeOrganization
	JOIN 
		Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID	 
	LEFT JOIN 
		State ON Organization.StateID =  State.StateID
	LEFT JOIN 
		OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	WHERE 
		SourceCodeOrganization.SourceCodeID = ISNULL(@SourceCodeID, SourceCodeOrganization.SourceCodeID)
		AND Organization.StateID = ISNULL(@StateId, Organization.StateID)
		AND Organization.OrganizationTypeID = ISNULL(@OrganizationTypeId, Organization.OrganizationTypeID)
END
-- NEXT ADD THE RECORDS NOT SELECTED FOR CURRENT SOURCECODE
-- Load the Available side
IF (@SourceCodeID IS NOT NULL AND (IsNull(@GetSelected, 0) = 0) AND IsNull(@SearchSourceCodeID, 0) = 0)
BEGIN
		INSERT 
			@TEMPSourceCodeOrganization
		SELECT
			SourceCodeOrganization.SourceCodeOrganizationID, 
			COALESCE(SourceCodeOrganization.SourceCodeID, @SourceCodeID),
			Organization.OrganizationID,
			COALESCE(SourceCodeOrganization.LastModified, GETDATE()),		
			COALESCE(SourceCodeOrganization.LastStatEmployeeID, -1),
			COALESCE(SourceCodeOrganization.AuditLogTypeID, 0),
			Organization.OrganizationName,
			Organization.OrganizationCity,
			State.StateAbbrv,
			OrganizationType.OrganizationTypeName,
			0 AS 'Hidden' --unselected			
		FROM 
			Organization 
			
		LEFT JOIN 
			SourceCodeOrganization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID	
			AND SourceCodeOrganization.SourceCodeID = @SourceCodeID
		LEFT JOIN 
			State ON Organization.StateID =  State.StateID
		LEFT JOIN 
			OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
		LEFT JOIN
			GetOrganizationsByAdministrationGroup(@AdministrationGroupFieldValue) AdministrationGroup ON Organization.OrganizationID = AdministrationGroup.OrganizationID		

		WHERE 
			IsNull(SourceCodeOrganization.SourceCodeOrganizationID, -1) = IsNull(@SearchSourceCodeID, -1)
		AND PATINDEX(IsNull(@OrganizationName, Organization.OrganizationName) + '%', Organization.OrganizationName) > 0
		AND Organization.StateID = ISNULL(@StateId, Organization.StateID)
		AND Organization.OrganizationTypeID = ISNULL(@OrganizationTypeId, Organization.OrganizationTypeID)
		AND ISNULL(Organization.ContractedStatLineClient, 0) = ISNULL(@ContractedStatlineClient, ISNULL(Organization.ContractedStatLineClient, 0))
		-- Administrative Group
		AND ( 
				COALESCE(@AdministrationGroupFieldValue, '') = ''  
			OR
				AdministrationGroup.OrganizationID IS NOT NULL
			)
END

/* ADD SELECTED RECORDS FROM ANOTHER SOURCECODE AND MARK AS UNSELECTED FOR CURRENT SOURCECODE*/
IF (@SourceCodeID IS NOT NULL AND (IsNull(@GetSelected, 0) = 0) AND IsNull(@SearchSourceCodeID, 0) > 0)
BEGIN
		INSERT 
			@TEMPSourceCodeOrganization
		SELECT
			SourceCodeOrganization.SourceCodeOrganizationID, 
			@SourceCodeID,
			Organization.OrganizationID,
			COALESCE(SourceCodeOrganization.LastModified, GETDATE()),		
			COALESCE(SourceCodeOrganization.LastStatEmployeeID, -1),
			COALESCE(SourceCodeOrganization.AuditLogTypeID, 0),
			Organization.OrganizationName,
			Organization.OrganizationCity,
			State.StateAbbrv,
			OrganizationType.OrganizationTypeName,
			0 AS 'Hidden' --unselected			
	FROM 
		dbo.SourceCodeOrganization
	JOIN 
		Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID	 
	LEFT JOIN 
		State ON Organization.StateID =  State.StateID
	LEFT JOIN 
		OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	WHERE 
		SourceCodeOrganization.SourceCodeID = @SearchSourceCodeID
		AND PATINDEX(IsNull(@OrganizationName, Organization.OrganizationName) + '%', Organization.OrganizationName) > 0
		AND Organization.StateID = ISNULL(@StateId, Organization.StateID)
		AND Organization.OrganizationTypeID = ISNULL(@OrganizationTypeId, Organization.OrganizationTypeID)
END
	-- finally select the values from the temp table.
	SELECT
		COALESCE(SourceCodeOrganizationID, IDCOLUMN) AS SourceCodeOrganizationID,
		SourceCodeID,
		OrganizationID,
		LastModified,		
		LastStatEmployeeID,
		AuditLogTypeID,
		OrganizationName,
		OrganizationCity,
		StateAbbrv,
		OrganizationType,
		Hidden
	FROM 
		@TEMPSourceCodeOrganization
	ORDER BY
		SourceCodeID,
		OrganizationName
GO

GRANT EXEC ON SourceCodeOrganizationSelect TO PUBLIC
GO
