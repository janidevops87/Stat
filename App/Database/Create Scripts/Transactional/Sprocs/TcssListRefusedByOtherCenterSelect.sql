IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListRefusedByOtherCenterSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListRefusedByOtherCenterSelect'
		DROP Procedure TcssListRefusedByOtherCenterSelect
	END
GO

PRINT 'Creating Procedure TcssListRefusedByOtherCenterSelect'
GO

CREATE PROCEDURE dbo.TcssListRefusedByOtherCenterSelect
AS

/***************************************************************************************************
**	Name: TcssListRefusedByOtherCenterSelect
**	Desc: Update Data in table TcssListRefusedByOtherCenter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlrboc.TcssListRefusedByOtherCenterId AS ListId,
	tlrboc.FieldValue AS FieldValue
FROM dbo.TcssListRefusedByOtherCenter tlrboc with (nolock)
ORDER BY tlrboc.SortOrder, tlrboc.FieldValue
GO

GRANT EXEC ON TcssListRefusedByOtherCenterSelect TO PUBLIC
GO
