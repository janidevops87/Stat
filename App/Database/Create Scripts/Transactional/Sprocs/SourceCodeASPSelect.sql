

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeASPSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeASPSelect'
		DROP Procedure SourceCodeASPSelect
	END
GO

PRINT 'Creating Procedure SourceCodeASPSelect'
GO
CREATE Procedure SourceCodeASPSelect
(
		@SourceCodeASPId int = null output,
		@SourceCodeId int = null					
)
AS
/******************************************************************************
**	File: SourceCodeASPSelect.sql
**	Name: SourceCodeASPSelect
**	Desc: Selects multiple rows of SourceCodeASP Based on Id  fields 
**	Auth: ccarroll
**	Date: 7/26/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/26/2010		ccarroll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		SourceCodeASP.SourceCodeASPId,
		SourceCodeASP.SourceCodeId,
		SourceCodeASP.ASP,
		SourceCodeASP.LastModified,
		SourceCodeASP.LastStatEmployeeID,
		SourceCodeASP.AuditLogTypeID
	FROM 
		dbo.SourceCodeASP 
	WHERE 
		SourceCodeASP.SourceCodeASPId = ISNULL(@SourceCodeASPId, SourceCodeASP.SourceCodeASPId)
	AND
		SourceCodeASP.SourceCodeId = ISNULL(@SourceCodeId, SourceCodeASP.SourceCodeId)				
	ORDER BY 1
GO

GRANT EXEC ON SourceCodeASPSelect TO PUBLIC
GO
