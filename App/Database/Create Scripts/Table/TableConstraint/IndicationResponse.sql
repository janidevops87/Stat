
		/******************************************************************************
		**	File: IndicationResponse(Constraint).sql 
		**	Name: IndicationResponse
		**	Desc: Creates the table IndicationResponse
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table IndicationResponse'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_IndicationResponse')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_IndicationResponse'
			ALTER TABLE dbo.IndicationResponse ADD CONSTRAINT PK_IndicationResponse PRIMARY KEY Clustered (IndicationResponseId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_IndicationResponse_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_IndicationResponse_LastModified'
			ALTER TABLE dbo.IndicationResponse ADD CONSTRAINT DF_IndicationResponse_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE IndicationResponse SET (LOCK_ESCALATION = TABLE)
		END

