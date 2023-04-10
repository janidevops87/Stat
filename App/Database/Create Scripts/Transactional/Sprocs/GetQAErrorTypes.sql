
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorTypes]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorTypes]
	PRINT 'Dropping Procedure: GetQAErrorTypes'
END
	PRINT 'Creating Procedure: GetQAErrorTypes'
GO
 
CREATE PROCEDURE [dbo].[GetQAErrorTypes]
(
	@OrganizationID int = NULL,
	@QAErrorLocationID int = NULL,
	@QATrackingTypeID int = Null
)
/******************************************************************************
**		File: GetQAErrorTypes.sql
**		Name: GetQAErrorTypes
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/2009		jth			initial
**      03/10       jth         added location parm
**	   04/2010		bret			updating to include in release
**		6/13		jth			added tracking type parm
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
IF @QAErrorLocationID = 0
		BEGIN
			
			SET @QAErrorLocationID = Null
		END
IF @QATrackingTypeID = 0
		BEGIN
			
			SET @QATrackingTypeID = Null
		END

	SELECT distinct 
		QAErrorTypeDescription,
		QAErrorTypeID,
		QAErrorTypeGenerateLogIfNo
		
	FROM
			QAErrorType
	
	
where organizationid = @OrganizationID and QAErrorTypeActive = 1
and [QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID)
and [QATrackingTypeID] = IsNull(@QATrackingTypeID, QATrackingTypeID)
order by QAErrorTypeDescription

	RETURN @@Error

GO
