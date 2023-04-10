IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AzureQueueAddMessage')
	BEGIN
		PRINT 'Dropping Procedure AzureQueueAddMessage'
		DROP Procedure [Api].AzureQueueAddMessage
	END
GO

PRINT 'Creating Procedure AzureQueueAddMessage'
GO

CREATE PROCEDURE [Api].[AzureQueueAddMessage](
	@message AS VARCHAR(MAX),  
	@azureQueueConnectionString VARCHAR(MAX),
	@STATUSOUTPUT INT OUTPUT)
AS
		/*******************************************************************************
		**	File: Api.AzureQueueAddMessage.sql 
		**	Name: AzureQueueAddMessage
		**	Desc: Add message to the Azure Queue 
		**	Auth: Ilya Osipov
		**	Date: 8/16/2017
		**	Called By: 
		*******************************************************************************/	
DECLARE @Object INT;
DECLARE @Status INT = 0;
DECLARE @StatusText VARCHAR(8000);
    DECLARE @sURL VARCHAR(200)
    DECLARE @response varchar(max)
	Declare @encoded varchar(max), @ResponseText as Varchar(8000);

SELECT @message = 
    CAST(N'' AS XML).value(
          'xs:base64Binary(xs:hexBinary(sql:column("bin")))'
        , 'VARCHAR(MAX)'
    )
FROM (
    SELECT CAST(@message AS VARBINARY(MAX)) AS bin
) AS bin_sql_server_temp;

SET @message = '<QueueMessage>
					<MessageText>'+@message+'
					</MessageText>
				</QueueMessage>';

EXEC sp_OACreate 'WinHttp.WinHttpRequest.5.1', @Object OUT;
EXEC sp_OAMethod @Object, 'Open', NULL, 'POST',  @azureQueueConnectionString, 'false';
EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/xml';
DECLARE @len INT = len(@message) ;
EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Length', @len;
EXEC sp_OAMethod @Object, 'send', null, @message;
Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT;
EXEC sp_OAGetProperty @Object, 'Status', @Status OUT;
EXEC sp_OAGetProperty @Object, 'StatusText', @StatusText OUT;

EXEC sp_OADestroy @Object;

IF @Status <> 200 AND @Status <> 201
	BEGIN
		RAISERROR (N'Failed to do azure queue web request: %d %s.', -- Message text.  
				18, -- Severity (Maximum),  
				1, -- State,  
				@Status,
				@StatusText);
	END;

SET @STATUSOUTPUT = @Status;
	
RETURN