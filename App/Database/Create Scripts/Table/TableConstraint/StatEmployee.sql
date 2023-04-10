
		/******************************************************************************
		**	File: StatEmployee(Constraint).sql 
		**	Name: StatEmployee
		**	Desc: Creates the table StatEmployee
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/29/2010		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table StatEmployee'
		GO
		IF EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_StatEmployee_1__13')
		BEGIN
			PRINT 'DROP CONSTRAINT PK_StatEmployee_1__13'
			ALTER TABLE dbo.StatEmployee
				DROP CONSTRAINT PK_StatEmployee_1__13
		END
		GO	
		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_StatEmployee')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_StatEmployee'
			ALTER TABLE dbo.StatEmployee ADD CONSTRAINT PK_StatEmployee PRIMARY KEY Clustered (StatEmployeeId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_StatEmployee_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_StatEmployee_LastModified'
			ALTER TABLE dbo.StatEmployee ADD CONSTRAINT DF_StatEmployee_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE StatEmployee SET (LOCK_ESCALATION = TABLE)
		END

