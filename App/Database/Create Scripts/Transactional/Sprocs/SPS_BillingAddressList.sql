SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_BillingAddressList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_BillingAddressList]
GO



CREATE PROCEDURE SPS_BillingAddressList AS

SELECT 

	BillingAddressID,
	BillingAddress1,
	BillingAddress2,
	BillingAddress3,
	BillingAddress4,
	BillingAddress5
FROM   	BillingAddress
ORDER BY 	BillingAddress1





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

