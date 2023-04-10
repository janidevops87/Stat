  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'IndicationSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure IndicationSelectDataSet'
		DROP Procedure IndicationSelectDataSet
	END
GO

PRINT 'Creating Procedure IndicationSelectDataSet'
GO

CREATE PROCEDURE dbo.IndicationSelectDataSet
(
	@IndicationID int = null,
	@ChildQuestionID int = null
)
AS
/***************************************************************************************************
**	Name: QuestionSelectDataSet
**	Desc: Select Data for Question
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/20/2009	ccarroll		Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
***************************************************************************************************/
	EXEC dbo.IndicationSelect --@IndicationID 
	EXEC dbo.IndicationResponseSelect --@IndicationID
	EXEC dbo.AssociatedCriteriaGroupsSelect @IndicationID;
	EXEC dbo.IndicationQuestionAssociatedSelect null, null, @ChildQuestionID;
	
GO

GRANT EXEC ON IndicationSelectDataSet TO PUBLIC
GO  