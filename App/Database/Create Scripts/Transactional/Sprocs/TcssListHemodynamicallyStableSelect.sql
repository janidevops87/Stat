IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHemodynamicallyStableSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHemodynamicallyStableSelect'
		DROP Procedure TcssListHemodynamicallyStableSelect
	END
GO

PRINT 'Creating Procedure TcssListHemodynamicallyStableSelect'
GO

CREATE PROCEDURE dbo.TcssListHemodynamicallyStableSelect
AS

/***************************************************************************************************
**	Name: TcssListHemodynamicallyStableSelect
**	Desc: Update Data in table TcssListHemodynamicallyStable
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhs.TcssListHemodynamicallyStableId AS ListId,
	tlhs.FieldValue AS FieldValue
FROM dbo.TcssListHemodynamicallyStable tlhs with (nolock)
ORDER BY tlhs.SortOrder, tlhs.FieldValue
GO

GRANT EXEC ON TcssListHemodynamicallyStableSelect TO PUBLIC
GO
