IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListOfferStatusSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListOfferStatusSelect'
		DROP Procedure TcssListOfferStatusSelect
	END
GO

PRINT 'Creating Procedure TcssListOfferStatusSelect'
GO

CREATE PROCEDURE dbo.TcssListOfferStatusSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListOfferStatusSelect
**	Desc: Update Data in table TcssListOfferStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlos.TcssListOfferStatusId AS ListId,
	tlos.FieldValue AS FieldValue
FROM dbo.TcssListOfferStatus tlos with (nolock)
WHERE
	(@ListId IS NULL OR tlos.TcssListOfferStatusId = @ListId)
	AND (@FieldValue IS NULL OR tlos.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlos.UnosValue = @UnosValue)
ORDER BY tlos.SortOrder, tlos.FieldValue
GO

GRANT EXEC ON TcssListOfferStatusSelect TO PUBLIC
GO
