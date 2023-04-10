 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SourceCodeTransplantCenter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 begin
	 print 'droppoing table SourceCodeTransplantCenter'
	 drop table [dbo].[SourceCodeTransplantCenter]
end
GO


if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SourceCodeTransplantCenter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
print 'create table SourceCodeTransplantCenter'
CREATE TABLE [dbo].[SourceCodeTransplantCenter] (
	[SourceCodeTransplantCenterID] [int] IDENTITY (1, 1) NOT NULL ,
	[SourceCodeID] [int] ,
	[OrganizationID] [int],
	[TransplantCode] [varchar] (50)  
) ON [PRIMARY]
END

GO

