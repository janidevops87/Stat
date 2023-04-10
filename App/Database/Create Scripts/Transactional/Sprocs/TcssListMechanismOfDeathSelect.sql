IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListMechanismOfDeathSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListMechanismOfDeathSelect'
		DROP Procedure TcssListMechanismOfDeathSelect
	END
GO

PRINT 'Creating Procedure TcssListMechanismOfDeathSelect'
GO

CREATE PROCEDURE dbo.TcssListMechanismOfDeathSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListMechanismOfDeathSelect
**	Desc: Update Data in table TcssListMechanismOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlmod.TcssListMechanismOfDeathId AS ListId,
	tlmod.FieldValue AS FieldValue
FROM dbo.TcssListMechanismOfDeath tlmod with (nolock)
WHERE
	(@ListId IS NULL OR tlmod.TcssListMechanismOfDeathId = @ListId)
	AND (@FieldValue IS NULL OR tlmod.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlmod.UnosValue = @UnosValue)
ORDER BY tlmod.SortOrder, tlmod.FieldValue
GO

GRANT EXEC ON TcssListMechanismOfDeathSelect TO PUBLIC
GO
