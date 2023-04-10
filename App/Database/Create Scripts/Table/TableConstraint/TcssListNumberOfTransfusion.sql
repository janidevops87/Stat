/***************************************************************************************************
**	Name: TcssListNumberOfTransfusion
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListNumberOfTransfusion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListNumberOfTransfusion')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListNumberOfTransfusion'
	ALTER TABLE dbo.TcssListNumberOfTransfusion ADD CONSTRAINT PK_TcssListNumberOfTransfusion PRIMARY KEY Clustered (TcssListNumberOfTransfusionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListNumberOfTransfusion_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListNumberOfTransfusion_LastUpdateDate'
	ALTER TABLE dbo.TcssListNumberOfTransfusion ADD CONSTRAINT DF_TcssListNumberOfTransfusion_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListNumberOfTransfusion_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListNumberOfTransfusion_SortOrder'
	ALTER TABLE dbo.TcssListNumberOfTransfusion ADD CONSTRAINT DF_TcssListNumberOfTransfusion_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListNumberOfTransfusion_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListNumberOfTransfusion_IsActive'
	ALTER TABLE dbo.TcssListNumberOfTransfusion ADD CONSTRAINT DF_TcssListNumberOfTransfusion_IsActive DEFAULT(1) FOR IsActive
END
GO
