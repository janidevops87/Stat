IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListGenderSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListGenderSelect'
		DROP Procedure TcssListGenderSelect
	END
GO

PRINT 'Creating Procedure TcssListGenderSelect'
GO

CREATE PROCEDURE dbo.TcssListGenderSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListGenderSelect
**	Desc: Update Data in table TcssListGender
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlg.TcssListGenderId AS ListId,
	tlg.FieldValue AS FieldValue
FROM dbo.TcssListGender tlg with (nolock)
WHERE
	(@ListId IS NULL OR tlg.TcssListGenderId = @ListId)
	AND (@FieldValue IS NULL OR tlg.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlg.UnosValue = @UnosValue)
ORDER BY tlg.SortOrder, tlg.FieldValue
GO

GRANT EXEC ON TcssListGenderSelect TO PUBLIC
GO
