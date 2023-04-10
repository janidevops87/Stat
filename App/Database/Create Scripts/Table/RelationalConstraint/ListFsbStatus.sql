/***************************************************************************************************
**	Name: ListFsbStatus
**	Desc: Add Foreign keys to ListFsbStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ListFsbStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_ListFsbStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.ListFsbStatus ADD CONSTRAINT FK_ListFsbStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
