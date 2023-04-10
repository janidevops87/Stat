if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_CallCountSummarytEMP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_CallCountSummarytEMP]
GO

CREATE TABLE [dbo].[Referral_CallCountSummarytEMP] (
	[Unknown OTE] [int] NULL ,
	[Unknown Tissue] [int] NULL ,
	[Unknown T/E] [int] NULL ,
	[Unknown Eye] [int] NULL ,
	[Unknown Total RO] [int] NULL ,
	[Unknown Age RO] [int] NULL ,
	[Unknown Med RO] [int] NULL ,
	[Unknown Other] [int] NULL ,
	[Unknown Other Eye] [int] NULL ,
	[Unknown Totals] [int] NULL ,
	[Consented OTE] [int] NULL ,
	[Consented Tissue] [int] NULL ,
	[Consented T/E] [int] NULL ,
	[Consented Eye] [int] NULL ,
	[Consented Total RO] [int] NULL ,
	[Consented Age RO] [int] NULL ,
	[Consented Med RO] [int] NULL ,
	[Consented Other] [int] NULL ,
	[Consented Other Eye] [int] NULL ,
	[Consented Totals] [int] NULL ,
	[Denied OTE] [int] NULL ,
	[Denied Tissue] [int] NULL ,
	[Denied T/E] [int] NULL ,
	[Denied Eye] [int] NULL ,
	[Total Denied RO] [int] NULL ,
	[Denied Age RO] [int] NULL ,
	[Denied Med RO] [int] NULL ,
	[Denied Other] [int] NULL ,
	[Denied Other Eye] [int] NULL ,
	[Denied Totals] [int] NULL ,
	[Not Approached OTE] [int] NULL ,
	[Not Approached Tissue] [int] NULL ,
	[Not Approached TE] [int] NULL ,
	[Not Approached Eye] [int] NULL ,
	[Not Approached Total RO] [int] NULL ,
	[Not Approached Age RO] [int] NULL ,
	[Not Approached Med RO] [int] NULL ,
	[Not Approached Other] [int] NULL ,
	[Not Approached Other Eye] [int] NULL ,
	[Not Approached Totals] [int] NULL ,
	[Total Referrals OTE] [int] NULL ,
	[Total Referrals Tissue] [int] NULL ,
	[Total Referrals T/E] [int] NULL ,
	[Total Referrals Eye] [int] NULL ,
	[Total Referrals Total RO] [int] NULL ,
	[Total Referrals Age RO] [int] NULL ,
	[Total Referrals Med RO] [int] NULL ,
	[Total Referrals Other] [int] NULL ,
	[Total Referrals Totals] [int] NULL ,
	[Total Other Eye] [int] NULL 
) ON [PRIMARY]
GO


