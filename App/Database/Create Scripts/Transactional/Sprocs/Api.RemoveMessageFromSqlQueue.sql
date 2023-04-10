IF OBJECT_ID('Api.RemoveMessageFromSqlQueue', 'P') IS NOT NULL
	DROP PROC Api.RemoveMessageFromSqlQueue;
GO

CREATE PROCEDURE Api.RemoveMessageFromSqlQueue
	@queueId int
AS

/******************************************************************************
  ** File: Api.RemoveMessageFromSqlQueue.sql 
  ** Name: RemoveMessageFromSqlQueue
  ** Desc: Removes a message from the Api.Queue table.
  ** Auth: Andrey Savin
  ** Date: 1/18/2018
  ** Called By: 
  *******************************************************************************/ 

SET NOCOUNT ON;

DELETE FROM Api.Queue 
WHERE QueueId = @queueId;
			
GO
