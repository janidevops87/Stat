CREATE TABLE [dbo].[Log]
(
    [Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [CreatedTime] DATETIME2,
    [EventId] NVARCHAR(100),
    [LogLevel] NVARCHAR(100),
    [Category] NVARCHAR(100),
    [Message] NVARCHAR(MAX)
)
