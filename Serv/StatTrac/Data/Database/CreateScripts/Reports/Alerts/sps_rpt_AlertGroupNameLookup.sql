IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AlertGroupNameLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AlertGroupNameLookup'
		DROP  Procedure  sps_rpt_AlertGroupNameLookup
	END

GO

PRINT 'Creating Procedure sps_rpt_AlertGroupNameLookup'
GO
CREATE Procedure sps_rpt_AlertGroupNameLookup
@ReportGroupID Int = Null

AS

/******************************************************************************
**		File: sps_rpt_AlertGroupNameLookup.sql
**		Name: sps_rpt_AlertGroupNameLookup
**		Desc: 
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
**		Date: 02/01/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     02/01/2008		ccarroll				initial release
*******************************************************************************/
	SELECT		Null AS 'AlertID', '' AS 'AlertGroupName'

UNION

	SELECT		Alert.AlertID, Alert.AlertGroupName 

	FROM 		Alert
	JOIN 		AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID

	WHERE		AlertSourceCode.SourceCodeID IN (SELECT * FROM dbo.fn_SourceCodeList(@ReportGroupID, Null))
	GROUP BY	Alert.AlertID, Alert.AlertGroupName
	ORDER BY	AlertGroupName


GO
