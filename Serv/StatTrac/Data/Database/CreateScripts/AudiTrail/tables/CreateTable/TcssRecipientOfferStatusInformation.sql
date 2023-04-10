/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformation
**	Desc: Creates new table TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientOfferStatusInformation')
BEGIN
	-- DROP TABLE dbo.TcssRecipientOfferStatusInformation
	PRINT 'Creating table TcssRecipientOfferStatusInformation'
	CREATE TABLE dbo.TcssRecipientOfferStatusInformation
	(
		TcssRecipientOfferStatusInformationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NULL,
		CoordinatorId int NULL,
		TcssListStatusId int NULL,
		Comment varchar(50) NULL
	)
END
GO
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssRecipientOfferStatusInformation') AND name = 'Comment')
BEGIN
	ALTER TABLE TcssRecipientOfferStatusInformation ALTER COLUMN Comment VARCHAR(200) 
END


GRANT SELECT ON TcssRecipientOfferStatusInformation TO PUBLIC
GO
