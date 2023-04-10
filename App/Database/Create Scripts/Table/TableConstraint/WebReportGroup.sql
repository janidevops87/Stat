
		/******************************************************************************
		**	File: WebReportGroup.sql 
		**	Name: WebReportGroup
		**	Desc: Creates the table WebReportGroup
		**	Auth: Bret Knoll
		**	Date: 7/22/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	7/22/2009		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		IF  EXISTS (SELECT * FROM sysindexes WHERE id = OBJECT_ID(N'[dbo].[WebReportGroup]') AND name = N'PK_WebReportGroup_1__13')
		BEGIN
			ALTER TABLE dbo.WebReportGroup
				DROP CONSTRAINT PK_WebReportGroup_1__13	
		END

		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table WebReportGroup'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_WebReportGroup')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_WebReportGroup'
			ALTER TABLE dbo.WebReportGroup ADD CONSTRAINT PK_WebReportGroup PRIMARY KEY Clustered (WebReportGroupId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_WebReportGroup_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_WebReportGroup_LastModified'
			ALTER TABLE dbo.WebReportGroup ADD CONSTRAINT DF_WebReportGroup_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebReportGroup SET (LOCK_ESCALATION = TABLE)
		END

