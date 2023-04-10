/***************************************************************************************************
**	Name: TcssListEthnicity
**	Desc: Creates new table TcssListEthnicity
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListEthnicity')
BEGIN
	-- DROP TABLE dbo.TcssListEthnicity
	PRINT 'Creating table TcssListEthnicity'
	CREATE TABLE dbo.TcssListEthnicity
	(
		TcssListEthnicityId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListEthnicity TO PUBLIC
GO
