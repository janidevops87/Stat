SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineSavePhone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineSavePhone]
GO




CREATE PROCEDURE  sps_OnlineSavePhone
			@vPhoneAreaCode as int=303,
			@vPhonePrefix as int=893,
			@vPhoneNumber as int = 8399

 AS

 INSERT INTO Phone (PhoneAreaCode, PhonePrefix, PhoneNumber, PhoneTypeID) VALUES (@vPhoneAreaCode,@vPhonePrefix,@vPhoneNumber,3)

Select @@Identity



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

