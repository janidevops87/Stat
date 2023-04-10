/***************************************************************************************************
**	Name: WebReportGroupSourceCode
**	Desc: Add Initial Data and cleanup existing data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
***************************************************************************************************/ 
PRINT 'REMOVE WebReportGroupSourceCode if WebReportGroupID does not exist'
	DELETE WebReportGroupSourceCode 
	WHERE WebReportGroupID not in (select WebReportGroupID from WebReportGroup)
	
PRINT 'REMOVE WebReportGroupSourceCode IF SourceCodeID'	
	DELETE WebReportGroupSourceCode 
	WHERE SourceCodeID not in (select SourceCodeID from SourceCode)

	