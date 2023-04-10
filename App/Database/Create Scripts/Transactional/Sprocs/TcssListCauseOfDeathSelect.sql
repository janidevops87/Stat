IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCauseOfDeathSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCauseOfDeathSelect'
		DROP Procedure TcssListCauseOfDeathSelect
	END
GO

PRINT 'Creating Procedure TcssListCauseOfDeathSelect'
GO

CREATE PROCEDURE dbo.TcssListCauseOfDeathSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCauseOfDeathSelect
**	Desc: Update Data in table TcssListCauseOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcod.TcssListCauseOfDeathId AS ListId,
	tlcod.FieldValue AS FieldValue
FROM dbo.TcssListCauseOfDeath tlcod with (nolock)
WHERE
	(@ListId IS NULL OR tlcod.TcssListCauseOfDeathId = @ListId)
	AND (@FieldValue IS NULL OR tlcod.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcod.UnosValue = @UnosValue)
ORDER BY tlcod.SortOrder, tlcod.FieldValue
GO

GRANT EXEC ON TcssListCauseOfDeathSelect TO PUBLIC
GO
