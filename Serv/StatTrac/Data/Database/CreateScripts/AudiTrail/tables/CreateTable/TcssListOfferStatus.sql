/***************************************************************************************************
**	Name: TcssListOfferStatus
**	Desc: Creates new table TcssListOfferStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListOfferStatus')
BEGIN
	-- DROP TABLE dbo.TcssListOfferStatus
	PRINT 'Creating table TcssListOfferStatus'
	CREATE TABLE dbo.TcssListOfferStatus
	(
		TcssListOfferStatusId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListOfferStatus TO PUBLIC
GO
