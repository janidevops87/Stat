/******************************************************************************
**		File: CreateConstraintTable_RegistryOwnerStateConfig.sql
**		Name: CreateConstraintTable_RegistryOwnerStateConfig
**		Desc: Create table indexes and foregin keys on tables
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
**		07/15/2013	ccarroll			Added note for CCRST152
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryOwnerStateConfig')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryOwnerStateConfig'
			ALTER TABLE RegistryOwnerStateConfig
				ADD	 CONSTRAINT [PK_RegistryOwnerStateConfig] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryOwnerStateConfigID]
					 )  ON [IDX]
	END
GO	