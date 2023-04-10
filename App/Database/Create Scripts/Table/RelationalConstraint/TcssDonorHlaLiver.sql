/***************************************************************************************************
**	Name: TcssDonorHlaLiver
**	Desc: Add Foreign keys to TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId
			FOREIGN KEY(TcssListPreliminaryCrossmatchId) REFERENCES dbo.TcssListPreliminaryCrossmatch(TcssListPreliminaryCrossmatchId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaA1Id_TcssListHlaA1_TcssListHlaA1Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaA1Id_TcssListHlaA1_TcssListHlaA1Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaA1Id_TcssListHlaA1_TcssListHlaA1Id
			FOREIGN KEY(TcssListHlaA1Id) REFERENCES dbo.TcssListHlaA1(TcssListHlaA1Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaA2Id_TcssListHlaA2_TcssListHlaA2Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaA2Id_TcssListHlaA2_TcssListHlaA2Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaA2Id_TcssListHlaA2_TcssListHlaA2Id
			FOREIGN KEY(TcssListHlaA2Id) REFERENCES dbo.TcssListHlaA2(TcssListHlaA2Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaB1Id_TcssListHlaB1_TcssListHlaB1Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaB1Id_TcssListHlaB1_TcssListHlaB1Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaB1Id_TcssListHlaB1_TcssListHlaB1Id
			FOREIGN KEY(TcssListHlaB1Id) REFERENCES dbo.TcssListHlaB1(TcssListHlaB1Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaB2Id_TcssListHlaB2_TcssListHlaB2Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaB2Id_TcssListHlaB2_TcssListHlaB2Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaB2Id_TcssListHlaB2_TcssListHlaB2Id
			FOREIGN KEY(TcssListHlaB2Id) REFERENCES dbo.TcssListHlaB2(TcssListHlaB2Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaBw4Id_TcssListHlaBw4_TcssListHlaBw4Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaBw4Id_TcssListHlaBw4_TcssListHlaBw4Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaBw4Id_TcssListHlaBw4_TcssListHlaBw4Id
			FOREIGN KEY(TcssListHlaBw4Id) REFERENCES dbo.TcssListHlaBw4(TcssListHlaBw4Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaBw6Id_TcssListHlaBw6_TcssListHlaBw6Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaBw6Id_TcssListHlaBw6_TcssListHlaBw6Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaBw6Id_TcssListHlaBw6_TcssListHlaBw6Id
			FOREIGN KEY(TcssListHlaBw6Id) REFERENCES dbo.TcssListHlaBw6(TcssListHlaBw6Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaC1Id_TcssListHlaC1_TcssListHlaC1Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaC1Id_TcssListHlaC1_TcssListHlaC1Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaC1Id_TcssListHlaC1_TcssListHlaC1Id
			FOREIGN KEY(TcssListHlaC1Id) REFERENCES dbo.TcssListHlaC1(TcssListHlaC1Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaC2Id_TcssListHlaC2_TcssListHlaC2Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaC2Id_TcssListHlaC2_TcssListHlaC2Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaC2Id_TcssListHlaC2_TcssListHlaC2Id
			FOREIGN KEY(TcssListHlaC2Id) REFERENCES dbo.TcssListHlaC2(TcssListHlaC2Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDr1Id_TcssListHlaDr1_TcssListHlaDr1Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDr1Id_TcssListHlaDr1_TcssListHlaDr1Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDr1Id_TcssListHlaDr1_TcssListHlaDr1Id
			FOREIGN KEY(TcssListHlaDr1Id) REFERENCES dbo.TcssListHlaDr1(TcssListHlaDr1Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDr2Id_TcssListHlaDr2_TcssListHlaDr2Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDr2Id_TcssListHlaDr2_TcssListHlaDr2Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDr2Id_TcssListHlaDr2_TcssListHlaDr2Id
			FOREIGN KEY(TcssListHlaDr2Id) REFERENCES dbo.TcssListHlaDr2(TcssListHlaDr2Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDr51Id_TcssListHlaDr51_TcssListHlaDr51Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDr51Id_TcssListHlaDr51_TcssListHlaDr51Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDr51Id_TcssListHlaDr51_TcssListHlaDr51Id
			FOREIGN KEY(TcssListHlaDr51Id) REFERENCES dbo.TcssListHlaDr51(TcssListHlaDr51Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDr52Id_TcssListHlaDr52_TcssListHlaDr52Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDr52Id_TcssListHlaDr52_TcssListHlaDr52Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDr52Id_TcssListHlaDr52_TcssListHlaDr52Id
			FOREIGN KEY(TcssListHlaDr52Id) REFERENCES dbo.TcssListHlaDr52(TcssListHlaDr52Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDr53Id_TcssListHlaDr53_TcssListHlaDr53Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDr53Id_TcssListHlaDr53_TcssListHlaDr53Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDr53Id_TcssListHlaDr53_TcssListHlaDr53Id
			FOREIGN KEY(TcssListHlaDr53Id) REFERENCES dbo.TcssListHlaDr53(TcssListHlaDr53Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDq1Id_TcssListHlaDq1_TcssListHlaDq1Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDq1Id_TcssListHlaDq1_TcssListHlaDq1Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDq1Id_TcssListHlaDq1_TcssListHlaDq1Id
			FOREIGN KEY(TcssListHlaDq1Id) REFERENCES dbo.TcssListHlaDq1(TcssListHlaDq1Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorHlaLiver_TcssListHlaDq2Id_TcssListHlaDq2_TcssListHlaDq2Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorHlaLiver_TcssListHlaDq2Id_TcssListHlaDq2_TcssListHlaDq2Id'
		ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT FK_TcssDonorHlaLiver_TcssListHlaDq2Id_TcssListHlaDq2_TcssListHlaDq2Id
			FOREIGN KEY(TcssListHlaDq2Id) REFERENCES dbo.TcssListHlaDq2(TcssListHlaDq2Id) 
	END
GO
