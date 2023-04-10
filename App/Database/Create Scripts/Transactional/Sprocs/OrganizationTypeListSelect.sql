IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationTypeListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationTypeListSelect]
	PRINT 'Dropping Procedure: OrganizationTypeListSelect'
END
	PRINT 'Creating Procedure: OrganizationTypeListSelect'
GO

CREATE PROCEDURE [dbo].[OrganizationTypeListSelect]
(
	@OrganizationTypeID int = NULL
)
/******************************************************************************
**		File: OrganizationTypeListSelect.sql
**		Name: OrganizationTypeListSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret	initial
**		07/12/2010	ccarroll added this note for development build (GenerateSQL)
**		05/20/2011	ccarroll Added WHERE Inactive <> 1 
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
			[OrganizationTypeID] AS ListId,
			[OrganizationTypeName] AS FieldValue
	
	FROM
			[OrganizationType]
	WHERE	IsNull(Inactive, 0) <> 1
	ORDER BY OrganizationTypeName			


	RETURN @@Error
GO
