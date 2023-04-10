/***************************************************************************************************
**	Name: TcssListArginineVasopressin
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListArginineVasopressin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListArginineVasopressin')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListArginineVasopressin'
	ALTER TABLE dbo.TcssListArginineVasopressin ADD CONSTRAINT PK_TcssListArginineVasopressin PRIMARY KEY Clustered (TcssListArginineVasopressinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListArginineVasopressin_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListArginineVasopressin_LastUpdateDate'
	ALTER TABLE dbo.TcssListArginineVasopressin ADD CONSTRAINT DF_TcssListArginineVasopressin_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListArginineVasopressin_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListArginineVasopressin_SortOrder'
	ALTER TABLE dbo.TcssListArginineVasopressin ADD CONSTRAINT DF_TcssListArginineVasopressin_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListArginineVasopressin_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListArginineVasopressin_IsActive'
	ALTER TABLE dbo.TcssListArginineVasopressin ADD CONSTRAINT DF_TcssListArginineVasopressin_IsActive DEFAULT(1) FOR IsActive
END
GO
