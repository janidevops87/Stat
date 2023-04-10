IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCardiacArrestDownTimeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCardiacArrestDownTimeSelect'
		DROP Procedure TcssListCardiacArrestDownTimeSelect
	END
GO

PRINT 'Creating Procedure TcssListCardiacArrestDownTimeSelect'
GO

CREATE PROCEDURE dbo.TcssListCardiacArrestDownTimeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCardiacArrestDownTimeSelect
**	Desc: Update Data in table TcssListCardiacArrestDownTime
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcadt.TcssListCardiacArrestDownTimeId AS ListId,
	tlcadt.FieldValue AS FieldValue
FROM dbo.TcssListCardiacArrestDownTime tlcadt with (nolock)
WHERE
	(@ListId IS NULL OR tlcadt.TcssListCardiacArrestDownTimeId = @ListId)
	AND (@FieldValue IS NULL OR tlcadt.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcadt.UnosValue = @UnosValue)
ORDER BY tlcadt.SortOrder, tlcadt.FieldValue
GO

GRANT EXEC ON TcssListCardiacArrestDownTimeSelect TO PUBLIC
GO
