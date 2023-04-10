IF (SELECT COUNT(*) FROM PersonType WHERE PersonTypeName IN ('Transplant Surgeon','Transplant Administrator','Transplant Coordinator','Clinical Manager')) = 0 
	BEGIN
		PRINT 'Adding new titles data to person type'
		INSERT INTO PersonType
			(
				PersonTypeName,
				Verified,
				Inactive
			)
			VALUES
			(
				'Transplant Surgeon',
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
				'Transplant Administrator',
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
				'Transplant Coordinator',
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
				'Clinical Manager',
				0,
				0		
			)
	END
	ELSE
	BEGIN
			PRINT '  -0 rows added - data already exists'
	END 