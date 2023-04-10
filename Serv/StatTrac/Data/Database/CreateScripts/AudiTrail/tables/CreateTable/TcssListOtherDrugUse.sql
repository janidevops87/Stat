/***************************************************************************************************
**	Name: TcssListOtherDrugUse
**	Desc: Creates new table TcssListOtherDrugUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListOtherDrugUse')
BEGIN
	-- DROP TABLE dbo.TcssListOtherDrugUse
	PRINT 'Creating table TcssListOtherDrugUse'
	CREATE TABLE dbo.TcssListOtherDrugUse
	(
		TcssListOtherDrugUseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListOtherDrugUse TO PUBLIC
GO
