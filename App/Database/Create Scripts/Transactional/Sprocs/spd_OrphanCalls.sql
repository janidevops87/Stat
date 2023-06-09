SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_OrphanCalls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_OrphanCalls]
GO


--spd_OrphanCalls '1398758'


CREATE PROCEDURE  spd_OrphanCalls
	
	@vCallID 			int	= null

 AS
/*
	select * from call where CallID = @vCallID
	select * from referral where callid = @vCallID
	select * from logevent where callid = @vCallID
	select * from message where callid = @vCallID
*/
	delete call where callid = @vCallID
	delete referral where callid = @vCallID
	delete logevent where callid = @vCallID
	delete message where callid = @vCallID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

