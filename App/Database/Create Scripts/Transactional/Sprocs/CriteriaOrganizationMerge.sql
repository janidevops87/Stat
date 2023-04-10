   

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaOrganizationMerge')
	BEGIN
		PRINT 'Dropping Procedure CriteriaOrganizationMerge'
		DROP Procedure CriteriaOrganizationMerge
	END
GO

PRINT 'Creating Procedure CriteriaOrganizationMerge'
GO
CREATE Procedure CriteriaOrganizationMerge
(
		@CriteriaOrganizationID int = null,
		@CriteriaID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,		
		@OrganizationName varchar(50) = null,
		@OrganizationCity varchar(50) = null,
		@StateAbbrv varchar(50) = null,
		@OrganizationType varchar(50) = null,
		@Hidden BIT = null
)
AS
/******************************************************************************
**	File: CriteriaOrganizationMerge.sql
**	Name: CriteriaOrganizationMerge
**	Desc: Updates CriteriaOrganization Based on Id field 
**	Note: Hidden = Selected in control 
**	Auth: ccarroll	
**	Date: 1/12/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/12/2010		ccarroll				Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

MERGE dbo.CriteriaOrganization AS target
USING	(SELECT 
		@CriteriaOrganizationID, 
		@CriteriaID,
		@OrganizationID,
		@Hidden) AS source 
		(CriteriaOrganizationID, 
		CriteriaID, 
		OrganizationID,
		Hidden)
ON		(target.CriteriaOrganizationID = source.CriteriaOrganizationID)
WHEN MATCHED AND source.Hidden = 1  THEN 
	UPDATE		
	SET 
			CriteriaID = @CriteriaID,
			OrganizationID = @OrganizationID,
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 3 --Modify
			
			
WHEN MATCHED AND source.Hidden = 0  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 1 THEN
	INSERT	
	(
		CriteriaID,
		OrganizationID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
	VALUES
	(
		@CriteriaID, 
		@OrganizationID,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	);
  