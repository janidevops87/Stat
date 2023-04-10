/******************************************************************************
**		File: CreateConstraintTable_RegistryOwnerGrantedAccess.sql
**		Name: CreateConstraintTable_RegistryOwnerGrantedAccess
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
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryOwnerGrantedAccess')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryOwnerGrantedAccess'
			ALTER TABLE RegistryOwnerGrantedAccess
				ADD	 CONSTRAINT [PK_RegistryOwnerGrantedAccess] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryOwnerGrantedAccessID]
					 )  ON [IDX]
	END
	