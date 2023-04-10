/*	AddRegistryOwnerStateConfig
	To find OPOs Use FindOrganizationsBySourceCodeName.sql
	Note: This script needs to be first dataload script in manifest
	Add RegistryOwner - Owner of Registry
	Add RegistryOwnerStateConfig - Legal for Verification Forms by State
	Add RegistryOwnerUserOrg - OPOs allowed to access Registry Portal and Reports
	:

	Nevada Donor registry (NDN)
	Add State configurations for NV, AZ, CA, UT, and NM
	ccarroll 02/09/2010 initial release
	ccarroll 04/26/2010 - added following organizations per HS 23408
	4237	CA- Calif Transplant Donor Network (Organs)
	4243	CA- Golden State Donor Services (Organs)
	4236	CA- Sierra Eye & Tissue Donor Services
	14360	University of Nevada School of Medicine
	10645	UT- Intermountain Donor Services
	
	New England Donor Registry (NEOB) HS 23415
	4321	CT- LifeChoice Donor Services
	4322	CT- Connecticut Eye Bank
	5745	NY- Center for Donation & Transplant

	ccarroll 01/11/2011 (NORS)
	Added States (ALL)
	Nebraska Organ Recovery System (NORS)
	423		NE- A Nebraska Organ Recovery System
*/


DECLARE @RegistryOwnerID int

/*** Start Registry Owner ***/
/* Nevada Donor registry (NDN)*/
IF (SELECT Count(*) FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') = 0
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
			AuditLogTypeID,
			IDologyActive,
			IDologyLogin,
			IDologyPassword,
			IDologySpLogin,
			IDologySpPassword
			
		)
	VALUES
		(
			'NDN',
			Null,
			0,
			0,
			GetDate(),
			GetDate(),
			1100,
			1, -- AuditLogTypeID
			1,
			'jtvPsjoEyiWm+lvnQC/Vow==//////fJFi2Ipuef4Kufpyqrw5hA==',
			'i7lMnTY9tOcfKzivk+1C4g==//////XUNkAwNkjk9u7/gEWV3K6A==',
			'RB71CNJtMf/Ek2z+cv26aQ==//////o3MBnlT5XATgq21ot1kRBQ==',
			'blWh4nzX2vR76P1hFI98zQ==//////paVucJwIEGI2YvtRuhnfjQ=='
		)
END

/* Nebraska Organ Recovery System (NORS)*/
IF (SELECT Count(*) FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') = 0
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
			AuditLogTypeID,
			IDologyActive,
			IDologyLogin,
			IDologyPassword,
			IDologySpLogin,
			IDologySpPassword,
			EnrollmentFormHideComments,
			EnrollmentFormDefaultStateSelection,
			RegistryOwnerRouteName
		)
	VALUES
		(
			'NORS',
			Null,
			0, --DisplaySearchPendingSignature
			0, --DisplaySearchResultDateField
			GetDate(),
			GetDate(),
			1100, 
			1, -- AuditLogTypeID
			0, -- IDologyActive
			'', -- IDologyLogin
			'', -- IDologyPassword
			'', -- IDologySpLogin
			'', -- IDologySpPassword
			1, -- EnrollmentFormHideComments
			'NE', -- EnrollmentFormDefaultStateSelection
			'ne' -- RegistryOwnerRouteName
		)
END

/*** Start Registry Owner State Configuration ***/
/* NDN */
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NV') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			26, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NV', -- RegistryOwnerStateAbbrv
			'Nevada', -- RegistryOwnerStateName
			'NV_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NV', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Donor Comments:', -- lblLimitationsText
			'<br>' +
			'<table>' +
			'<tr><td width=''300px;''><strong>California Transplant Donor Network</strong</td><td><strong>Nevada Organ and Tissue Donor Task Force</strong></td></tr>' +
			'<tr><td><strong>888-570-9400</strong></td><td><strong>775-784-6171</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Nevada Donor Network</strong</td><td><strong>Intermountain Donor Services</strong></td></tr>' +
			'<tr><td><strong>720-796-9600</strong></td><td><strong>801-521-1755</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr>' +
			'<tr><td><strong>775-323-1566</strong></td><td></td></tr>' +
			'</table>', -- ContactInformationText
			'<strong>Confidential Donor Registry Verification</strong>', -- LegalHeaderText
			'Nevada: Pursuant to NRS 451.500et seq.', -- LegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from ' +
			'the deceased for anatomical gifts to be made upon their death. A signature is not required.', -- LegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- LegalDescriptionlText
			'<strong>Confidential Donor Registry Verification</strong>', -- WebLegalHeader
			'Nevada: Pursuant to NRS 451.500et seq.', -- WebLegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from the deceased for ' +
			'anatomical gifts to be made upon their death. A signature is not required.', -- WebLegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- WebLegalDescriptionlText
			0 -- DisableDMVSearchOption
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'AZ') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			3, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'AZ', -- RegistryOwnerStateAbbrv
			'Arizona', -- RegistryOwnerStateName
			'AZ_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NV', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- RegistryOwnerStatelblStateIdText
			'Donor Comments:', -- lblLimitationsText
			'<br>' +
			'<table>' +
			'<tr><td width=''300px;''><strong>California Transplant Donor Network</strong</td><td><strong>Nevada Organ and Tissue Donor Task Force</strong></td></tr>' +
			'<tr><td><strong>888-570-9400</strong></td><td><strong>775-784-6171</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Nevada Donor Network</strong</td><td><strong>Intermountain Donor Services</strong></td></tr>' +
			'<tr><td><strong>720-796-9600</strong></td><td><strong>801-521-1755</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr>' +
			'<tr><td><strong>775-323-1566</strong></td><td></td></tr>' +
			'</table>', -- ContactInformationText
			'<strong>Confidential Donor Registry Verification</strong>', -- LegalHeaderText
			'Nevada: Pursuant to NRS 451.500et seq.', -- LegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from ' +
			'the deceased for anatomical gifts to be made upon their death. A signature is not required.', -- LegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- LegalDescriptionlText
			'<strong>Confidential Donor Registry Verification</strong>', -- WebLegalHeader
			'Nevada: Pursuant to NRS 451.500et seq.', -- WebLegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from the deceased for ' +
			'anatomical gifts to be made upon their death. A signature is not required.', -- WebLegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CA') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			5, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'CA', -- RegistryOwnerStateAbbrv
			'California', -- RegistryOwnerStateName
			'CA_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NV', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Donor Comments:', -- lblLimitationsText
			'<br>' +
			'<table>' +
			'<tr><td width=''300px;''><strong>California Transplant Donor Network</strong</td><td><strong>Nevada Organ and Tissue Donor Task Force</strong></td></tr>' +
			'<tr><td><strong>888-570-9400</strong></td><td><strong>775-784-6171</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Nevada Donor Network</strong</td><td><strong>Intermountain Donor Services</strong></td></tr>' +
			'<tr><td><strong>720-796-9600</strong></td><td><strong>801-521-1755</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr>' +
			'<tr><td><strong>775-323-1566</strong></td><td></td></tr>' +
			'</table>', -- ContactInformationText
			'<strong>Confidential Donor Registry Verification</strong>', -- LegalHeaderText
			'Nevada: Pursuant to NRS 451.500et seq.', -- LegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from ' +
			'the deceased for anatomical gifts to be made upon their death. A signature is not required.', -- LegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- LegalDescriptionlText
			'<strong>Confidential Donor Registry Verification</strong>', -- WebLegalHeader
			'Nevada: Pursuant to NRS 451.500et seq.', -- WebLegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from the deceased for ' +
			'anatomical gifts to be made upon their death. A signature is not required.', -- WebLegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'UT') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			42, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'UT', -- RegistryOwnerStateAbbrv
			'Utah', -- RegistryOwnerStateName
			'UT_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_UT', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Donor Comments:', -- lblLimitationsText
			'<br>' +
			'<table>' +
			'<tr><td width=''300px;''><strong>California Transplant Donor Network</strong</td><td><strong>Nevada Organ and Tissue Donor Task Force</strong></td></tr>' +
			'<tr><td><strong>888-570-9400</strong></td><td><strong>775-784-6171</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Nevada Donor Network</strong</td><td><strong>Intermountain Donor Services</strong></td></tr>' +
			'<tr><td><strong>720-796-9600</strong></td><td><strong>801-521-1755</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr>' +
			'<tr><td><strong>775-323-1566</strong></td><td></td></tr>' +
			'</table>', -- ContactInformationText
			'<strong>Confidential Donor Registry Verification</strong>', -- LegalHeaderText
			'Nevada: Pursuant to NRS 451.500et seq.', -- LegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from ' +
			'the deceased for anatomical gifts to be made upon their death. A signature is not required.', -- LegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- LegalDescriptionlText
			'<strong>Confidential Donor Registry Verification</strong>', -- WebLegalHeader
			'Nevada: Pursuant to NRS 451.500et seq.', -- WebLegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from the deceased for ' +
			'anatomical gifts to be made upon their death. A signature is not required.', -- WebLegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END

IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NM') = 0
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') 

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			29, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NM', -- RegistryOwnerStateAbbrv
			'New Mexico', -- RegistryOwnerStateName
			'NM_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NV', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Donor Comments:', -- lblLimitationsText
			'<br>' +
			'<table>' +
			'<tr><td width=''300px;''><strong>California Transplant Donor Network</strong</td><td><strong>Nevada Organ and Tissue Donor Task Force</strong></td></tr>' +
			'<tr><td><strong>888-570-9400</strong></td><td><strong>775-784-6171</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Nevada Donor Network</strong</td><td><strong>Intermountain Donor Services</strong></td></tr>' +
			'<tr><td><strong>720-796-9600</strong></td><td><strong>801-521-1755</strong></td></tr>' +
			'<tr><td width=''300px;''><strong>Sierra Eye Tissue Donor Services</strong</td><td></td></tr>' +
			'<tr><td><strong>775-323-1566</strong></td><td></td></tr>' +
			'</table>', -- ContactInformationText
			'<strong>Confidential Donor Registry Verification</strong>', -- LegalHeaderText
			'Nevada: Pursuant to NRS 451.500et seq.', -- LegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from ' +
			'the deceased for anatomical gifts to be made upon their death. A signature is not required.', -- LegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- LegalDescriptionlText
			'<strong>Confidential Donor Registry Verification</strong>', -- WebLegalHeader
			'Nevada: Pursuant to NRS 451.500et seq.', -- WebLegalIntroText
			'The deceased named below is listed in the Donor Registry. This is an authorization from the deceased for ' +
			'anatomical gifts to be made upon their death. A signature is not required.', -- WebLegalText
			'<p>Under the Nevada Revised Statutes, an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The law also authorizes any examination necessary to assure the medical acceptability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, organ, tissue, and eye recovery agency representatives ' +
			'are authorized to examine or remove copies of medical records, obtain blood and tissue samples to test for ' +
			'hepatitis, HIV, syphilis, and conduct any other examination to determine the medical suitability of the ' +
			'anatomical gift.</p>' +
			'<p>A different location may be needed to carry out the recovery of donated tissues. In that case, the body ' +
			'may be transferred to an alternative surgical facility for the recovery of tissues.</p>' +
			'<p>The Registry will only accommodate restrictions or exclusions related to individual organs ' +
			'or tissues that can be removed for purposes of transplantation, medical education or research. ' +
			'Organs are distributed according to national regulations.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


/* Nebraska Organ Recovery System (NORS)*/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NE' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			25, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NE', -- RegistryOwnerStateAbbrv
			'Nebraska', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			0 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'AL' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			1, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'AL', -- RegistryOwnerStateAbbrv
			'Alabama', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'AK' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN

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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			2, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'AK', -- RegistryOwnerStateAbbrv
			'ALaska', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'AZ' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			3, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'AZ', -- RegistryOwnerStateAbbrv
			'Arizona', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'AR' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			4, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'AR', -- RegistryOwnerStateAbbrv
			'Arkansas', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			5, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'CA', -- RegistryOwnerStateAbbrv
			'California', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CO' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			6, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'CO', -- RegistryOwnerStateAbbrv
			'Colorado', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'CT' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			7, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'CT', -- RegistryOwnerStateAbbrv
			'Connecticut', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'DE' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			8, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'DE', -- RegistryOwnerStateAbbrv
			'Delaware', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'DC' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			9, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'DC', -- RegistryOwnerStateAbbrv
			'District Of Columbia', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'FL' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			10, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'FL', -- RegistryOwnerStateAbbrv
			'Florida', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'GA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			0, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'GA', -- RegistryOwnerStateAbbrv
			'Georgia', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'HI' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			11, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'HI', -- RegistryOwnerStateAbbrv
			'Hawaii', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'ID' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			0, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'ID', -- RegistryOwnerStateAbbrv
			'Idaho', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'IL' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			12, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'IL', -- RegistryOwnerStateAbbrv
			'Illinois', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'IN' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			13, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'IN', -- RegistryOwnerStateAbbrv
			'Indiana', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'IA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			14, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'IA', -- RegistryOwnerStateAbbrv
			'Iowa', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'KS' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			15, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'KS', -- RegistryOwnerStateAbbrv
			'Kansas', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'KY' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			16, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'KY', -- RegistryOwnerStateAbbrv
			'Kentucky', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'LA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			17, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'LA', -- RegistryOwnerStateAbbrv
			'Louisiana', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'ME' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			18, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'ME', -- RegistryOwnerStateAbbrv
			'Maine', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MD' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			0, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MD', -- RegistryOwnerStateAbbrv
			'Maryland', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			19, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MA', -- RegistryOwnerStateAbbrv
			'Massachusetts', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MI' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			20, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MI', -- RegistryOwnerStateAbbrv
			'Michigan', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MN' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			21, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MN', -- RegistryOwnerStateAbbrv
			'Minnesota', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MS' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			22, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MS', -- RegistryOwnerStateAbbrv
			'Mississippi', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MO' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			23, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MO', -- RegistryOwnerStateAbbrv
			'Missouri', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'MT' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			24, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'MT', -- RegistryOwnerStateAbbrv
			'Montana', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END



SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NV' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			26, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NV', -- RegistryOwnerStateAbbrv
			'Nevada', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NH' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			27, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NH', -- RegistryOwnerStateAbbrv
			'New Hampshire', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NJ' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			28, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NJ', -- RegistryOwnerStateAbbrv
			'New Jersey', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NM' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			29, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NM', -- RegistryOwnerStateAbbrv
			'New Mexico', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NY' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			30, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NY', -- RegistryOwnerStateAbbrv
			'New York', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'NC' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			31, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'NC', -- RegistryOwnerStateAbbrv
			'North Carolina', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'ND' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			32, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'ND', -- RegistryOwnerStateAbbrv
			'North Dekota', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'OH' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			33, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'OH', -- RegistryOwnerStateAbbrv
			'Ohio', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'OK' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			34, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'OK', -- RegistryOwnerStateAbbrv
			'Oklahoma', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'OR' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			35, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'OR', -- RegistryOwnerStateAbbrv
			'Oregon', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'PA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			36, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'PA', -- RegistryOwnerStateAbbrv
			'Pennsylvania', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'RI' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			37, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'RI', -- RegistryOwnerStateAbbrv
			'Rhode Island', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'SC' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			38, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'SC', -- RegistryOwnerStateAbbrv
			'South Carolina ', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'SD' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			39, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'SD', -- RegistryOwnerStateAbbrv
			'South Dekota', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'TN' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			40, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'TN', -- RegistryOwnerStateAbbrv
			'Tennessee', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'TX' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			41, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'TX', -- RegistryOwnerStateAbbrv
			'Texas', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'UT' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			41, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'UT', -- RegistryOwnerStateAbbrv
			'Utah', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'VT' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			42, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'VT', -- RegistryOwnerStateAbbrv
			'Vermont', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'VA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			43, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'VA', -- RegistryOwnerStateAbbrv
			'Virginia', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'WA' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			44, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'WA', -- RegistryOwnerStateAbbrv
			'Washington', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END

SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'WV' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			45, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'WV', -- RegistryOwnerStateAbbrv
			'West Virginia', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'WI' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			46, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'WI', -- RegistryOwnerStateAbbrv
			'Wisconsin', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END


SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS') 
IF (SELECT Count(*) FROM RegistryOwnerStateConfig WHERE RegistryOwnerStateAbbrv = 'WY' AND RegistryOwnerID = @RegistryOwnerID) = 0
BEGIN
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
			AuditLogTypeID,
			lblStateIdText,
			lblLimitationsText,
			ContactInformationText,
			LegalHeaderText,
			LegalIntroText,
			LegalText,
			LegalDescriptionlText,
			WebLegalHeader,
			WebLegalIntroText,
			WebLegalText,
			WebLegalDescriptionlText,
			DisableDMVSearchOption
		)
	VALUES
		(
			@RegistryOwnerID,
			47, -- Stattrac StateID SELECT * FROM _ReferralDev2..STATE
			'WY', -- RegistryOwnerStateAbbrv
			'Wyoming', -- RegistryOwnerStateName
			'NE_VerificationForm', -- RegistryOwnerStateVerificationform
			'DMV_NE', -- RegistryOwnerStateDMVDSN
			1, -- RegistryOwnerStateActive
			GetDate(), -- CreateDate
			GetDate(), -- LastModified
			1100, -- LastStatEmployeeID
			1, -- AuditLogTypeID
			'Driver''s License/ID number <BR> Or Registry ID number: ', -- lblStateIdText
			'Restrictions:', -- lblLimitationsText
			'<br><table><tr><td width=''400px;''><img src=''images/nors_logo.gif''></td><td><img src=''images/nors_eyebank.gif''></td></tr><tr><td width=''300px;''><strong>Nebraska Organ Recovery System</strong</td><td><strong>Lions Eye Bank of Nebraska</strong></td></tr><tr><td><strong>(800)925-0215</strong></td><td><strong>(800)225-7244</strong></td></tr></table>&nbsp&nbsp', -- ContactInformationText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- LegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- LegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- LegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- LegalDescriptionlText
			'<strong>Donor Registry of Nebraska Verification</strong>', -- WebLegalHeaderText
			'<i>Pursuant to Neb. Rev. Stat. §71-4801 et. Seq.</i>', -- WebLegalIntroText
			'The individual named below has registered to be included in the Donor Registry of Nebraska established by Neb. Rev. Stat. §71-4822. ' +
			'This is an authorization for anatomical gifts to be made upon his/her death.', -- WebLegalText
			'<p>Under Nebraska’s Uniform Anatomical Gift Act (the “Act”), an anatomical gift not revoked by the donor before death ' +
			'is irrevocable and does not require consent or concurrence of any person after the donor''s death. ' +
			'The Act also authorizes any medical examination necessary to assure the medical suitability of the anatomical gift.</p>' +
			'<p>In order to comply with the wishes of this deceased, representatives of Nebraska Organ Recovery System and/or the ' +
			'Lions Eye Bank of Nebraska are authorized to examine or remove copies of medical records, obtain blood and tissue samples ' +
			'for infectious disease testing, and conduct any other examination to determine the medical suitability of the anatomical gift. </p>' +
			'<p>The recovery of donated organs and/or tissues ' +
			'may be conducted at an alternative surgical facility.</p>', -- WebLegalDescriptionlText
			1 -- DisableDMVSearchOption
		)
END
/**** END AddRegistryOwnerStateConfig ***/
GO



