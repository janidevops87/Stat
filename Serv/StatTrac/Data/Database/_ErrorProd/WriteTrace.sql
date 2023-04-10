 /****** Object:  Stored Procedure dbo.WriteTrace    Script Date: 10/1/2004 3:16:34 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WriteTrace]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WriteTrace]
GO

/****** Object:  Stored Procedure dbo.WriteTrace    Script Date: 10/1/2004 3:16:36 PM ******/

CREATE PROCEDURE WriteTrace
(
	@EventID int, 
	@Category nvarchar(64),
	@Priority int, 
	@Severity nvarchar(32), 
	@Title nvarchar(256), 
	@Timestamp datetime,
	@MachineName nvarchar(32), 
	@AppDomainName nvarchar(2048),
	@ProcessID nvarchar(256),
	@ProcessName nvarchar(2048),
	@ThreadName nvarchar(2048),
	@Win32ThreadId nvarchar(128),
	@Message nvarchar(2048),
	@FormattedMessage ntext
)
AS 

	INSERT INTO [Trace] (
		EventID,
		Category,
		Priority,
		Severity,
		Title,
		[Timestamp],
		MachineName,
		AppDomainName,
		ProcessID,
		ProcessName,
		ThreadName,
		Win32ThreadId,
		Message,
		FormattedMessage
	)
	VALUES (
		@EventID, 
		@Category, 
		@Priority, 
		@Severity, 
		@Title, 
		@Timestamp,
		@MachineName, 
		@AppDomainName,
		@ProcessID,
		@ProcessName,
		@ThreadName,
		@Win32ThreadId,
		@Message,
		@FormattedMessage)
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO  