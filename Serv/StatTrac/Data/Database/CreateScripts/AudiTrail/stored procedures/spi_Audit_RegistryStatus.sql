SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_RegistryStatus]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_RegistryStatus]
GO

create procedure "spi_Audit_RegistryStatus" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 datetime,
	@c5 int,
	@c6 int

AS
BEGIN


insert into 
	"RegistryStatus"
	( 
		"ID",
		"RegistryStatus",
		"CallID",
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
		@c6
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

