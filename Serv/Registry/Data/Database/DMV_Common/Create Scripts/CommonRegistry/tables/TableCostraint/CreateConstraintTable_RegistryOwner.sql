/******************************************************************************
**		File: CreateConstraintTable_RegistryOwner.sql
**		Name: CreateConstraintTable_RegistryOwner
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
**		07/09/2013	ccarroll			Note for build CCRST152
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryOwner')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryOwner'
			ALTER TABLE RegistryOwner
				ADD	 CONSTRAINT [PK_RegistryOwner] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryOwnerID]
					 )  ON [IDX]
	END
GO