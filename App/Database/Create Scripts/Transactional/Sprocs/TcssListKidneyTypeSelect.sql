IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyTypeSelect'
		DROP Procedure TcssListKidneyTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyTypeSelect
AS

/***************************************************************************************************
**	Name: TcssListKidneyTypeSelect
**	Desc: Update Data in table TcssListKidneyType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkt.TcssListKidneyTypeId AS ListId,
	tlkt.FieldValue AS FieldValue
FROM dbo.TcssListKidneyType tlkt with (nolock)
ORDER BY tlkt.SortOrder, tlkt.FieldValue
GO

GRANT EXEC ON TcssListKidneyTypeSelect TO PUBLIC
GO
