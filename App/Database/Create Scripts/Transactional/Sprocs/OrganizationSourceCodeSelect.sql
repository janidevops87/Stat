 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationSourceCodeSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationSourceCodeSelect]
	PRINT 'Dropping Procedure: OrganizationSourceCodeSelect'
END
	PRINT 'Creating Procedure: OrganizationSourceCodeSelect'
GO

CREATE PROCEDURE [dbo].[OrganizationSourceCodeSelect]
(
	@organizationID int = NULL
)
/******************************************************************************
**		File: OrganizationSourceCodeSelect.sql
**		Name: OrganizationSourceCodeSelect
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
**		7/6/2009	bret	initial
**		07/12/2010	ccarroll added this note for development build (GenerateSQL)
**		02/28/2011  ccarroll Changed Joins to include all combinations of source code
**							 and organizations when @Organization is null. 
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT	DISTINCT
	SourceCode.SourceCodeID, 
	SourceCode.SourceCodeName + ' (' + SourceCodeType.SourceCodeTypeName + ')' AS 'SourceCode',
	@organizationID AS OrganizationID
FROM         
	SourceCode 
INNER JOIN
	SourceCodeType ON SourceCode.SourceCodeType = SourceCodeType.SourceCodeTypeId
LEFT JOIN 
	SourceCodeOrganization ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID
WHERE
	SourceCode.SourceCodeName Is NOT Null AND
	IsNull(SourceCodeOrganization.OrganizationID, 0) = IsNull(@OrganizationID, IsNull(SourceCodeOrganization.OrganizationID, 0))
AND @organizationID > 0
ORDER BY 2	


	RETURN @@Error
GO
