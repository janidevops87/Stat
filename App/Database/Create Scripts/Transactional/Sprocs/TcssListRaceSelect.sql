IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListRaceSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListRaceSelect'
		DROP Procedure TcssListRaceSelect
	END
GO

PRINT 'Creating Procedure TcssListRaceSelect'
GO

CREATE PROCEDURE dbo.TcssListRaceSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListRaceSelect
**	Desc: Update Data in table TcssListRace
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlr.TcssListRaceId AS ListId,
	tlr.FieldValue AS FieldValue
FROM dbo.TcssListRace tlr with (nolock)
WHERE
	(@ListId IS NULL OR tlr.TcssListRaceId = @ListId)
	AND (@FieldValue IS NULL OR tlr.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlr.UnosValue = @UnosValue)
ORDER BY tlr.SortOrder, tlr.FieldValue
GO

GRANT EXEC ON TcssListRaceSelect TO PUBLIC
GO
