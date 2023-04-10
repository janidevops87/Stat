IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaUpdate'
		DROP Procedure TcssDonorHlaUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorHlaUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorHlaUpdate
(
	@TcssDonorHlaId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListAboId int = null,
	@DateOfBirth smalldatetime = null,
	@Age int = null,
	@TcssListAgeUnitId int = null,
	@TcssListGenderId int = null,
	@HeightFeet int = null,
	@HeightInches int = null,
	@Weight decimal(18,3) = null,
	@Bmi decimal(18,4) = null,
	@TcssListEthnicityId int = null,
	@TcssListRaceId int = null,
	@TcssListCauseOfDeathId int = null,
	@TcssListMechanismOfDeathId int = null,
	@TcssListCircumstancesOfDeathId int = null,
	@TcssListDonorDefinitionId int = null,
	@TcssListDonorDbdSubDefinitionId int = null,
	@TcssListDonorDcdSubDefinitionId int = null,
	@TcssListBreathingOverVentId int = null,
	@UwScore varchar(50) = null,
	@TcssListHemodynamicallyStableId int = null,
	@AdmitDateTime smalldatetime = null,
	@PronouncedDateTime smalldatetime = null,
	@CardiacArrestDateTime smalldatetime = null,
	@CrossClampDateTime smalldatetime = null,
	@ColdSchemeticTime varchar(50) = null,
	@TcssListDonorMeetsEcdCriteriaId int = null,
	@TcssListDonorMeetsDcdCriteriaId int = null,
	@TcssListCardiacArrestDownTimeId int = null,
	@EstimattedDownTime int = null,
	@TcssListCprAdministeredId int = null,
	@Duration int = null,
	@DonorHighlights varchar(5000) = null,
	@AdmissionCourseComments varchar(2000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaUpdate
**	Desc: Update Data in table TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorHla
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListAboId = @TcssListAboId,
	DateOfBirth = @DateOfBirth,
	Age = @Age,
	TcssListAgeUnitId = @TcssListAgeUnitId,
	TcssListGenderId = @TcssListGenderId,
	HeightFeet = @HeightFeet,
	HeightInches = @HeightInches,
	Weight = @Weight,
	Bmi = @Bmi,
	TcssListEthnicityId = @TcssListEthnicityId,
	TcssListRaceId = @TcssListRaceId,
	TcssListCauseOfDeathId = @TcssListCauseOfDeathId,
	TcssListMechanismOfDeathId = @TcssListMechanismOfDeathId,
	TcssListCircumstancesOfDeathId = @TcssListCircumstancesOfDeathId,
	TcssListDonorDefinitionId = @TcssListDonorDefinitionId,
	TcssListDonorDbdSubDefinitionId = @TcssListDonorDbdSubDefinitionId,
	TcssListDonorDcdSubDefinitionId = @TcssListDonorDcdSubDefinitionId,
	TcssListBreathingOverVentId = @TcssListBreathingOverVentId,
	UwScore = @UwScore,
	TcssListHemodynamicallyStableId = @TcssListHemodynamicallyStableId,
	AdmitDateTime = @AdmitDateTime,
	PronouncedDateTime = @PronouncedDateTime,
	CardiacArrestDateTime = @CardiacArrestDateTime,
	CrossClampDateTime = @CrossClampDateTime,
	ColdSchemeticTime = @ColdSchemeticTime,
	TcssListDonorMeetsEcdCriteriaId = @TcssListDonorMeetsEcdCriteriaId,
	TcssListDonorMeetsDcdCriteriaId = @TcssListDonorMeetsDcdCriteriaId,
	TcssListCardiacArrestDownTimeId = @TcssListCardiacArrestDownTimeId,
	EstimattedDownTime = @EstimattedDownTime,
	TcssListCprAdministeredId = @TcssListCprAdministeredId,
	Duration = @Duration,
	DonorHighlights = @DonorHighlights,
	AdmissionCourseComments = @AdmissionCourseComments
WHERE
	TcssDonorHlaId = @TcssDonorHlaId
GO

GRANT EXEC ON TcssDonorHlaUpdate TO PUBLIC
GO
