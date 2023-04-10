/******************************************************************************
**		File: CreateConstraintForeign_RegistryAddr.sql
**		Name: CreateConstraintForeign_RegistryAddr
**		Desc: Create foreign key constraint(s) on table
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
  /***FK_RegistryAddr***/
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryAddr_Registry')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryAddr_Registry'
			ALTER TABLE RegistryAddr
				ADD CONSTRAINT [FK_RegistryAddr_Registry] FOREIGN KEY ([RegistryID]) REFERENCES [Registry]([RegistryID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryAddr_Registry'
	END

  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_RegistryAddr_AddrType')
	BEGIN
		PRINT 'Creating Foreign Constraint: FK_RegistryAddr_AddrType'
			ALTER TABLE RegistryAddr
				ADD CONSTRAINT [FK_RegistryAddr_AddrType] FOREIGN KEY ([AddrTypeID]) REFERENCES [AddrType]([AddrTypeID])
	END

  ELSE
	BEGIN
		PRINT 'Foreign Constraint Exists: FK_RegistryAddr_AddrType'
	END