
		/******************************************************************************
		**	File: CriteriaWeightUnit(Constraint).sql 
		**	Name: CriteriaWeightUnit
		**	Desc: Creates the table CriteriaWeightUnit
		**	Auth: ccarroll
		**	Date: 12/16/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	12/16/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table CriteriaWeightUnit'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_CriteriaWeightUnit')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_CriteriaWeightUnit'
			ALTER TABLE dbo.CriteriaWeightUnit ADD CONSTRAINT PK_CriteriaWeightUnit PRIMARY KEY Clustered (CriteriaWeightUnitId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_CriteriaWeightUnit_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_CriteriaWeightUnit_LastModified'
			ALTER TABLE dbo.CriteriaWeightUnit ADD CONSTRAINT DF_CriteriaWeightUnit_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE CriteriaWeightUnit SET (LOCK_ESCALATION = TABLE)
		END

