SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_SecondaryMedication]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spd_Audit_SecondaryMedication]
GO

create procedure "spd_Audit_SecondaryMedication" 
	@pkc1 int,
	@pkc2 int
as


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

