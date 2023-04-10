

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportSourceCodeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportSourceCodeDropDown';
		DROP Procedure sps_ReportSourceCodeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportSourceCodeDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportSourceCodeDropDown]
	@WebReportGroupId int = null,
	@SourceCodeTypeId int = null
 AS 
 /******************************************************************************
**	File: sps_ReportSourceCodeDropDown.sql
**	Name: sps_ReportSourceCodeDropDown
**	Desc: Populates dropdown for report source code dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/15/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/15/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

if (@WebReportGroupID = 0 ) SET @WebReportGroupID = NULL ;

SELECT DISTINCT 
	SC.SourceCodeName as [value],
	SC.SourceCodeName as [label]
FROM 
	WebReportGroupSourceCode WRGSC
JOIN
	SourceCode SC ON SC.SourceCodeID = WRGSC.SourceCodeID
WHERE 
	WRGSC.WebReportGroupID = ISNULL(@WebReportGroupID, WRGSC.WebReportGroupID)
AND
	SC.SourceCodeType = ISNULL(@SourceCodeTypeID, SC.SourceCodeType)	
ORDER BY 
	SourceCodeName ASC;

GO

GRANT EXEC ON sps_ReportSourceCodeDropDown TO PUBLIC;
GO
