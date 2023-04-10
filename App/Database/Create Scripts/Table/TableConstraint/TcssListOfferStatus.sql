/***************************************************************************************************
**	Name: TcssListOfferStatus
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListOfferStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListOfferStatus')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListOfferStatus'
	ALTER TABLE dbo.TcssListOfferStatus ADD CONSTRAINT PK_TcssListOfferStatus PRIMARY KEY Clustered (TcssListOfferStatusId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOfferStatus_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOfferStatus_LastUpdateDate'
	ALTER TABLE dbo.TcssListOfferStatus ADD CONSTRAINT DF_TcssListOfferStatus_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOfferStatus_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOfferStatus_SortOrder'
	ALTER TABLE dbo.TcssListOfferStatus ADD CONSTRAINT DF_TcssListOfferStatus_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOfferStatus_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOfferStatus_IsActive'
	ALTER TABLE dbo.TcssListOfferStatus ADD CONSTRAINT DF_TcssListOfferStatus_IsActive DEFAULT(1) FOR IsActive
END
GO
