IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportStateDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportStateDropDown';
		DROP Procedure sps_ReportStateDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportStateDropDown';
GO


CREATE PROCEDURE sps_ReportStateDropDown

AS

 /******************************************************************************
**	File: sps_ReportStateDropDown.sql
**	Name: sps_ReportStateDropDown
**	Desc: Populates dropdown for state dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 01/18/2021
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	01/18/2021		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT 
	StateID as [value], 
	StateName as [label] 
FROM State 
ORDER BY StateName ASC


GO

GRANT EXEC ON sps_ReportStateDropDown TO PUBLIC;
GO

