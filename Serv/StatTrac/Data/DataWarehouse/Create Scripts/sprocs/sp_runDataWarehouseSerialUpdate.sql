IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_runDataWarehouseSerialUpdate')
	BEGIN
		PRINT 'Dropping Procedure sp_runDataWarehouseSerialUpdate';
		DROP Procedure sp_runDataWarehouseSerialUpdate;
	END
GO

PRINT 'Creating Procedure sp_runDataWarehouseSerialUpdate';
GO
CREATE Procedure sp_runDataWarehouseSerialUpdate
AS
/******************************************************************************
**	File: sp_runDataWarehouseSerialUpdate.sql
**	Name: sp_runDataWarehouseSerialUpdate
**	Desc: Runs all datawarehouse jobs in serial
**	Auth: Bret Knoll
**	Date: 9/29/2019
**	Called By: SQL Job 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/29/2019		Bret Knoll		Initial Sproc Creation
*******************************************************************************/


	DECLARE 
	@loopCount int, 
	@loopMax int,
	@job_id uniqueidentifier,
	@job_name nvarchar(200),
	@sql nvarchar(4000);

	DECLARE @jobList TABLE	(
		ID INT IDENTITY(1,1),
		job_id uniqueidentifier,
		job_name nvarchar(200)
	);
	
	INSERT @jobList
	select job_id, name from msdb..sysjobs
	where name like 'sp%update%';


	SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @jobList;

	WHILE (@loopCount <= @loopMax)
	BEGIN

		SELECT 
			@job_id = job_id,
			@job_name = job_name
		FROM 
			@jobList
		WHERE
			ID = @loopCount;

		set @sql = 'exec msdb.dbo.sp_start_job_serial ''' + @job_name + '''';

		EXEC SP_ExecuteSQL @sql ;
		SET @loopCount = @loopCount + 1;
	END
GO