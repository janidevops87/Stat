/***************************************************************************************************
**	Name: TcssListDonorMeetsEcdCriteria
**	Desc: Add Foreign keys to TcssListDonorMeetsEcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssListDonorMeetsEcdCriteria_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssListDonorMeetsEcdCriteria_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssListDonorMeetsEcdCriteria ADD CONSTRAINT FK_TcssListDonorMeetsEcdCriteria_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
