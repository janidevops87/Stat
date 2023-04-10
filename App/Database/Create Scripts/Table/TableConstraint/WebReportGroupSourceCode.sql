
		/******************************************************************************
		**	File: WebReportGroupSourceCode.sql 
		**	Name: WebReportGroupSourceCode
		**	Desc: Creates the table WebReportGroupSourceCode
		**	Auth: Bret Knoll
		**	Date: 7/22/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	7/22/2009		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		IF  EXISTS (SELECT * FROM sysindexes WHERE id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]') AND name = N'PK___1__20')
		BEGIN
			ALTER TABLE dbo.WebReportGroupSourceCode
				DROP CONSTRAINT PK___1__20	
		END

		
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table WebReportGroupSourceCode'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_WebReportGroupSourceCode')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_WebReportGroupSourceCode'
			ALTER TABLE dbo.WebReportGroupSourceCode ADD CONSTRAINT PK_WebReportGroupSourceCode PRIMARY KEY Clustered (WebReportGroupSourceCodeId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_WebReportGroupSourceCode_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_WebReportGroupSourceCode_LastModified'
			ALTER TABLE dbo.WebReportGroupSourceCode ADD CONSTRAINT DF_WebReportGroupSourceCode_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebReportGroupSourceCode SET (LOCK_ESCALATION = TABLE)
		END

