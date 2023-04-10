SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_SourceEvent    Script Date: 5/14/2007 10:02:42 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SourceEvent]
GO





CREATE PROCEDURE sps_SourceEvent AS


SELECT 
	SourceCodeName, 
	SourceCodeID  
FROM 	RegistryEventSourceCodes  
ORDER BY SourceCodeName







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

