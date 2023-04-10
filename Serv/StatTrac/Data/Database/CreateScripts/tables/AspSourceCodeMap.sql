if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AspSourceCodeMap]'))
BEGIN
            PRINT 'CREATE TABLE [dbo].[AspSourceCodeMap]'
END
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AspSourceCodeMap]'))
begin

CREATE TABLE [dbo].[AspSourceCodeMap] (
            [AspSourceCodeMapID] [int] IDENTITY (1, 1) NOT NULL ,
            [SourceCodeID] [int] NULL ,
            [AspSourceCodeID] [int] NULL 
)
end
GO