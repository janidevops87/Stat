 
 /******************************************************************************
**		File: FSBCaseStatus
**		Name: FSBCaseStatus
**		Desc: Load data to table FSBCaseStatus
**		Auth: Bret Knoll
**		Date: 07/15/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		07/15/2011	Bret Knoll			Initial data load
*******************************************************************************/
PRINT 'Clean up FSBCaseStatus'

-- remove records not in Call 
DELETE 
FROM FSBCaseStatus 
WHERE CallId NOT IN (SELECT CallId FROM Call)
