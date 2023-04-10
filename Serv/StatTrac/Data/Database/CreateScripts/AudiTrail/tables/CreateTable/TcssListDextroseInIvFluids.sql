/***************************************************************************************************
**	Name: TcssListDextroseInIvFluids
**	Desc: Creates new table TcssListDextroseInIvFluids
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDextroseInIvFluids')
BEGIN
	-- DROP TABLE dbo.TcssListDextroseInIvFluids
	PRINT 'Creating table TcssListDextroseInIvFluids'
	CREATE TABLE dbo.TcssListDextroseInIvFluids
	(
		TcssListDextroseInIvFluidsId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDextroseInIvFluids TO PUBLIC
GO
