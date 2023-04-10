/******************************************************************************
**		File: CreateConstraintTable_RegistryOwnerEnrollmentText.sql
**		Name: CreateConstraintTable_RegistryOwnerEnrollmentText
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryOwnerEnrollmentText')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryOwnerEnrollmentText'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD	 CONSTRAINT [PK_RegistryOwnerEnrollmentText] PRIMARY KEY  NONCLUSTERED 
					 (
						[ID]
					 )  ON [IDX]
	END
GO
	 