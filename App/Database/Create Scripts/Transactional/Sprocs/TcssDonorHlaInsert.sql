IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaInsert'
		DROP Procedure TcssDonorHlaInsert
	END
GO

PRINT 'Creating Procedure TcssDonorHlaInsert'
GO

CREATE PROCEDURE dbo.TcssDonorHlaInsert
(
	@TcssDonorHlaId int output,
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
**	Name: TcssDonorHlaInsert
**	Desc: Insert Data into table TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorHla
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListAboId,
	DateOfBirth,
	Age,
	TcssListAgeUnitId,
	TcssListGenderId,
	HeightFeet,
	HeightInches,
	Weight,
	Bmi,
	TcssListEthnicityId,
	TcssListRaceId,
	TcssListCauseOfDeathId,
	TcssListMechanismOfDeathId,
	TcssListCircumstancesOfDeathId,
	TcssListDonorDefinitionId,
	TcssListDonorDbdSubDefinitionId,
	TcssListDonorDcdSubDefinitionId,
	TcssListBreathingOverVentId,
	UwScore,
	TcssListHemodynamicallyStableId,
	AdmitDateTime,
	PronouncedDateTime,
	CardiacArrestDateTime,
	CrossClampDateTime,
	ColdSchemeticTime,
	TcssListDonorMeetsEcdCriteriaId,
	TcssListDonorMeetsDcdCriteriaId,
	TcssListCardiacArrestDownTimeId,
	EstimattedDownTime,
	TcssListCprAdministeredId,
	Duration,
	DonorHighlights,
	AdmissionCourseComments
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListAboId,
	@DateOfBirth,
	@Age,
	@TcssListAgeUnitId,
	@TcssListGenderId,
	@HeightFeet,
	@HeightInches,
	@Weight,
	@Bmi,
	@TcssListEthnicityId,
	@TcssListRaceId,
	@TcssListCauseOfDeathId,
	@TcssListMechanismOfDeathId,
	@TcssListCircumstancesOfDeathId,
	@TcssListDonorDefinitionId,
	@TcssListDonorDbdSubDefinitionId,
	@TcssListDonorDcdSubDefinitionId,
	@TcssListBreathingOverVentId,
	@UwScore,
	@TcssListHemodynamicallyStableId,
	@AdmitDateTime,
	@PronouncedDateTime,
	@CardiacArrestDateTime,
	@CrossClampDateTime,
	@ColdSchemeticTime,
	@TcssListDonorMeetsEcdCriteriaId,
	@TcssListDonorMeetsDcdCriteriaId,
	@TcssListCardiacArrestDownTimeId,
	@EstimattedDownTime,
	@TcssListCprAdministeredId,
	@Duration,
	@DonorHighlights,
	@AdmissionCourseComments
)

-- Return the new identity value
SET @TcssDonorHlaId = @@Identity

GO

GRANT EXEC ON TcssDonorHlaInsert TO PUBLIC
GO
