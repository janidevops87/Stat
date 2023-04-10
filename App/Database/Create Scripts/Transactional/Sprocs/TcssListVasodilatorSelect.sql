IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListVasodilatorSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListVasodilatorSelect'
		DROP Procedure TcssListVasodilatorSelect
	END
GO

PRINT 'Creating Procedure TcssListVasodilatorSelect'
GO

CREATE PROCEDURE dbo.TcssListVasodilatorSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListVasodilatorSelect
**	Desc: Update Data in table TcssListVasodilator
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlv.TcssListVasodilatorId AS ListId,
	tlv.FieldValue AS FieldValue
FROM dbo.TcssListVasodilator tlv with (nolock)
WHERE
	(@ListId IS NULL OR tlv.TcssListVasodilatorId = @ListId)
	AND (@FieldValue IS NULL OR tlv.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlv.UnosValue = @UnosValue)
ORDER BY tlv.SortOrder, tlv.FieldValue
GO

GRANT EXEC ON TcssListVasodilatorSelect TO PUBLIC
GO
