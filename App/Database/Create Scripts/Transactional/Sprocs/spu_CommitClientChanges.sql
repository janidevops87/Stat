SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_CommitClientChanges]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_CommitClientChanges]
GO



CREATE PROCEDURE spu_CommitClientChanges
	@JobName varchar(255)
	
AS
/******************************************************************************
**	File: spu_CommitClientChanges.sql
**	Name: spu_CommitClientChanges
**	Desc: Runs Committ client changes
**	Auth: Uknown
**	Date: Unknown
**	Called By: Called by StatTrac
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	Uknown			Uknownl				Initial Sproc Creation
**	10/17/2019		Bret Knoll			Replaced call to extended procedure with 
** 										query to sysjobs tables
**	06/08/2021		Mike Berenson		Added session logic when querying msdb.dbo.sysjobactivity
*******************************************************************************/
SET NOCOUNT ON;

DECLARE @vReturn int,
	    @vReturnString varchar(255),
	    @JobId UNIQUEIDENTIFIER,
	    @JobState int,
	    @NumJobs int,
	    @JobEnabled int;

--Append DB name to @JobName
SELECT @JobName = @JobName + DB_NAME(db_id());

--See if our job exists
SELECT @NumJobs = Count(*) FROM  msdb..sysjobs WHERE name = @JobName;

IF @NumJobs > 0
BEGIN
	--Get the Job Id
	SELECT @JobId = job_id FROM msdb..sysjobs WHERE name = @JobName;

	--Verify the Job is enabled
	SELECT @JobEnabled = enabled FROM msdb..sysjobs
	WHERE job_id = @JobId;

	IF @JobEnabled = 1
	BEGIN
		--Get the job status, if stop_execution_date is null then the job is running
		SELECT top(1) @JobState =  case when sja.stop_execution_date is null then 1 else 4 end
			FROM msdb.dbo.sysjobs sj
			JOIN msdb.dbo.sysjobactivity sja
			ON sj.job_id = sja.job_id
			WHERE session_id = (
				SELECT MAX(session_id) FROM msdb.dbo.sysjobactivity)
				and sj.Job_id =  @JobId ;
			
		
		--If Job is Idle, continue
		IF @JobState = 4	--Idle
		BEGIN
			--Start the Job
			EXEC @vReturn = msdb..sp_start_job @job_id = @JobId;

			--Return the result to the calling procedure
			SELECT CASE @vReturn 
				WHEN 0 THEN 'The job was started successfully.'							--Success
				WHEN 1 THEN 'There was a problem starting the job.  Please contact your System Administrator.'	--Failure
				ELSE 'The job status is unknown.  Please contact your System Administrator.'
			END as 'ResultString';
		END
		ELSE
		BEGIN
			--Return the result to the calling procedure
			SELECT CASE @JobState
				WHEN 1 THEN 'The job is already running.  Please try again later.'				--Executing
				WHEN 2 THEN 'The job is already running.  Please try again later.'				--Waiting for thread
				WHEN 3 THEN 'The job is already running.  Please try again later.'				--Between retries
				WHEN 5 THEN 'The job is already running.  Please try again later.'				--Suspended
				WHEN 7 THEN 'The job is already running.  Please try again later.'				--Performing completion actions
				ELSE 'The job cannot be started at this time.  Please contact your System Administrator.'
			END as 'ResultString';
		END
	END
	ELSE
	BEGIN
		SELECT CASE @JobEnabled
			WHEN 0 THEN 'The job is disabled at this time.  Please contact your System Administrator.'
			ELSE 'It is not known whether the job is enabled.  Please contact your System Administrator.'
		END as 'ResultString';
	END
	
END
ELSE
BEGIN
	--Use a Return value of 5 if 
	SELECT @vReturnString = 'The  job does not exist.  Please contact your System Administrator.';
	SELECT @vReturnString as 'ResultString';
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

