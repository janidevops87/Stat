IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAApproved'
		DROP  Procedure  sps_rpt_QAApproved
	END
GO
		PRINT 'Creating Procedure sps_rpt_QAApproved'
GO

CREATE Procedure sps_rpt_QAApproved
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
**	File: sps_rpt_QAApproved.sql
**	Name: sps_rpt_QAApproved.sql
**	Desc: 
**
**              
**	Return values:
** 
**	Called by:   
**              
**	Parameters:
**	Input							Output
**    ----------							-----------
**	See above
**
**	Auth: jth
**	Date: 05/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  5/2009			jth			Initial release
**  3/10            jth			added tracking type parm 
**	04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013		jth			removed webreportgrouporg change above
**	09/09/2013		ccarroll	fixed table joins wi 7764
**	09/19/2013		ccarroll	HS 37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014		ccarroll	HS 38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT DISTINCT
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
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE
	tf.QATrackingApproved = 1
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND t.QATrackingSourceCode = coalesce(@SourceCodeName, t.QATrackingSourceCode)
	-- @DisplayMT : Not sure why this is not implemented
ORDER BY 
1,2,3;

GO