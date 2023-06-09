SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_SourceEvent    Script Date: 5/14/2007 10:02:45 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SourceEvent]
GO




CREATE PROCEDURE spu_SourceEvent AS

DECLARE @ErrorMessage VARCHAR(500)

	UPDATE EventSourceCodes
	SET
	EventSourceCodes.SourceCodeName  = EST.SourceCodeName,
	EventSourceCodes.SourceCodeNote  = EST.SourceCodeNote 
	
	FROM _EventSource_Temp EST
	WHERE EventSourceCodes.SourceCodeID  = EST.SourceCodeID
	
SET @ErrorMessage = 'Information Message:> Event Source update count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

