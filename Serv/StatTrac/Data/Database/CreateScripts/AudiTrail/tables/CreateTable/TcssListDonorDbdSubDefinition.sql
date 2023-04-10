/***************************************************************************************************
**	Name: TcssListDonorDbdSubDefinition
**	Desc: Creates new table TcssListDonorDbdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDonorDbdSubDefinition')
BEGIN
	-- DROP TABLE dbo.TcssListDonorDbdSubDefinition
	PRINT 'Creating table TcssListDonorDbdSubDefinition'
	CREATE TABLE dbo.TcssListDonorDbdSubDefinition
	(
		TcssListDonorDbdSubDefinitionId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDonorDbdSubDefinition TO PUBLIC
GO
