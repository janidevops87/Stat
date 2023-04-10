/***************************************************************************************************
**	Name: TcssRecipient
**	Desc: Creates new table TcssRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipient')
BEGIN
	-- DROP TABLE dbo.TcssRecipient
	PRINT 'Creating table TcssRecipient'
	CREATE TABLE dbo.TcssRecipient
	(
		TcssRecipientId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL
	)
END
GO

GRANT SELECT ON TcssRecipient TO PUBLIC
GO
