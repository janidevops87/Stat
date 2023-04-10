/***************************************************************************************************
**	Name: TcssListOtherOrgan
**	Desc: Creates new table TcssListOtherOrgan
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListOtherOrgan')
BEGIN
	-- DROP TABLE dbo.TcssListOtherOrgan
	PRINT 'Creating table TcssListOtherOrgan'
	CREATE TABLE dbo.TcssListOtherOrgan
	(
		TcssListOtherOrganId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListOtherOrgan TO PUBLIC
GO
