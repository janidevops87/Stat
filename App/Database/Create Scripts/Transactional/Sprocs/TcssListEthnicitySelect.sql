IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListEthnicitySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListEthnicitySelect'
		DROP Procedure TcssListEthnicitySelect
	END
GO

PRINT 'Creating Procedure TcssListEthnicitySelect'
GO

CREATE PROCEDURE dbo.TcssListEthnicitySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListEthnicitySelect
**	Desc: Update Data in table TcssListEthnicity
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tle.TcssListEthnicityId AS ListId,
	tle.FieldValue AS FieldValue
FROM dbo.TcssListEthnicity tle with (nolock)
WHERE
	(@ListId IS NULL OR tle.TcssListEthnicityId = @ListId)
	AND (@FieldValue IS NULL OR tle.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tle.UnosValue = @UnosValue)
ORDER BY tle.SortOrder, tle.FieldValue
GO

GRANT EXEC ON TcssListEthnicitySelect TO PUBLIC
GO
