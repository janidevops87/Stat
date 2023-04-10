/***************************************************************************************************
**	Name: TcssListHlaB2
**	Desc: Add Foreign keys to TcssListHlaB2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssListHlaB2_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssListHlaB2_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssListHlaB2 ADD CONSTRAINT FK_TcssListHlaB2_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
