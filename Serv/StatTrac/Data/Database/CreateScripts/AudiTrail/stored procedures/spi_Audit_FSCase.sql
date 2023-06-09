SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_FSCase]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_FSCase]
GO

create procedure "spi_Audit_FSCase" @c1 int,
	@c2 int,
	@c3 int,
	@c4 datetime,
	@c5 int,
	@c6 datetime,
	@c7 int,
	@c8 datetime,
	@c9 int,
	@c10 datetime,
	@c11 int,
	@c12 datetime,
	@c13 int,
	@c14 datetime,
	@c15 datetime,
	@c16 int,
	@c17 int,
	@c18 datetime,
	@c19 int,
	@c20 datetime,
	@c21 int,
	@c22 datetime,
	@c23 int,
	@c24 smallint,
	@c25 varchar(15),
	@c26 int,
	@c27 int,
	@c28 datetime,
	@c29 int,
	@c30 datetime,
	@c31 smallint,
	@c32 smallint,
	@c33 smallint,
	@c34 varchar(50),
	@c35 smallint,
	@c36 datetime,
	@c37 smallint,
	@c38 int,
	@c39 int,
	@c40 smalldatetime

AS
BEGIN


insert into "FSCase"( 
	"FSCaseId",
	"CallId",
	"FSCaseCreateUserId",
	"FSCaseCreateDateTime",
	"FSCaseOpenUserId",
	"FSCaseOpenDateTime",
	"FSCaseSysEventsUserId",
	"FSCaseSysEventsDateTime",
	"FSCaseSecCompUserId",
	"FSCaseSecCompDateTime",
	"FSCaseApproachUserId",
	"FSCaseApproachDateTime",
	"FSCaseFinalUserId",
	"FSCaseFinalDateTime",
	"FSCaseUpdate",
	"FSCaseUserId",
	"FSCaseBillSecondaryUserID",
	"FSCaseBillDateTime",
	"FSCaseBillApproachUserID",
	"FSCaseBillApproachDateTime",
	"FSCaseBillMedSocUserID",
	"FSCaseBillMedSocDateTime",
	"SecondaryManualBillPersonId",
	"SecondaryUpdatedFlag",
	"FSCaseTotalTime",
	"FSCaseSeconds",
	"FSCaseBillFamUnavailUserId",
	"FSCaseBillFamUnavailDateTime",
	"FSCaseBillCryoFormUserId",
	"FSCaseBillCryoFormDateTime",
	"FSCaseBillApproachCount",
	"FSCaseBillMedSocCount",
	"FSCaseBillCryoFormCount",
	"FSCaseBillOTEPerson",
	"FSCaseBillOTEUserID",
	"FSCaseBillOTEDateTime",
	"FSCaseBillOTECount",
	"LastStatEmployeeID",
	"AuditLogTypeID",
	"LastModified"
 )

values ( 
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
	@c40
 )


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

