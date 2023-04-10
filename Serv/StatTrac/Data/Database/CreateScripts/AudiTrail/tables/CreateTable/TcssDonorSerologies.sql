/***************************************************************************************************
**	Name: TcssDonorSerologies
**	Desc: Creates new table TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorSerologies')
BEGIN
	-- DROP TABLE dbo.TcssDonorSerologies
	PRINT 'Creating table TcssDonorSerologies'
	CREATE TABLE dbo.TcssDonorSerologies
	(
		TcssDonorSerologiesId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListSerologyQuestionId int NULL,
		TcssListSerologyAnswerId int NULL
	)
END
GO

GRANT SELECT ON TcssDonorSerologies TO PUBLIC
GO
