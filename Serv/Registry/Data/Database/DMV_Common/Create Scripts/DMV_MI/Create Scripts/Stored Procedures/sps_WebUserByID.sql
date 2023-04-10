
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  StoredProcedure [dbo].[sps_WebUserbyID]    Script Date: 08/12/2010 14:20:38 ******/
/****** HS 24855 ccarroll SQL2008 compatibility issue 08/12/2010 ****/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserByID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserByID]
GO


CREATE PROCEDURE [dbo].[sps_WebUserbyID]
  @WebUserID   INT = 0
AS
SET NOCOUNT ON
If @WebUserID <> 0
BEGIN
 SELECT * FROM webuser --, registry
 WHERE webuserid=@WebUserID
 --AND webuser.RegistryID --*= registry.ID
END


GO


