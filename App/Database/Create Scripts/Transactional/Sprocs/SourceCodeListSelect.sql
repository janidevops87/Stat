 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[SourceCodeListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[SourceCodeListSelect]
	PRINT 'Dropping Procedure: SourceCodeListSelect'
END
	PRINT 'Creating Procedure: SourceCodeListSelect'
GO

CREATE PROCEDURE [dbo].[SourceCodeListSelect]
(
	@StatEmployeeUserId int,
	@OrganizationId int = null
)
AS
/******************************************************************************
**		File: SourceCodeListSelect.sql
**		Name: SourceCodeListSelect
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
**		6/19/2009	bret		initial
**		07/12/2010	ccarroll	added this note for development build (GenerateSQL)
**		06/01/2011	ccarroll	Added Statline full access wi: 11904
*******************************************************************************/


SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
DECLARE
	@userOrganizationId int
SELECT 
	@userOrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeUserId)

SELECT @OrganizationId = ISNULL(@OrganizationId, @userOrganizationId)


IF @OrganizationID <> 194 --StatLine
BEGIN	
	SELECT
		[SourceCodeID] AS ListId,
		RTRIM(LTRIM(SourceCode.SourceCodeName)) + ' ' + SourceCodeType.SourceCodeTypeName AS FieldValue	
	FROM
		[SourceCode]	
	INNER JOIN
        SourceCodeType ON SourceCode.SourceCodeType = SourceCodeType.SourceCodeTypeId			
	WHERE 
		SourceCodeName IS NOT NULL
	AND 
		( -- This limits by User and/or OrganizationID
			SourceCodeID IN (	
								SELECT userSc.SourceCodeID 
								FROM dbo.fn_SourceCodeForAdmininistrationByOrganizationId(@userOrganizationId) userSc
								JOIN dbo.fn_SourceCodeForAdmininistrationByOrganizationId(@OrganizationId) orgSc ON userSc.SourceCodeID = orgSc.SourceCodeID
							 )				
		)
			
	ORDER BY 2  --- ORDERS BY COLUMN 2
END
ELSE
BEGIN
	--StatLine Full Lookup
	SELECT
		[SourceCodeID] AS ListId,
		RTRIM(LTRIM(SourceCode.SourceCodeName)) + ' ' + SourceCodeType.SourceCodeTypeName AS FieldValue	
	FROM
		[SourceCode]	
	INNER JOIN
        SourceCodeType ON SourceCode.SourceCodeType = SourceCodeType.SourceCodeTypeId			
	WHERE 
		SourceCodeName IS NOT NULL
			
	ORDER BY 2  --- ORDERS BY COLUMN 2
END

	RETURN @@Error
GO
