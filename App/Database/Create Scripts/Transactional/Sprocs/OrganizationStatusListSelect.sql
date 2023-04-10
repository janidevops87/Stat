 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationStatusListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationStatusListSelect]
	PRINT 'Dropping Procedure: OrganizationStatusListSelect'
END
	PRINT 'Creating Procedure: OrganizationStatusListSelect'
GO

CREATE PROCEDURE [dbo].[OrganizationStatusListSelect]
/******************************************************************************
**		File: OrganizationStatusListSelect.sql
**		Name: OrganizationStatusListSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/6/2009	bret		initial
**		07/12/2010	ccarroll	added this note for development build (GenerateSQL)
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[OrganizationStatusID] AS ListId,
		[OrganizationStatusName] AS FieldValue
	
	FROM
			[OrganizationStatus]	


	RETURN @@Error
GO
