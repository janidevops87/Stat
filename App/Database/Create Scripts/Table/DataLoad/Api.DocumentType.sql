/******************************************************************************
		**	File: Api.DocumentType.sql
		**	Name: Api.DocumentType
		**	Desc: Load data to table Api.DocumentType
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
SET NOCOUNT ON

IF ((SELECT count(*) FROM Api.DocumentType) = 0)
BEGIN

SET IDENTITY_INSERT Api.DocumentType ON; 
	-- Api.DocumentType Information
	INSERT INTO Api.DocumentType (DocumentTypeId, Name) VALUES (1, 'Referral');
	INSERT INTO Api.DocumentType (DocumentTypeId, Name) VALUES (2, 'Message');	
	
SET IDENTITY_INSERT Api.DocumentType OFF;

END
GO