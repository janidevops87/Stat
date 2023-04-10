
		/******************************************************************************
		**	File: TrainedRequestor(Constraint).sql 
		**	Name: TrainedRequestor
		**	Desc: Creates the table TrainedRequestor
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------		--------	-------------------------------------------
		**	9/15/2009		Bret Knoll		Initial Table Creation
		**	6/13/2011		Bret Knoll		Modify for Scripts
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table TrainedRequestor'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TrainedRequestor')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_TrainedRequestor'
			ALTER TABLE dbo.TrainedRequestor ADD CONSTRAINT PK_TrainedRequestor PRIMARY KEY Clustered (TrainedRequestorId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TrainedRequestor_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_TrainedRequestor_LastModified'
			ALTER TABLE dbo.TrainedRequestor ADD CONSTRAINT DF_TrainedRequestor_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE TrainedRequestor SET (LOCK_ESCALATION = TABLE)
		END

