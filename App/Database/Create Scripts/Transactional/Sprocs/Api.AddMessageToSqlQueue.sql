IF OBJECT_ID('Api.AddMessageToSqlQueue', 'P') IS NOT NULL
	DROP PROC Api.AddMessageToSqlQueue;
GO

CREATE PROCEDURE Api.AddMessageToSqlQueue
	@referralID int,
	@webReportGroupId int,
	@documentTypeId int,
	@organizationId int
AS

  /*******************************************************************************
  ** File: Api.AddMessageToSqlQueue.sql 
  ** Name: AddMessageToSqlQueue
  ** Desc: Adds a message with referral-related IDs to Api.Queue table
  ** Auth: Andrey Savin
  ** Date: 1/18/2018
  ** Called By: 
  *******************************************************************************/ 

SET NOCOUNT ON;

DECLARE @JSON VARCHAR(MAX) = 
	'{'+
		'"ReferralId" : ' + CONVERT(varchar, @referralID) + ',' +
		'"WebReportGroupId" : ' + CONVERT(varchar, @webReportGroupId) + 
	'}';

INSERT INTO Api.Queue (WebReportGroupId,DocumentTypeId,OrganizationId,Document)
VALUES (@webReportGroupId, @documentTypeId, @organizationId, @JSON ) 

GO
