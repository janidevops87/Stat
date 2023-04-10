/***************************************************************************************************
**	Name: TcssRecipientHlaLiver
**	Desc: Creates new table TcssRecipientHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientHlaLiver')
BEGIN
	-- DROP TABLE dbo.TcssRecipientHlaLiver
	PRINT 'Creating table TcssRecipientHlaLiver'
	CREATE TABLE dbo.TcssRecipientHlaLiver
	(
		TcssRecipientHlaLiverId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NULL,
		TxCenter varchar(50) NULL,
		SsnNum char(9) NULL,
		Score varchar(50) NULL,
		OtherOrgans varchar(50) NULL,
		PraPeak varchar(50) NULL,
		PraCurrent varchar(50) NULL,
		PraUsedByMatch varchar(50) NULL,
		MisMatchA varchar(50) NULL,
		MisMatchB varchar(50) NULL,
		MisMatchDr varchar(50) NULL,
		RecipientAboId int NULL,
		RecipientDateOfBirth smalldatetime NULL,
		RecipientAge int NULL,
		RecipientAgeUnitId int NULL,
		RecipientGenderId int NULL,
		RecipientHeight int NULL,
		RecipientWeight decimal NULL,
		TcssListScdId int NULL
	)
END
GO

GRANT SELECT ON TcssRecipientHlaLiver TO PUBLIC
GO
