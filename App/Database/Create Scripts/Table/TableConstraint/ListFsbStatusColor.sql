/***************************************************************************************************
**	Name: ListFsbStatusColor
**	Desc: Add Primary keys, Unique keys, and Default Keys to ListFsbStatusColor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_ListFsbStatusColor')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_ListFsbStatusColor'
	ALTER TABLE dbo.ListFsbStatusColor ADD CONSTRAINT PK_ListFsbStatusColor PRIMARY KEY Clustered (ListFsbStatusColorId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_ListFsbStatusColor_FieldValue')
BEGIN
	PRINT 'Creating Unique Constraint IX_ListFsbStatusColor_FieldValue'
	CREATE UNIQUE NonClustered INDEX IX_ListFsbStatusColor_FieldValue ON dbo.ListFsbStatusColor (FieldValue) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatusColor_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatusColor_LastModified'
	ALTER TABLE dbo.ListFsbStatusColor ADD CONSTRAINT DF_ListFsbStatusColor_LastModified DEFAULT(GetUtcDate()) FOR LastModified
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ListFsbStatusColor_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_ListFsbStatusColor_IsActive'
	ALTER TABLE dbo.ListFsbStatusColor ADD CONSTRAINT DF_ListFsbStatusColor_IsActive DEFAULT(1) FOR IsActive
END
GO
