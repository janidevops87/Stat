 truncate table StateDSNLookup;

/* 1.0 Add values */
/* ccarroll 04/03/2008 - added additional information for new fields */
 
PRINT 'Adding table values: StateDSNLookup'
IF (SELECT COUNT(*) FROM StateDSNLookup) = 0 
BEGIN
		INSERT StateDSNLookup(State, DSN, StateDisplayName, Selected, Inactive, LastModified, CreateDate)VALUES('CO', 'DMV_CO', 'Colorado', Null, Null, Null, GetDate())
		INSERT StateDSNLookup(State, DSN, StateDisplayName, Selected, Inactive, LastModified, CreateDate)VALUES('WY', 'DMV_WY', 'Wyoming', Null, Null, Null, GetDate())

		PRINT '  -Insert row(s) added'
END
ELSE
BEGIN
		PRINT '  -0 rows added - data already exists'
END