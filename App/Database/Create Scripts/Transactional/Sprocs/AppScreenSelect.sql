 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'AppScreenSelect')
	BEGIN
		PRINT 'Dropping Procedure AppScreenSelect'
		DROP Procedure AppScreenSelect
	END
GO

PRINT 'Creating Procedure AppScreenSelect'
GO

CREATE PROCEDURE dbo.AppScreenSelect
(
	@AppScreenId int = 1
)
AS
/******************************************************************************
**	File: AppScreenSelect.sql
**	Name: AppScreenSelect
**	Desc: Select Data from AppScreen
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
SELECT 
	AppScreenId,
	ParentId,
	ScreenName,
	SortOrder,
	ShortCutKey
FROM dbo.AppScreen
WHERE ParentId IS NOT NULL
--WHERE ParentId = @AppScreenId
--
--UNION ALL 
--
--SELECT 
--	Child.AppScreenId,
--	Child.ParentId,
--	Child.ScreenName,
--	Child.SortOrder,
--	Child.ShortCutKey
--FROM dbo.AppScreen Parent
--	INNER JOIN AppScreen Child on Parent.AppScreenId = Child.ParentId
--WHERE @AppScreenId = 1 AND Parent.ParentId = @AppScreenId
ORDER BY ParentId, SortOrder
GO

GRANT EXEC ON AppScreenSelect TO PUBLIC
GO

