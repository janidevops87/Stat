

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationQuestionAssociatedUpdate')
	BEGIN
		PRINT 'Dropping Procedure IndicationQuestionAssociatedUpdate'
		DROP Procedure IndicationQuestionAssociatedUpdate
	END
GO

PRINT 'Creating Procedure IndicationQuestionAssociatedUpdate'
GO
CREATE Procedure IndicationQuestionAssociatedUpdate
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
**	File: IndicationQuestionAssociatedUpdate.sql
**	Name: IndicationQuestionAssociatedUpdate
**	Desc: Updates IndicationQuestionAssociated Based on Id field 
**	Auth: ccarroll
**	Date: 12/03/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	12/03/2009		ccarroll		Initial Sproc Creation
**	07/12/2010		ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.IndicationQuestionAssociated 	
SET 
		QuestionID = @QuestionID,
		ChildQuestionID = @ChildQuestionID,
		DisplayOrder = @DisplayOrder,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	IndicationQuestionAssociatedID = @IndicationQuestionAssociatedID 				

GO

GRANT EXEC ON IndicationQuestionAssociatedUpdate TO PUBLIC
GO
