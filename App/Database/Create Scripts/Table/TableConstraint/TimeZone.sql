   /***************************************************************************************************
**	Name: TimeZone
**	Desc: Add Primary keys, Unique keys, and Default Keys to TimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**  07/14/10	Bret Knoll		Adding to release 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TimeZone')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TimeZone'
	ALTER TABLE dbo.TimeZone ADD CONSTRAINT PK_TimeZone PRIMARY KEY Clustered (TimeZoneId) 
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TimeZone_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_TimeZone_LastModified'
	ALTER TABLE dbo.TimeZone ADD CONSTRAINT DF_TimeZone_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
 