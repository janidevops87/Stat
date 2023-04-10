SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Organization]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Organization]
GO

create procedure [dbo].[spi_Audit_Organization] 
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
	@c11 varchar(2),
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
	@c50 varchar(20) -- FacilityEreferralCode


AS
BEGIN


insert into 
	"Organization"
	( 
		"OrganizationID",
		"OrganizationName",
		"OrganizationAddress1",
		"OrganizationAddress2",
		"OrganizationCity",
		"StateID",
		"OrganizationZipCode",
		"CountyID",
		"OrganizationTypeID",
		"PhoneID",
		"OrganizationTimeZone",
		"OrganizationNotes",
		"OrganizationNoPatientName",
		"OrganizationNoRecordNum",
		"Verified",
		"Inactive",
		"OrganizationNoAdmitDateTime",
		"OrganizationNoWeight",
		"OrganizationConfCallCust",
		"Unused2",
		"Unused3",
		"Unused4",
		"Unused5",
		"Unused6",
		"OrganizationPageInterval",
		"LastModified",
		"Unused8",
		"OrganizationUserCode",
		"OrganizationReferralNotes",
		"OrganizationMessageNotes",
		"OrganizationConsentInterval",
		"OrganizationLO",
		"OrganizationLOEnabled",
		"OrganizationLOType",
		"OrganizationLOTriageEnabled",
		"OrganizationLOFSEnabled",
		"OrganizationArchive",
		"LastStatEmployeeID",
		"AuditLogTypeID",
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
		"FacilityEreferralCode" -- c50
	)

values 
	( 
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7,
		@c8,
		@c9,
		@c10,
		@c11,
		@c12,
		@c13,
		@c14,
		@c15,
		@c16,
		@c17,
		@c18,
		@c19,
		@c20,
		@c21,
		@c22,
		@c23,
		@c24,
		@c25,
		@c26,
		@c27,
		@c28,
		@c29,
		@c30,
		@c31,
		@c32,
		@c33,
		@c34,
		@c35,
		@c36,
		@c37,
		@c38,
		@c39,
		@c40,
		@c41,
		@c42,
		@c43,
		@c44,
		@c45,
		@c46,
		@c47,
		@c48,
		@c49,
		@C50
	)


END

GO

