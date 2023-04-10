IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListVitalSignSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListVitalSignSelect'
		DROP Procedure TcssListVitalSignSelect
	END
GO

PRINT 'Creating Procedure TcssListVitalSignSelect'
GO

CREATE PROCEDURE dbo.TcssListVitalSignSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListVitalSignSelect
**	Desc: Update Data in table TcssListVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlvs.TcssListVitalSignId AS ListId,
	tlvs.FieldValue AS FieldValue,
	tlvs.IsLiver,
	tlvs.IsKidney,
	tlvs.IsLung,
	tlvs.IsHeart,
	tlvs.IsIntestine,
	tlvs.IsPancreas,
	tlvs.IsHeartLung,
	tlvs.IsKidneyPancreas,
	tlvs.IsMultiOrgan
FROM dbo.TcssListVitalSign tlvs with (nolock)
WHERE
	(@ListId IS NULL OR tlvs.TcssListVitalSignId = @ListId)
	AND (@FieldValue IS NULL OR tlvs.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlvs.UnosValue = @UnosValue)
ORDER BY tlvs.SortOrder, tlvs.FieldValue
GO

GRANT EXEC ON TcssListVitalSignSelect TO PUBLIC
GO
