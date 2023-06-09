SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_NOK]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_NOK]
GO

create procedure "spi_Audit_NOK" @c1 int,
	@c2 varchar(50),
	@c3 varchar(50),
	@c4 varchar(14),
	@c5 varchar(255),
	@c6 varchar(50),
	@c7 int,
	@c8 varchar(10),
	@c9 varchar(50),
	@c10 datetime,
	@c11 int,
	@c12 int

AS
BEGIN


insert into 
	"NOK"
	( 
		"NOKID",
		"NOKFirstName",
		"NOKLastName",
		"NOKPhone",
		"NOKAddress",
		"NOKCity",
		"NOKStateID",
		"NOKZip",
		"NOKApproachRelation",
		"LastModified",
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
		@c12
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

