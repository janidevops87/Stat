/***************************************************************************************************
**	Name: TcssListDdavp
**	Desc: Creates new table TcssListDdavp
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDdavp')
BEGIN
	-- DROP TABLE dbo.TcssListDdavp
	PRINT 'Creating table TcssListDdavp'
	CREATE TABLE dbo.TcssListDdavp
	(
		TcssListDdavpId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDdavp TO PUBLIC
GO
