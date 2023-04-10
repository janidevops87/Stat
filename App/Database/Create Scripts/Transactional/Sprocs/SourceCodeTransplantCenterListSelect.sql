 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTransplantCenterListSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeTransplantCenterListSelect'
		DROP Procedure SourceCodeTransplantCenterListSelect
	END
GO

PRINT 'Creating Procedure SourceCodeTransplantCenterListSelect'
GO
CREATE Procedure SourceCodeTransplantCenterListSelect
AS
/******************************************************************************
**	File: SourceCodeTransplantCenterListSelect.sql
**	Name: SourceCodeTransplantCenterListSelect
**	Desc: Selects multiple rows of SourceCodeTransplantCenter 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	11/12/2009		ccarroll		Initial Sproc Creation
**	05/31/2011		ccarroll		Added field delimiter for FieldValue selection 
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
	ORDER BY 2
GO

GRANT EXEC ON SourceCodeTransplantCenterListSelect TO PUBLIC
GO
