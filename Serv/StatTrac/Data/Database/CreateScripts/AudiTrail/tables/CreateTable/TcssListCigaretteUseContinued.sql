/***************************************************************************************************
**	Name: TcssListCigaretteUseContinued
**	Desc: Creates new table TcssListCigaretteUseContinued
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCigaretteUseContinued')
BEGIN
	-- DROP TABLE dbo.TcssListCigaretteUseContinued
	PRINT 'Creating table TcssListCigaretteUseContinued'
	CREATE TABLE dbo.TcssListCigaretteUseContinued
	(
		TcssListCigaretteUseContinuedId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCigaretteUseContinued TO PUBLIC
GO
