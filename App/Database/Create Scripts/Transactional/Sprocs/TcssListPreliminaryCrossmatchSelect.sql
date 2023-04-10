IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListPreliminaryCrossmatchSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListPreliminaryCrossmatchSelect'
		DROP Procedure TcssListPreliminaryCrossmatchSelect
	END
GO

PRINT 'Creating Procedure TcssListPreliminaryCrossmatchSelect'
GO

CREATE PROCEDURE dbo.TcssListPreliminaryCrossmatchSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListPreliminaryCrossmatchSelect
**	Desc: Update Data in table TcssListPreliminaryCrossmatch
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlpc.TcssListPreliminaryCrossmatchId AS ListId,
	tlpc.FieldValue AS FieldValue
FROM dbo.TcssListPreliminaryCrossmatch tlpc with (nolock)
WHERE
	(@ListId IS NULL OR tlpc.TcssListPreliminaryCrossmatchId = @ListId)
	AND (@FieldValue IS NULL OR tlpc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlpc.UnosValue = @UnosValue)
ORDER BY tlpc.SortOrder, tlpc.FieldValue
GO

GRANT EXEC ON TcssListPreliminaryCrossmatchSelect TO PUBLIC
GO
