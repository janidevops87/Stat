IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingType]
	PRINT 'Dropping Procedure: GetQATrackingType'
END
	PRINT 'Creating Procedure: GetQATrackingType'
GO

CREATE PROCEDURE GetQATrackingType
(
@OrganizationID int = NULL
)

/******************************************************************************
**		File: GetQATrackingType.sql
**		Name: GetQATrackingType
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
**      02/17/09    jth			qatrackingid is not in table   
**      03/10       jth			remove fields not needed
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	
	SELECT
		[QATrackingTypeID],
		
		[QATrackingTypeDescription]
		
	
	FROM
			[QATrackingType]
	WHERE 
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO

