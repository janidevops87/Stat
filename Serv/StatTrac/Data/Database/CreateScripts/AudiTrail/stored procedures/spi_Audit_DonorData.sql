SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_DonorData]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_DonorData]
GO

create procedure spi_Audit_DonorData @DonorDataId int,
	@CallID int,
	@DonorDataMiddleName varchar(20),
	@DonorDataLicense varchar(9),
	@DonorDataAddress varchar(40),
	@DonorDataCity varchar(25),
	@DonorDataState varchar(2),
	@DonorDataZip varchar(10),
	@DonorDataNotAvailable bit,
	@LastModified smalldatetime,
	@MultipleDonorsFound smallint,
	@LastStatEmployeeID int,
	@AuditLogTypeID int

AS
BEGIN


insert into DonorData
	( 
	DonorDataId,
	CallID,
	DonorDataMiddleName,
	DonorDataLicense,
	DonorDataAddress,
	DonorDataCity,
	DonorDataState,
	DonorDataZip,
	DonorDataNotAvailable,
	LastModified,
	MultipleDonorsFound,
	LastStatEmployeeID,
	AuditLogTypeID
 )

values ( 
	@DonorDataId,
	@CallID,
	@DonorDataMiddleName,
	@DonorDataLicense,
	@DonorDataAddress,
	@DonorDataCity,
	@DonorDataState,
	@DonorDataZip,
	@DonorDataNotAvailable,
	@LastModified,
	@MultipleDonorsFound,
	@LastStatEmployeeID,
	@AuditLogTypeID
 )


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

