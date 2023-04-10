/* 
	RegistryStatusType
	mberenson 10/25/2016
	CCRST234 - initial data load into RegistryStatusType
*/

-- Enable Identity Inserts
SET IDENTITY_INSERT RegistryStatusType ON;

-- Insert records into RegistryStatusType
IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 1)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			1,
			'StateRegistry'
		);
END

IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 2)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			2,
			'WebRegistry'
		);
END

IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 3)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			3,
			'Not on Registry'
		);
END

IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 4)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			4,
			'Manually Found'
		);
END

IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 5)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			5,
			'Not Checked'
		);
END

IF NOT EXISTS (SELECT 1 FROM RegistryStatusType WHERE ID = 6)
BEGIN
	INSERT RegistryStatusType
		(
			ID,
			RegistryType
		)
	VALUES
		(
			6,
			'DLA Registry'
		);
END

-- Disable Identity Inserts
SET IDENTITY_INSERT RegistryStatusType OFF;