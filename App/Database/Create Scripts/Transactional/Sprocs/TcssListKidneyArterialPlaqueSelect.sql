IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyArterialPlaqueSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyArterialPlaqueSelect'
		DROP Procedure TcssListKidneyArterialPlaqueSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyArterialPlaqueSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyArterialPlaqueSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyArterialPlaqueSelect
**	Desc: Update Data in table TcssListKidneyArterialPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkap.TcssListKidneyArterialPlaqueId AS ListId,
	tlkap.FieldValue AS FieldValue
FROM dbo.TcssListKidneyArterialPlaque tlkap with (nolock)
WHERE
	(@ListId IS NULL OR tlkap.TcssListKidneyArterialPlaqueId = @ListId)
	AND (@FieldValue IS NULL OR tlkap.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkap.UnosValue = @UnosValue)
ORDER BY tlkap.SortOrder, tlkap.FieldValue
GO

GRANT EXEC ON TcssListKidneyArterialPlaqueSelect TO PUBLIC
GO
