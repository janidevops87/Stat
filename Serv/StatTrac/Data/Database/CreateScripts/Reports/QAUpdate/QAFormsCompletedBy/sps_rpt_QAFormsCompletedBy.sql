IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAFormsCompletedBy')
      BEGIN
            PRINT 'Dropping Procedure sps_rpt_QAFormsCompletedBy'
            DROP  Procedure  sps_rpt_QAFormsCompletedBy
      END

GO

PRINT 'Creating Procedure sps_rpt_QAFormsCompletedBy'
GO

CREATE Procedure sps_rpt_QAFormsCompletedBy
      @TrackingNum                        varchar(20) = Null,
      @CompletedByID              int = Null,
      @CallStartDateTime                DateTime = Null,
      @CallEndDateTime            DateTime = Null,
      @ErrorStartDateTime               DateTime = Null,
      @ErrorEndDateTime             DateTime = Null,
      @TrackingTypeID				int = Null,      
      @ReportGroupID                      int = Null,
      @OrganizationID                     int = Null,
      @SourceCodeName                     varchar(10) = Null,
      
      @DisplayMT                          int = Null

AS
/******************************************************************************
**          File: sps_rpt_QAFormsCompletedBy.sql
**          Name: sps_rpt_QAFormsCompletedBy.sql
**          Desc: 
**
**              
**          Return values:
** 
**          Called by:   
**              
**          Parameters:
**          Input                                     Output
**     ----------                                     -----------
**          See above
**
**          Auth: jth
**          Date: 05/2009
*******************************************************************************
**          Change History
*******************************************************************************
**          Date:       Author:		Description:
**          --------    --------	-------------------------------------------
**      5/2009          jth         Initial release
**		09/18/2009		ccarroll	restored to original (production release)
**									modified to only return Form data.
**		10/03/2009		ccarroll	added date bypass for @TrackingNum
**      3/10			jth			added tracking type parm 
**      10/2011         jth			added filter to not return incomplete forms
**		04/13/2012		ccarroll	Added required fields for link to QAReview Report
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**		02/28/2013		jth			removed webreportgrouporg change above
**		09/09/2013		ccarroll	re-arranged table joins and where clause
**		01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   Null
	END


SELECT DISTINCT tf.QATrackingFormID,
				tf.QATrackingFormPoints,
				t.QATrackingNumber,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid) AS Employee,

				 el.StatEmployeeID,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid) AS CompletedBy,
				
				tf.PersonID,
                (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode,
                  case when   QATrackingNumber NOT LIKE '%[A-Z]%'  then
                  case when        LEN(QATrackingNumber) < 10 then
                          (SELECT     TOP 1 ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName)
                            FROM          ReferralType INNER JOIN
                                                   Referral ON ReferralType.ReferralTypeID = Referral.ReferralTypeID INNER JOIN
                                                   WebReportGroupOrg ON Referral.ReferralCallerOrganizationID = WebReportGroupOrg.OrganizationID RIGHT OUTER JOIN
                                                   MessageType INNER JOIN
                                                   Message ON MessageType.MessageTypeID = Message.MessageTypeID RIGHT OUTER JOIN
                                                   CallType INNER JOIN
                                                   Call INNER JOIN
                                                   SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID ON CallType.CallTypeID = Call.CallTypeID ON 
                                                   Message.CallID = Call.CallID ON Referral.CallID = Call.CallID
                            WHERE      call.callid  = ISNULL(@TrackingNum,QATrackingNumber)) end
                      else 'N/A' end AS CallTypeName,

					/* Added columns for URL query string */
					tt.QATrackingTypeDescription,
					ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
					mf.QAMonitoringFormID,
					mf.QAMonitoringFormName,
					CASE WHEN IsNull(t.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
					ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS QATrackingFormCompletedBy,
					t.QATrackingID


FROM dbo.QAErrorLog el
	INNER JOIN dbo.QATracking t ON t.QATrackingID = el.QATrackingID
	INNER JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	INNER JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID
	-- Joins to get diplay data
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	--TrackingTypeDesc
	LEFT JOIN dbo.QATrackingType tt ON mf.QATrackingTypeID = tt.QATrackingTypeID
	-- Employee, EmployeeFirst, EmployeeLast, EmployeeFullName, PersonID
	LEFT JOIN dbo.Person AS Employee ON el.QAErrorLogPersonID = Employee.PersonID
	LEFT JOIN dbo.Person AS Person ON tf.PersonID = Person.PersonID 
	LEFT JOIN dbo.Person AS CompletedBy ON el.StatEmployeeID = CompletedBy.PersonID
WHERE
	tf.QATrackingFormID Is Not Null
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND PATINDEX(coalesce(@TrackingNum, t.QATrackingNumber), t.QATrackingNumber) > 0 
	AND PATINDEX(coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '')), coalesce(t.QATrackingSourceCode, '')) > 0
	AND mf.QATrackingTypeID = coalesce(@TrackingTypeID, mf.QATrackingTypeID)	
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND  StatEmployeeID = coalesce(@CompletedByID, StatEmployeeID)
	AND el.qaerrorlogpersonid is not null;

GO
