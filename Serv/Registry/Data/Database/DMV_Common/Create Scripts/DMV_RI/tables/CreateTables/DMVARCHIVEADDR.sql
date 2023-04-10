/* Update Column: DMVARCHIVEADDR.Addr1 to varchar(80) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVARCHIVEADDR]')
	AND syscolumns.name = 'Addr1'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVARCHIVEADDR Changing Column Addr1 to varchar(80)'
	ALTER TABLE DMVARCHIVEADDR
		ALTER COLUMN [Addr1] [varchar](80) NULL;
END

/* Update Column: DMVARCHIVEADDR.City to varchar(80) */
IF EXISTS (
	select * from syscolumns where id = OBJECT_ID(N'[dbo].[DMVARCHIVEADDR]')
	AND syscolumns.name = 'City'
	)
BEGIN
	PRINT 'ALTERING TABLE DMVARCHIVEADDR Changing Column City to varchar(80)'
	ALTER TABLE DMVARCHIVEADDR
		ALTER COLUMN [City] [varchar](80) NULL;
END

