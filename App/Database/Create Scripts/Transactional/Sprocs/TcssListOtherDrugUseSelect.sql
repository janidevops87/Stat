IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListOtherDrugUseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListOtherDrugUseSelect'
		DROP Procedure TcssListOtherDrugUseSelect
	END
GO

PRINT 'Creating Procedure TcssListOtherDrugUseSelect'
GO

CREATE PROCEDURE dbo.TcssListOtherDrugUseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListOtherDrugUseSelect
**	Desc: Update Data in table TcssListOtherDrugUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlodu.TcssListOtherDrugUseId AS ListId,
	tlodu.FieldValue AS FieldValue
FROM dbo.TcssListOtherDrugUse tlodu with (nolock)
WHERE
	(@ListId IS NULL OR tlodu.TcssListOtherDrugUseId = @ListId)
	AND (@FieldValue IS NULL OR tlodu.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlodu.UnosValue = @UnosValue)
ORDER BY tlodu.SortOrder, tlodu.FieldValue
GO

GRANT EXEC ON TcssListOtherDrugUseSelect TO PUBLIC
GO
