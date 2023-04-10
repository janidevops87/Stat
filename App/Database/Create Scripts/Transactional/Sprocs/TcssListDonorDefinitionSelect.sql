IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorDefinitionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorDefinitionSelect'
		DROP Procedure TcssListDonorDefinitionSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorDefinitionSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorDefinitionSelect
AS

/***************************************************************************************************
**	Name: TcssListDonorDefinitionSelect
**	Desc: Update Data in table TcssListDonorDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldd.TcssListDonorDefinitionId AS ListId,
	tldd.FieldValue AS FieldValue
FROM dbo.TcssListDonorDefinition tldd with (nolock)
ORDER BY tldd.SortOrder, tldd.FieldValue
GO

GRANT EXEC ON TcssListDonorDefinitionSelect TO PUBLIC
GO
