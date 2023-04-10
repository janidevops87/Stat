IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReportGroupSourceCodeLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReportGroupSourceCodeLookup'
		DROP  Procedure  sps_rpt_ReportGroupSourceCodeLookup
	END

GO

PRINT 'Creating Procedure sps_rpt_ReportGroupSourceCodeLookup'
GO
CREATE Procedure sps_rpt_ReportGroupSourceCodeLookup
@ReportGroupID int = Null
AS

/******************************************************************************
**		File: sps_rpt_ReportGroupSourceCodeLookup.sql
**		Name: sps_rpt_ReportGroupSourceCodeLookup
**		Desc: This sproc is used to lookup SourceCodeName's which apply   
**			  to a given users ReportGroupID
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**		Auth: ccarroll
**		Date: 01/30/2008	
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      01/30/2008		ccarroll				initial release
*******************************************************************************/
	SELECT		Null AS 'SourceCodeName'

UNION 

	SELECT		SourceCodeName 

	FROM		SourceCode

	WHERE		SourceCodeID IN (SELECT * FROM dbo.fn_SourceCodeList(@ReportGroupID, Null))

	GROUP BY	SourceCodeName
	ORDER BY	SourceCodeName


GO
