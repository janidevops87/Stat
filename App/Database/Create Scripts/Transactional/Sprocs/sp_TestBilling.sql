SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TestBilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TestBilling]
GO

CREATE PROCEDURE [sp_TestBilling] 
	@TableTextID  CHAR(10) = "0000000000" OUTPUT,
	@TableID 	INTEGER = 0 

AS



	Select @TableTextID = "1234567891"



RETURN "39"

















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

