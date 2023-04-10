/***************************************************************************************************
**	Name: BillTo
**	Desc: Add Primary keys, Unique keys, and Default Keys to BillTo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_BillTo')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_BillTo'
	ALTER TABLE dbo.BillTo ADD CONSTRAINT PK_BillTo PRIMARY KEY Clustered (BillToId) 
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_BillTo_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_BillTo_LastModified'
	ALTER TABLE dbo.BillTo ADD CONSTRAINT DF_BillTo_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
 