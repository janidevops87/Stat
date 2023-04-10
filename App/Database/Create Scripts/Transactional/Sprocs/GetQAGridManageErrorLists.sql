 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridManageErrorLists]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridManageErrorLists]
	PRINT 'Dropping Procedure: GetQAGridManageErrorLists'
END
	PRINT 'Creating Procedure: GetQAGridManageErrorLists'
GO

CREATE PROCEDURE [dbo].[GetQAGridManageErrorLists]
(
	@OrganizationID int = NULL,
	@QAMonitoringFormID int = NULL,
	--@QAMonitoringFormTemplateID int = NULL,
	@QAErrorTypeActive smallint = NULL,
	@QATrackingTypeID int = NULL
)
/******************************************************************************
**		File: GetQAGridManageErrorLists.sql
**		Name: GetQAGridManageErrorLists
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/28/2009	ccarroll	initial
**      02/09       jth         set templateid to null if 0 passed in 
**      03/09       jth         no active logic
**      05/09       jth         took out join to form, since some error types don't have one
**      02/10       jth         broke out to do forms and error list
**      03/10       jth         added tracking type desc
**	   04/2010		bret			updating to include in release
**      01/13       jth         added tracking type id parm
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
if (@QAMonitoringFormID=0)
begin
	set @QAMonitoringFormID = null
end
IF @QAErrorTypeActive = 0
		BEGIN
			/* Display All ErrorTypes */
			SET @QAErrorTypeActive =1
		END
ELSE 
		BEGIN
			/* Only display active ErrorTypes */	 
			SET @QAErrorTypeActive =null
		END
	SELECT
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateID,
				QAErrorType.QAErrorTypeActive,
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,
				QAErrorType.QAErrorTypeID,QAErrorType.QATrackingTypeID,
				QAErrorType.QAErrorTypeDescription,
				QAErrorLocation.QAErrorLocationDescription,
				--QAMonitoringForm.QAMonitoringFormID,QAMonitoringForm.QAMonitoringFormName,
				QAErrorLocation.QAErrorLocationID,
				(select QATrackingType.QATrackingTypeDescription from QATrackingType where QATrackingType.QATrackingTypeID = QAErrorType.QATrackingTypeID) as TrackingDesc
	
	FROM         --QAMonitoringFormTemplate INNER JOIN
                      --QAErrorType inner join ON QAMonitoringFormTemplate.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QAErrorType inner join QAErrorLocation ON QAErrorType.QAErrorLocationID = QAErrorLocation.QAErrorLocationID 
                      --LEFT OUTER JOIN QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
	WHERE     (QAErrorType.QAErrorTypeActive = ISNULL(@QAErrorTypeActive, QAErrorType.QAErrorTypeActive)) 
				AND (QAErrorType.OrganizationID = ISNULL(@OrganizationID, QAErrorType.OrganizationID)) 
				and (QAErrorType.QATrackingTypeID = ISNULL(@QATrackingTypeID, QAErrorType.QATrackingTypeID)) 

                      --AND (ISNULL(ISNULL(@QAMonitoringFormID, QAMonitoringFormTemplate.QAMonitoringFormID), - 1) = ISNULL(QAMonitoringFormTemplate.QAMonitoringFormID, - 1))
order by 5,4
	RETURN @@Error
GO


