/******************************************************************************
**		File: ReportDateType_Insert_LogEventDt.sql
**		Name: ReportDateType Insert LogEventDt
**		Desc: Creates a new ReportDateType record for Log Event D/T
**
**		Auth: Mike Berenson
**		Date: 05/12/2022
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      05/12/2022	Mike Berenson		initial
*******************************************************************************/

-- Insert ReportControl record
IF NOT EXISTS (SELECT 1 FROM ReportDateType WHERE ReportDateTypeName = 'LogEventDT')
BEGIN

	SET IDENTITY_INSERT ReportDateType ON;
	
	INSERT INTO [dbo].[ReportDateType] ([ReportDateTypeID], [ReportDateTypeName], [ReportDateTypeDisplayname])
    VALUES (11, 'LogEventDT', 'Log Event D/T');
	
	SET IDENTITY_INSERT ReportDateType OFF;

END
GO