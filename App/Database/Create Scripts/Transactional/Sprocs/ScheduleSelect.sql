IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ScheduleSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleSelect'
		DROP Procedure ScheduleSelect
	END
GO

PRINT 'Creating Procedure ScheduleSelect'
GO

CREATE PROCEDURE dbo.ScheduleSelect
(
	@TimeZoneDif INT,
	@ScheduleGroupID INT,
	@FromDate DATETIME,  
	@ToDate DATETIME
)
AS
/******************************************************************************
**	File: ScheduleSelect.sql
**	Name: ScheduleSelect
**	Desc: Select Data from Schedule
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
set @TimeZoneDif = 0

SELECT 
	ScheduleItem.ScheduleItemID, 
	ScheduleItem.ScheduleGroupID, 
	ScheduleItem.ScheduleItemName, 
	CONVERT(CHAR, DATEADD(hh, @TimeZoneDif, ScheduleItemStartDate + ' ' + ScheduleItemStartTime), 101) AS 'ScheduleItemStartDate', 
	CONVERT(CHAR(5), DATEADD(hh, @TimeZoneDif, ScheduleItemStartDate + ' ' + ScheduleItemStartTime) , 108) AS 'StartTime', 
	DATEADD(hh,0, ScheduleItemStartDate + ' ' + ScheduleItemStartTime) AS ScheduleStartDateTime, 
	CONVERT(CHAR, DATEADD(hh, @TimeZoneDif, ScheduleItemEndDate + ' ' + ScheduleItemEndTime), 101) AS 'ScheduleItemEndDate',
	CONVERT(CHAR(5), DATEADD(hh, @TimeZoneDif, ScheduleItemEndDate + ' ' + ScheduleItemEndTime), 108) AS'EndTime', 
	DATEADD(hh, @TimeZoneDif, ScheduleItemEndDate + ' ' + ScheduleItemEndTime ) AS ScheduleEndDateTime,
	person1.PersonID AS Person1,
	person2.PersonID AS Person2,
	person3.PersonID AS Person3,
	person4.PersonID AS Person4,
	person5.PersonID AS Person5,
	person6.PersonID AS Person6,
	person7.PersonID AS Person7,
	person8.PersonID AS Person8,
	person9.PersonID AS Person9,
	person10.PersonID AS Person10,
	person11.PersonID AS Person11,
	person12.PersonID AS Person12,
	person13.PersonID AS Person13,
	person14.PersonID AS Person14,
	person15.PersonID AS Person15,
	person16.PersonID AS Person16,
	person17.PersonID AS Person17,
	person18.PersonID AS Person18

	FROM 
			ScheduleItem 
	LEFT JOIN ScheduleItemPerson person1 ON ScheduleItem.ScheduleItemID = person1.ScheduleItemID AND person1.Priority = 1
	LEFT JOIN ScheduleItemPerson person2 ON ScheduleItem.ScheduleItemID = person2.ScheduleItemID AND person2.Priority = 2
	LEFT JOIN ScheduleItemPerson person3 ON ScheduleItem.ScheduleItemID = person3.ScheduleItemID AND person3.Priority = 3
	LEFT JOIN ScheduleItemPerson person4 ON ScheduleItem.ScheduleItemID = person4.ScheduleItemID AND person4.Priority = 4
	LEFT JOIN ScheduleItemPerson person5 ON ScheduleItem.ScheduleItemID = person5.ScheduleItemID AND person5.Priority = 5
	LEFT JOIN ScheduleItemPerson person6 ON ScheduleItem.ScheduleItemID = person6.ScheduleItemID AND person6.Priority = 6
	LEFT JOIN ScheduleItemPerson person7 ON ScheduleItem.ScheduleItemID = person7.ScheduleItemID AND person7.Priority = 7
	LEFT JOIN ScheduleItemPerson person8 ON ScheduleItem.ScheduleItemID = person8.ScheduleItemID AND person8.Priority = 8
	LEFT JOIN ScheduleItemPerson person9 ON ScheduleItem.ScheduleItemID = person9.ScheduleItemID AND person9.Priority = 9
	LEFT JOIN ScheduleItemPerson person10 ON ScheduleItem.ScheduleItemID = person10.ScheduleItemID AND person10.Priority = 10
	LEFT JOIN ScheduleItemPerson person11 ON ScheduleItem.ScheduleItemID = person11.ScheduleItemID AND person11.Priority = 11
	LEFT JOIN ScheduleItemPerson person12 ON ScheduleItem.ScheduleItemID = person12.ScheduleItemID AND person12.Priority = 12	
	LEFT JOIN ScheduleItemPerson person13 ON ScheduleItem.ScheduleItemID = person13.ScheduleItemID AND person13.Priority = 13
	LEFT JOIN ScheduleItemPerson person14 ON ScheduleItem.ScheduleItemID = person14.ScheduleItemID AND person14.Priority = 14
	LEFT JOIN ScheduleItemPerson person15 ON ScheduleItem.ScheduleItemID = person15.ScheduleItemID AND person15.Priority = 15
	LEFT JOIN ScheduleItemPerson person16 ON ScheduleItem.ScheduleItemID = person16.ScheduleItemID AND person16.Priority = 16
	LEFT JOIN ScheduleItemPerson person17 ON ScheduleItem.ScheduleItemID = person17.ScheduleItemID AND person17.Priority = 17
	LEFT JOIN ScheduleItemPerson person18 ON ScheduleItem.ScheduleItemID = person18.ScheduleItemID AND person18.Priority = 18
	
	WHERE ScheduleGroupID = @ScheduleGroupID 
		AND ((ScheduleItemStartDate BETWEEN @FromDate AND @ToDate) 
		OR (ScheduleItemEndDate BETWEEN @FromDate AND @ToDate))
	ORDER BY ScheduleStartDateTime  
