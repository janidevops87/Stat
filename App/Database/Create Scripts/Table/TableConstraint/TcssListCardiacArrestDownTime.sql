/***************************************************************************************************
**	Name: TcssListCardiacArrestDownTime
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCardiacArrestDownTime
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCardiacArrestDownTime')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCardiacArrestDownTime'
	ALTER TABLE dbo.TcssListCardiacArrestDownTime ADD CONSTRAINT PK_TcssListCardiacArrestDownTime PRIMARY KEY Clustered (TcssListCardiacArrestDownTimeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCardiacArrestDownTime_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCardiacArrestDownTime_LastUpdateDate'
	ALTER TABLE dbo.TcssListCardiacArrestDownTime ADD CONSTRAINT DF_TcssListCardiacArrestDownTime_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCardiacArrestDownTime_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCardiacArrestDownTime_SortOrder'
	ALTER TABLE dbo.TcssListCardiacArrestDownTime ADD CONSTRAINT DF_TcssListCardiacArrestDownTime_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCardiacArrestDownTime_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCardiacArrestDownTime_IsActive'
	ALTER TABLE dbo.TcssListCardiacArrestDownTime ADD CONSTRAINT DF_TcssListCardiacArrestDownTime_IsActive DEFAULT(1) FOR IsActive
END
GO
