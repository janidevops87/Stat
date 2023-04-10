IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyPumpSolutionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyPumpSolutionSelect'
		DROP Procedure TcssListKidneyPumpSolutionSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyPumpSolutionSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyPumpSolutionSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyPumpSolutionSelect
**	Desc: Update Data in table TcssListKidneyPumpSolution
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkps.TcssListKidneyPumpSolutionId AS ListId,
	tlkps.FieldValue AS FieldValue
FROM dbo.TcssListKidneyPumpSolution tlkps with (nolock)
WHERE
	(@ListId IS NULL OR tlkps.TcssListKidneyPumpSolutionId = @ListId)
	AND (@FieldValue IS NULL OR tlkps.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkps.UnosValue = @UnosValue)
ORDER BY tlkps.SortOrder, tlkps.FieldValue
GO

GRANT EXEC ON TcssListKidneyPumpSolutionSelect TO PUBLIC
GO
