/***************************************************************************************************
**	Name: TcssListHeparin
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHeparin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/12/2010	jth				Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHeparin')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHeparin'
	ALTER TABLE dbo.TcssListHeparin ADD CONSTRAINT PK_TcssListHeparin PRIMARY KEY Clustered (TcssListHeparinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeparin_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeparin_LastUpdateDate'
	ALTER TABLE [dbo].[TcssListHeparin] ADD  CONSTRAINT [DF_TcssListHeparin_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]	
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeparin_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeparin_SortOrder'
	ALTER TABLE dbo.TcssListHeparin ADD CONSTRAINT DF_TcssListHeparin_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeparin_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeparin_IsActive'
	ALTER TABLE dbo.TcssListHeparin ADD CONSTRAINT DF_TcssListHeparin_IsActive DEFAULT(1) FOR IsActive
END
GO
