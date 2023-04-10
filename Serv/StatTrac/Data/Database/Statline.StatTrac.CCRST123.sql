PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:12/23/2010 2:33:11 PM-- -- --  
-- C:/Projects/Statline/StatTrac/Development/Main/Database/Create Scripts/Transactional/Sprocs/sps_CallStaffStats.sql
-- C:/Projects/Statline/StatTrac/Development/Main/Database/Create Scripts/Transactional/Sprocs/InsertTrackingNumber.sql
-- C:/Projects/Statline/StatTrac/Development/Main/Database/Create Scripts/Transactional/Sprocs/GetPoints.sql

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallStaffStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallStaffStats]
GO


CREATE PROCEDURE sps_CallStaffStats

     @pvStartDate         datetime     = null,  
     @pvEndDate           datetime     = null,
     @pvUserOrgID	  int	       = null	 
AS
     DECLARE
     @vTZ     varchar(2),
     @TZ      int               
     


     SELECT @vTZ = OrganizationTimeZone FROM Organization WHERE OrganizationID = 194

     EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

     SELECT    CallTypeName, 
               PersonFirst + ' ' + PersonLast, 
               Count(CallID), 
               IsNULL(Avg(CallSeconds), 0),
               IsNULL(Max(CallSeconds), 0),
               IsNULL(Sum(CallSeconds), 0)
     FROM      Call 
     JOIN      CallType on Call.CallTypeID = CallType.CallTypeID 
     JOIN      StatEmployee on Call.StatEmployeeID = StatEmployee.StatEmployeeID 
     JOIN      Person ON Person.PersonID = StatEmployee.PersonID 
     WHERE     DATEADD(hour, @TZ, CallDateTime) Between @pvStartDate AND @pvEndDate 

     GROUP BY CallTypeName, PersonFirst + ' ' + PersonLast 
     ORDER By CallTypeName, PersonFirst + ' ' + PersonLast 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



 GO 

--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure InsertTrackingNumber'
		DROP  Procedure  InsertTrackingNumber
	END

GO

PRINT 'Creating Procedure InsertTrackingNumber'
GO
/******************************************************************************
**	File: InsertTrackingNumber.sql
**	Name: InsertTrackingNumber
**	Desc: Inserts a tracking number into the qa system, along with the tracking type and some other data
**	Auth: jim hawkins
**	Date: 2009
**	Called By: When user adds a qa tracking number to a form or error
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*** 9/10            jth                     added parm and code to use various tracking types other than StatTrac
*******************************************************************************/
CREATE PROCEDURE InsertTrackingNumber
@QAOrgID int,
@QATrackingNumber varchar(20),
@EmpID int,
@SourceCode varchar(20),
@RefDateTime datetime,
@RefTypeID int,
@FromQAForm int,
@QAFormID int,
@returnVal int OUTPUT

AS



BEGIN
--Insert the values
DECLARE @trackinTypeID int

if @FromQAForm = 1
Begin
	select @trackinTypeID=QATrackingTypeID FROM QAMonitoringForm where qamonitoringformid = @QAFormID 
End
Else
Begin
	set @trackinTypeID=@QAFormID
end
INSERT INTO QATracking VALUES 
(@QAOrgID, 
@trackinTypeID, 
@QATrackingNumber,
null,
@SourceCode,
@RefDateTime,
@RefTypeID,
1,
getdate(),
@EmpID,
1)



--Select the column to send back


SELECT @returnVal = MAX(QATrackingID) FROM QATracking



--Return Value


RETURN @returnVal


END

GO



 GO 

--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPoints')
	BEGIN
		PRINT 'Dropping Procedure GetPoints'
		DROP  Procedure  GetPoints
	END

GO

PRINT 'Creating Procedure GetPoints'
GO

CREATE PROCEDURE GetPoints
	@QAMonitoringFormID int,
	@QATrackingFormID int,
	@returnVal dec(5,3) OUTPUT

/******************************************************************************
**		File: GetPoints.sql
**		Name: GetPoints
**		Desc:  Need to get points for an error
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**	   04/2010		bret			updating to include in release
**		
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED



BEGIN
--Insert the values

CREATE TABLE #Points
     (
     [PointsNo][int]NULL,
     [AutoZero][int]NULL, 
     [Earned][int]NULL,
     [Available][int]NULL,
     [Tot][int]NULL
     )

     INSERT #Points
     (PointsNo,AutoZero,Earned, Available, Tot)
        
SELECT     
QAErrorLog.QAErrorLogPointsNo,
QAErrorTypeAutomaticZeroScore,
(CASE QAErrorLog.QAErrorLogPointsYes WHEN 1 THEN QAErrorType.QAErrorTypeAssignedPoints ELSE 0 END),
(CASE QAErrorLog.QAErrorLogPointsNA WHEN 1 THEN 
Case  when QAErrorType.QAErrorTypeAssignedPoints > 0 then -QAErrorType.QAErrorTypeAssignedPoints end ELSE 0 END) , 
(Case  when QAErrorType.QAErrorTypeAssignedPoints > 0 then QAErrorTypeAssignedPoints end)
FROM         QAErrorLog INNER JOIN
                      QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID INNER JOIN
                      QAErrorType ON QAMonitoringFormTemplate.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID INNER JOIN
                      QATrackingForm ON QATrackingFormErrors.QATrackingFormID = QATrackingForm.QATrackingFormID
WHERE     (QAMonitoringFormTemplate.QAMonitoringFormID = @QAMonitoringFormID) AND (QATrackingFormErrors.QATrackingFormID = @QATrackingFormID)

--Select the column to send back
Begin
	set @returnVal = 0
end
begin
if (select count(*)  from #Points where pointsno =1 and autozero = 1) = 0
	BEGIN 
		if (select (CAST(sum(available) AS DECIMAL(5,1))+ CAST(sum(tot) AS DECIMAL(5,1))) from #Points) > 0
		Begin
			if (select CAST(sum(earned) AS DECIMAL(5,1)) from #Points)  > 0
			Begin
				select @returnVal = CAST(sum(earned) AS DECIMAL(5,1)) / (CAST(sum(available) AS DECIMAL(5,1))+ CAST(sum(tot) AS DECIMAL(5,1)) )   from #Points
			end
		End
	END
end
DROP TABLE #Points

--Return Value


RETURN @returnVal


END

GO


 GO 

