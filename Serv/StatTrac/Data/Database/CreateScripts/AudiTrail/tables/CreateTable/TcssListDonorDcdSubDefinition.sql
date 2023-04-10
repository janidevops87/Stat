/***************************************************************************************************
**	Name: TcssListDonorDcdSubDefinition
**	Desc: Creates new table TcssListDonorDcdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDonorDcdSubDefinition')
BEGIN
	-- DROP TABLE dbo.TcssListDonorDcdSubDefinition
	PRINT 'Creating table TcssListDonorDcdSubDefinition'
	CREATE TABLE dbo.TcssListDonorDcdSubDefinition
	(
		TcssListDonorDcdSubDefinitionId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDonorDcdSubDefinition TO PUBLIC
GO
