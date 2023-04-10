IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaConditionalROInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaConditionalROInsert';
		DROP Procedure CriteriaConditionalROInsert;
	END
GO

PRINT 'Creating Procedure CriteriaConditionalROInsert';
GO
CREATE Procedure CriteriaConditionalROInsert
(
	@CriteriaTemplateId INT  			
)
AS
/******************************************************************************
**	File: CriteriaConditionalROInsert.sql
**	Name: CriteriaConditionalROInsert
**	Desc: Insert Conditional RO records for Criteria  
**	Auth: Pam Scheicheost
**	Date: 11/22/2019
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/22/2019		Pam Scheichenost		Initial Sproc Creation 
*******************************************************************************/
DECLARE
@MaxSubCriteriaId INT;

SELECT @MaxSubCriteriaId =  MAX(subcriteriaid) 
FROM subcriteria;

INSERT ProcessorCriteria_ConditionalRO
(
	FSIndicationID, FSConditionID, FSAppropriateID, SubCriteriaID
)
SELECT 
	FSIndicationId,
	FSConditionId,
	FSAppropriateId,
	@MaxSubCriteriaId 
FROM CriteriaTemplate_ConditionalRO 
WHERE CriteriaTemplateID = @CriteriaTemplateId;

GO

GRANT EXEC ON CriteriaConditionalROInsert TO PUBLIC
GO
