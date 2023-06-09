SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_CallCustomField]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_CallCustomField]
GO

create procedure "spi_Audit_CallCustomField" 
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 varchar(40),
		@c6 varchar(40),
		@c7 varchar(40),
		@c8 varchar(255),
		@c9 varchar(255),
		@c10 varchar(40),
		@c11 varchar(40),
		@c12 varchar(40),
		@c13 varchar(40),
		@c14 varchar(40),
		@c15 varchar(40),
		@c16 varchar(40),
		@c17 varchar(40),
		@c18 datetime,
		@c19 smallint,
		@c20 int,
		@c21 int

AS
BEGIN

insert into "CallCustomField"( 
	"CallID",
	"CallCustomField1",
	"CallCustomField2",
	"CallCustomField3",
	"CallCustomField4",
	"CallCustomField5",
	"CallCustomField6",
	"CallCustomField7",
	"CallCustomField8",
	"CallCustomField9",
	"CallCustomField10",
	"CallCustomField11",
	"CallCustomField12",
	"CallCustomField13",
	"CallCustomField14",
	"CallCustomField15",
	"CallCustomField16",
	"LastModified",
	"UpdatedFlag",
	"LastStatEmployeeID",
	"AuditLogTypeID"
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
	@c21
 )


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

