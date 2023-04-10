IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListLungTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListLungTypeSelect'
		DROP Procedure TcssListLungTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListLungTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListLungTypeSelect
AS

/***************************************************************************************************
**	Name: TcssListLungTypeSelect
**	Desc: Update Data in table TcssListLungType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tllt.TcssListLungTypeId AS ListId,
	tllt.FieldValue AS FieldValue
FROM dbo.TcssListLungType tllt with (nolock)
ORDER BY tllt.SortOrder, tllt.FieldValue
GO

GRANT EXEC ON TcssListLungTypeSelect TO PUBLIC
GO
