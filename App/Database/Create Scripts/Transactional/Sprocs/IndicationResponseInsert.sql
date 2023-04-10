

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationResponseInsert')
	BEGIN
		PRINT 'Dropping Procedure IndicationResponseInsert'
		DROP Procedure IndicationResponseInsert
	END
GO

PRINT 'Creating Procedure IndicationResponseInsert'
GO
CREATE Procedure IndicationResponseInsert
(
		@IndicationResponseID int = null output,
		@IndicationResponseName nvarchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: IndicationResponseInsert.sql
**	Name: IndicationResponseInsert
**	Desc: Inserts IndicationResponse Based on Id field 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	IndicationResponse
	(
		IndicationResponseName,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@IndicationResponseName,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @IndicationResponseID = SCOPE_IDENTITY()

EXEC IndicationResponseSelect @IndicationResponseID

GO

GRANT EXEC ON IndicationResponseInsert TO PUBLIC
GO
