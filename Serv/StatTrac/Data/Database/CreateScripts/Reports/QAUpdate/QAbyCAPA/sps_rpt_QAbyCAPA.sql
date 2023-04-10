IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	DROP  Procedure  sps_rpt_QAbyCAPA;
	PRINT 'Dropping Procedure: sps_rpt_QAbyCAPA'
GO
	PRINT 'Creating Procedure: sps_rpt_QAbyCAPA'
GO

CREATE Procedure sps_rpt_QAbyCAPA
	@TrackingNum				varchar(20) = Null,
	@CAPANum				varchar(20) = Null,
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
**		File: sps_rpt_QAbyCAPA.sql
**		Name: sps_rpt_QAbyCAPA.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:		Description:
**		--------		--------	-------------------------------------------
**      5/2009			jth			Initial release
**      08/09           jth			only display records with a capa number
**		10/03/2009		ccarroll	return all dates when @TrackingNum or @CAPANum used 
**      3/10            jth			added tracking type parm
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**		02/28/2013		jth			removed webreportgrouporg change above
**		09/09/2013		ccarroll	re-organized table joins and where clause
**		09/19/2013		ccarroll	HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**		01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

--if @SourceCodeName is null
--BEGIN
-- SET @SourceCodeName = ''
--END

If @TrackingNum IS NOT NULL OR @CAPANum IS NOT NULL
BEGIN
SELECT 
	@CallStartDateTime = Null,
	@CallEndDateTime = Null,
	@ErrorStartDateTime = Null,
	@ErrorEndDateTime = Null
END

SELECT DISTINCT
		tf.QATrackingFormID,
		(case  when len(tf.QATrackingCAPANumber) > 0  then tf.QATrackingCAPANumber else 'N/A' end) QATrackingCAPANumber, 
	    (case  when len(t.QATrackingSourceCode) > 0  then t.QATrackingSourceCode else 'N/A' end)  SourceCode, 
         coalesce(el.QAErrorLogDateTime, t.QATrackingReferralDateTime) AS CallDateTime, 
         t.QATrackingNumber

FROM dbo.QAErrorLog el
	INNER JOIN dbo.QATracking t ON t.QATrackingID = el.QATrackingID
	INNER JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	INNER JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	-- Errortype
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
WHERE
	t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND PATINDEX(coalesce(@TrackingNum, t.QATrackingNumber), t.QATrackingNumber) > 0 
	AND PATINDEX(coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '')), coalesce(t.QATrackingSourceCode, '')) > 0
	AND PATINDEX(coalesce(@CAPANum,tf.QATrackingCAPANumber), tf.QATrackingCAPANumber)> 0
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND tf.QATrackingCAPANumber > '0'
ORDER BY 
2,3, 4;


GO
