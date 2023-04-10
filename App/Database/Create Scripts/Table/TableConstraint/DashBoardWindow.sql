 /***************************************************************************************************
**	Name: DashBoardWindow
**	Desc: Add Primary keys, Unique keys, and Default Keys to DashBoardWindow
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DashBoardWindow')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DashBoardWindow'
	ALTER TABLE dbo.DashBoardWindow ADD CONSTRAINT PK_DashBoardWindow PRIMARY KEY Clustered (DashBoardWindowId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DashBoardWindow_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_DashBoardWindow_LastModified'
	ALTER TABLE dbo.DashBoardWindow ADD CONSTRAINT DF_DashBoardWindow_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
