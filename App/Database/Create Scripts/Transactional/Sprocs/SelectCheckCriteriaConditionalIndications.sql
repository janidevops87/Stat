

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectCheckCriteriaConditionalIndications')
	BEGIN
		PRINT 'Dropping Procedure SelectCheckCriteriaConditionalIndications';
		DROP Procedure SelectCheckCriteriaConditionalIndications;
	END
GO

PRINT 'Creating Procedure SelectCheckCriteriaConditionalIndications';
GO
CREATE Procedure SelectCheckCriteriaConditionalIndications
(
		@SubCriteriaID INT,
		@FSConditionID INT
)
AS
/******************************************************************************
**	File: SelectCheckCriteriaConditionalIndications.sql
**	Name: SelectCheckCriteriaConditionalIndications
**	Desc: Selects ConditionalID, AppropriateID, IndicationID, and IndicationName 
**	Auth: Mike Berenson
**	Date: 10/16/2019
**	Called By: SecondaryDisposition_bas.CheckCriteria_ConditionalIndications 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/16/2019		Mike Berenson		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 
		pccro.ProcessorCriteria_ConditionalROID, 
		pccro.FSAppropriateID, 
		fsi.FSIndicationID, 
		fsi.FSIndicationName 
	FROM 
		ProcessorCriteria_ConditionalRO pccro
			JOIN FSIndication fsi ON pccro.FSIndicationID = fsi.FSIndicationID
	WHERE 
		pccro.SubCriteriaID = @SubCriteriaID
	AND pccro.FSConditionID = @FSConditionID;

GO

GRANT EXEC ON SelectCheckCriteriaConditionalIndications TO PUBLIC;
GO
