  

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeDefaultCallTypeBySourceCode')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeDefaultCallTypeBySourceCode'
		PRINT GETDATE()
		DROP Procedure SourceCodeDefaultCallTypeBySourceCode
	END
GO

PRINT 'Creating Procedure SourceCodeDefaultCallTypeBySourceCode'
PRINT GETDATE()
GO
CREATE Procedure SourceCodeDefaultCallTypeBySourceCode
(
	@sourceCode nvarchar(10)  = ''
)
AS
/******************************************************************************
**	File: SourceCodeDefaultCallTypeBySourceCode.sql
**	Name: SourceCodeDefaultCallTypeBySourceCode
**	Desc: Gets values through a Non-Query 
**	Auth: Bret Knoll
**	Date: 3/8/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	3/08/2011		Bret Knoll			Initial Sproc Creation (6423)
*******************************************************************************/

SELECT 
	COALESCE(SourceCode.SourceCodeCallTypeID, 0) SourceCodeCallTypeID
 FROM 
	SourceCode
 WHERE
	SourceCode.SourceCodeName = @sourceCode
 AND
	SourceCode.SourceCodeDefault = 1


GO

GRANT EXEC ON SourceCodeDefaultCallTypeBySourceCode TO PUBLIC
GO
