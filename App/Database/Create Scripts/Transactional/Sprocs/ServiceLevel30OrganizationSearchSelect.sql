 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevel30OrganizationSearchSelect'
		DROP Procedure ServiceLevel30OrganizationSearchSelect
	END
GO

PRINT 'Creating Procedure ServiceLevel30OrganizationSearchSelect'
GO
CREATE Procedure ServiceLevel30OrganizationSearchSelect
(
		@OrganizationID int,
		@SourceCodeID int,
		@CriteriaStatus int
)
AS
/******************************************************************************
**	File: ServiceLevel30OrganizationSearchSelect.sql
**	Name: ServiceLevel30OrganizationSearchSelect
**	Desc: Selects multiple rows of ServiceLevel30Organization Based on Id  fields 
**	Auth: ccarroll
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll				Initial Sproc Creation 
**  06/15/2011		ccarroll				Added JOIN and WHERE for SourceCodeID
**											The ServiceLevel Organization must be from a list of
**											already selected sourcecodes 
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	DECLARE @ServiceLevelOrganizationID int = 0
	DECLARE @ServiceLevel30OrganizationTable Table
	(
		ServiceLevelOrganizationID int
	)
	insert @ServiceLevel30OrganizationTable
	SELECT DISTINCT ServiceLevel30Organization.ServiceLevelOrganizationID 
	FROM ServiceLevel30Organization 
	JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID 
	JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID 
	WHERE OrganizationID = @OrganizationID 		
	AND ServiceLevelSourceCode.SourceCodeID = @SourceCodeID 
	AND ServiceLevelStatus = @CriteriaStatus
	

	-- take the first
	SELECT TOP 1 @ServiceLevelOrganizationID = ServiceLevelOrganizationID FROM @ServiceLevel30OrganizationTable
	
	IF (@ServiceLevelOrganizationID > 0 )
	BEGIN
		EXEC ServiceLevel30OrganizationSelect @ServiceLevelOrganizationID = @ServiceLevelOrganizationID
	END
	
GO

GRANT EXEC ON ServiceLevel30OrganizationSearchSelect TO PUBLIC
GO
