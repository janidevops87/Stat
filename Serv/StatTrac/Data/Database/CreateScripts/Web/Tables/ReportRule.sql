/******************************************************************************
**		File: 
**		Name: ReportRule
**		Desc: 
**
**		This table provides information to control what reports users have access to by UserRole
**              
**
**		Auth: Bret Knoll
**		Date: 3/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ReportRule')
	BEGIN

		PRINT 'Creating Table ReportRule'
		
		BEGIN TRANSACTION
		SET QUOTED_IDENTIFIER ON
		SET ARITHABORT ON
		SET NUMERIC_ROUNDABORT OFF
		SET CONCAT_NULL_YIELDS_NULL ON
		SET ANSI_NULLS ON
		SET ANSI_PADDING ON
		SET ANSI_WARNINGS ON
		COMMIT
		BEGIN TRANSACTION
		COMMIT
		BEGIN TRANSACTION
		COMMIT
		BEGIN TRANSACTION
		CREATE TABLE dbo.ReportRule
			(
			ReportRuleID int NOT NULL IDENTITY (1, 1),
			ReportID int NULL,
			RoleID int NULL
			)  ON [PRIMARY]
		
		DECLARE @v sql_variant 
		SET @v = N'Controls what report users have access to by the groups they are in.'
		EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'ReportRule', NULL, NULL
		
		ALTER TABLE dbo.ReportRule ADD CONSTRAINT
			PK_ReportRule PRIMARY KEY CLUSTERED 
			(
			ReportRuleID
			) ON [PRIMARY]

		
		CREATE NONCLUSTERED INDEX FK_RolesID ON dbo.ReportRule
			(
			RoleID
			) ON IDX
		
		ALTER TABLE dbo.ReportRule ADD CONSTRAINT
			FK_ReportRule_Report FOREIGN KEY
			(
			ReportID
			) REFERENCES dbo.Report
			(
			ReportID
			)
		
		ALTER TABLE dbo.ReportRule ADD CONSTRAINT
			FK_ReportRule_Roles FOREIGN KEY
			(
			RoleID
			) REFERENCES dbo.Roles
			(
			RoleID
			) NOT FOR REPLICATION

		
		COMMIT


		GRANT SELECT ON ReportRule TO PUBLIC


	END
GO


