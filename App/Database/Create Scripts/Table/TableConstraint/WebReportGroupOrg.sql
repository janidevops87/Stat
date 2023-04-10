
		/******************************************************************************
		**	File: WebReportGroupOrg.sql 
		**	Name: WebReportGroupOrg
		**	Desc: Creates the table WebReportGroupOrg
		**	Auth: Bret Knoll
		**	Date: 7/22/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	7/22/2009		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		IF  EXISTS (SELECT * FROM sysindexes WHERE id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]') AND name = N'PK_WebReportGroupOrg_1__13')
		BEGIN
			ALTER TABLE dbo.WebReportGroupOrg
				DROP CONSTRAINT PK_WebReportGroupOrg_1__13	
		END
		GO	
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table WebReportGroupOrg'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_WebReportGroupOrg')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_WebReportGroupOrg'
			ALTER TABLE dbo.WebReportGroupOrg ADD CONSTRAINT PK_WebReportGroupOrg PRIMARY KEY Clustered (WebReportGroupOrgId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_WebReportGroupOrg_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_WebReportGroupOrg_LastModified'
			ALTER TABLE dbo.WebReportGroupOrg ADD CONSTRAINT DF_WebReportGroupOrg_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebReportGroupOrg SET (LOCK_ESCALATION = TABLE)
		END

