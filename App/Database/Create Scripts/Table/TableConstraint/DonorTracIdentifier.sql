
		/******************************************************************************
		**	File: DonorTracIdentifier(Constraint).sql 
		**	Name: DonorTracIdentifier
		**	Desc: Creates the table DonorTracIdentifier
		**	Auth: ccarroll
		**	Date: 10/23/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/23/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table DonorTracIdentifier'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DonorTracIdentifier')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_DonorTracIdentifier'
			ALTER TABLE dbo.DonorTracIdentifier ADD CONSTRAINT PK_DonorTracIdentifier PRIMARY KEY Clustered (DonorTracIdentifierId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DonorTracIdentifier_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_DonorTracIdentifier_LastModified'
			ALTER TABLE dbo.DonorTracIdentifier ADD CONSTRAINT DF_DonorTracIdentifier_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE DonorTracIdentifier SET (LOCK_ESCALATION = TABLE)
		END

