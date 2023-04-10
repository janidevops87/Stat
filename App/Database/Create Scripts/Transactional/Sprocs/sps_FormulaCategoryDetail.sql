SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FormulaCategoryDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FormulaCategoryDetail]
GO


CREATE PROCEDURE sps_FormulaCategoryDetail 
	@FormulaCategoryID as int = null

AS

	SELECT  FormulaCategoryID,
		FormulaCategoryDetailID,
		FormulaCategoryDetailName                                                                            
	FROM 	FormulaCategoryDetail
	WHERE	FormulaCategoryID = ISNULL(@FormulaCategoryID, FormulaCategoryID)
	ORDER BY 	FormulaCategoryID,
			FormulaCategoryDetailName                                                                            





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

