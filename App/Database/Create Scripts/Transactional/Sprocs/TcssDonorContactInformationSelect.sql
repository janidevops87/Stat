IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorContactInformationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorContactInformationSelect'
		DROP Procedure TcssDonorContactInformationSelect
	END
GO

PRINT 'Creating Procedure TcssDonorContactInformationSelect'
GO

CREATE PROCEDURE dbo.TcssDonorContactInformationSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorContactInformationSelect
**	Desc: Update Data in table TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	tdci.TcssDonorContactInformationId,
	tdci.LastUpdateStatEmployeeId,
	tdci.LastUpdateDate,
	tdci.TcssDonorId,
	tdci.DonorHospital,
	tdci.TcssListTimeZoneId,
	tdci.TcssListDaylightSavingsObservedId,
	tdci.Opo,
	tdci.DonorHospitalPhone,
	tdci.DonorHospitalContact,
	tdci.OpoContact,
	tdci.TransplantSurgeonContactId,
	tdci.TransplantSurgeonContactOther,
	tdci.ClinicalCoordinatorId,
	tdci.ClinicalCoordinatorOther
FROM dbo.TcssDonorContactInformation tdci
WHERE
	tdci.TcssDonorId = @TcssDonorId
GO

GRANT EXEC ON TcssDonorContactInformationSelect TO PUBLIC
GO
