IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QA'
		DROP  Procedure  sps_rpt_QA
	END

GO

PRINT 'Creating Procedure sps_rpt_QA'
GO


CREATE Procedure [dbo].[sps_rpt_QA]
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@HowIdentifiedID			int = null,
	@ZeroErrors					int = Null,
	@Personids	 				varchar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QA.sql
**		Name: sps_rpt_QA.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth					Initial release
**		08/14/2009		ccarroll			Created temp table. split sproc into two locations,
**											one for TrackingForm and one for Error Log.
**											Added WHERE to only show errors.
**		5/2010			Sue Dabiri			Added QAMonitoring Form Name Field
**		06/02/2010		James Gerberich		Removed QATrackingEventDateTime field and added Distinct to 
**											final select statement to avoid dups in report.  HS 23872
**		09/27/2010		jegerberich			Added @TrackingTypeID variable and WHERE logic to 
**											accomodate the parameter in filtering results. HS 25264
**      10/2011         jth					fixed table variable for errmonth, erryear, refmonnum and refyear to be varchar
*******************************************************************************/

--declare @ErrorLocationID			int 
--declare	@ProcessStepID				int 
--declare	@ErrorTypeID				int 
--declare	@HowIdentifiedID			int 
--declare	@ZeroErrors					int 
--declare	@Personids	 				varchar(8000) 
--declare	@CallStartDateTime		    DateTime 
--declare	@CallEndDateTime		    DateTime 
--declare	@ErrorStartDateTime		    DateTime 
--declare	@ErrorEndDateTime			DateTime 
--declare	@TrackingTypeID				int 
--declare	@ReportGroupID				int 
--declare	@OrganizationID				int 
--declare	@SourceCodeName				varchar(10) 
--declare	@DisplayMT					int 


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
IF  @ZeroErrors = 0
	BEGIN
		SET @ZeroErrors	= Null
	END
ELSE
	BEGIN
		SET @ZeroErrors	= 0
	END
	
CREATE TABLE #Temp_QA
   (
		[SourceCode] [varchar] (15) NULL,
		[CallDateTime] [Datetime] Null,
		[QATrackingNumber] [varchar] (20) Null,
		[QAMonitoringFormName] [varchar] (255) Null,
		[QAErrorLogNumberOfErrors] [int] Null,
		[QAErrorLogComments] [varchar] (1000)Null,
		[HowIdentified] [varchar] (250)Null,
		[Employee] [varchar] (101)Null,
		[EmployeeFirst] [varchar] (50)Null,
		[EmployeeLast] [varchar] (50)Null,
		[RefMonthNum] [varchar] (20) Null,
		[RefMonth] [varchar] (20) Null,
		[RefYear] [varchar] (20) Null,
		[ErrMonthNum] [varchar] (20) Null,
		[ErrMonth] [varchar] (20) Null,
		[ErrYear] [varchar] (20) Null,
		[ProcessStep] [varchar] (255) Null,
		[ErrorType] [varchar] (255) Null,
		[ErrorLocation] [varchar] (255)Null--,
	--[QATrackingEventDateTime] [datetime] Null
   )
   
TRUNCATE TABLE #Temp_QA

	INSERT #Temp_QA
		exec sps_rpt_QATrackingForm_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@TrackingTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT

	INSERT #Temp_QA
		exec sps_rpt_QAErrorLog_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@TrackingTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT
				
				
SELECT DISTINCT * FROM #Temp_QA
WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
ORDER BY
QATrackingNumber,
EmployeeLast,
ErrorLocation




GO