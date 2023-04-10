 
		/******************************************************************************
		**	File: PhoneType(Constraint).sql 
		**	Name: PhoneType
		**	Desc: Creates the table PhoneType
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/6/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table PhoneType'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_PhoneType')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_PhoneType'
			ALTER TABLE dbo.PhoneType ADD CONSTRAINT PK_PhoneType PRIMARY KEY Clustered (PhoneTypeId) 
		END
		GO