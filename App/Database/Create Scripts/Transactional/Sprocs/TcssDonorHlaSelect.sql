IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaSelect'
		DROP Procedure TcssDonorHlaSelect
	END
GO

PRINT 'Creating Procedure TcssDonorHlaSelect'
GO

CREATE PROCEDURE dbo.TcssDonorHlaSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaSelect
**	Desc: Update Data in table TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdh.TcssDonorHlaId,
	tdh.LastUpdateStatEmployeeId,
	tdh.LastUpdateDate,
	tdh.TcssDonorId,
	tdh.TcssListAboId,
	tdh.DateOfBirth,
	tdh.Age,
	tdh.TcssListAgeUnitId,
	tdh.TcssListGenderId,
	tdh.HeightFeet,
	tdh.HeightInches,
	tdh.Weight,
	tdh.Bmi,
	tdh.TcssListEthnicityId,
	tdh.TcssListRaceId,
	tdh.TcssListCauseOfDeathId,
	tdh.TcssListMechanismOfDeathId,
	tdh.TcssListCircumstancesOfDeathId,
	tdh.TcssListDonorDefinitionId,
	tdh.TcssListDonorDbdSubDefinitionId,
	tdh.TcssListDonorDcdSubDefinitionId,
	tdh.TcssListBreathingOverVentId,
	tdh.UwScore,
	tdh.TcssListHemodynamicallyStableId,
	tdh.AdmitDateTime,
	tdh.PronouncedDateTime,
	tdh.CardiacArrestDateTime,
	tdh.CrossClampDateTime,
	tdh.ColdSchemeticTime,
	tdh.TcssListDonorMeetsEcdCriteriaId,
	tdh.TcssListDonorMeetsDcdCriteriaId,
	tdh.TcssListCardiacArrestDownTimeId,
	tdh.EstimattedDownTime,
	tdh.TcssListCprAdministeredId,
	tdh.Duration,
	tdh.DonorHighlights,
	tdh.AdmissionCourseComments
FROM dbo.TcssDonorHla tdh
WHERE
	tdh.TcssDonorId = @TcssDonorId
GO

GRANT EXEC ON TcssDonorHlaSelect TO PUBLIC
GO
