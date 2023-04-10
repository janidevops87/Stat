 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AutoDisplaySourceCodeGet')
	BEGIN
		PRINT 'Dropping Procedure AutoDisplaySourceCodeGet'
		PRINT GETDATE()
		DROP Procedure AutoDisplaySourceCodeGet
	END
GO

PRINT 'Creating Procedure AutoDisplaySourceCodeGet'
PRINT GETDATE()
GO
CREATE Procedure AutoDisplaySourceCodeGet
(
	@organizationId int,
	@sourceCode nvarchar(10)  = '' out,
	@sourceCodeDefaultCallTypeID int = 0 out
)
AS
/******************************************************************************
**	File: AutoDisplaySourceCodeGet.sql
**	Name: AutoDisplaySourceCodeGet
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
	@sourceCode = COALESCE(SourceCodeByID.SourceCodeName , ''), 
	@sourceCodeDefaultCallTypeID = COALESCE(SourceCodeByName.SourceCodeCallTypeID, 0)
 FROM 
	OrganizationASPSetting
 LEFT JOIN SourceCode SourceCodeByID ON 	OrganizationASPSetting.AutoDisplaySourceCodeId = SourceCodeByID.SourceCodeID
 LEFT JOIN SourceCode SourceCodeByName ON SourceCodeByID.SourceCodeName = SourceCodeByName.SourceCodeName AND SourceCodeByName.SourceCodeDefault = 1
 
 WHERE
	OrganizationId = @organizationId

SELECT 
	@sourceCode = COALESCE(@sourceCode, ''), 
	@sourceCodeDefaultCallTypeID = COALESCE(@sourceCodeDefaultCallTypeID, 0)


GO

GRANT EXEC ON AutoDisplaySourceCodeGet TO PUBLIC
GO
