/***************************************************************************************************
**	Name: TcssListKidneyHematoma
**	Desc: Add Foreign keys to TcssListKidneyHematoma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/30/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssListKidneyHematoma_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssListKidneyHematoma_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssListKidneyHematoma ADD CONSTRAINT FK_TcssListKidneyHematoma_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
