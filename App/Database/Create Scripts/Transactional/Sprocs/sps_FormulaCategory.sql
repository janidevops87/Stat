SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FormulaCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FormulaCategory]
GO



CREATE PROCEDURE sps_FormulaCategory AS
	
	SELECT	FormulaCategoryID, FormulaCategoryName 
	FROM 	FormulaCategory


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

