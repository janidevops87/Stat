

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportMonthDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportMonthDropDown';
		DROP Procedure sps_ReportMonthDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportMonthDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportMonthDropDown]
	
 AS 
 /******************************************************************************
**	File: sps_ReportMonthDropDown.sql
**	Name: sps_ReportMonthDropDown
**	Desc: Populates dropdown for report month dropdown in reporting.
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
DECLARE
@Month Table
(
	[value] int,
	[label] nvarchar(25)
)

INSERT INTO @Month VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December')

SELECT  *
FROM @Month
Order BY [value]

GO

GRANT EXEC ON sps_ReportMonthDropDown TO PUBLIC;
GO
