SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Zip]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Zip](
	[ZipID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Zip] [varchar](5) NOT NULL,
	[ZipCountyFIPS] [varchar](3) NOT NULL,
	[ZipStateAbbrv] [varchar](2) NOT NULL,
	[ZipCity] [varchar](50) NULL,
	[ZipCityUSPSPreferred] [varchar](50) NULL,
	[ZipCountyName] [varchar](50) NULL,
	[StateID] [int] NULL,
	[ZipSource] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_Zip] PRIMARY KEY NONCLUSTERED 
(
	[ZipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Zip_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Zip]'))
ALTER TABLE [dbo].[Zip]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Zip_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Zip_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Zip]'))
ALTER TABLE [dbo].[Zip] CHECK CONSTRAINT [FK_dbo_Zip_StateID_dbo_State_StateID]
GO
