

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaWeightUnitInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaWeightUnitInsert'
		DROP Procedure CriteriaWeightUnitInsert
	END
GO

PRINT 'Creating Procedure CriteriaWeightUnitInsert'
GO
CREATE Procedure CriteriaWeightUnitInsert
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
**	File: CriteriaWeightUnitInsert.sql
**	Name: CriteriaWeightUnitInsert
**	Desc: Inserts CriteriaWeightUnit Based on Id field 
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

INSERT	CriteriaWeightUnit
	(
		CriteriaWeightUnitName,
		DisplayOrder,
		Inactive,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CriteriaWeightUnitName,
		@DisplayOrder,
		@Inactive,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CriteriaWeightUnitID = SCOPE_IDENTITY()

EXEC CriteriaWeightUnitSelect @CriteriaWeightUnitID

GO

GRANT EXEC ON CriteriaWeightUnitInsert TO PUBLIC
GO
