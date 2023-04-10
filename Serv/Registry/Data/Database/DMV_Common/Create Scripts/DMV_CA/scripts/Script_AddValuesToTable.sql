
/* 1.0 Add Import file values */
PRINT 'Adding table values: DMVIMPORTFILES'
IF (SELECT COUNT(*) FROM DMVIMPORTFILES) = 0 
BEGIN
		INSERT INTO DMVIMPORTFILES (TableName, FileName, WorkOrder) VALUES('DMVIMPORT_A','',1)
		PRINT '  -Insert row(s) added'
END
ELSE
BEGIN
		PRINT '  -0 rows added - data already exists'
END

/* 2.0 Add values to DMVArchiveType table*/
PRINT 'Adding table values: DMVARCHIVETYPE'

		SET IDENTITY_INSERT DMVARCHIVETYPE ON
		GO

IF (SELECT Count(*) FROM DMVARCHIVETYPE) = 0  
	BEGIN
		INSERT DMVARCHIVETYPE(ID,description)VALUES(1,'Import')
		INSERT DMVARCHIVETYPE(ID,description)VALUES(2,'Deceased')
		INSERT DMVARCHIVETYPE(ID,description)VALUES(3,'OutOfState')
		INSERT DMVARCHIVETYPE(ID,description)VALUES(4,'Referral')
		INSERT DMVARCHIVETYPE(ID,description)VALUES(5,'DonorStatusChange')

		PRINT '  -Insert row(s) added'
	END
ELSE
	BEGIN
		PRINT '  -0 rows added - data already exists'
	END
		SET IDENTITY_INSERT DMVARCHIVETYPE OFF
	GO