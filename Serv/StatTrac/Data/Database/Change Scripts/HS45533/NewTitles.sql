-- New Titles for HelpSTAR Ticket 45533 (StatTrac)

IF NOT EXISTS (SELECT (1) FROM PersonType WHERE PersonTypeName = 'Clinical Director')
BEGIN
	PRINT 'Adding new person type: Clinical Director';
	INSERT INTO PersonType
		(
			PersonTypeName,
			Verified,
			Inactive
		)
		VALUES
		(
			'Clinical Director',
			0,
			0		
		);
END

IF NOT EXISTS (SELECT (1) FROM PersonType WHERE PersonTypeName = 'Clinical Educator/Supervisor')
BEGIN
	PRINT 'Adding new person type: Clinical Educator/Supervisor';
	INSERT INTO PersonType
		(
			PersonTypeName,
			Verified,
			Inactive
		)
		VALUES
		(
			'Clinical Educator/Supervisor',
			0,
			0		
		);
END

IF NOT EXISTS (SELECT (1) FROM PersonType WHERE PersonTypeName = 'Regional Supervisor')
BEGIN
	PRINT 'Adding new person type: Regional Supervisor';
	INSERT INTO PersonType
		(
			PersonTypeName,
			Verified,
			Inactive
		)
		VALUES
		(
			'Regional Supervisor',
			0,
			0		
		);
END