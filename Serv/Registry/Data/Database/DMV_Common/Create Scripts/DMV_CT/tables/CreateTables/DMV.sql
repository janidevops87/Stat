
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

/* Add Column: FirstName_Display DMV */
IF NOT EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMV]')
	AND syscolumns.name = 'FirstName_Display'
	)
BEGIN
	PRINT 'ALTERING TABLE DMV Adding Column FirstName_Display'
	ALTER TABLE DMV
		ADD [FirstName_Display] [nvarchar](255) NULL
END

/* Add Column: MiddleName_Display DMV */
IF NOT EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMV]')
	AND syscolumns.name = 'MiddleName_Display'
	)
BEGIN
	PRINT 'ALTERING TABLE DMV Adding Column MiddleName_Display'
	ALTER TABLE DMV
		ADD [MiddleName_Display] [nvarchar](255) NULL
END

/* Add Column: LastName_Display DMV */
IF NOT EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMV]')
	AND syscolumns.name = 'LastName_Display'
	)
BEGIN
	PRINT 'ALTERING TABLE DMV Adding Column LastName_Display'
	ALTER TABLE DMV
		ADD [LastName_Display] [nvarchar](255) NULL
END
