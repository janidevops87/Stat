

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaWeightUnitUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaWeightUnitUpdate'
		DROP Procedure CriteriaWeightUnitUpdate
	END
GO

PRINT 'Creating Procedure CriteriaWeightUnitUpdate'
GO
CREATE Procedure CriteriaWeightUnitUpdate
(
		@CriteriaWeightUnitID int = null output,
		@CriteriaWeightUnitName nvarchar(20) = null,
		@DisplayOrder int = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaWeightUnitUpdate.sql
**	Name: CriteriaWeightUnitUpdate
**	Desc: Updates CriteriaWeightUnit Based on Id field 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/16/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CriteriaWeightUnit 	
SET 
		CriteriaWeightUnitName = @CriteriaWeightUnitName,
		DisplayOrder = @DisplayOrder,
		Inactive = @Inactive,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaWeightUnitID = @CriteriaWeightUnitID 				

GO

GRANT EXEC ON CriteriaWeightUnitUpdate TO PUBLIC
GO
