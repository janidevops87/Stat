 /* Add reporting states to StateDSNLookup table
	 add additional states below.
	 -------------------------------
	ccarroll - 06/01/2009 Added NEOB States
*/

USE DMV_Common
GO

/*** NEOB states ***/
IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'CT') = 0
BEGIN 
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'CT',
			'DMV_CT',
			'Connecticut',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END

IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'MA') = 0
BEGIN
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'MA',
			'DMV_MA',
			'Massachusetts',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END

IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'ME') = 0
BEGIN
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'ME',
			'DMV_ME',
			'Maine',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END

IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'NH') = 0
BEGIN
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'NH',
			'DMV_NH',
			'New Hampshire',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END

IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'RI') = 0
BEGIN
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'RI',
			'DMV_RI',
			'Rhode Island',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END

IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'VT') = 0
BEGIN
	INSERT StateDSNLookup
		(
			State,
			DSN,
			StateDisplayName,
			Selected,
			Inactive,
			LastModified,
			CreateDate
		)
	VALUES
		(
			'VT',
			'DMV_VT',
			'Vermont',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END /*** NEOB states ***/

/*** Add additional states here ***/