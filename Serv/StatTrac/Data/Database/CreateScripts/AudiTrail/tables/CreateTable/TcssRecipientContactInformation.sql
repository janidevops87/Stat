/***************************************************************************************************
**	Name: TcssRecipientContactInformation
**	Desc: Creates new table TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientContactInformation')
BEGIN
	-- DROP TABLE dbo.TcssRecipientContactInformation
	PRINT 'Creating table TcssRecipientContactInformation'
	CREATE TABLE dbo.TcssRecipientContactInformation
	(
		TcssRecipientContactInformationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NULL,
		OpoContact varchar(50) NULL,
		TransplantSurgeonContact varchar(50) NULL,
		ClinicalCoordinator varchar(50) NULL
	)
END
GO

GRANT SELECT ON TcssRecipientContactInformation TO PUBLIC
GO
