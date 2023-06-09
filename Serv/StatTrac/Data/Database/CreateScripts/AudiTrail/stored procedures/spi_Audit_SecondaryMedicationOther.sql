SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SecondaryMedicationOther]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_SecondaryMedicationOther]
GO

create procedure "spi_Audit_SecondaryMedicationOther" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 varchar(100),
	@c5 varchar(100),
	@c6 varchar(100),
	@c7 smalldatetime,
	@c8 smalldatetime,
	@c9 int,
	@c10 int,
	@c11 smalldatetime
AS
BEGIN


insert into 
	"SecondaryMedicationOther"
	( 
		"SecondaryMedicationOtherId",
		"CallId",
		"MedicationId",
		"SecondaryMedicationOtherTypeUse",
		"SecondaryMedicationOtherName",
		"SecondaryMedicationOtherDose",
		"SecondaryMedicationOtherStartDate",
		"SecondaryMedicationOtherEndDate",
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

