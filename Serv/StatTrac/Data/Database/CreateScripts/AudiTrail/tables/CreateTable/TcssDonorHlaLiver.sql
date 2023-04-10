/***************************************************************************************************
**	Name: TcssDonorHlaLiver
**	Desc: Creates new table TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorHlaLiver')
BEGIN
	-- DROP TABLE dbo.TcssDonorHlaLiver
	PRINT 'Creating table TcssDonorHlaLiver'
	CREATE TABLE dbo.TcssDonorHlaLiver
	(
		TcssDonorHlaLiverId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListPreliminaryCrossmatchId int NULL,
		PreAdmissionHistory varchar(500) NULL,
		TcssListHlaA1Id int NULL,
		TcssListHlaA2Id int NULL,
		TcssListHlaB1Id int NULL,
		TcssListHlaB2Id int NULL,
		TcssListHlaBw4Id int NULL,
		TcssListHlaBw6Id int NULL,
		TcssListHlaC1Id int NULL,
		TcssListHlaC2Id int NULL,
		TcssListHlaDr1Id int NULL,
		TcssListHlaDr2Id int NULL,
		TcssListHlaDr51Id int NULL,
		TcssListHlaDr52Id int NULL,
		TcssListHlaDr53Id int NULL,
		TcssListHlaDq1Id int NULL,
		TcssListHlaDq2Id int NULL
	)
END
GO

GRANT SELECT ON TcssDonorHlaLiver TO PUBLIC
GO
