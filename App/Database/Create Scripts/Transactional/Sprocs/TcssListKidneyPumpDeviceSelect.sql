IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyPumpDeviceSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyPumpDeviceSelect'
		DROP Procedure TcssListKidneyPumpDeviceSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyPumpDeviceSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyPumpDeviceSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyPumpDeviceSelect
**	Desc: Update Data in table TcssListKidneyPumpDevice
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkpd.TcssListKidneyPumpDeviceId AS ListId,
	tlkpd.FieldValue AS FieldValue
FROM dbo.TcssListKidneyPumpDevice tlkpd with (nolock)
WHERE
	(@ListId IS NULL OR tlkpd.TcssListKidneyPumpDeviceId = @ListId)
	AND (@FieldValue IS NULL OR tlkpd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkpd.UnosValue = @UnosValue)
ORDER BY tlkpd.SortOrder, tlkpd.FieldValue
GO

GRANT EXEC ON TcssListKidneyPumpDeviceSelect TO PUBLIC
GO
