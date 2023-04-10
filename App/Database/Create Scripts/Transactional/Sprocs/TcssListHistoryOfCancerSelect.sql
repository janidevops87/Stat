IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHistoryOfCancerSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHistoryOfCancerSelect'
		DROP Procedure TcssListHistoryOfCancerSelect
	END
GO

PRINT 'Creating Procedure TcssListHistoryOfCancerSelect'
GO

CREATE PROCEDURE dbo.TcssListHistoryOfCancerSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHistoryOfCancerSelect
**	Desc: Update Data in table TcssListHistoryOfCancer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhoc.TcssListHistoryOfCancerId AS ListId,
	tlhoc.FieldValue AS FieldValue
FROM dbo.TcssListHistoryOfCancer tlhoc with (nolock)
WHERE
	(@ListId IS NULL OR tlhoc.TcssListHistoryOfCancerId = @ListId)
	AND (@FieldValue IS NULL OR tlhoc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhoc.UnosValue = @UnosValue)
ORDER BY tlhoc.SortOrder, tlhoc.FieldValue
GO

GRANT EXEC ON TcssListHistoryOfCancerSelect TO PUBLIC
GO
