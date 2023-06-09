SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SourceCode_ListAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SourceCode_ListAll]
GO


Create Procedure [dbo].[SourceCode_ListAll]
As
Begin

Select Distinct 
	SC.SourceCodeId,
	SC.SourceCodeName
From
	SourceCode SC
	Inner Join WebReportGroupSourceCode WSC On ( WSC.SourceCodeId = SC.SourceCodeId )
Where
	WSC.WebReportGroupId = 436
Order By
	SC.SourceCodeName

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

