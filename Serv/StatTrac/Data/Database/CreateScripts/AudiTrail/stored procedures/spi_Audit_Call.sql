SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Call]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Call]
GO

create procedure "spi_Audit_Call" 
	@c1 int,
	@c2 varchar(15),
	@c3 int,
	@c4 smalldatetime,
	@c5 smallint,
	@c6 varchar(15),
	@c7 smallint,
	@c8 smallint,
	@c9 smallint,
	@c10 datetime,
	@c11 smallint,
	@c12 int,
	@c13 int,
	@c14 int,
	@c15 numeric(5,0),
	@c16 smallint,
	@c17 int,
	@c18 smallint,
	@c19 smallint,
	@c20 int,
	@c21 int

AS
BEGIN

insert into "Call"
	( 
		"CallID",
		"CallNumber",
		"CallTypeID",
		"CallDateTime",
		"StatEmployeeID",
		"CallTotalTime",
		"CallTempExclusive",
		"Inactive",
		"CallSeconds",
		"LastModified",
		"CallTemp",
		"SourceCodeID",
		"CallOpenByID",
		"CallTempSavedByID",
		"CallExtension",
		"UpdatedFlag",
		"CallOpenByWebPersonId",
		"RecycleNCFlag",
		"CallActive",
		"CallSaveLastByID",
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
		@c21
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

