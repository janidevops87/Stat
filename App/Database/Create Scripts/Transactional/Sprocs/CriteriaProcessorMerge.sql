    

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaProcessorMerge')
	BEGIN
		PRINT 'Dropping Procedure CriteriaProcessorMerge'
		DROP Procedure CriteriaProcessorMerge
	END
GO

PRINT 'Creating Procedure CriteriaProcessorMerge'
GO
CREATE Procedure CriteriaProcessorMerge
(
		@CriteriaProcessorID int = null,
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
**	File: CriteriaProcessorMerge.sql
**	Name: CriteriaProcessorMerge
**	Desc: Updates CriteriaProcessor Based on Id field 
**	Note: Hidden = Selected in control 
**	Auth: ccarroll	
**	Date: 1/19/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/19/2010		ccarroll				Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

MERGE dbo.CriteriaProcessor AS target
USING	(SELECT 
		@CriteriaProcessorID, 
		@CriteriaID,
		@OrganizationID,
		@Hidden) AS source 
		(CriteriaProcessorID, 
		CriteriaID, 
		OrganizationID,
		Hidden)
ON		(target.CriteriaProcessorID = source.CriteriaProcessorID)
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
  