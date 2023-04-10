/***************************************************************************************************
**	Name: TcssListCloseReason
**	Desc: Creates new table TcssListCloseReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCloseReason')
BEGIN
	-- DROP TABLE dbo.TcssListCloseReason
	PRINT 'Creating table TcssListCloseReason'
	CREATE TABLE dbo.TcssListCloseReason
	(
		TcssListCloseReasonId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCloseReason TO PUBLIC
GO
