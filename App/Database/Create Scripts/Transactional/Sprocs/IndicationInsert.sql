

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationInsert')
	BEGIN
		PRINT 'Dropping Procedure IndicationInsert'
		DROP Procedure IndicationInsert
	END
GO

PRINT 'Creating Procedure IndicationInsert'
GO
CREATE Procedure IndicationInsert
(
		@IndicationID int = null output,
		@IndicationName varchar(80) = null,
		@IndicationNote varchar(255) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@IndicationHighRisk smallint = null,
		@UpdatedFlag smallint = null,
		@IndicationResponseID int = null,
		@IndicationQuestionAssociatedID int = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: IndicationInsert.sql
**	Name: IndicationInsert
**	Desc: Inserts Indication Based on Id field 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Indication
	(
		IndicationName,
		IndicationNote,
		Verified,
		Inactive,
		LastModified,
		IndicationHighRisk,
		UpdatedFlag,
		IndicationResponseID,
		IndicationQuestionAssociatedID,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@IndicationName,
		@IndicationNote,
		@Verified,
		@Inactive,
		@LastModified,
		@IndicationHighRisk,
		@UpdatedFlag,
		@IndicationResponseID,
		@IndicationQuestionAssociatedID,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @IndicationID = SCOPE_IDENTITY()

EXEC IndicationSelect @IndicationID

GO

GRANT EXEC ON IndicationInsert TO PUBLIC
GO
