/***************************************************************************************************
**	Name: TcssDonorStatusInformation
**	Desc: Creates new table TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorStatusInformation')
BEGIN
	-- DROP TABLE dbo.TcssDonorStatusInformation
	PRINT 'Creating table TcssDonorStatusInformation'
	CREATE TABLE dbo.TcssDonorStatusInformation
	(
		TcssDonorStatusInformationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		DateTime smalldatetime NULL,
		StatEmployeeId int NULL,
		TcssListStatusId int NULL,
		Comment varchar(200) NULL
	)
END
GO

GRANT SELECT ON TcssDonorStatusInformation TO PUBLIC
GO
