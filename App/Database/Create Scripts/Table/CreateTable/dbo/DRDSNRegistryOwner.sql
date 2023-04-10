SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DRDSNRegistryOwner]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DRDSNRegistryOwner]
(
	[DRDSNID] smallint not null,
	[RegistryOwnerId] int not null,
	CONSTRAINT FK_dbo_DRDSNRegistryOwner_DRDSNID_dbo_DRDSN_DRDSNID 
	FOREIGN KEY([DRDSNID]) REFERENCES [dbo].[DRDSN] ([DRDSNID])
);
END
GO
