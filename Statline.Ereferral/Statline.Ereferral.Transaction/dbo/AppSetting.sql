CREATE TABLE [dbo].[AppSetting]
(
    [Id] INT NOT NULL PRIMARY KEY, 
    [Key] NVARCHAR(50) NOT NULL, 
    [Value] NVARCHAR(MAX) NULL
)
