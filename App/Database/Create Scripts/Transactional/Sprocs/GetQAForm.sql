IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAForm]
	PRINT 'Dropping Procedure: GetQAForm'
END
	PRINT 'Creating Procedure: GetQAForm'
GO

CREATE PROCEDURE [dbo].[GetQAForm]
(
	@OrganizationID int = NULL,
	@ErrorTypeID      int = null,
	@TrackingTypeID      int = null
)
/******************************************************************************
**		File: GetQAForm.sql
**		Name: GetQAForm
**		Desc:  Used on ddl for error list (forms config)
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	jth     	initial
**      03/2009		jth			add active criteria
**      02/10       jth         add errortypeid take out 
**	   04/2010		bret			updating to include in release
**      01/13       jth         added tracking type id parm
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
IF @TrackingTypeID = 0
BEGIN
	SET @TrackingTypeID = Null
END 
SELECT DISTINCT QAMonitoringForm.QAMonitoringFormID, QAMonitoringForm.QAMonitoringFormName, (Select top 1 QAMonitoringFormTemplateActive from QAMonitoringFormTemplate where QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID and QAMonitoringFormTemplate.QAErrorTypeID = @ErrorTypeID) as QAMonitoringFormTemplateActive,
(Select top 1 QAMonitoringFormTemplateID from QAMonitoringFormTemplate where QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID and QAMonitoringFormTemplate.QAErrorTypeID = @ErrorTypeID) as QAMonitoringFormTemplateID,
(select top 1 QATrackingType.QATrackingTypeDescription from QATrackingType where QATrackingType.QATrackingTypeID = QAMonitoringForm.QATrackingTypeID) as TrackingDesc
FROM         QAMonitoringForm 
WHERE     
	(QAMonitoringForm.OrganizationID = @OrganizationID) AND (QAMonitoringForm.QAMonitoringFormActive = 1) 
	and
	qamonitoringform.QATrackingTypeID = IsNull(@TrackingTypeID,qamonitoringform.QATrackingTypeID)
ORDER BY QAMonitoringForm.QAMonitoringFormName
	


	RETURN @@Error
GO


 