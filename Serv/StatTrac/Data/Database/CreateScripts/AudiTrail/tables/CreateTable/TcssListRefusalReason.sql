/***************************************************************************************************
**	Name: TcssListRefusalReason
**	Desc: Creates new table TcssListRefusalReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListRefusalReason')
BEGIN
	-- DROP TABLE dbo.TcssListRefusalReason
	PRINT 'Creating table TcssListRefusalReason'
	CREATE TABLE dbo.TcssListRefusalReason
	(
		TcssListRefusalReasonId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL,
		Description varchar(1000) NULL
	)
END
GO

GRANT SELECT ON TcssListRefusalReason TO PUBLIC
GO
