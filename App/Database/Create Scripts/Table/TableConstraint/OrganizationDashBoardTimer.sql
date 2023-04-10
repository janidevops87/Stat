 /***************************************************************************************************
**	Name: OrganizationDashBoardTimer
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationDashBoardTimer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationDashBoardTimer')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationDashBoardTimer'
	ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT PK_OrganizationDashBoardTimer PRIMARY KEY Clustered (OrganizationDashBoardTimerId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationDashBoardTimer_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationDashBoardTimer_LastModified'
	ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT DF_OrganizationDashBoardTimer_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
