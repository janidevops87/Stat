/******************************************************************************
**	File: ReferralType.sql
**	Name: ReferralType
**	Desc: new referral types and abbreviations
**	Auth: jth
**	Date: 3/7/11
*******************************************************************************/


		
IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 1) = 1)
BEGIN
	UPDATE ReferralType 
		SET ReferralAbbreviation = 'OTE'
	WHERE ReferralTypeID = 1
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 2) = 1)
BEGIN
	UPDATE ReferralType 
		SET ReferralAbbreviation = 'TE'
	WHERE ReferralTypeID = 2
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 3) = 1)
BEGIN
	UPDATE ReferralType 
		SET ReferralAbbreviation = 'E'
	WHERE ReferralTypeID = 3
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 4) = 1)
BEGIN
	UPDATE ReferralType 
		SET ReferralAbbreviation = 'RO'
	WHERE ReferralTypeID = 4
END

SET IDENTITY_INSERT ReferralType ON;
		
IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 5) = 0)
BEGIN
	INSERT INTO ReferralType (ReferralTypeID, ReferralTypeName, Verified, Inactive,UpdatedFlag,ReferralAbbreviation) 
	VALUES
	(5, 'Organ/Tissue', 0, 0,null,'OT')
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 6) = 0)
BEGIN
	INSERT INTO ReferralType (ReferralTypeID, ReferralTypeName, Verified, Inactive,UpdatedFlag,ReferralAbbreviation) 
	VALUES
	(6, 'Organ/Eye', 0, 0,null,'OE')
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 7) = 0)
BEGIN
	INSERT INTO ReferralType (ReferralTypeID, ReferralTypeName, Verified, Inactive,UpdatedFlag,ReferralAbbreviation) 
	VALUES
	(7, 'Organ', 0, 0,null,'O')
END

IF ((SELECT count(*) FROM ReferralType WHERE ReferralTypeID = 8) = 0)
BEGIN
	INSERT INTO ReferralType (ReferralTypeID, ReferralTypeName, Verified, Inactive,UpdatedFlag,ReferralAbbreviation) 
	VALUES
	(8, 'Tissue', 0, 0,null,'T')
END

SET IDENTITY_INSERT ReferralType OFF;	 