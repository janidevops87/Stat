 
		/******************************************************************************
		**	File: SourceCodeASP(Constraint).sql 
		**	Name: SourceCodeASP
		**	Desc: Creates the table SourceCodeASP
		**	Auth: ccarroll
		**	Date: 7/26/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	7/26/2010		ccarroll		Initial Table Creation
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table SourceCodeASP'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SourceCodeASP')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_SourceCodeASP'
			ALTER TABLE dbo.SourceCodeASP ADD CONSTRAINT PK_SourceCodeASP PRIMARY KEY Clustered (SourceCodeASPId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SourceCodeASP_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_SourceCodeASP_LastModified'
			ALTER TABLE dbo.SourceCodeASP ADD CONSTRAINT DF_SourceCodeASP_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeASP SET (LOCK_ESCALATION = TABLE)
		END

