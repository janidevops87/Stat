IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCircumstancesOfDeathSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCircumstancesOfDeathSelect'
		DROP Procedure TcssListCircumstancesOfDeathSelect
	END
GO

PRINT 'Creating Procedure TcssListCircumstancesOfDeathSelect'
GO

CREATE PROCEDURE dbo.TcssListCircumstancesOfDeathSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCircumstancesOfDeathSelect
**	Desc: Update Data in table TcssListCircumstancesOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcod.TcssListCircumstancesOfDeathId AS ListId,
	tlcod.FieldValue AS FieldValue
FROM dbo.TcssListCircumstancesOfDeath tlcod with (nolock)
WHERE
	(@ListId IS NULL OR tlcod.TcssListCircumstancesOfDeathId = @ListId)
	AND (@FieldValue IS NULL OR tlcod.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcod.UnosValue = @UnosValue)
ORDER BY tlcod.SortOrder, tlcod.FieldValue
GO

GRANT EXEC ON TcssListCircumstancesOfDeathSelect TO PUBLIC
GO
