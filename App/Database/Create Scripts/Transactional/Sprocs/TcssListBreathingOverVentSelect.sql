IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListBreathingOverVentSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListBreathingOverVentSelect'
		DROP Procedure TcssListBreathingOverVentSelect
	END
GO

PRINT 'Creating Procedure TcssListBreathingOverVentSelect'
GO

CREATE PROCEDURE dbo.TcssListBreathingOverVentSelect
AS

/***************************************************************************************************
**	Name: TcssListBreathingOverVentSelect
**	Desc: Update Data in table TcssListBreathingOverVent
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlbov.TcssListBreathingOverVentId AS ListId,
	tlbov.FieldValue AS FieldValue
FROM dbo.TcssListBreathingOverVent tlbov with (nolock)
ORDER BY tlbov.SortOrder, tlbov.FieldValue
GO

GRANT EXEC ON TcssListBreathingOverVentSelect TO PUBLIC
GO
