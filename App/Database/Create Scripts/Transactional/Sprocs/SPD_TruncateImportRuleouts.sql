SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_TruncateImportRuleouts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_TruncateImportRuleouts]
GO

CREATE PROCEDURE SPD_TruncateImportRuleouts AS
Truncate table dbo.Import_Criteria_Ruleouts

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

