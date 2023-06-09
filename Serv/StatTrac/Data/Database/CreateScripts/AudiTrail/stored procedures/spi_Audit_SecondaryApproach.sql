SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SecondaryApproach]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_SecondaryApproach]
GO

create procedure "spi_Audit_SecondaryApproach" 
	@c1 int,
	@c2 smallint,
	@c3 int,
	@c4 smallint,
	@c5 smallint,
	@c6 smallint,
	@c7 smallint,
	@c8 int,
	@c9 smallint,
	@c10 smallint,
	@c11 varchar(50),
	@c12 smallint,
	@c13 int,
	@c14 smallint,
	@c15 smallint,
	@c16 int,
	@c17 smallint,
	@c18 varchar(50),
	@c19 smallint,
	@c20 int,
	@c21 int,
	@c22 smalldatetime

AS
BEGIN


insert into 
	"SecondaryApproach"
	( 
		"CallId",
		"SecondaryApproached",
		"SecondaryApproachedBy",
		"SecondaryApproachType",
		"SecondaryApproachOutcome",
		"SecondaryApproachReason",
		"SecondaryConsented",
		"SecondaryConsentBy",
		"SecondaryConsentOutcome",
		"SecondaryConsentResearch",
		"SecondaryRecoveryLocation",
		"SecondaryHospitalApproach",
		"SecondaryHospitalApproachedBy",
		"SecondaryHospitalOutcome",
		"SecondaryConsentMedSocPaperwork",
		"SecondaryConsentMedSocObtainedBy",
		"SecondaryConsentFuneralPlans",
		"SecondaryConsentFuneralPlansOther",
		"SecondaryConsentLongSleeves",
		"LastStatEmployeeID",
		"AuditLogTypeID",
		"LastModified"
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
		@c22
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

