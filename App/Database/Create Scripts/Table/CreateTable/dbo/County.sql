SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[County]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[County](
	[CountyID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CountyName] [varchar](50) NULL,
	[StateID] [int] NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_County_1__13] PRIMARY KEY CLUSTERED 
(
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[County]') AND name = N'IX_County_CountyName')
CREATE NONCLUSTERED INDEX [IX_County_CountyName] ON [dbo].[County]
(
	[CountyName] ASC
)
INCLUDE([CountyID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_County_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[County]'))
ALTER TABLE [dbo].[County]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_County_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_County_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[County]'))
ALTER TABLE [dbo].[County] CHECK CONSTRAINT [FK_dbo_County_StateID_dbo_State_StateID]
GO
