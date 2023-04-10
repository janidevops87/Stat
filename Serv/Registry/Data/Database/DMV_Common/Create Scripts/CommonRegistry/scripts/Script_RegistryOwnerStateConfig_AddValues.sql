/* Add RegistryOwnerStateConfig data
*/


USE DMV_Common
GO

DECLARE @RegistryOwnerID int

/*** Start Registry Owner ***/
IF (SELECT Count(*) FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') = 0
BEGIN
	INSERT RegistryOwner
		(
			RegistryOwnerName,
			SourceCodeID,
			DisplaySearchPendingSignature,
			DisplaySearchResultDateField,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			'NEOB',
			Null,
			0,
			0,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') = 0
BEGIN
	INSERT RegistryOwner
		(
			RegistryOwnerName,
			SourceCodeID,
			DisplaySearchPendingSignature,
			DisplaySearchResultDateField,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			'CODA',
			Null,
			1,
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END


/*** Start Registry Owner State Configuration ***/
/*** NEOB ***/
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CT') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			7, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'CT',
			'Connecticut',
			'CT_VerificationForm',
			'DMV_CT',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MA') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			19, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'MA',
			'Massachusetts',
			'MA_VerificationForm',
			'DMV_MA',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'ME') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			18, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'ME',
			'Maine',
			'ME_VerificationForm',
			'DMV_ME',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NH') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			27, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'NH',
			'New Hampshire',
			'NH_VerificationForm',
			'DMV_NH',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'RI') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			37, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'RI',
			'Rhode Island',
			'RI_VerificationForm',
			'DMV_RI',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'VT') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			44, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'VT',
			'Vermont',
			'VT_VerificationForm',
			'DMV_VT',
			0,
			GetDate(),
			GetDate(),
			1,
			1
		)
END /*** NEOB ***/

/*** CODA **/
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CO') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			6, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'CO',
			'Colorado',
			'CO_VerificationForm',
			'DMV_CO',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END


IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'WY') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') 

	INSERT RegistryOwnerStateConfig
		(
			RegistryOwnerID,
			RegistryOwnerStateID,
			RegistryOwnerStateAbbrv,
			RegistryOwnerStateName,
			RegistryOwnerStateVerificationform,
			RegistryOwnerStateDMVDSN,
			RegistryOwnerStateActive,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			48, -- Stattrac StateID SELECT * FROM _ReferralDev1..STATE
			'WY',
			'Wyoming',
			'WY_VerificationForm',
			'DMV_WY',
			1,
			GetDate(),
			GetDate(),
			1,
			1
		)
END /*** CODA **/


/*** Add RegistryOwnerUserOrgID ***/
IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 1595) = 0
BEGIN
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				1595, 
				GetDate(),
				GetDate(),
				1,
				1
			)
END

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 1555) = 0
BEGIN
	SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB') 

		INSERT RegistryOwnerUserOrg
			(
				RegistryOwnerID,
				UserOrgID,
				CreateDate,
				LastModified,
				LastStatEmployeeID,
				AuditLogTypeID
			)
		VALUES
			(
				@RegistryOwnerID,
				1555, 
				GetDate(),
				GetDate(),
				1,
				1
			)
END
/*** NEOB **/

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 50) = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') 

	INSERT RegistryOwnerUserOrg
		(
			RegistryOwnerID,
			UserOrgID,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			50, 
			GetDate(),
			GetDate(),
			1,
			1
		)
END /*** CODA **/

IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = 51) = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'CODA') 

	INSERT RegistryOwnerUserOrg
		(
			RegistryOwnerID,
			UserOrgID,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		)
	VALUES
		(
			@RegistryOwnerID,
			51, 
			GetDate(),
			GetDate(),
			1,
			1
		)
END /*** CODA **/