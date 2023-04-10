 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyTrackingNumber'
		DROP  Procedure  sps_rpt_QAbyTrackingNumber
	END

GO
	PRINT 'Creating Procedure sps_rpt_QAbyTrackingNumber'
GO
 
 CREATE Procedure sps_rpt_QAbyTrackingNumber
	@TrackingNum				varchar(20) = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**	File: sps_rpt_QAbyTrackingNumber.sql
**	Name: sps_rpt_QAbyTrackingNumber.sql
**	Desc: 
**
**              
**	Return values:
** 
**	Called by:   
**              
**	Parameters:
**	Input							Output
**  ----------							-----------
**	See above
**
**	Auth: jth
**	Date: 05/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:		Description:
**	--------		--------	-------------------------------------------
**   5/2009			jth			Initial release
**	08/018/2009		ccarroll	added CASE statement for error counts
**	09/21/2009		ccarroll	Change WHERE clause to include Tracking Numbers which
**								have errors defined by GenerateLogIfYes and GenerareLogIfNo options.
**	10/03/2009		ccarroll	changed QAErrorLogCorrection to CorrectionLog to match sort option
**	5/10			Sue Dabiri	Added QAMonitoringForm Name field
**	04/19/2012		ccarroll	Added CASE statement for QAMonitoringFormName CCRST143 -wi 1299
**	04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013		jth			removed webreportgrouporg change above
**	09/19/2013		ccarroll	HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   null
	END
			

SELECT DISTINCT 
	tf.QATrackingFormID,
	coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) AS QATrackingReferralDateTime,  
    t.QATrackingNumber,
	CASE WHEN QAMonitoringFormName is null THEN 'N/A' ELSE QAMonitoringFormName END AS QAMonitoringFormName,
	CASE WHEN (tf.qatrackingformid)is not null THEN
			CASE WHEN coalesce(QAErrorLogPointsYes,0) = 1 AND coalesce(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN coalesce(QAErrorLogPointsNo, 0) = 1 AND coalesce(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END
	ELSE el.QAErrorLogNumberOfErrors END AS QAErrorLogNumberOfErrors,
case when (tf.qatrackingformid)is not null then                      
 (SELECT     coalesce(Person.PersonFirst, '') + ' ' + coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid)
else
(SELECT     coalesce(Person.PersonFirst, '') + ' ' + coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS Employee,
case when (tf.qatrackingformid)is not null then
 (SELECT     coalesce(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = tf.personid) 
else
 (SELECT     coalesce(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
AS EmployeeFirst,
case when (tf.qatrackingformid)is not null then
 (SELECT     coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid)
else
(SELECT     coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS EmployeeLast,
case when (tf.qatrackingformid)is not null then
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = tf.qaprocessstepid)
else
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = el.qaprocessstepid)
end
 AS ProcessStep,

                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = el.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = el.qaerrorlocationid) AS ErrorLocation,
                          (SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = el.QAErrorLogHowIdentifiedid) AS HowIdentified,
el.QAErrorLogDateTime,
el.QAerrorlogComments,
el.QAErrorLogTicketNumber,
el.QAErrorLogCorrection AS CorrectionLog
FROM dbo.QATracking t
	INNER JOIN dbo.QAErrorLog el ON t.QATrackingID = el.QATrackingID
	LEFT JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	LEFT JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID

	-- QAErrorLogNumberOfErrors
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ProcessStep
	LEFT JOIN dbo.QAProcessStep ps ON tf.QAProcessStepID = ps.QAProcessStepID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE 
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- Ignore @ZeroErrors and Only show items with more than zero error 
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	-- @ReportGroupID : Not sure why this is not implemented
	AND coalesce(t.OrganizationID, 0) = coalesce(@OrganizationID, t.OrganizationID,0)
	AND coalesce(t.QATrackingSourceCode, '') = coalesce(@SourceCodeName, t.QATrackingSourceCode, '')
	AND QATrackingNumber = coalesce(@TrackingNum,QATrackingNumber)
	AND (
			(coalesce(QAErrorLogPointsYes,0) = 1 AND coalesce(QAErrorTypeGenerateLogIfYes, 0) = 1)
		OR	(coalesce(QAErrorLogPointsNo, 0) = 1 AND coalesce(QAErrorTypeGenerateLogIfNo, 0) = 1)
		OR	(coalesce(QAErrorLogNumberOfErrors,0) > 0)
		);
GO


