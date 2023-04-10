/***************************************************************************************************
**	Name: TcssListDiagnosisLungChestXray
**	Desc: Creates new table TcssListDiagnosisLungChestXray
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDiagnosisLungChestXray')
BEGIN
	-- DROP TABLE dbo.TcssListDiagnosisLungChestXray
	PRINT 'Creating table TcssListDiagnosisLungChestXray'
	CREATE TABLE dbo.TcssListDiagnosisLungChestXray
	(
		TcssListDiagnosisLungChestXrayId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDiagnosisLungChestXray TO PUBLIC
GO
