 /* Table: AddrType
	Add default values if they do not exist
	ccarroll	02/20/2009
*/

IF (SELECT Count(*) FROM AddrType) < 1
	BEGIN
		PRINT 'AddrType: Adding default values'
		SET IDENTITY_INSERT AddrType ON

		INSERT INTO AddrType (AddrTypeID, Description) VALUES(1, 'Residential')
		INSERT INTO AddrType (AddrTypeID, Description) VALUES(2, 'Mailing')

		SET IDENTITY_INSERT AddrType OFF
	END
