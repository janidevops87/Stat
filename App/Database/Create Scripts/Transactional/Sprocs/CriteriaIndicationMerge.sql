    

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaIndicationMerge')
	BEGIN
		PRINT 'Dropping Procedure CriteriaIndicationMerge'
		DROP Procedure CriteriaIndicationMerge
	END
GO

PRINT 'Creating Procedure CriteriaIndicationMerge'
GO
CREATE Procedure CriteriaIndicationMerge
(
		@CriteriaIndicationID int = null,
		@CriteriaID int = null,
		@IndicationID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,		
		@IndicationHighRisk int = null,
		@IndicationStandardMRO int = null,
		@UpdateFlag int = null,
		@IndicationName varchar(80) = null,
		@IndicationResponseName nvarchar(50) = null,
		@Hidden BIT = null
)
AS
/******************************************************************************
**	File: CriteriaIndicationMerge.sql
**	Name: CriteriaIndicationMerge
**	Desc: Updates CriteriaIndication Based on Id field 
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

MERGE dbo.CriteriaIndication AS target
USING	(SELECT 
		@CriteriaIndicationID, 
		@CriteriaID,
		@IndicationID,
		@Hidden) AS source 
		(CriteriaIndicationID, 
		CriteriaID, 
		IndicationID,
		Hidden)
ON		(target.CriteriaIndicationID = source.CriteriaIndicationID)
WHEN MATCHED AND source.Hidden = 1  THEN 
	UPDATE		
	SET 
			CriteriaID = @CriteriaID,
			IndicationID = @IndicationID,
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 3 --Modify
			
			
WHEN MATCHED AND source.Hidden = 0  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 1 THEN
	INSERT	
	(
		CriteriaID,
		IndicationID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
	VALUES
	(
		@CriteriaID, 
		@IndicationID,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	);
  