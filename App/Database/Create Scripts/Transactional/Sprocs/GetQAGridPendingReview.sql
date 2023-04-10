 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridPendingReview]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridPendingReview]
	PRINT 'Dropping Procedure: GetQAGridPendingReview'
END
	PRINT 'Creating Procedure: GetQAGridPendingReview'
GO

CREATE PROCEDURE [dbo].[GetQAGridPendingReview]
(
	--@QATrackingID int = NULL,
	@OrganizationID int = NULL,
	@Personids	VarChar(8000) = NULL,
	@startDateTime datetime = null,
	@endDateTime datetime = null
)
/******************************************************************************
**		File: GetQAGridPendingReview.sql
**		Name: GetQAGridPendingReview
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
**      02/09       jth         don't need trackingid
**      03/09       jth         sql returning wrong fields
**      04/09       jth         add join to form template to get formid
**      04/09       jth         reworked because of new tables
**		09/18/2009	ccarroll	changed EventDate and StatEmployeeName for ErrorTypes
**      02/2010     jth         added if person is null, so that pending forms won't show if not completed with an employee
**	    04/2010		bret		updating to include in release
**      04/2010     jth         implemented Steve's speed changes
**      09/2011     jth			use only error types and forms that require review and added sorting by date
**     110/2011     jth			added personids and date parms
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT DISTINCT 
       QATracking.QATrackingID, 
       QATracking.QATrackingNumber, 
       QATracking.QATrackingReferralDateTime, 
       QATrackingForm.QATrackingFormID, 
       QAMFT.QAMonitoringFormID as QAMonitoringFormID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAE1.QAErrorLocationDescription
            ELSE NULL 
       END AS LocationDesc,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAE1.QAErrorLocationID
            ELSE NULL 
       END AS LocationID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN 'Error Type' 
            ELSE 'QM Form'
       END AS 'TrackingType',
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAErrorlog.qaerrorlogid
            ELSE NULL 
       END AS qaerrorlogid,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAET1.qaerrortypedescription
            ELSE NULL 
       END AS QAErrorTypeDescription,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAEPS.qaprocessstepdescription
            ELSE NULL 
       END AS QAProcessStepDescription,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAELHI.QAErrorLogHowIdentifiedDescription
            ELSE NULL 
       END AS QAErrorLogHowIdentifiedDescription,
       Person.PersonID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN
                  CONVERT(CHAR(10),QAErrorLog.LastModified,101) + ' ' +
                  CONVERT(CHAR(5),QAErrorLog.LastModified,108)
            ELSE
                  CONVERT(CHAR(10),QATrackingForm.QATrackingEventDateTime,101) + ' ' +
                  CONVERT(CHAR(5),QATrackingForm.QATrackingEventDateTime,108)
       END AS QATrackingEventDateTimeString,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            then ISNULL(P1.PersonFirst, '') + ' ' + ISNULL(P1.PersonLast, '')
            else ISNULL(P2.PersonFirst, '') + ' ' + ISNULL(P2.PersonLast, '')
       end as Employee,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
                  THEN ISNULL(SE.StatEmployeeFirstName, '') + ' ' + ISNULL(SE.StatEmployeeLastName, '') 
            ELSE ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
       END AS StatEmployeeName,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN QAErrorLog.LastModified
            ELSE QATrackingEventDateTime 
       END AS QATrackingEventDateTime,       
       QAErrorLogPersonID,
       QATT.QATrackingTypeDescription as 'TrackingDesc'
FROM   QATracking INNER JOIN QAErrorLog ON (QATracking.QATrackingID = QAErrorLog.QATrackingID) 
                  INNER JOIN Person ON (Person.PersonID = QAErrorLog.StatEmployeeID)
                  LEFT OUTER JOIN QATrackingFormErrors ON (QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID)
                  LEFT OUTER JOIN QAMonitoringFormTemplate QAMFT ON (QAErrorLog.QAMonitoringFormTemplateID = QAMFT.QAMonitoringFormTemplateID)
                  LEFT OUTER JOIN QAErrorLocation QAE1 ON (QAErrorLog.QAErrorLocationID = QAE1.QAErrorLocationID )  
                  LEFT OUTER JOIN QAErrorType QAET1 ON (qaerrorlog.qaerrortypeid  = QAET1.qaerrortypeid )
                  LEFT OUTER JOIN QATrackingForm ON (QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID )
                  LEFT OUTER JOIN QAProcessStep QAEPS ON (qaerrorlog.qaprocessstepid = QAEPS.qaprocessstepid)
                  LEFT OUTER JOIN QAErrorLogHowIdentified QAELHI ON (QAErrorLog.QAErrorLogHowIdentifiedid = QAELHI.QAErrorLogHowIdentifiedid)
                  LEFT OUTER JOIN Person P1 ON (QAErrorLog.QAErrorLogPersonID = P1.personid)
                  LEFT OUTER JOIN Person P2 ON (QATrackingForm.personid = P2.personid)
                  INNER JOIN StatEmployee SE ON (QAErrorLog.LastStatEmployeeID = SE.StatEmployeeID) 
                  LEFT OUTER JOIN QATrackingType QATT ON (QATracking.QATrackingTypeID = QATT.QATrackingTypeID)
				  Left outer join QAMonitoringForm on (QAMonitoringForm.QAMonitoringFormID = QAMFT.QAMonitoringFormID)
      WHERE QAErrorLog.QAErrorStatusID = 1 and
            QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
            and QAErrorLog.qaerrorlogpersonid is not null
			and ((QAMonitoringForm.QAMonitoringFormRequireReview  = 1) or
            (QAErrorLog.QAMonitoringFormTemplateID IS Null and QAET1.QAErrorRequireReview = 1 and QAET1.QAErrorTypeActive = 1))
			AND PATINDEX('%' + CAST(CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN SE.PersonID ELSE Person.PersonID END AS VarChar)+ '%', 
			IsNull(@Personids, CAST(CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN SE.PersonID  ELSE Person.PersonID END AS VarChar))) > 0
			And 
			CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN QAErrorLog.LastModified
            ELSE QATrackingEventDateTime end
			BETWEEN ISNULL(@startDateTime, '01/01/1901') AND ISNULL(@endDateTime, '12/31/2100')
	Order by QATrackingEventDateTime

	RETURN @@Error
GO


