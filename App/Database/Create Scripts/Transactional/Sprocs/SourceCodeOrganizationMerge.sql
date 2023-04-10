  

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationMerge')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeOrganizationMerge'
		DROP Procedure SourceCodeOrganizationMerge
	END
GO

PRINT 'Creating Procedure SourceCodeOrganizationMerge'
GO
CREATE Procedure SourceCodeOrganizationMerge
(
		@SourceCodeOrganizationID int = null,
		@SourceCodeID int = null,
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
**	File: SourceCodeOrganizationMerge.sql
**	Name: SourceCodeOrganizationMerge
**	Desc: Updates SourceCodeOrganization Based on Id field
**	Note: Hidden = Selected in control 
**	Auth: ccarroll	
**	Date: 1/11/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/11/2010		ccarroll				Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

MERGE dbo.SourceCodeOrganization AS target
USING	(SELECT 
		@SourceCodeOrganizationID, 
		@SourceCodeID,
		@OrganizationID,
		@Hidden) AS source 
		(SourceCodeOrganizationID, 
		SourceCodeID, 
		OrganizationID,
		Hidden)
ON		(target.SourceCodeOrganizationID = source.SourceCodeOrganizationID)
WHEN MATCHED AND source.Hidden = 1  THEN 
	UPDATE		
	SET 
			SourceCodeID = @SourceCodeID,
			OrganizationID = @OrganizationID,
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 3 --Modify
			
			
WHEN MATCHED AND source.Hidden = 0  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 1 THEN
	INSERT	
	(
		SourceCodeID,
		OrganizationID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
	VALUES
	(
		@SourceCodeID, 
		@OrganizationID,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	);
  