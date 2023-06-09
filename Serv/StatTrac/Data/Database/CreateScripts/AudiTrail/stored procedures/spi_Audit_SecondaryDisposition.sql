SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SecondaryDisposition]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_SecondaryDisposition]
GO

create procedure "spi_Audit_SecondaryDisposition" @c1 int,
	@c2 int,
	@c3 int,
	@c4 smallint,
	@c5 smallint,
	@c6 smallint,
	@c7 smallint,
	@c8 smallint,
	@c9 int,
	@c10 int,
	@c11 smalldatetime

AS
BEGIN


insert into 
	"SecondaryDisposition"
	( 
		"SecondaryDispositionID",
		"CallID",
		"SubCriteriaID",
		"SecondaryDispositionAppropriate",
		"SecondaryDispositionApproach",
		"SecondaryDispositionConsent",
		"SecondaryDispositionConversion",
		"SecondaryDispositionCRO",
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
		@c11
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

