/******************************************************************************
**		File: CreateScreeningCriteriaCustomParams.sql
**		Name: CreateScreeningCriteriaCustomParams
**		Desc: Creates a new report control for ScreeningCriteria custom params and then associates
**				it with configurations for 2 screening criteria reports
**
**		Auth: Mike Berenson
**		Date: 08/26/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/26/2021	Mike Berenson		initial
*******************************************************************************/

DECLARE @NewReportControlID INT = 0;

-- Insert ReportControl record
IF NOT EXISTS (SELECT 1 FROM ReportControl WHERE ReportControlName = 'customParamsScreeningCriteria')
BEGIN

	INSERT INTO [dbo].[ReportControl]
			   ([ReportControlName]
			   ,[ReportParamSectionID])
		 VALUES
			   ('customParamsScreeningCriteria', 1);

	SELECT @NewReportControlID = @@IDENTITY;

END

-- Update ReportParamConfiguration to use the new ReportControl
IF @NewReportControlID > 0 
BEGIN

	UPDATE
		[dbo].[ReportParamConfiguration]
	SET
		ReportControlID = @NewReportControlID
	WHERE 
		ReportParamConfiguration IN (2237, 2238); -- configuration for 2 screening reports

END
GO