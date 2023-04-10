IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListLabSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListLabSelect'
		DROP Procedure TcssListLabSelect
	END
GO

PRINT 'Creating Procedure TcssListLabSelect'
GO

CREATE PROCEDURE dbo.TcssListLabSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListLabSelect
**	Desc: Update Data in table TcssListLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tll.TcssListLabId AS ListId,
	tll.FieldValue AS FieldValue,
	tll.IsLiver,
	tll.IsKidney,
	tll.IsLung,
	tll.IsHeart,
	tll.IsIntestine,
	tll.IsPancreas,
	tll.IsHeartLung,
	tll.IsKidneyPancreas,
	tll.IsMultiOrgan
FROM dbo.TcssListLab tll with (nolock)
WHERE
	(@ListId IS NULL OR tll.TcssListLabId = @ListId)
	AND (@FieldValue IS NULL OR tll.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tll.UnosValue = @UnosValue)
ORDER BY tll.SortOrder, tll.FieldValue
GO

GRANT EXEC ON TcssListLabSelect TO PUBLIC
GO
