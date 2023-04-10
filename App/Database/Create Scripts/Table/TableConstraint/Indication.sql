
		/******************************************************************************
		**	File: Indication(Constraint).sql 
		**	Name: Indication
		**	Desc: Creates the table Indication
		**	Auth: ccarroll
		**	Date: 11/20/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	11/20/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
--		PRINT 'Add Primary Keys, Indexes and Defaults for Table Indication'
--		GO

--		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Indication')
--		BEGIN
--			PRINT 'Creating Primary Key Constraint PK_Indication'
--			ALTER TABLE dbo.Indication ADD CONSTRAINT PK_Indication PRIMARY KEY Clustered (IndicationId) 
--		END
--		GO

--		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Indication_LastModified')
--		BEGIN
--			PRINT 'Creating Default Constraint DF_Indication_LastModified'
--			ALTER TABLE dbo.Indication ADD CONSTRAINT DF_Indication_LastModified DEFAULT(GetDate()) FOR LastModified
--		END
--		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Indication SET (LOCK_ESCALATION = TABLE)
		END

