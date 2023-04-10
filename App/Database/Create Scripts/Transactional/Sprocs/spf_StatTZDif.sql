SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_StatTZDif]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_StatTZDif]
GO


CREATE PROCEDURE spf_StatTZDif
	@vTZ	VARCHAR(2),
	@vDate	smalldatetime =null

AS

DECLARE @vDif INT 

		SELECT @vDif = dbo.fn_TimeZoneDifference
			(
				@vTZ,
				@vDate 
			)

	select @vDif

	return @vDif

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

