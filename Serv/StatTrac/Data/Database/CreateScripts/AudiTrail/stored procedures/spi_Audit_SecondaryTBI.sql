SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SecondaryTBI]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_SecondaryTBI]
GO

create procedure "spi_Audit_SecondaryTBI" 
	@c1 int,
	@c2 varchar(25),
	@c3 int,
	@c4 varchar(10),
	@c5 smallint,
	@c6 int,
	@c7 int,
	@c8 varchar(250),
	@c9 smalldatetime,
	@c10 smalldatetime,
	@c11 int

AS
BEGIN


insert into 
	"SecondaryTBI"
	( 
		"CallID",
		"SecondaryTBINumber",
		"SecondaryTBIIssuedStatEmployeeID",
		"SecondaryTBIPrefixDate",
		"SecondaryTBIAssignmentNotNeeded",
		"SecondaryTBIAssignmentNotNeededStatEmployeeID",
		"LastStatEmployeeID",
		"SecondaryTBIComment",
		"CreateDate",
		"LastModified",
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
		@c11
 )


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

