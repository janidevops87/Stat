IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListRefusalReasonSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListRefusalReasonSelect'
		DROP Procedure TcssListRefusalReasonSelect
	END
GO

PRINT 'Creating Procedure TcssListRefusalReasonSelect'
GO

CREATE PROCEDURE dbo.TcssListRefusalReasonSelect
AS

/***************************************************************************************************
**	Name: TcssListRefusalReasonSelect
**	Desc: Update Data in table TcssListRefusalReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlrr.TcssListRefusalReasonId AS ListId,
	tlrr.FieldValue AS FieldValue
FROM dbo.TcssListRefusalReason tlrr with (nolock)
ORDER BY tlrr.SortOrder, tlrr.FieldValue
GO

GRANT EXEC ON TcssListRefusalReasonSelect TO PUBLIC
GO
