SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_ReferralSecondaryData]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_ReferralSecondaryData]
GO

create procedure "spi_Audit_ReferralSecondaryData" 
	@c1 int,
	@c2 varchar(500),
	@c3 smalldatetime,
	@c4 smallint,
	@c5 float,
	@c6 float,
	@c7 float,
	@c8 float,
	@c9 float,
	@c10 float,
	@c11 float,
	@c12 float,
	@c13 varchar(50),
	@c14 float,
	@c15 float,
	@c16 float,
	@c17 float,
	@c18 varchar(50),
	@c19 smallint,
	@c20 smallint,
	@c21 smallint,
	@c22 smallint,
	@c23 smallint,
	@c24 smallint,
	@c25 smallint,
	@c26 smallint,
	@c27 smallint,
	@c28 int,
	@c29 datetime,
	@c30 varchar(50),
	@c31 varchar(50),
	@c32 varchar(50),
	@c33 int,
	@c34 int

AS
BEGIN


insert into 
	"ReferralSecondaryData"
	( 
		"ReferralID",
		"ReferralSecondaryHistory",
		"LastModified",
		"hdBloodRecv48",
		"hdWholeBloodUnits",
		"hdWholeBloodAmt",
		"hdRedBloodUnits",
		"hdRedBloodAmt",
		"hdColloid_1",
		"hdColloid_2",
		"hdColloid_3",
		"hdColloid_4",
		"hdColloid_List",
		"hdCrystalloid_1",
		"hdCrystalloid_2",
		"hdCrystalloid_3",
		"hdCrystalloid_4",
		"hdCrystalloid_List",
		"hdQuest1_1",
		"hdQuest2_1",
		"hdQuest2_2",
		"hdQuest2_3",
		"hdQuest2_4",
		"hdQuest3_1",
		"hdQuest3_2",
		"hdQuest3_3",
		"hdQuest3_4",
		"fscUserID",
		"hdLastModified",
		"hdQuest3_2a",
		"hdQuest3_3a",
		"hdQuest3_4a",
		"LastStatEmployeeID",
		"AuditLogTypeID"
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
		@c34
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

