/***************************************************************************************************
**	Name: TcssDonorUrinalysis
**	Desc: Creates new table TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
**  5/11        jth				added varchar fields...use instead of ints
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorUrinalysis')
BEGIN
	-- DROP TABLE dbo.TcssDonorUrinalysis
	PRINT 'Creating table TcssDonorUrinalysis'
	CREATE TABLE dbo.TcssDonorUrinalysis
	(
		TcssDonorUrinalysisId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL,
		Color varchar(10) NULL,
		AppearanceId varchar(10) NULL,
		Ph decimal(18,2),
		SpecificGravity decimal(18,2),
		TcssListUrinalysisProteinId int NULL,
		TcssListUrinalysisGlucoseId int NULL,
		TcssListUrinalysisBloodId int NULL,
		TcssListUrinalysisRbcId int NULL,
		TcssListUrinalysisWbcId int NULL,
		TcssListUrinalysisEpithId int NULL,
		TcssListUrinalysisCastId int NULL,
		TcssListUrinalysisBacteriaId int NULL,
		TcssListUrinalysisLeukocyteId int NULL
	)
END
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'SpecificGravity'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Altering Column SpecificGravity'
			ALTER TABLE TcssDonorUrinalysis ALTER COLUMN SpecificGravity [decimal](18,5) NULL
		END			


IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisProtein'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisProtein'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisProtein varchar(50) NULL
		END		

IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisGlucose'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisGlucose'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisGlucose varchar(50) NULL
		END		
		
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisBlood'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisBlood'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisBlood varchar(50) NULL
		END		
		
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisRbc'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisRbc'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisRbc varchar(50) NULL
		END		
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisWbc'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisWbc'
			ALTER TABLE TcssDonorUrinalysis Add TcssUrinalysisWbc varchar(50) NULL
		END			


IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisEpith'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisEpith'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisEpith varchar(50) NULL
		END		

IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisCast'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisCast'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisCast varchar(50) NULL
		END		
		
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisBacteria'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisBacteria'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisBacteria varchar(50) NULL
		END		
		
IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]')
			AND syscolumns.name = 'TcssUrinalysisLeukocyte'
			)
		BEGIN
			PRINT 'ALTERING TABLE TcssDonorUrinalysis Adding Column TcssUrinalysisLeukocyte'
			ALTER TABLE TcssDonorUrinalysis ADD TcssUrinalysisLeukocyte varchar(50) NULL
		END		

GRANT SELECT ON TcssDonorUrinalysis TO PUBLIC
GO
