 
		/******************************************************************************
		**	File: DonorTracDB(Constraint).sql 
		**	Name: DonorTracDB
		**	Desc: Creates the table DonorTracDB
		**	Auth: iosipov
		**	Date: 07/17/2018		
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------		--------		-------------------------------------------
		**	07/17/2018		iosipov			added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table DonorTracDB'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DonorTracDB')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_DonorTracDB'
			ALTER TABLE dbo.DonorTracDB ADD CONSTRAINT PK_DonorTracDB PRIMARY KEY CLUSTERED ( OrganizationID ) ON [PRIMARY]
		END
		GO


