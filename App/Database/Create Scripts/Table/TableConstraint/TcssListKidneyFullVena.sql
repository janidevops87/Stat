/***************************************************************************************************
**	Name: TcssListKidneyFullVena
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyFullVena
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyFullVena')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyFullVena'
	ALTER TABLE dbo.TcssListKidneyFullVena ADD CONSTRAINT PK_TcssListKidneyFullVena PRIMARY KEY Clustered (TcssListKidneyFullVenaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFullVena_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFullVena_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyFullVena ADD CONSTRAINT DF_TcssListKidneyFullVena_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFullVena_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFullVena_SortOrder'
	ALTER TABLE dbo.TcssListKidneyFullVena ADD CONSTRAINT DF_TcssListKidneyFullVena_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFullVena_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFullVena_IsActive'
	ALTER TABLE dbo.TcssListKidneyFullVena ADD CONSTRAINT DF_TcssListKidneyFullVena_IsActive DEFAULT(1) FOR IsActive
END
GO
