 /******************************************************************************
**		File: CreateConstraintTable_RegistryDigitalCertificate.sql
**		Name: CreateConstraintTable_RegistryDigitalCertificate
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_RegistryDigitalCertificate')
	BEGIN
		PRINT 'Creating Table Constraint: PK_RegistryDigitalCertificate'
			ALTER TABLE RegistryDigitalCertificate
				ADD	 CONSTRAINT [PK_RegistryDigitalCertificate] PRIMARY KEY  NONCLUSTERED 
					 (
						[RegistryDigitalCertificateID]
					 )  ON [IDX]
	END
	