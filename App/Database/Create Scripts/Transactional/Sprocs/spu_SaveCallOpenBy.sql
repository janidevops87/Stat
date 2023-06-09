SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SaveCallOpenBy]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SaveCallOpenBy]
GO


CREATE PROCEDURE spu_SaveCallOpenBy
	@pvCallID int,
	@pvCallOpenByID int,
	@pvCallOpenByWebPersonId int,
	@CallSaveLastByID int = 77,
	@AuditLogTypeID int = NULL

AS
	-- CREATED 11/18/2002 BJK
	-- @1996 - 2002
	-- Statline, LLC. All rights reserved

	UPDATE 
		Call
	SET 
		CallOpenByID = @pvCallOpenByID,
	    CallOpenByWebPersonId = @pvCallOpenByWebPersonId,
		LastModified = CASE WHEN @pvCallOpenByID = 0 THEN GetDate() ELSE LastModified END,		
		CallSaveLastByID = @CallSaveLastByID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify
	WHERE CallID = @pvCallID

	RETURN @@ERROR



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

