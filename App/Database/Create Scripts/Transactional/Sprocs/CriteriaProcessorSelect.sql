IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaProcessorSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaProcessorSelect'
		DROP Procedure CriteriaProcessorSelect
	END
GO

PRINT 'Creating Procedure CriteriaProcessorSelect'
GO

CREATE Procedure [dbo].[CriteriaProcessorSelect]
(		
		@CriteriaID int = null,
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
**	File: CriteriaProcessorSelect.sql
**	Name: CriteriaProcessorSelect
**	Desc: Selects multiple rows of CriteriaProcessor Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/18/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/18/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF ISNULL(@OrganizationTypeId, 0) = 0
	BEGIN
		SET @OrganizationTypeId = null
	END

	IF ISNULL(@StateId, 0) = 0
	BEGIN
		SET @StateId = null
	END
	
	DECLARE @TEMPCriteriaProcessor TABLE
	(
		CriteriaProcessorID int NULL,
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
	
	--- FIRST SELECT SELECTED VALUES INTO A TEMP TABLE
	INSERT @TEMPCriteriaProcessor
	SELECT
		CriteriaProcessor.CriteriaProcessorID,
		CriteriaProcessor.CriteriaID,
		Organization.OrganizationID,
		CriteriaProcessor.LastModified,		
		CriteriaProcessor.LastStatEmployeeID,
		CriteriaProcessor.AuditLogTypeID,
		Organization.OrganizationName,
		Organization.OrganizationCity,
		State.StateAbbrv,
		OrganizationType.OrganizationTypeName,
		0 AS 'Hidden'		
	
	FROM 
		dbo.CriteriaProcessor
	JOIN 
		Organization ON CriteriaProcessor.OrganizationID = Organization.OrganizationID	 
	LEFT JOIN 
		State ON Organization.StateID =  State.StateID
	LEFT JOIN 
		OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	WHERE 
		CriteriaProcessor.CriteriaID = ISNULL(@CriteriaID, CriteriaProcessor.CriteriaID)

-- NEXT ADD THE RECORDS NOT SELECTED
	IF (@CriteriaID IS NOT NULL)
	BEGIN
		INSERT 
			@TEMPCriteriaProcessor
		SELECT
			CriteriaProcessor.CriteriaProcessorID, 
			COALESCE(CriteriaProcessor.CriteriaID, @CriteriaID),
			Organization.OrganizationID,
			COALESCE(CriteriaProcessor.LastModified, GETDATE()),		
			COALESCE(CriteriaProcessor.LastStatEmployeeID, -1),
			COALESCE(CriteriaProcessor.AuditLogTypeID, 0),
			Organization.OrganizationName,
			Organization.OrganizationCity,
			State.StateAbbrv,
			OrganizationType.OrganizationTypeName,
			1 AS 'Hidden'			
		FROM 
			Organization 
			
		LEFT JOIN 
			CriteriaProcessor ON CriteriaProcessor.OrganizationID = Organization.OrganizationID	
			AND CriteriaProcessor.CriteriaID = @CriteriaID
		LEFT JOIN 
			State ON Organization.StateID =  State.StateID
		LEFT JOIN 
			OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
		WHERE 
			CriteriaProcessor.CriteriaProcessorID IS NULL
		AND
			State.StateID = ISNULL(@StateID, State.StateID)
		AND Organization.OrganizationTypeID = ISNULL(@OrganizationTypeId, Organization.OrganizationTypeID)
							
	END
	-- finally select the values from the temp table note.
	-- intellsense does not know the columns of the temp table
	SELECT
		COALESCE(CriteriaProcessorID, IDCOLUMN) AS CriteriaProcessorID,
		CriteriaID,
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
		@TEMPCriteriaProcessor
	ORDER BY
		CriteriaID,
		OrganizationName


GO


