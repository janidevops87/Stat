/***************************************************************************************************
**	Name: TcssListRefusedByOtherCenter
**	Desc: Creates new table TcssListRefusedByOtherCenter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListRefusedByOtherCenter')
BEGIN
	-- DROP TABLE dbo.TcssListRefusedByOtherCenter
	PRINT 'Creating table TcssListRefusedByOtherCenter'
	CREATE TABLE dbo.TcssListRefusedByOtherCenter
	(
		TcssListRefusedByOtherCenterId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListRefusedByOtherCenter TO PUBLIC
GO
