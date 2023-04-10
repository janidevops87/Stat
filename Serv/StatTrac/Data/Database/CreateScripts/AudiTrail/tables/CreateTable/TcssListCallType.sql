/***************************************************************************************************
**	Name: TcssListCallType
**	Desc: Creates new table TcssListCallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCallType')
BEGIN
	-- DROP TABLE dbo.TcssListCallType
	PRINT 'Creating table TcssListCallType'
	CREATE TABLE dbo.TcssListCallType
	(
		TcssListCallTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCallType TO PUBLIC
GO
