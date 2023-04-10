/* Add reporting states to StateDSNLookup table
	 add additional states below.
	 -------------------------------
	ccarroll - 02/05/2010 Added Nevada Donor Network States
*/

-- USE DMV_Common
-- GO

/*** Nevada Donor Network States ***/
IF (SELECT Count(*) FROM StateDSNLookup WHERE State = 'NV') = 0
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
			'NV',
			'DMV_NV',
			'Nevada',
			Null,
			Null,
			GetDate(),
			GetDate()
		)
END
/*** Add additional states here ***/
GO