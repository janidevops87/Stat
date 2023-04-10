IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorDbdSubDefinitionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorDbdSubDefinitionSelect'
		DROP Procedure TcssListDonorDbdSubDefinitionSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorDbdSubDefinitionSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorDbdSubDefinitionSelect
AS

/***************************************************************************************************
**	Name: TcssListDonorDbdSubDefinitionSelect
**	Desc: Update Data in table TcssListDonorDbdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlddsd.TcssListDonorDbdSubDefinitionId AS ListId,
	tlddsd.FieldValue AS FieldValue
FROM dbo.TcssListDonorDbdSubDefinition tlddsd with (nolock)
ORDER BY tlddsd.SortOrder, tlddsd.FieldValue
GO

GRANT EXEC ON TcssListDonorDbdSubDefinitionSelect TO PUBLIC
GO
