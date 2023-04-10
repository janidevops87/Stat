IF OBJECT_ID('Api.ProcessSqlQueue', 'P') IS NOT NULL
	DROP PROC Api.ProcessSqlQueue;
GO

CREATE PROCEDURE Api.ProcessSqlQueue
	@azureQueueConnectionString varchar(max)
AS

  /******************************************************************************
  ** File: Api.ProcessSqlQueue.sql 
  ** Name: ProcessSqlQueue
  ** Desc: Enumerates messages in the Api.Queue table and tries to push them 
  ** to Azure Queue for further processing.
  ** Auth: Andrey Savin
  ** Date: 1/18/2018
  ** Called By: 
  *******************************************************************************/ 

DECLARE @document varchar(max),
		@webReportGroupId int,
		@documentTypeId int,
		@organizationId int,
		@queueId int;

DECLARE C CURSOR FAST_FORWARD /* read only, forward only */ FOR
SELECT  QueueId, WebReportGroupId, DocumentTypeId, OrganizationId, Document  
FROM Api.Queue;

OPEN C;

FETCH NEXT 
FROM C 
INTO @queueId, @webReportGroupId, @documentTypeId, @organizationId, @document;

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @status int = 0;
	
	BEGIN TRY
		EXEC Api.AzureQueueAddMessage
			@document, 
			@azureQueueConnectionString,
			@status OUTPUT;
	
		EXEC Api.RemoveMessageFromSqlQueue 
			@queueId;

	END TRY
	BEGIN CATCH
		PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
		PRINT 'Error Message : ' + ERROR_MESSAGE();
		PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
		PRINT 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));
		PRINT 'Error Line : ' + CAST(ERROR_LINE() AS VARCHAR(10));
		PRINT 'Error Proc : ' + COALESCE(ERROR_PROCEDURE(), 'Not within proc');
	END CATCH;
	
	FETCH NEXT 
	FROM C 
	INTO @queueId, @webReportGroupId, @documentTypeId, @organizationId, @document;
END

CLOSE C;
DEALLOCATE C;

GO