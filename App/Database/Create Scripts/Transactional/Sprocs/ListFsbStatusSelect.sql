IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ListFsbStatusSelect')
	BEGIN
		PRINT 'Dropping Procedure ListFsbStatusSelect'
		DROP Procedure ListFsbStatusSelect
	END
GO

PRINT 'Creating Procedure ListFsbStatusSelect'
GO

CREATE PROCEDURE dbo.ListFsbStatusSelect
AS
/***************************************************************************************************
**	Name: ListFsbStatusSelect
**	Desc: Select Data from table ListFsbStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
**  7/6/11		jth				added where isactive = 1 (only active values)
***************************************************************************************************/

SELECT
	lfs.ListFsbStatusId AS ListId,
	lfs.FieldValue AS FieldValue
FROM dbo.ListFsbStatus lfs with (nolock) 
where isactive = 1
ORDER BY FieldValue
GO

GRANT EXEC ON ListFsbStatusSelect TO PUBLIC
GO
