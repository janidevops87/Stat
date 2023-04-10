IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorContactInformationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorContactInformationInsert'
		DROP Procedure TcssDonorContactInformationInsert
	END
GO

PRINT 'Creating Procedure TcssDonorContactInformationInsert'
GO

CREATE PROCEDURE dbo.TcssDonorContactInformationInsert
(
	@TcssDonorContactInformationId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@DonorHospital varchar(50) = null,
	@TcssListTimeZoneId int = null,
	@TcssListDaylightSavingsObservedId int = null,
	@Opo varchar(50) = null,
	@DonorHospitalPhone varchar(15) = null,
	@DonorHospitalContact varchar(100) = null,
	@OpoContact varchar(50) = null,
	@TransplantSurgeonContactId int = null,
	@TransplantSurgeonContactOther varchar(100) = null,
	@ClinicalCoordinatorId int = null,
	@ClinicalCoordinatorOther varchar(100) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorContactInformationInsert
**	Desc: Insert Data into table TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorContactInformation
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	DonorHospital,
	TcssListTimeZoneId,
	TcssListDaylightSavingsObservedId,
	Opo,
	DonorHospitalPhone,
	DonorHospitalContact,
	OpoContact,
	TransplantSurgeonContactId,
	TransplantSurgeonContactOther,
	ClinicalCoordinatorId,
	ClinicalCoordinatorOther
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@DonorHospital,
	@TcssListTimeZoneId,
	@TcssListDaylightSavingsObservedId,
	@Opo,
	@DonorHospitalPhone,
	@DonorHospitalContact,
	@OpoContact,
	@TransplantSurgeonContactId,
	@TransplantSurgeonContactOther,
	@ClinicalCoordinatorId,
	@ClinicalCoordinatorOther
)

-- Return the new identity value
SET @TcssDonorContactInformationId = @@Identity

GO

GRANT EXEC ON TcssDonorContactInformationInsert TO PUBLIC
GO
