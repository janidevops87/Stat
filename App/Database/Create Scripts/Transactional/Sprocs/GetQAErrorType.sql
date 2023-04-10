IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorType]
	PRINT 'Dropping Procedure: GetQAErrorType'
END
	PRINT 'Creating Procedure: GetQAErrorType'
GO

CREATE PROCEDURE [dbo].[GetQAErrorType]
(
@QAErrorTypeID int = null
	--@OrganizationID int = NULL,
	--@QAErrorTypeActive smallint = NULL
)
/******************************************************************************
**		File: GetQAErrorType.sql
**		Name: GetQAErrorType
**		Desc: Used on QA Update Tab, Web UI
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
**      02/19/09    jth         took out unnecessary parms  
**      03/09       jth         added qatrackingtypeid
**		08/17/2009  ccarroll	added Column QAErrorTypeGenerateLogIfYes (used in reports) 
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	/*
	IF @QAErrorTypeID = 0
		BEGIN
			
			SET @QAErrorTypeID = Null
		END

	IF @QAErrorTypeActive = null
		BEGIN
			
			SET @QAErrorTypeActive =0
		END
ELSE 
		BEGIN
			
			SET @QAErrorTypeActive =null
		END
		*/

	SELECT
		[QAErrorTypeID],
		[OrganizationID],
		[QAErrorLocationID],
		[QAErrorTypeDescription],
		[QAErrorRequireReview],
		[QAErrorTypeActive],
		[QAErrorTypeInactiveComments],
		[QAErrorTypeAssignedPoints],
		[QAErrorTypeAutomaticZeroScore],
		[QAErrorTypeDisplayNA],
		[QAErrorTypeDisplayComments],
		[QAErrorTypeGenerateLogIfNo],
		[QAErrorTypeGenerateLogIfYes],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[QATrackingTypeID]
	
	FROM
			[QAErrorType]
	WHERE 
		[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID) --AND
		--[OrganizationID] = IsNull(@OrganizationID, OrganizationID) AND
		--[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID) AND
		--[QAErrorTypeActive] = IsNull(@QAErrorTypeActive, QAErrorTypeActive)
order by QAErrorTypeDescription

	RETURN @@Error
GO


