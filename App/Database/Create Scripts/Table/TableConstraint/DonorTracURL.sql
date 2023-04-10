 
		/******************************************************************************
		**	File: DonorTracURL(Constraint).sql 
		**	Name: DonorTracURL
		**	Desc: Creates the table DonorTracURL
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table DonorTracURL'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DonorTracURL')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_DonorTracURL'
			ALTER TABLE dbo.DonorTracURL ADD CONSTRAINT PK_DonorTracURL PRIMARY KEY Clustered (DonorTracURLId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DonorTracURL_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_DonorTracURL_LastModified'
			ALTER TABLE dbo.DonorTracURL ADD CONSTRAINT DF_DonorTracURL_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE DonorTracURL SET (LOCK_ESCALATION = TABLE)
		END

