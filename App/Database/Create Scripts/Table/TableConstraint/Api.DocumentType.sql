/******************************************************************************
		**	File: Api.DocumentType.sql
		**	Name: Api.DocumentType
		**	Desc: Primary Key of table Api.DocumentType
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DocumentType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DocumentType'
	ALTER TABLE Api.DocumentType ADD CONSTRAINT PK_DocumentType PRIMARY KEY Clustered (DocumentTypeId) --ON Primary
END
GO