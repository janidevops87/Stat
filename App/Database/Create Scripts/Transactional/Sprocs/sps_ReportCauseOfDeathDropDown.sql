

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportCauseOfDeathDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportCauseOfDeathDropDown';
		DROP Procedure sps_ReportCauseOfDeathDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportCauseOfDeathDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportCauseOfDeathDropDown]
	
 AS 
 /******************************************************************************
**	File: sps_ReportCauseOfDeathDropDown.sql
**	Name: sps_ReportCauseOfDeathDropDown
**	Desc: Populates dropdown for report cause of death dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/24/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/24/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT 
	CauseOfDeathID as [value],
	CauseOfDeathName as [label]

FROM 
	CauseofDeath
WHERE
	Inactive = 0

GO

GRANT EXEC ON sps_ReportCauseOfDeathDropDown TO PUBLIC;
GO
