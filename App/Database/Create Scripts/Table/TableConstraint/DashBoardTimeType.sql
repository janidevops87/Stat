 /***************************************************************************************************
**	Name: DashBoardTimerType
**	Desc: Add Primary keys, Unique keys, and Default Keys to DashBoardTimerType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DashBoardTimerType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DashBoardTimerType'
	ALTER TABLE dbo.DashBoardTimerType ADD CONSTRAINT PK_DashBoardTimerType PRIMARY KEY Clustered (DashBoardTimerTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DashBoardTimerType_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_DashBoardTimerType_LastModified'
	ALTER TABLE dbo.DashBoardTimerType ADD CONSTRAINT DF_DashBoardTimerType_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
