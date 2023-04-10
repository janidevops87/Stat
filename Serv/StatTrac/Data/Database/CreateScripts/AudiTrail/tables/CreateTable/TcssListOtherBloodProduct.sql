/***************************************************************************************************
**	Name: TcssListOtherBloodProduct
**	Desc: Creates new table TcssListOtherBloodProduct
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListOtherBloodProduct')
BEGIN
	-- DROP TABLE dbo.TcssListOtherBloodProduct
	PRINT 'Creating table TcssListOtherBloodProduct'
	CREATE TABLE dbo.TcssListOtherBloodProduct
	(
		TcssListOtherBloodProductId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListOtherBloodProduct TO PUBLIC
GO
