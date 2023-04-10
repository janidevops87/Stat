/* Update Column: DMVADDR.Addr1 to varchar(80) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVADDR]')
	AND syscolumns.name = 'Addr1'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVADDR Changing Column Addr1 to varchar(80)'
	ALTER TABLE DMVADDR
		ALTER COLUMN [Addr1] [varchar](80) NULL;
END

/* Update Column: DMVADDR.City to varchar(80) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVADDR]')
	AND syscolumns.name = 'City'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVADDR Changing Column City to varchar(80)'
	ALTER TABLE DMVADDR
		ALTER COLUMN [City] [varchar](80) NULL;
END

