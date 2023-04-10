/******************************************************************************
**		File: CreateConstraintTable_RegistryOwnerElectronicSignatureText.sql
**		Name: CreateConstraintTable_RegistryOwnerElectronicSignatureText
**		Desc: Create table indexes and foregin keys on tables
**
**		Auth: ccarroll
**		Date: 02/9/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/9/2010	ccarroll			initial
**		07/09/2013	ccarroll			Note for build CCRST152
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryOwnerElectronicSignatureText')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryOwnerElectronicSignatureText'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD	 CONSTRAINT [PK_RegistryOwnerElectronicSignatureText] PRIMARY KEY  NONCLUSTERED 
					 (
						[ID]
					 )  ON [IDX]
	END
GO	

