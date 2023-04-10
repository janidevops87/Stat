IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationQuestionAssociatedSelect')
	BEGIN
		PRINT 'Dropping Procedure IndicationQuestionAssociatedSelect'
		DROP Procedure IndicationQuestionAssociatedSelect
	END
GO

PRINT 'Creating Procedure IndicationQuestionAssociatedSelect'
GO
CREATE Procedure IndicationQuestionAssociatedSelect
(
		@IndicationQuestionAssociatedID int = null output,
		@QuestionID int = null,
		@ChildQuestionID int = null					
)
AS
/******************************************************************************
**	File: IndicationQuestionAssociatedSelect.sql
**	Name: IndicationQuestionAssociatedSelect
**	Desc: Selects multiple rows of IndicationQuestionAssociated Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/03/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/03/2009		ccarroll				Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		IF @IndicationQuestionAssociatedID =0
		BEGIN
			/* Display All  */
			SET @IndicationQuestionAssociatedID =null
		END
		IF @QuestionID =0
		BEGIN
			/* Display All  */
			SET @QuestionID =null
		END

	SELECT
		IndicationQuestionAssociated.IndicationQuestionAssociatedID,
		IndicationQuestionAssociated.QuestionID,
		Question.Question AS Question,
		IndicationQuestionAssociated.ChildQuestionID,
		ChildQuestion.Question AS ChildQuestion,
		IndicationQuestionAssociated.DisplayOrder,
		IndicationQuestionAssociated.LastModified,
		IndicationQuestionAssociated.LastStatEmployeeID,
		IndicationQuestionAssociated.AuditLogTypeID,
		(select QuestionIfYes from QuestionIfYes where QuestionIfYesID = (select Question.QuestionIfYesID from Question where Question.QuestionID = ChildQuestionID)) as QuestionIfYes
		
	FROM 
		dbo.IndicationQuestionAssociated 
	JOIN
		Question ON Question.QuestionID = IndicationQuestionAssociated.QuestionID
	JOIN
		Question AS ChildQuestion ON ChildQuestion.QuestionID = IndicationQuestionAssociated.ChildQuestionID
	WHERE 
		IndicationQuestionAssociated.IndicationQuestionAssociatedID = ISNULL(@IndicationQuestionAssociatedID, IndicationQuestionAssociated.IndicationQuestionAssociatedID)
	AND
		IndicationQuestionAssociated.QuestionID = ISNULL(@QuestionID, IndicationQuestionAssociated.QuestionID)
	AND
		IndicationQuestionAssociated.ChildQuestionID = ISNULL(@ChildQuestionID, IndicationQuestionAssociated.ChildQuestionID)				
	ORDER BY 1
GO

GRANT EXEC ON IndicationQuestionAssociatedSelect TO PUBLIC
GO
