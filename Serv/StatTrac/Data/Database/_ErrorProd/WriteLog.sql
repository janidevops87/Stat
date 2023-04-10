 /****** Object:  Stored Procedure dbo.WriteLog    Script Date: 10/1/2004 3:16:34 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WriteLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WriteLog]
GO

/****** Object:  Stored Procedure dbo.WriteLog    Script Date: 10/1/2004 3:16:36 PM ******/

CREATE PROCEDURE WriteLog
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

	INSERT INTO [Log] (
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