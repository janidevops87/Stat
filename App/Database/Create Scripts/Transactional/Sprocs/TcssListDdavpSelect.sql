IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDdavpSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDdavpSelect'
		DROP Procedure TcssListDdavpSelect
	END
GO

PRINT 'Creating Procedure TcssListDdavpSelect'
GO

CREATE PROCEDURE dbo.TcssListDdavpSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDdavpSelect
**	Desc: Update Data in table TcssListDdavp
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tld.TcssListDdavpId AS ListId,
	tld.FieldValue AS FieldValue
FROM dbo.TcssListDdavp tld with (nolock)
WHERE
	(@ListId IS NULL OR tld.TcssListDdavpId = @ListId)
	AND (@FieldValue IS NULL OR tld.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tld.UnosValue = @UnosValue)
ORDER BY tld.SortOrder, tld.FieldValue
GO

GRANT EXEC ON TcssListDdavpSelect TO PUBLIC
GO
