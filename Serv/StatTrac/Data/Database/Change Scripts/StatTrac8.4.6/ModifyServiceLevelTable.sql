	BEGIN TRANSACTION
		SET QUOTED_IDENTIFIER ON
		SET ARITHABORT ON
		SET NUMERIC_ROUNDABORT OFF
		SET CONCAT_NULL_YIELDS_NULL ON
		SET ANSI_NULLS ON
		SET ANSI_PADDING ON
		SET ANSI_WARNINGS ON

		/*	ccarroll 08/04/2008 - StatTrac 8.4.6 release
			- Add column: ServiceLevelBillApproachOnly. When set to -1 disables the bill secondary
			  feature in statTrac. Used for ME/Coroner cases billing.
		*/
			

	COMMIT

	BEGIN TRANSACTION

	/* ServiceLevelBillApproachOnly */
		IF (SELECT Count(ID) FROM syscolumns WHERE name LIKE 'ServiceLevelBillApproachOnly') > 0
			PRINT 'Modify Aborted.. column already exists' 
		ELSE
		 BEGIN
			PRINT 'Modify Table: ServiceLevel -add ServiceLevelBillApproachOnly' 

			ALTER TABLE ServiceLevel ADD
			  ServiceLevelBillApproachOnly	smallint NULL CONSTRAINT ServiceLevelBillApproachOnlydflt DEFAULT 0 WITH VALUES
		 END
		 
	/* ServiceLevelAllowASPAccessToAllEvents ***REMOVED FROM REQUIREMENT SCOPE 08/13/2008 *** 
		IF (SELECT Count(ID) FROM syscolumns WHERE name LIKE 'ServiceLevelAllowASPAccessToAllEvents') > 0
			PRINT 'Modify Aborted.. column already exists' 
		ELSE
		 BEGIN
			PRINT 'Modify Table: ServiceLevel -add ServiceLevelAllowASPAccessToAllEvents'

			ALTER TABLE ServiceLevel ADD
			  ServiceLevelAllowASPAccessToAllEvents	smallint NULL CONSTRAINT ServiceLevelAllowASPAccessToAllEventsdflt DEFAULT 0 WITH VALUES
		 END
	*/	 
		 
	COMMIT
