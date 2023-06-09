if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_MultiTypeCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_MultiTypeCount]
GO

CREATE TABLE [dbo].[Referral_MultiTypeCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[Total] [smallint] NULL ,
	[OTE] [smallint] NULL ,
	[OT] [smallint] NULL ,
	[OE] [smallint] NULL ,
	[O] [smallint] NULL ,
	[Tissue] [smallint] NULL ,
	[TE] [smallint] NULL ,
	[Eye] [smallint] NULL ,
	[AgeRO] [smallint] NULL ,
	[MedRO] [smallint] NULL ,
	[RO] [smallint] NULL 
) ON [PRIMARY]
GO


