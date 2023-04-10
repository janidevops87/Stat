IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_GetAlerts')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_GetAlerts'
		DROP  Procedure  sps_rpt_GetAlerts
	END

GO

PRINT 'Creating Procedure sps_rpt_GetAlerts'
GO
CREATE Procedure sps_rpt_GetAlerts
@SourceCodeName AS Varchar(10) = Null,
@AlertTypeID AS Int = Null,
@AlertID AS Int = Null

AS
/******************************************************************************
**		File: sps_rpt_GetAlerts.sql
**		Name: sps_rpt_GetAlerts
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll
**		Date: 01/30/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      01/30/2008		ccarroll				initial release
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
/* Clear if zero: Return all types */
If @AlertTypeID = 0
BEGIN
	SET @AlertTypeID = Null
END

/* Limit return to one row if No SourceCodeName */
If @SourceCodeName = Null
BEGIN
	SET ROWCOUNT 1
END




	SELECT 	
		IsNull(Alert.AlertTypeID, 0) AS 'AlertTypeID',
		CASE Alert.AlertTypeID
			WHEN 1 THEN 'Referrals'
			WHEN 2 THEN 'Messages'
			WHEN 4 THEN 'Import Offers'
		  END	AS 'AlertTypeName',
		SourceCode.SourceCodeName,
		Alert.AlertGroupName,
		Alert.AlertMessage1,
		Alert.AlertMessage2,
		Alert.AlertScheduleMessage
	FROM 	Alert
	JOIN 	AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN	SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID
	WHERE 	SourceCodeName = isNull(@SourceCodeName, SourceCodeName)
	AND		Alert.AlertID = IsNull(@AlertID, Alert.AlertID)
	AND		Alert.AlertTypeID = IsNull(@AlertTypeID, Alert.AlertTypeID) 
	ORDER BY AlertTypeID, AlertGroupName ASC


GO

