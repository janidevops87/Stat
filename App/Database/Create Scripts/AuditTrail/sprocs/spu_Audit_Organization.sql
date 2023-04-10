SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Organization]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_Organization'
		drop procedure [dbo].[spu_Audit_Organization]
	END
GO

	PRINT 'Creating Procedure spu_Audit_Organization'
GO

CREATE procedure [dbo].[spu_Audit_Organization] 
	@c1 int,
	@c2 varchar(80),
	@c3 varchar(80),
	@c4 varchar(80),
	@c5 varchar(30),
	@c6 int,
	@c7 varchar(6),
	@c8 int,
	@c9 int,
	@c10 int,
	@c11 varchar(3),
	@c12 varchar(255),
	@c13 smallint,
	@c14 smallint,
	@c15 smallint,
	@c16 smallint,
	@c17 smallint,
	@c18 smallint,
	@c19 smallint,
	@c20 smallint,
	@c21 smallint,
	@c22 smallint,
	@c23 smallint,
	@c24 smallint,
	@c25 int,
	@c26 datetime,
	@c27 smallint,
	@c28 varchar(10),
	@c29 ntext,
	@c30 ntext,
	@c31 int,
	@c32 smallint,
	@c33 smallint,
	@c34 int,
	@c35 smallint,
	@c36 smallint,
	@c37 smallint,
	@c38 int,
	@c39 int,
	@c40 int, -- ContractedStatlineClient	bit	no	1
	@c41 int, -- CountryID	int	no	4
	@c42 nvarchar(20), -- ProviderNumber	nvarchar	no	20
	@c43 nvarchar(8), -- UnosCode	nvarchar	no	8
	@c44 int, -- OrganizationStatusId	int	no	4
	@c45 int, -- TimeZoneId	int	no	4
	@c46 int, -- ObservesDaylightSavings	bit	no	1
	@c47 int, -- IddId	int	no	4
	@c48 int, -- CountryCodeId	int	no	4
	@c49 int, -- StatTracOrganization	bit	no	1
	@c50 varchar(20), -- FacilityEreferralCode
	@pkc1 int,
	@bitmap binary(7)
AS
/******************************************************************************
**		File: spu_Audit_Organization.sql
**		Name: spu_Audit_Organization
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int

IF (
		SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- OrganizationID
		OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- OrganizationName
		OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- OrganizationAddress1
		OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- OrganizationAddress2
		OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- OrganizationCity
		OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- StateID
		OR SUBSTRING(@bitmap, 1, 1) & 64 = 64 -- OrganizationZipCode
		OR SUBSTRING(@bitmap, 1, 1) & 128 = 128 -- CountyID
		OR SUBSTRING(@bitmap, 2, 1) & 1 = 1 -- OrganizationTypeID
		OR SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- PhoneID
		OR SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- OrganizationTimeZone
		OR SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- OrganizationNotes
		OR SUBSTRING(@bitmap, 2, 1) & 16 = 16 -- OrganizationNoPatientName
		OR SUBSTRING(@bitmap, 2, 1) & 32 = 32 -- OrganizationNoRecordNum
		OR SUBSTRING(@bitmap, 2, 1) & 64 = 64 -- Verified
		OR SUBSTRING(@bitmap, 2, 1) & 128 = 128 -- Inactive
		OR SUBSTRING(@bitmap, 3, 1) & 1 = 1 -- OrganizationNoAdmitDateTime
		OR SUBSTRING(@bitmap, 3, 1) & 2 = 2 -- OrganizationNoWeight
		OR SUBSTRING(@bitmap, 3, 1) & 4 = 4 -- OrganizationConfCallCust
		OR SUBSTRING(@bitmap, 3, 1) & 8 = 8 -- Unused2
		OR SUBSTRING(@bitmap, 3, 1) & 16 = 16 -- Unused3
		OR SUBSTRING(@bitmap, 3, 1) & 32 = 32 -- Unused4
		OR SUBSTRING(@bitmap, 3, 1) & 64 = 64 -- Unused5
		OR SUBSTRING(@bitmap, 3, 1) & 128 = 128 -- Unused6
		OR SUBSTRING(@bitmap, 4, 1) & 1 = 1 -- OrganizationPageInterval
		OR SUBSTRING(@bitmap, 4, 1) & 2 = 2 -- LastModified
		OR SUBSTRING(@bitmap, 4, 1) & 4 = 4 -- Unused8
		OR SUBSTRING(@bitmap, 4, 1) & 8 = 8 -- OrganizationUserCode
		OR LEN(ISNULL(CONVERT(VARCHAR, @C29), '')) > 0 -- OrganizationReferralNotes
		OR LEN(ISNULL(CONVERT(VARCHAR, @C30), '')) > 0 -- OrganizationMessageNotes
		OR SUBSTRING(@bitmap, 4, 1) & 64 = 64 -- OrganizationConsentInterval
		OR SUBSTRING(@bitmap, 4, 1) & 128 = 128 -- OrganizationLO
		OR SUBSTRING(@bitmap, 5, 1) & 1 = 1 -- OrganizationLOEnabled
		OR SUBSTRING(@bitmap, 5, 1) & 2 = 2 -- OrganizationLOType
		OR SUBSTRING(@bitmap, 5, 1) & 4 = 4 -- OrganizationLOTriageEnabled
		OR SUBSTRING(@bitmap, 5, 1) & 8 = 8 -- OrganizationLOFSEnabled
		OR SUBSTRING(@bitmap, 5, 1) & 16 = 16 -- OrganizationArchive
		OR SUBSTRING(@bitmap, 5, 1) & 32 = 32 -- LastStatEmployeeID
		OR SUBSTRING(@bitmap, 5, 1) & 64 = 64 -- AuditLogTypeID
		OR SUBSTRING(@bitmap, 5, 1) & 128 = 128	-- ContractedStatlineClient	bit	no	1
		OR SUBSTRING(@bitmap, 6, 1) & 1 = 1 --  -- CountryID	int	no	4
		OR SUBSTRING(@bitmap, 6, 1) & 2 = 2 --  -- ProviderNumber	nvarchar	no	20
		OR SUBSTRING(@bitmap, 6, 1) & 4 = 4 --  -- UnosCode	nvarchar	no	8
		OR SUBSTRING(@bitmap, 6, 1) & 8 = 8 --  -- OrganizationStatusId	int	no	4
		OR SUBSTRING(@bitmap, 6, 1) & 16 = 16 -- TimeZoneId	int	no	4
		OR SUBSTRING(@bitmap, 6, 1) & 32 = 32 -- ObservesDaylightSavings	bit	no	1
		OR SUBSTRING(@bitmap, 6, 1) & 64 = 64  -- IddId	int	no	4
		OR SUBSTRING(@bitmap, 6, 1) & 128 = 128 -- CountryCodeId	int	no	4
		OR SUBSTRING(@bitmap, 7, 1) & 1 = 1 -- StatTracOrganization	bit	no	1
		OR SUBSTRING(@bitmap, 7, 1) & 2 = 2 -- FacilityEreferralCode
		)
BEGIN		
	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c39, 3) -- use Modify as default
	FROM
		Organization
	WHERE 
		OrganizationID = @pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a Review or Modify or Delete
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- OrganizationID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- OrganizationName
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- OrganizationAddress1
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- OrganizationAddress2
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- OrganizationCity
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- StateID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- OrganizationZipCode
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- CountyID
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- OrganizationTypeID
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- PhoneID
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- OrganizationTimeZone
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- OrganizationNotes
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- OrganizationNoPatientName
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- OrganizationNoRecordNum
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- Verified
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- Inactive
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- OrganizationNoAdmitDateTime
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- OrganizationNoWeight
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- OrganizationConfCallCust
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- Unused2
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- Unused3
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- Unused4
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- Unused5
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- Unused6
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- OrganizationPageInterval
		AND SUBSTRING(@bitmap, 4, 1) & 2 = 2 -- LastModified
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- Unused8
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- OrganizationUserCode
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- OrganizationReferralNotes
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- OrganizationMessageNotes
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- OrganizationConsentInterval
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- OrganizationLO
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- OrganizationLOEnabled
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- OrganizationLOType
		AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- OrganizationLOTriageEnabled
		AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- OrganizationLOFSEnabled
		AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- OrganizationArchive
		-- AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- LastStatEmployeeID
		AND IsNull(@auditLogTypeID, 2) IN (2, 3, 4)	
		AND SUBSTRING(@bitmap, 5, 1) & 128 = 128 -- ContractedStatlineClient
		AND SUBSTRING(@bitmap, 6, 1) & 1 = 1 --  -- CountryID	
		AND SUBSTRING(@bitmap, 6, 1) & 2 = 2 --  -- ProviderNumber	
		AND SUBSTRING(@bitmap, 6, 1) & 4 = 4 --  -- UnosCode	
		AND SUBSTRING(@bitmap, 6, 1) & 8 = 8 --  -- ANDganizationStatusId	
		AND SUBSTRING(@bitmap, 6, 1) & 16 = 16 -- TimeZoneId	
		AND SUBSTRING(@bitmap, 6, 1) & 32 = 32 -- ObservesDaylightSavings	
		AND SUBSTRING(@bitmap, 6, 1) & 64 = 64  -- IddId	
		AND SUBSTRING(@bitmap, 6, 1) & 128 = 128 -- CountryCodeId	
		AND SUBSTRING(@bitmap, 7, 1) & 1 = 1 -- StatTracOrganization	
		AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- FacilityEreferralCode
		)


BEGIN 	/* Only LastModified Changed. Check for Deleted record */
	IF 	@auditLogTypeID <> 4 --Deleted
		BEGIN
			SET @auditLogTypeID = 2	-- Review
		END
	ELSE
		BEGIN
			SET @auditLogTypeID = 4	-- Deleted
		END
END


insert into 
	"Organization"
	( 
		"OrganizationID", -- c1
		"OrganizationName", -- c2
		"OrganizationAddress1", -- c3
		"OrganizationAddress2", -- c4
		"OrganizationCity", -- c5
		"StateID", -- c6
		"OrganizationZipCode", -- c7
		"CountyID", -- c8
		"OrganizationTypeID", -- c9
		"PhoneID", -- c10
		"OrganizationTimeZone", -- c11
		"OrganizationNotes", -- c12
		"OrganizationNoPatientName", -- c13
		"OrganizationNoRecordNum", -- c14
		"Verified", -- c15
		"Inactive", -- c16
		"OrganizationNoAdmitDateTime", -- c17
		"OrganizationNoWeight", -- c18
		"OrganizationConfCallCust", -- c19
		"Unused2", -- c20
		"Unused3", -- c21
		"Unused4", -- c22
		"Unused5", -- c23
		"Unused6", -- c24
		"OrganizationPageInterval", -- c25
		"LastModified", -- c26
		"Unused8", -- c27
		"OrganizationUserCode", -- c28
		"OrganizationReferralNotes", -- c29
		"OrganizationMessageNotes", -- c30
		"OrganizationConsentInterval", -- c31
		"OrganizationLO", -- c32
		"OrganizationLOEnabled", -- c33
		"OrganizationLOType", -- c34
		"OrganizationLOTriageEnabled", -- c35
		"OrganizationLOFSEnabled", -- c36
		"OrganizationArchive", -- c37
		"LastStatEmployeeID", -- c38
		"AuditLogTypeID", -- c39
		"ContractedStatlineClient", -- c40
		"CountryID", -- c41
		"ProviderNumber", -- c42
		"UnosCode", -- c43
		"OrganizationStatusId", -- c44
		"TimeZoneId", -- c45
		"ObservesDaylightSavings", -- c46
		"IddId", -- c47
		"CountryCodeId", -- c48
		"StatTracOrganization", -- c49		
		"FacilityEreferralCode"
	)

values 
	( 
		@pkc1,
		CASE WHEN /*OrganizationName*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
		CASE WHEN /*OrganizationAddress1*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
		CASE WHEN /*OrganizationAddress2*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
		CASE WHEN /*OrganizationCity*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN 'ILB' ELSE @c5 END,
		CASE WHEN /*StateID*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*OrganizationZipCode*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
		CASE WHEN /*CountyID*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
		CASE WHEN /*OrganizationTypeID*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, -1) IN ( -1, 0) THEN -2 ELSE @c9 END,
		CASE WHEN /*PhoneID*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, -1) IN ( -1, 0) THEN -2 ELSE @c10 END,
		CASE WHEN /*OrganizationTimeZone*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, '') = '' THEN 'ILB' ELSE @c11 END,
		CASE WHEN /*OrganizationNotes*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN 'ILB' ELSE @c12 END,
		CASE WHEN /*OrganizationNoPatientName*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 THEN @c13 END, -- YN do not show ILB
		CASE WHEN /*OrganizationNoRecordNum*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 THEN @c14 END, -- YN do not show ILB
		CASE WHEN /*Verified*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 THEN @c15 END, -- YN do not show ILB
		CASE WHEN /*Inactive*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 THEN @c16 END, -- YN do not show ILB
		CASE WHEN /*OrganizationNoAdmitDateTime*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 THEN @c17 END, -- YN do not show ILB
		CASE WHEN /*OrganizationNoWeight*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 THEN @c18 END, -- YN do not show ILB
		CASE WHEN /*OrganizationConfCallCust*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 THEN @c19 END, -- YN do not show ILB
		CASE WHEN /*Unused2*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@c20, -1) IN ( -1, 0) THEN -2 ELSE @c20 END,
		CASE WHEN /*Unused3*/ SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@c21, -1) IN ( -1, 0) THEN -2 ELSE @c21 END,
		CASE WHEN /*Unused4*/ SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@c22, -1) IN ( -1, 0) THEN -2 ELSE @c22 END,
		CASE WHEN /*Unused5*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, -1) IN ( -1, 0) THEN -2 ELSE @c23 END,
		CASE WHEN /*Unused6*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, -1) IN ( -1, 0) THEN -2 ELSE @c24 END,
		CASE WHEN /*OrganizationPageInterval*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND @c25 = 0 THEN -2 ELSE @c25 END,
		ISNULL(@c26, @lastModified),
		CASE WHEN /*Unused8*/ SUBSTRING(@bitmap, 4, 1) & 4 = 4 AND IsNull(@c27, -1) IN ( -1, 0) THEN -2 ELSE @c27 END,
		CASE WHEN /*OrganizationUserCode*/ SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@c28, '') = '' THEN 'ILB' ELSE @c28 END,
		@c29,	  /*rganizationReferralNotes*/
		@c30,	  /*OrganizationMessageNotes*/
		CASE WHEN /*OrganizationConsentInterval*/ SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@c31, 0) = 0 THEN -2 ELSE @c31 END,
		CASE WHEN /*OrganizationLO*/ SUBSTRING(@bitmap, 4, 1) & 128 = 128 THEN @c32 END, -- YN do not show ILB
		CASE WHEN /*OrganizationLOEnabled*/ SUBSTRING(@bitmap, 5, 1) & 1 = 1 THEN @c33 END, -- YN do not show ILB
		CASE WHEN /*OrganizationLOType*/ SUBSTRING(@bitmap, 5, 1) & 2 = 2 AND IsNull(@c34, -1) IN ( -1, 0) THEN -2 ELSE @c34 END,
		CASE WHEN /*OrganizationLOTriageEnabled*/ SUBSTRING(@bitmap, 5, 1) & 4 = 4 THEN @c35 END, -- YN do not show ILB
		CASE WHEN /*OrganizationLOFSEnabled*/ SUBSTRING(@bitmap, 5, 1) & 8 = 8 THEN @c36 END, -- YN do not show ILB
		CASE WHEN /*OrganizationArchive*/ SUBSTRING(@bitmap, 5, 1) & 16 = 16 THEN @c37 END, -- YN do not show ILB
		ISNULL(@c38, @LastStatEmployeeID),
		@auditLogTypeID,
		CASE WHEN /*ContractedStatlineClient*/ SUBSTRING(@bitmap, 5, 1) & 128 = 128 AND IsNull(@c40, -1) IN ( -1, 0) THEN -2 ELSE @c40 END,
		CASE WHEN /*CountryID	*/ SUBSTRING(@bitmap, 6, 1) & 1 = 1 AND IsNull(@c41, -1) IN ( -1, 0) THEN -2 ELSE @c41 END,
		
		CASE WHEN /*ProviderNumber	*/ SUBSTRING(@bitmap, 6, 1) & 2 = 2 AND IsNull(@c42, '') = '' THEN 'ILB' ELSE @c42 END,		
		CASE WHEN /*UnosCode	*/ SUBSTRING(@bitmap, 6, 1) & 4 = 4 AND IsNull(@c43, '') = '' THEN 'ILB' ELSE @c43 END,
		
		CASE WHEN /*OganizationStatusId	*/ SUBSTRING(@bitmap, 6, 1) & 8 = 8 AND IsNull(@c44, -1) IN ( -1, 0) THEN -2 ELSE @c44 END,
		CASE WHEN /*TimeZoneId	*/ SUBSTRING(@bitmap, 6, 1) & 16 = 16 AND IsNull(@c45, -1) IN ( -1, 0) THEN -2 ELSE @c45 END,
		CASE WHEN /*ObservesDaylightSavings	*/ SUBSTRING(@bitmap, 6, 1) & 32 = 32 AND IsNull(@c46, -1) IN ( -1, 0) THEN -2 ELSE @c46 END,
		CASE WHEN /*IddId	*/ SUBSTRING(@bitmap, 6, 1) & 64 = 64 AND IsNull(@c47, -1) IN ( -1, 0) THEN -2 ELSE @c47 END,
		CASE WHEN /*CountryCodeId	*/ SUBSTRING(@bitmap, 6, 1) & 128 = 128 AND IsNull(@c48, -1) IN ( -1, 0) THEN -2 ELSE @c48 END,
		CASE WHEN /*StatTracOrganization	*/ SUBSTRING(@bitmap, 7, 1) & 1 = 1 AND IsNull(@c49, -1) IN ( -1, 0) THEN -2 ELSE @c49 END,
		CASE WHEN /*FacilityEreferralCode	*/ SUBSTRING(@bitmap, 7, 1) & 2 = 2 AND IsNull(@c50, '') = '' THEN 'ILB' ELSE @c50 END
	)
END
GO

