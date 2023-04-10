--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPendingReview')
	BEGIN
		PRINT 'Dropping Procedure GetPendingReview'
		DROP  Procedure  GetPendingReview
	END

GO

PRINT 'Creating Procedure GetPendingReview'
GO

CREATE PROCEDURE GetPendingReview
@QATrackingID int = NULL,
@QATrackingFormID int = NULL,
@OrganizationID int = NULL,
@returnVal dec(5,2) OUTPUT
AS
/******************************************************************************
**		File: GetPendingReview.sql
**		Name: GetPendingReview
**		Desc: Returns whether a error and tracking number is in pending review or not
**
** 
**		
**
**		Auth: jth
**		Date: 03/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3.10	    jth					initial
**	   04/2010		bret			updating to include in release
**      05/10       jth                 sproc needed qatrackingformid
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  @returnVal = COUNT(*)    
 From QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID
                      LEFT OUTER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID

WHERE 
		QAErrorLog.QATrackingID = IsNull(@QATrackingID, QAErrorLog.QATrackingID) AND
		QAErrorLog.QAErrorStatusID = 1 and
		isNull(QATrackingFormID,0) = ISNULL( @QATrackingFormID,IsNull(QATrackingFormID,0)) and
		QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)



GO
 