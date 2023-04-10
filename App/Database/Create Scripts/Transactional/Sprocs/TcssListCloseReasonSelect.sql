IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCloseReasonSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCloseReasonSelect'
		DROP Procedure TcssListCloseReasonSelect
	END
GO

PRINT 'Creating Procedure TcssListCloseReasonSelect'
GO

CREATE PROCEDURE dbo.TcssListCloseReasonSelect
AS

/***************************************************************************************************
**	Name: TcssListCloseReasonSelect
**	Desc: Update Data in table TcssListCloseReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcr.TcssListCloseReasonId AS ListId,
	tlcr.FieldValue AS FieldValue
FROM dbo.TcssListCloseReason tlcr with (nolock)
ORDER BY tlcr.SortOrder, tlcr.FieldValue
GO

GRANT EXEC ON TcssListCloseReasonSelect TO PUBLIC
GO
