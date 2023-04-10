/***************************************************************************************************
**	Name: TcssDonorToRecipient
**	Desc: Creates new table TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorToRecipient')
BEGIN
	-- DROP TABLE dbo.TcssDonorToRecipient
	PRINT 'Creating table TcssDonorToRecipient'
	CREATE TABLE dbo.TcssDonorToRecipient
	(
		TcssDonorToRecipientId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssRecipientId int NULL
	)
END
GO

GRANT SELECT ON TcssDonorToRecipient TO PUBLIC
GO
