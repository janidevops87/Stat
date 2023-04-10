

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaAgeUnitUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaAgeUnitUpdate'
		DROP Procedure CriteriaAgeUnitUpdate
	END
GO

PRINT 'Creating Procedure CriteriaAgeUnitUpdate'
GO
CREATE Procedure CriteriaAgeUnitUpdate
(
		@CriteriaAgeUnitID int = null output,
		@CriteriaAgeUnitName nvarchar(10) = null,
		@DisplayOrder int = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaAgeUnitUpdate.sql
**	Name: CriteriaAgeUnitUpdate
**	Desc: Updates CriteriaAgeUnit Based on Id field 
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
*******************************************************************************/

UPDATE
	dbo.CriteriaAgeUnit 	
SET 
		CriteriaAgeUnitName = @CriteriaAgeUnitName,
		DisplayOrder = @DisplayOrder,
		Inactive = @Inactive,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaAgeUnitID = @CriteriaAgeUnitID 				

GO

GRANT EXEC ON CriteriaAgeUnitUpdate TO PUBLIC
GO
