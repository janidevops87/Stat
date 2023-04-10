

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationQuestionAssociatedInsert')
	BEGIN
		PRINT 'Dropping Procedure IndicationQuestionAssociatedInsert'
		DROP Procedure IndicationQuestionAssociatedInsert
	END
GO

PRINT 'Creating Procedure IndicationQuestionAssociatedInsert'
GO
CREATE Procedure IndicationQuestionAssociatedInsert
(
		@IndicationQuestionAssociatedID int = null output,
		@QuestionID int = null,
		@Question varchar(500) = null,
		@ChildQuestionID int = null,
		@ChildQuestion varchar(500) = null,
		@DisplayOrder int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: IndicationQuestionAssociatedInsert.sql
**	Name: IndicationQuestionAssociatedInsert
**	Desc: Inserts IndicationQuestionAssociated Based on Id field 
**	Auth: ccarroll
**	Date: 12/03/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/03/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	IndicationQuestionAssociated
	(
		QuestionID,
		ChildQuestionID,
		DisplayOrder,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@QuestionID,
		@ChildQuestionID,
		@DisplayOrder,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @IndicationQuestionAssociatedID = SCOPE_IDENTITY()

EXEC IndicationQuestionAssociatedSelect @IndicationQuestionAssociatedID

GO

GRANT EXEC ON IndicationQuestionAssociatedInsert TO PUBLIC
GO
