 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ScheduleLogSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleLogSelect'
		DROP Procedure ScheduleLogSelect
	END
GO

PRINT 'Creating Procedure ScheduleLogSelect'
GO

CREATE PROCEDURE dbo.ScheduleLogSelect
(
	@TimeZoneDif INT,
	@ScheduleGroupID INT,
	@FromDate DATETIME,  
	@ToDate DATETIME
)
AS
/******************************************************************************
**	File: ScheduleLogSelect.sql
**	Name: ScheduleLogSelect
**	Desc: Select Data from ScheduleLog
**	Auth: Bret Knoll
**	Date: 05/11/2011
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	05/11/2011  Bret Knoll		Initial Sproc Creation
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT 
	ScheduleLogID, 
	Person.PersonID, 
	DATEADD(hh, @TimeZoneDif, ScheduleLogDateTime) ScheduleLogDateTime, 
	COALESCE(PersonFirst, '') + ' ' + COALESCE(PersonLast, '') PersonName, 
	ScheduleLogType, 
	ScheduleLogShift, 
	ScheduleLogChange 
FROM 
	ScheduleLog 
LEFT JOIN 
	Person ON Person.PersonID = ScheduleLog.PersonID 
WHERE 
	ScheduleGroupID = @ScheduleGroupID 
AND 
	ScheduleLogDateTime BETWEEN @FromDate AND  @ToDate 
ORDER BY 
	ScheduleLogDateTime DESC
