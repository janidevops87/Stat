

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaAgeUnitInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaAgeUnitInsert'
		DROP Procedure CriteriaAgeUnitInsert
	END
GO

PRINT 'Creating Procedure CriteriaAgeUnitInsert'
GO
CREATE Procedure CriteriaAgeUnitInsert
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
**	File: CriteriaAgeUnitInsert.sql
**	Name: CriteriaAgeUnitInsert
**	Desc: Inserts CriteriaAgeUnit Based on Id field 
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

INSERT	CriteriaAgeUnit
	(
		CriteriaAgeUnitName,
		DisplayOrder,
		Inactive,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CriteriaAgeUnitName,
		@DisplayOrder,
		@Inactive,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CriteriaAgeUnitID = SCOPE_IDENTITY()

EXEC CriteriaAgeUnitSelect @CriteriaAgeUnitID

GO

GRANT EXEC ON CriteriaAgeUnitInsert TO PUBLIC
GO
