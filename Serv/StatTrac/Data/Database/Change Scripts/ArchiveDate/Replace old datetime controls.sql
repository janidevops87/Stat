DECLARE @RC int
DECLARE @startReportControlID int
DECLARE @endReportControlID int
DECLARE @ReportControlName varchar(50)
DECLARE @ReportParamSectionID int


SELECT 
	@ReportControlName = 'webDateTimeEditStart'
  ,@ReportParamSectionID = 2

EXECUTE @RC = [spi_ReportControl] 
   @startReportControlID OUTPUT
  ,@ReportControlName
  ,@ReportParamSectionID

SELECT 
	@ReportControlName = 'webDateTimeEditEnd'
  ,@ReportParamSectionID = 2

EXECUTE @RC = [spi_ReportControl] 
   @endReportControlID OUTPUT
  ,@ReportControlName
  ,@ReportParamSectionID


UPDATE ReportParamConfiguration
SET ReportControlID = @startReportControlID
WHERE ReportControlID = (SELECT ReportControlID FROM ReportControl WHERE ReportControlName = 'webDateTimeEditStart')

UPDATE ReportParamConfiguration
SET ReportControlID = @startReportControlID
WHERE ReportControlID = (SELECT ReportControlID FROM ReportControl WHERE ReportControlName = 'webDateTimeEditStart')

UPDATE ReportParamConfiguration
SET ReportControlID = @endReportControlID
WHERE ReportControlID = (SELECT ReportControlID FROM ReportControl WHERE ReportControlName = 'webDateTimeEditEnd')

UPDATE ReportParamConfiguration
SET ReportControlID = @endReportControlID
WHERE ReportControlID = (SELECT ReportControlID FROM ReportControl WHERE ReportControlName = 'webDateTimeEditEnd')

UPDATE ReportDateTimeConfiguration 
SET IsDateOnly = 1
WHERE ReportID = (select ReportID from Report where ReportDisplayName = 'Billable Count Summary')
