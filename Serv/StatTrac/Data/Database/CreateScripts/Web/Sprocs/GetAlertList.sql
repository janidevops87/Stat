IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetAlertList')
	BEGIN
		DROP  Procedure  GetAlertList
	END

GO

CREATE Procedure GetAlertList
	@alertTypeId INT = NULL,
	@sourceCodeName VARCHAR(10) = NULL

AS
/******************************************************************************
**		File: GetAlertList.sql
**		Name: GetAlertList
**		Desc: 
**
**		Called by:   CustomParamsAlertsControl
**              
**
**		Auth: Bret Knoll
**		Date: 06/10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    6/10/2008		Bret Knoll			Initial
**		07/07/2008	Bret Knoll			Add Params AlertTypeID and SourceCodeName
*******************************************************************************/

SELECT     AlertID, AlertGroupName
FROM         Alert
WHERE     
	(AlertTypeID = ISNULL(@alertTypeId, AlertTypeID)) 
AND 
	(AlertID IN (SELECT	AlertID
	             FROM   AlertSourceCode
	             JOIN	SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID
	             WHERE  (SourceCodeName = ISNULL(@sourceCodeName, SourceCodeName))))
ORDER BY AlertGroupName


GO


