IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorDcdSubDefinitionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorDcdSubDefinitionSelect'
		DROP Procedure TcssListDonorDcdSubDefinitionSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorDcdSubDefinitionSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorDcdSubDefinitionSelect
AS

/***************************************************************************************************
**	Name: TcssListDonorDcdSubDefinitionSelect
**	Desc: Update Data in table TcssListDonorDcdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlddsd.TcssListDonorDcdSubDefinitionId AS ListId,
	tlddsd.FieldValue AS FieldValue
FROM dbo.TcssListDonorDcdSubDefinition tlddsd with (nolock)
ORDER BY tlddsd.SortOrder, tlddsd.FieldValue
GO

GRANT EXEC ON TcssListDonorDcdSubDefinitionSelect TO PUBLIC
GO
