/***************************************************************************************************
**	Name: TcssListHistoryOfCancer
**	Desc: Creates new table TcssListHistoryOfCancer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHistoryOfCancer')
BEGIN
	-- DROP TABLE dbo.TcssListHistoryOfCancer
	PRINT 'Creating table TcssListHistoryOfCancer'
	CREATE TABLE dbo.TcssListHistoryOfCancer
	(
		TcssListHistoryOfCancerId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHistoryOfCancer TO PUBLIC
GO
