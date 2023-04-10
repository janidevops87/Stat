IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportAlertGroupDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportAlertGroupDropDown';
		DROP Procedure sps_ReportAlertGroupDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportAlertGroupDropDown';
GO


CREATE Procedure [dbo].[sps_ReportAlertGroupDropDown]
	@AlertTypeId INT = NULL,
	@SourceCodeName NVARCHAR(10) = NULL

AS
 /******************************************************************************
**	File: sps_ReportAlertGroupDropDown.sql
**	Name: sps_ReportAlertGroupDropDown
**	Desc: Populates dropdown for report alert groups dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/01/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/01/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT    
	AlertID as [value], 
	AlertGroupName as [label]
FROM         Alert
WHERE     
	( @AlertTypeId IS NULL OR AlertTypeID = @AlertTypeId) 
AND 
	(AlertID IN (SELECT	AlertID
	             FROM   AlertSourceCode
	             JOIN	SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID
	             WHERE  (SourceCodeName = ISNULL(@SourceCodeName, SourceCodeName))))
ORDER BY AlertGroupName
GO


GRANT EXEC ON sps_ReportAlertGroupDropDown TO PUBLIC;
GO


