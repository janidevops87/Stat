 /***************************************************************************************************
**	Name: DuplicateSearchRuleDefault
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/ 
IF ((SELECT COUNT(*) FROM DuplicateSearchRuleDefault) = 0)
BEGIN
	DECLARE @callTypeID INT

	SELECT @callTypeID = CallType.CallTypeID FROM CallType WHERE CallType.CallTypeName = 'Referral'

	select @callTypeID

	INSERT DuplicateSearchRuleDefault (DuplicateSearchRuleID, CallTypeID, NumberOfDaysToSearch, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DuplicateSearchRule.DuplicateSearchRuleId, 
		@callTypeID, 
		CASE 
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Last Name with Cardiac Death d/t' THEN  7
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Last Name without Cardiac Death d/t' THEN  180
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Medical Record Number' THEN  180
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'Identity Unknown by Referral Type' THEN  5
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Match ID, OPTN #, and Organ' THEN  2
		END,
		GETDATE(),
		45,
		1	
		FROM DuplicateSearchRule
		WHERE DuplicateSearchRule.DuplicateSearchRule <> 'By Match ID, OPTN #, and Organ'
		
	SELECT @callTypeID = CallType.CallTypeID FROM CallType WHERE CallType.CallTypeName = 'OASIS'

	select @callTypeID

	INSERT DuplicateSearchRuleDefault (DuplicateSearchRuleID, CallTypeID, NumberOfDaysToSearch, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DuplicateSearchRule.DuplicateSearchRuleId, 
		@callTypeID, 
		CASE 
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Last Name with Cardiac Death d/t' THEN  7
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Last Name without Cardiac Death d/t' THEN  180
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Medical Record Number' THEN  180
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'Identity Unknown by Referral Type' THEN  5
		WHEN DuplicateSearchRule.DuplicateSearchRule = 'By Match ID, OPTN #, and Organ' THEN  2
		END,
		GETDATE(),
		45,
		1	
		FROM DuplicateSearchRule
		WHERE DuplicateSearchRule.DuplicateSearchRule = 'By Match ID, OPTN #, and Organ'
		

		

END
