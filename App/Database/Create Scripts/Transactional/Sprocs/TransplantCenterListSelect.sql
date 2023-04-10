
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TransplantCenterListSelect')
	BEGIN
		PRINT 'Dropping Procedure TransplantCenterListSelect'
		DROP Procedure TransplantCenterListSelect
	END
GO

PRINT 'Creating Procedure TransplantCenterListSelect'
GO
CREATE Procedure TransplantCenterListSelect
	(
		@Code nvarchar(50) = Null,
		@OrganizationName nvarchar(80) = Null,
		@OrganType nvarchar(50) = Null
	)
AS
/******************************************************************************
**	File: TransplantCenterListSelect.sql
**	Name: TransplantCenterListSelect
**	Desc: Selects multiple rows of TransplantCenter Based on Id  fields 
**	Auth: ccarroll
**	Date: 04/20/2011
**	Called By: SourceCodeScoureCodeControl
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	04/20/2010		ccarroll			Initial Sproc Creation
**	05/31/2011		ccarroll			Added field delimiter for FieldValue selection 
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		TransplantCenterId AS ListId,
		IsNull(Code, '') + '|' + 
		IsNull(OrganizationName, '') + '|' +
		IsNull(OrganType, '')+ '|' AS FieldValue
	FROM 
		dbo.TransplantCenter
	WHERE
		Code = Isnull(@Code,Code) AND
		OrganizationName= Isnull(@OrganizationName,OrganizationName) AND
		OrganType = Isnull(@OrganType, OrganType)
				 
	ORDER BY 2
GO

GRANT EXEC ON TransplantCenterListSelect TO PUBLIC
GO
 