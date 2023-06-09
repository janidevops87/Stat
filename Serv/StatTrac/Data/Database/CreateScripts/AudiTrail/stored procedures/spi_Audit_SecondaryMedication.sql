SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SecondaryMedication]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_SecondaryMedication]
GO

create procedure "spi_Audit_SecondaryMedication" @c1 int,
	@c2 int,
	@c3 int,
	@c4 int,
	@c5 smalldatetime

AS
BEGIN


insert into 
	"SecondaryMedication"
	( 
		"CallId",
		"MedicationId",
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
		@c5
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

