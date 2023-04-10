IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ReportDateTimeConfiguration')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportDateTimeConfiguration'
		DROP  Procedure  sps_ReportDateTimeConfiguration
	END

GO

PRINT 'Creating Procedure sps_ReportDateTimeConfiguration'
GO
CREATE Procedure sps_ReportDateTimeConfiguration
	@reportID INT,
	@startDateTime DATETIME = null OUTPUT,
	@endDateTime DATETIME = null OUTPUT,
	@dateTimeName	VARCHAR(50) = NULL OUTPUT,
	@archiveDateTime DATETIME = '1/1/1900' OUTPUT,
	@isDateOnly BIT = 0 OUTPUT
AS

/******************************************************************************
**		File: 
**		Name: sps_ReportDateTimeConfiguration
**		Desc: Returns the Start and End DateTime for a report
**		EXEC sps_ReportDateTimeConfiguration 195
**		EXEC sps_ReportDateTimeConfiguration 192
**		EXEC sps_ReportDateTimeConfiguration 193
**		EXEC sps_ReportDateTimeConfiguration 194
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 7/26/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/26/07	Bret Knoll			initial
**		09/25/08	Bret Knoll			Add archiveDateTime to Reporting site, allowing for 
**										params page to notify users what they are querying
*******************************************************************************/
DECLARE 
	@currentDateTime DATETIME

SELECT
	@currentDateTime  = GETDATE()

SELECT
	@startDateTime = 
	CASE
		WHEN 
			rdtc.ReportDateTimeID = 1 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/1/' + CONVERT(VARCHAR, DATEPART(YYYY, @currentDateTime)) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 2 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									DATEADD(D, -1, @currentDateTime)
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, DATEADD(D, -1, @currentDateTime))) +'/' + CONVERT(VARCHAR, DATEPART(YYYY, DATEADD(D, -1, @currentDateTime))) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 3 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, @currentDateTime)) +'/' + CONVERT(VARCHAR, DATEPART(YYYY,@currentDateTime)) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 4 
		THEN
			@currentDateTime
		ELSE
			@currentDateTime
	END ,
	@endDateTime = 
	CASE
		WHEN 
			rdtc.ReportDateTimeID = 1 
		THEN
			DATEADD
			(
				S, 
				-1, 
				DATEADD
				(	
					M, 
					1, 
					CONVERT(VARCHAR, DATEPART
									(
										M, 
										@currentDateTime
									)
							)  + '/1/' + CONVERT(VARCHAR, DATEPART(YYYY, @currentDateTime) )
				)
			)		
		WHEN 
			rdtc.ReportDateTimeID = 2 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									DATEADD(D, -1, @currentDateTime)
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, DATEADD(D, -1, @currentDateTime))) +'/' + CONVERT(VARCHAR, DATEPART(YYYY, DATEADD(D, -1, @currentDateTime))) + ' 23:59:59'
		WHEN 
			rdtc.ReportDateTimeID = 3 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, @currentDateTime)) +'/' + CONVERT(VARCHAR, DATEPART(YYYY,@currentDateTime)) + ' 23:59:59'

		WHEN 
			rdtc.ReportDateTimeID = 4 
		THEN
			@currentDateTime
		ELSE
			@currentDateTime
	END	
	, @dateTimeName = rdt.ReportDateTimeName
	, @archiveDateTime = 
	CASE
		WHEN rdtc.IsArchived = 1 THEN (SELECT MAX(TableDate) FROM ARCHIVESTATUS)
		ELSE '1/1/1900'
	END 
	, @isDateOnly = rdtc.IsDateOnly
FROM
	ReportDateTimeConfiguration rdtc
JOIN
	ReportDateTime rdt on rdt.ReportDateTimeID = rdtc.ReportDateTimeID
WHERE
	ReportID = @ReportID

SELECT
	@startDateTime StartDateTime
	, @endDateTime EndDateTime
	, @dateTimeName DateTimeName
	, @archiveDateTime ArchiveDateTime
	, @isDateOnly IsDateOnly

/*
	SELECT * FROM ReportDateTime
	SELECT * FROM ReportDateTimeConfiguration
*/
GO

GRANT EXEC ON sps_ReportDateTimeConfiguration TO PUBLIC

GO
