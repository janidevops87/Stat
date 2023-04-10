/***************************************************************************************************
**	Name: TcssListNumberOfTransfusion
**	Desc: Creates new table TcssListNumberOfTransfusion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListNumberOfTransfusion')
BEGIN
	-- DROP TABLE dbo.TcssListNumberOfTransfusion
	PRINT 'Creating table TcssListNumberOfTransfusion'
	CREATE TABLE dbo.TcssListNumberOfTransfusion
	(
		TcssListNumberOfTransfusionId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListNumberOfTransfusion TO PUBLIC
GO
