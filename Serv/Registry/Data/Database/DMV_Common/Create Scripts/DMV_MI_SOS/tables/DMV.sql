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
