IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeCallTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeCallTypeListSelect'
		DROP Procedure SourceCodeCallTypeListSelect
	END
GO

PRINT 'Creating Procedure SourceCodeCallTypeListSelect'
GO
CREATE Procedure SourceCodeCallTypeListSelect
(
		@SourceCodeCallTypeID int,
		@DisplayAllSourceCodes bit,
		@StatEmployeeUserId int
)
AS
/******************************************************************************
**	File: SourceCodeCallTypeListSelect.sql
**	Name: SourceCodeCallTypeListSelect
**	Desc: Selects multiple rows of SourceCode Based on Id  fields 
**	Auth: ccarroll
**	Date: 07/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	07/29/2010		ccarroll			Initial Sproc Creation
**	05/17/2011		ccarroll			Added selection based on StatEmployeeID
**	05/18/2011		ccarroll			Statline needs full access to assign Report Groups
*******************************************************************************/

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE
	@userOrganizationId int,
	@organizationId int
	
SELECT 
	@userOrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeUserId)

SELECT @organizationId = ISNULL(@organizationId, @userOrganizationId)
	

IF @DisplayAllSourceCodes = 1
BEGIN
	-- Show All SourceCodes
	SET @DisplayAllSourceCodes = Null
END

IF @SourceCodeCallTypeID = 0
BEGIN
	SET @SourceCodeCallTypeID = -1
END

IF @OrganizationID <> 194
BEGIN

	SELECT
		SourceCode.SourceCodeID AS ListID,
		IsNull(SourceCode.SourceCodeName, '') AS FieldValue
	FROM 
		dbo.SourceCode 

	WHERE 
		SourceCode.SourceCodeCallTypeID = ISNULL(@SourceCodeCallTypeID, SourceCode.SourceCodeID) AND
		COALESCE(SourceCode.Inactive, 0) = ISNULL(@DisplayAllSourceCodes, COALESCE(SourceCode.Inactive, 0))
	AND 
		( -- This limits by User and/or OrganizationID
		  -- SourceCode must belong to a report group to appear in list
			SourceCodeID IN (	
								SELECT userSc.SourceCodeID 
								FROM dbo.fn_SourceCodeForAdmininistrationByOrganizationId(@userOrganizationId) userSc
								JOIN dbo.fn_SourceCodeForAdmininistrationByOrganizationId(@organizationId) orgSc ON userSc.SourceCodeID = orgSc.SourceCodeID
							 )				
		)
	ORDER BY 2 -- SourceCodeName
END
ELSE
BEGIN
	--StatLine Full Lookup
	SELECT
		SourceCode.SourceCodeID AS ListID,
		IsNull(SourceCode.SourceCodeName, '') AS FieldValue
	FROM 
		dbo.SourceCode 

	WHERE 
		SourceCode.SourceCodeCallTypeID = ISNULL(@SourceCodeCallTypeID, SourceCode.SourceCodeID) AND
		COALESCE(SourceCode.Inactive, 0) = ISNULL(@DisplayAllSourceCodes, COALESCE(SourceCode.Inactive, 0))

	ORDER BY 2 -- SourceCodeName
END


GO

GRANT EXEC ON SourceCodeCallTypeListSelect TO PUBLIC
GO
 