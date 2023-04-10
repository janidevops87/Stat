IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabSelect'
		DROP Procedure TcssDonorLabSelect
	END
GO

PRINT 'Creating Procedure TcssDonorLabSelect'
GO

CREATE PROCEDURE dbo.TcssDonorLabSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabSelect
**	Desc: Update Data in table TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  11/2010     jth				added HbA1c fields
***************************************************************************************************/

SELECT 
	tdl.TcssDonorLabId,
	tdl.LastUpdateStatEmployeeId,
	tdl.LastUpdateDate,
	tdl.TcssDonorId,
	tdl.TcssListToxicologyScreenId,
	tdl.Results,
	tdl.OtherLabs,
	tdl.HbA1c,
    tdl.HbA1cDateTime 
FROM dbo.TcssDonorLab tdl
WHERE
	tdl.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorLabSelect TO PUBLIC
GO
