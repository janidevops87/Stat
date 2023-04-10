/* Update Column: DMVARCHIVE.LastName to varchar(40) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVARCHIVE]')
	AND syscolumns.name = 'LastName'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVARCHIVE Changing Column LastName to varchar(40)'
	ALTER TABLE DMVARCHIVE
		ALTER COLUMN [LastName] [varchar](40) NULL;
END

/* Update Column: DMVARCHIVE.FirstName to varchar(40) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVARCHIVE]')
	AND syscolumns.name = 'FirstName'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVARCHIVE Changing Column FirstName to varchar(40)'
	ALTER TABLE DMVARCHIVE
		ALTER COLUMN [FirstName] [varchar](40) NULL;
END
