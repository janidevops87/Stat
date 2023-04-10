IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHeparinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHeparinSelect'
		DROP Procedure TcssListHeparinSelect
	END
GO

PRINT 'Creating Procedure TcssListHeparinSelect'
GO

CREATE PROCEDURE dbo.TcssListHeparinSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHeparinSelect
**	Desc: Update Data in table TcssListHeparin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/12/2010	jth				Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlh.TcssListHeparinId AS ListId,
	tlh.FieldValue AS FieldValue
FROM dbo.TcssListHeparin tlh with (nolock)
WHERE
	(@ListId IS NULL OR tlh.TcssListHeparinId = @ListId)
	AND (@FieldValue IS NULL OR tlh.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlh.UnosValue = @UnosValue)
ORDER BY tlh.SortOrder, tlh.FieldValue
GO

GRANT EXEC ON TcssListHeparinSelect TO PUBLIC
GO
