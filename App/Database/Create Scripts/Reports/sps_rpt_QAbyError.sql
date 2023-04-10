IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_QAbyError]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_QAbyError]
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE Procedure [dbo].[sps_rpt_QAbyError]
(
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@TrackingTypeID				int = Null,
	@ZeroErrors					int = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null
)
AS
/******************************************************************************
**		File: sps_rpt_QAbyError.sql
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**  6/2009		jth				Initial release
**	09/18/2009	ccarroll		added WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
**	10/03/2009	ccarroll		added @ErrorTypeID to WHERE
**  3/10        jth				added tracking type parm
**	05/28/2010	JGerberich		Removed el.QAErrorTypeID replaced 
**								with QAMonitoringFormTemplate.QAErrorTypeID HS #23404
**	04/26/2012	ccarroll		Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013	jth				removed webreportgrouporg change above
**	08/14/2013	Tanvir Ather	Bug # 7722
**	10/01/2013	ccarroll		HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014	ccarroll		HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
**	10/22/2014	mberenson		Added EventMonthNum, EventMonth, & EventYear to the select list
**	10/28/2014	mberenson		Added coalesce function with QAErrorLogDateTime to new EventMonthNum, EventMonth, & Event Year fields
**  10/28/2014	mberenson		Set coalesce function to key on QAErrorLogDateTime first and QATrackingEventDateTime second
**	02/05/2020	mberenson		No changes - comment needed for sql build after rollback
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	coalesce(t.QATrackingSourceCode, '') AS SourceCode,
	CASE
		WHEN tf.QATrackingFormID IS NOT NULL 
		THEN
			CASE
				WHEN coalesce(el.QAErrorLogPointsYes,0) = 1 AND coalesce(et.QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				WHEN coalesce(el.QAErrorLogPointsNo, 0) = 1 AND coalesce(et.QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
				ELSE 0
			END
		ELSE el.QAErrorLogNumberOfErrors
	END AS QAErrorLogNumberOfErrors,
	coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime) AS CallDateTime,
	t.QATrackingNumber, 
	DatePart(Month, t.QATrackingReferralDateTime) AS RefMonthNum,
	DateName(Month, t.QATrackingReferralDateTime) AS RefMonth,
	DateName(Year, t.QATrackingReferralDateTime) AS RefYear,
	DatePart(Month, el.QAErrorLogDateTime) AS ErrMonthNum,
	DateName(Month, el.QAErrorLogDateTime) AS ErrMonth,
	DateName(Year, el.QAErrorLogDateTime) AS ErrYear,
	coalesce(tfps.QAProcessStepDescription, elps.QAProcessStepDescription) AS ProcessStep,
	et.QAErrorTypeDescription AS ErrorType ,
	eloc.QAErrorLocationDescription AS ErrorLocation,
	coalesce(tf.QATrackingEventDateTime, el.QAErrorLogDateTime) AS QATrackingEventDateTime,
	@SourceCodeName,
	t.QATrackingSourceCode,
	datepart(month, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) AS EventMonthNum,
	datename(month, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) AS EventMonth,
	datename(year, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) As EventYear
FROM dbo.QATracking t
	INNER JOIN dbo.QAErrorLog el ON t.QATrackingID = el.QATrackingID
	LEFT JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	LEFT JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID

	-- QAErrorLogNumberOfErrors
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ProcessStep
	LEFT JOIN dbo.QAProcessStep tfps ON tf.QAProcessStepID = tfps.QAProcessStepID
	LEFT JOIN dbo.QAProcessStep elps ON el.QAProcessStepID = elps.QAProcessStepID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE
	el.QAErrorLocationID = coalesce(@ErrorLocationID, el.QAErrorLocationID)
	AND coalesce(tf.QAProcessStepID,el.QAProcessStepID) = coalesce(@ProcessStepID, tf.QAProcessStepID,el.QAProcessStepID)
	AND coalesce(mft.QAErrorTypeID, el.QAErrorTypeID)  = coalesce(@ErrorTypeID, mft.QAErrorTypeID, el.QAErrorTypeID)	
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- Ignore @ZeroErrors and Only show items with more than zero error 
	AND el.QAErrorLogNumberOfErrors > 0
	AND coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND coalesce(t.QATrackingSourceCode, '-') = coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '-'))

ORDER BY t.QATrackingNumber;

GO