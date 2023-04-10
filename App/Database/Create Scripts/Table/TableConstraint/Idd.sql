 /***************************************************************************************************
**	Name: Idd
**	Desc: Add Primary keys, Unique keys, and Default Keys to Idd
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Idd')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_Idd'
	ALTER TABLE dbo.Idd ADD CONSTRAINT PK_Idd PRIMARY KEY Clustered (IddId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Idd_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_Idd_LastModified'
	ALTER TABLE dbo.Idd ADD CONSTRAINT DF_Idd_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
