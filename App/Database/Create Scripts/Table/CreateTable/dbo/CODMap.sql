SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CODMap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CODMap](
	[MapID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CountyID] [int] NULL,
	[StateID] [int] NULL,
	[CountyFIPS] [varchar](3) NULL,
	[CoalitionID] [varchar](3) NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_CODMap] PRIMARY KEY NONCLUSTERED 
(
	[MapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CODMap__LastModi__3747B5CE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CODMap] ADD  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CODMap_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CODMap]'))
ALTER TABLE [dbo].[CODMap]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CODMap_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CODMap_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CODMap]'))
ALTER TABLE [dbo].[CODMap] CHECK CONSTRAINT [FK_dbo_CODMap_StateID_dbo_State_StateID]
GO
