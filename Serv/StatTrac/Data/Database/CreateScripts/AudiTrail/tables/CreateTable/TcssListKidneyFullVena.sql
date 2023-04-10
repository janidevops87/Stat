/***************************************************************************************************
**	Name: TcssListKidneyFullVena
**	Desc: Creates new table TcssListKidneyFullVena
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyFullVena')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyFullVena
	PRINT 'Creating table TcssListKidneyFullVena'
	CREATE TABLE dbo.TcssListKidneyFullVena
	(
		TcssListKidneyFullVenaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyFullVena TO PUBLIC
GO
