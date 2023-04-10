  IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaIndicationInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaIndicationInsert'
		DROP Procedure CriteriaIndicationInsert
	END
GO

PRINT 'Creating Procedure CriteriaIndicationInsert'
GO
CREATE Procedure CriteriaIndicationInsert
(
		@CriteriaIndicationID int = null output,
		@CriteriaID int = null,
		@IndicationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaIndicationInsert.sql
**	Name: CriteriaIndicationInsert
**	Desc: Inserts CriteriaIndication Based on Id field 
**	Auth: ccarroll
**	Date: 12/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/22/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	CriteriaIndication
	(
		CriteriaID,
		IndicationID,
		LastModified,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CriteriaID,
		@IndicationID,
		@LastModified,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CriteriaIndicationID = SCOPE_IDENTITY()

EXEC CriteriaIndicationSelect @CriteriaIndicationID

GO

GRANT EXEC ON CriteriaIndicationInsert TO PUBLIC
GO
