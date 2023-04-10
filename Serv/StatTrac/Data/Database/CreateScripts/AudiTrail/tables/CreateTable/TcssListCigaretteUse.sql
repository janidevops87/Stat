/***************************************************************************************************
**	Name: TcssListCigaretteUse
**	Desc: Creates new table TcssListCigaretteUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCigaretteUse')
BEGIN
	-- DROP TABLE dbo.TcssListCigaretteUse
	PRINT 'Creating table TcssListCigaretteUse'
	CREATE TABLE dbo.TcssListCigaretteUse
	(
		TcssListCigaretteUseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCigaretteUse TO PUBLIC
GO
