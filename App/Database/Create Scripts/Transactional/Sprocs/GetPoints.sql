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
