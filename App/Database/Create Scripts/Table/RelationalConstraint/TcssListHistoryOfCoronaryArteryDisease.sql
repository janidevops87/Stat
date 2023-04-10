/***************************************************************************************************
**	Name: TcssListHistoryOfCoronaryArteryDisease
**	Desc: Add Foreign keys to TcssListHistoryOfCoronaryArteryDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssListHistoryOfCoronaryArteryDisease_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssListHistoryOfCoronaryArteryDisease_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssListHistoryOfCoronaryArteryDisease ADD CONSTRAINT FK_TcssListHistoryOfCoronaryArteryDisease_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
