/***************************************************************************************************
**	Name: TcssListKidneyHorseshoeShape
**	Desc: Add Foreign keys to TcssListKidneyHorseshoeShape
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssListKidneyHorseshoeShape_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssListKidneyHorseshoeShape_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssListKidneyHorseshoeShape ADD CONSTRAINT FK_TcssListKidneyHorseshoeShape_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
