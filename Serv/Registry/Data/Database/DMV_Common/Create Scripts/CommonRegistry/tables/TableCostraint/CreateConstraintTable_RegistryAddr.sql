/******************************************************************************
**		File: CreateConstraintTable_RegistryAddr.sql
**		Name: CreateConstraintTable_RegistryAddr
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryAddr')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryAddr'
			ALTER TABLE RegistryAddr
				ADD	 CONSTRAINT [PK_RegistryAddr] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryAddrID]
					 )  ON [IDX]
	END
	