IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListVentSettingModeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListVentSettingModeSelect'
		DROP Procedure TcssListVentSettingModeSelect
	END
GO

PRINT 'Creating Procedure TcssListVentSettingModeSelect'
GO

CREATE PROCEDURE dbo.TcssListVentSettingModeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListVentSettingModeSelect
**	Desc: Update Data in table TcssListVentSettingMode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlvsm.TcssListVentSettingModeId AS ListId,
	tlvsm.FieldValue AS FieldValue
FROM dbo.TcssListVentSettingMode tlvsm with (nolock)
WHERE
	(@ListId IS NULL OR tlvsm.TcssListVentSettingModeId = @ListId)
	AND (@FieldValue IS NULL OR tlvsm.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlvsm.UnosValue = @UnosValue)
ORDER BY tlvsm.SortOrder, tlvsm.FieldValue
GO

GRANT EXEC ON TcssListVentSettingModeSelect TO PUBLIC
GO
