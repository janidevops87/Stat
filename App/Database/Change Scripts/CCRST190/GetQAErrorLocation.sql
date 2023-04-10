IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLocation]
	PRINT 'Dropping Procedure: GetQAErrorLocation'
END
	PRINT 'Creating Procedure: GetQAErrorLocation'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLocation]
(
	@OrganizationID int = NULL,
	@QAErrorLocationActive smallint = NULL,
	@QATrackingTypeID int = NULL
)
/******************************************************************************
**		File: GetQAErrorLocation.sql
**		Name: GetQAErrorLocation
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      03/09       jth         active logic was backward
**		10/17/2013  ccarroll	fixed table joins HS 37535, wi 9222
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	IF @QAErrorLocationActive = 0
		BEGIN
			/* Display All locations */
			SET @QAErrorLocationActive = 1
		END
	ELSE 
		BEGIN
			/* Only display active locations */	 
			SET @QAErrorLocationActive = null
		END
	IF @QATrackingTypeID = 0
		BEGIN
			
			SET @QATrackingTypeID = Null
		END
	
	SELECT distinct
		QALoc.QAErrorLocationID,
		QALoc.OrganizationID,
		QAErrorLocationDescription,
		QAErrorLocationActive,
		QALoc.LastModified,
		QALoc.LastStatEmployeeID,
		QALoc.AuditLogTypeID
	
	FROM
			QAErrorLocation QALoc 
			LEFT JOIN QAErrorType ON QALoc.QAErrorLocationID = QAErrorType.QAErrorLocationID 
	WHERE 	QALoc.OrganizationID = COALESCE(@OrganizationID, QALoc.OrganizationID)
		AND QAErrorLocationActive = COALESCE(@QAErrorLocationActive, QAErrorLocationActive)
		AND COALESCE(QAErrorType.QATrackingTypeID, 0) = COALESCE(@QATrackingTypeID, COALESCE(QAErrorType.QATrackingTypeID, 0))
		
	order by QAErrorLocationDescription


	RETURN @@Error

GO


