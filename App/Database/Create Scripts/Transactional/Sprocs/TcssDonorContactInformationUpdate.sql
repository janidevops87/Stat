IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorContactInformationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorContactInformationUpdate'
		DROP Procedure TcssDonorContactInformationUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorContactInformationUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorContactInformationUpdate
(
	@TcssDonorContactInformationId int,
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
**	Name: TcssDonorContactInformationUpdate
**	Desc: Update Data in table TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorContactInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	DonorHospital = @DonorHospital,
	TcssListTimeZoneId = @TcssListTimeZoneId,
	TcssListDaylightSavingsObservedId = @TcssListDaylightSavingsObservedId,
	Opo = @Opo,
	DonorHospitalPhone = @DonorHospitalPhone,
	DonorHospitalContact = @DonorHospitalContact,
	OpoContact = @OpoContact,
	TransplantSurgeonContactId = @TransplantSurgeonContactId,
	TransplantSurgeonContactOther = @TransplantSurgeonContactOther,
	ClinicalCoordinatorId = @ClinicalCoordinatorId,
	ClinicalCoordinatorOther = @ClinicalCoordinatorOther
WHERE
	TcssDonorContactInformationId = @TcssDonorContactInformationId
GO

GRANT EXEC ON TcssDonorContactInformationUpdate TO PUBLIC
GO
