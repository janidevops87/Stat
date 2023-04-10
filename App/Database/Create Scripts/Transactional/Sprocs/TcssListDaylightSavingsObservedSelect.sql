IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDaylightSavingsObservedSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDaylightSavingsObservedSelect'
		DROP Procedure TcssListDaylightSavingsObservedSelect
	END
GO

PRINT 'Creating Procedure TcssListDaylightSavingsObservedSelect'
GO

CREATE PROCEDURE dbo.TcssListDaylightSavingsObservedSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDaylightSavingsObservedSelect
**	Desc: Update Data in table TcssListDaylightSavingsObserved
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldso.TcssListDaylightSavingsObservedId AS ListId,
	tldso.FieldValue AS FieldValue
FROM dbo.TcssListDaylightSavingsObserved tldso with (nolock)
WHERE
	(@ListId IS NULL OR tldso.TcssListDaylightSavingsObservedId = @ListId)
	AND (@FieldValue IS NULL OR tldso.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldso.UnosValue = @UnosValue)
ORDER BY tldso.SortOrder, tldso.FieldValue
GO

GRANT EXEC ON TcssListDaylightSavingsObservedSelect TO PUBLIC
GO
