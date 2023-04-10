IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListLiverTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListLiverTypeSelect'
		DROP Procedure TcssListLiverTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListLiverTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListLiverTypeSelect
AS

/***************************************************************************************************
**	Name: TcssListLiverTypeSelect
**	Desc: Update Data in table TcssListLiverType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tllt.TcssListLiverTypeId AS ListId,
	tllt.FieldValue AS FieldValue
FROM dbo.TcssListLiverType tllt with (nolock)
ORDER BY tllt.SortOrder, tllt.FieldValue
GO

GRANT EXEC ON TcssListLiverTypeSelect TO PUBLIC
GO
