IF (SELECT COUNT(*) FROM PersonType WHERE PersonTypeName IN ('Staff Mortician','Senior Staff Mortician')) = 0 
	BEGIN
		PRINT 'Adding Mortician data to person type'
		INSERT INTO PersonType
			(
				PersonTypeName,
				Verified,
				Inactive
			)
			VALUES
			(
				'Staff Mortician',
				0,
				0		
			)
		INSERT INTO PersonType
			(
				PersonTypeName,
				Verified,
				Inactive
			)
			VALUES
			(
				'Senior Staff Mortician',
				0,
				0		
			)
	END
	ELSE
	BEGIN
			PRINT '  -0 rows added - data already exists'
	END