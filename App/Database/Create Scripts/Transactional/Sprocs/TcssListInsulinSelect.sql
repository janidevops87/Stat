IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListInsulinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListInsulinSelect'
		DROP Procedure TcssListInsulinSelect
	END
GO

PRINT 'Creating Procedure TcssListInsulinSelect'
GO

CREATE PROCEDURE dbo.TcssListInsulinSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListInsulinSelect
**	Desc: Update Data in table TcssListInsulin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tli.TcssListInsulinId AS ListId,
	tli.FieldValue AS FieldValue
FROM dbo.TcssListInsulin tli with (nolock)
WHERE
	(@ListId IS NULL OR tli.TcssListInsulinId = @ListId)
	AND (@FieldValue IS NULL OR tli.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tli.UnosValue = @UnosValue)
ORDER BY tli.SortOrder, tli.FieldValue
GO

GRANT EXEC ON TcssListInsulinSelect TO PUBLIC
GO
