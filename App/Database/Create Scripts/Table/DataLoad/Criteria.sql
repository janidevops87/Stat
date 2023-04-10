  /***************************************************************************************************
**	Name: Criteria
**	Desc: 
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	12/17/2009	ccarroll		Initial Script Creation
**  Update new fields with old criteria weight data where appropriate
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM Criteria WHERE CriteriaMaleUpperWeightUnit is Not Null) < 1)
BEGIN
	UPDATE Criteria

		SET CriteriaMaleUpperWeight = CriteriaUpperWeight,
			CriteriaFemaleUpperWeight = CriteriaUpperWeight,
			CriteriaMaleLowerWeight = CriteriaLowerWeight,
			CriteriaFemaleLowerWeight = CriteriaLowerWeight
	WHERE CriteriaStatus = 0
END
 