SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Message]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Message]
GO

create procedure "spi_Audit_Message" @c1 int,
	@c2 int,
	@c3 varchar(80),
	@c4 varchar(20),
	@c5 varchar(80),
	@c6 int,
	@c7 int,
	@c8 int,
	@c9 smallint,
	@c10 varchar(1000),
	@c11 smallint,
	@c12 datetime,
	@c13 numeric(5,0),
	@c14 varchar(50),
	@c15 varchar(20),
	@c16 varchar(5),
	@c17 smallint,
	@c18 int,
	@c19 int

AS
BEGIN


insert into 
	"Message"
	( 
		"MessageID",
		"CallID",
		"MessageCallerName",
		"MessageCallerPhone",
		"MessageCallerOrganization",
		"OrganizationID",
		"PersonID",
		"MessageTypeID",
		"MessageUrgent",
		"MessageDescription",
		"Inactive",
		"LastModified",
		"MessageExtension",
		"MessageImportPatient",
		"MessageImportUNOSID",
		"MessageImportCenter",
		"UpdatedFlag",
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
		@c19
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

