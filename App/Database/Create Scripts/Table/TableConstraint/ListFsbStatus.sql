/***************************************************************************************************
**	Name: ListFsbStatus
**	Desc: Add Primary keys, Unique keys, and Default Keys to ListFsbStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_ListFsbStatus')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_ListFsbStatus'
	ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT PK_ListFsbStatus PRIMARY KEY Clustered (ListFsbStatusId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_ListFsbStatus_FieldValue')
BEGIN
	PRINT 'Creating Unique Constraint IX_ListFsbStatus_FieldValue'
	CREATE UNIQUE NonClustered INDEX IX_ListFsbStatus_FieldValue ON dbo.ListFsbStatus (FieldValue) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatus_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatus_LastModified'
	ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT DF_ListFsbStatus_LastModified DEFAULT(GetUtcDate()) FOR LastModified
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatus_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatus_IsActive'
	ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT DF_ListFsbStatus_IsActive DEFAULT(1) FOR IsActive
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatus_ListFsbStatusColorId')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatus_ListFsbStatusColorId'
	ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT DF_ListFsbStatus_ListFsbStatusColorId DEFAULT(1) FOR ListFsbStatusColorId
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatus_ThresholdMinutes')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatus_ThresholdMinutes'
	ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT DF_ListFsbStatus_ThresholdMinutes DEFAULT(0) FOR ThresholdMinutes
END
GO
