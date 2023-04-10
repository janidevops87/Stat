/* Add Column: PreviousDonorState DMV */
IF Not Exists(select * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DMV' AND COLUMN_NAME = 'PreviousDonorState')
	BEGIN
			PRINT 'DMV Adding column: PreviousDonorState'
			ALTER TABLE DMV
				ADD PreviousDonorState varchar(50) NULL
	END
ELSE
	BEGIN
			PRINT 'DMV PreviousDonorState column already exists'
	END

/* Update Column: DMV.LastName to varchar(40) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMV]')
	AND syscolumns.name = 'LastName'
	)
BEGIN
	PRINT 'ALTERING TABLE DMV Changing Column LastName to varchar(40)'
	ALTER TABLE DMV
		ALTER COLUMN [LastName] [varchar](40) NULL;
END

/* Update Column: DMV.FirstName to varchar(40) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMV]')
	AND syscolumns.name = 'FirstName'
	)
BEGIN
	PRINT 'ALTERING TABLE DMV Changing Column FirstName to varchar(40)'
	ALTER TABLE DMV
		ALTER COLUMN [FirstName] [varchar](40) NULL;
END
