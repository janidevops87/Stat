/***************************************************************************************************
**	Name: TcssListDonorDefinition
**	Desc: Creates new table TcssListDonorDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDonorDefinition')
BEGIN
	-- DROP TABLE dbo.TcssListDonorDefinition
	PRINT 'Creating table TcssListDonorDefinition'
	CREATE TABLE dbo.TcssListDonorDefinition
	(
		TcssListDonorDefinitionId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDonorDefinition TO PUBLIC
GO
