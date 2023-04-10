/***************************************************************************************************
**	Name: TcssListKidneyUreterTissueQuality
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyUreterTissueQuality
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyUreterTissueQuality')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyUreterTissueQuality'
	ALTER TABLE dbo.TcssListKidneyUreterTissueQuality ADD CONSTRAINT PK_TcssListKidneyUreterTissueQuality PRIMARY KEY Clustered (TcssListKidneyUreterTissueQualityId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreterTissueQuality_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreterTissueQuality_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyUreterTissueQuality ADD CONSTRAINT DF_TcssListKidneyUreterTissueQuality_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreterTissueQuality_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreterTissueQuality_SortOrder'
	ALTER TABLE dbo.TcssListKidneyUreterTissueQuality ADD CONSTRAINT DF_TcssListKidneyUreterTissueQuality_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreterTissueQuality_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreterTissueQuality_IsActive'
	ALTER TABLE dbo.TcssListKidneyUreterTissueQuality ADD CONSTRAINT DF_TcssListKidneyUreterTissueQuality_IsActive DEFAULT(1) FOR IsActive
END
GO
