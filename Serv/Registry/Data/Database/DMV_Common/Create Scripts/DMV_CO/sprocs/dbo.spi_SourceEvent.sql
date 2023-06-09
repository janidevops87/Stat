SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_SourceEvent    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_SourceEvent]
GO




CREATE PROCEDURE spi_SourceEvent AS

DECLARE @ErrorMessage VARCHAR(500)

INSERT RegistryEventSourceCodes
(
SourceCodeID,
SourceCodeName,
SourceCodeNote
)
SELECT DISTINCT SourceCodeID,
		SourceCodeName,
		SourceCodeNote
FROM _EventSource_Temp
WHERE SourceCodeID NOT IN (SELECT  SourceCodeID FROM RegistryEventSourceCodes)


SET @ErrorMessage = 'Information Message:> Event Source insert count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG










GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

