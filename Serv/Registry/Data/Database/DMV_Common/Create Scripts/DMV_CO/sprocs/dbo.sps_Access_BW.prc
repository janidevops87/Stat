SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_Access_BW    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Access_BW]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Access_BW]
GO




CREATE PROCEDURE sps_Access_BW
		@WebUserID 		INT	= 0
AS

If @WebUserID <> 0
BEGIN
	SELECT Accesstype.Access, AccessName, AccessDescription
	FROM Accesstype, Webuser
	WHERE WebUserID= @WebUserID
	AND Accesstype.Access & WebUser.Access <> 0
END











GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

