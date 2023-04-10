/***************************************************************************************************
**	Name: TcssDonor
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonor')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonor'
	ALTER TABLE dbo.TcssDonor ADD CONSTRAINT PK_TcssDonor PRIMARY KEY Clustered (TcssDonorId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonor_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonor_LastUpdateDate'
	ALTER TABLE dbo.TcssDonor ADD CONSTRAINT DF_TcssDonor_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
