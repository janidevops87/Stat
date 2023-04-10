IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyInfarctedAreaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyInfarctedAreaSelect'
		DROP Procedure TcssListKidneyInfarctedAreaSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyInfarctedAreaSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyInfarctedAreaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyInfarctedAreaSelect
**	Desc: Update Data in table TcssListKidneyInfarctedArea
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkia.TcssListKidneyInfarctedAreaId AS ListId,
	tlkia.FieldValue AS FieldValue
FROM dbo.TcssListKidneyInfarctedArea tlkia with (nolock)
WHERE
	(@ListId IS NULL OR tlkia.TcssListKidneyInfarctedAreaId = @ListId)
	AND (@FieldValue IS NULL OR tlkia.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkia.UnosValue = @UnosValue)
ORDER BY tlkia.SortOrder, tlkia.FieldValue
GO

GRANT EXEC ON TcssListKidneyInfarctedAreaSelect TO PUBLIC
GO
