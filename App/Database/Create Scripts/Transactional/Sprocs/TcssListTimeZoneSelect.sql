IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListTimeZoneSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListTimeZoneSelect'
		DROP Procedure TcssListTimeZoneSelect
	END
GO

PRINT 'Creating Procedure TcssListTimeZoneSelect'
GO

CREATE PROCEDURE dbo.TcssListTimeZoneSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListTimeZoneSelect
**	Desc: Update Data in table TcssListTimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tltz.TcssListTimeZoneId AS ListId,
	tltz.FieldValue AS FieldValue
FROM dbo.TcssListTimeZone tltz with (nolock)
WHERE
	(@ListId IS NULL OR tltz.TcssListTimeZoneId = @ListId)
	AND (@FieldValue IS NULL OR tltz.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tltz.UnosValue = @UnosValue)
ORDER BY tltz.SortOrder, tltz.FieldValue
GO

GRANT EXEC ON TcssListTimeZoneSelect TO PUBLIC
GO
