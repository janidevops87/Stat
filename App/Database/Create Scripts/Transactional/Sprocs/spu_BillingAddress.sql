SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_BillingAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_BillingAddress]
GO

CREATE PROCEDURE spu_BillingAddress AS

DECLARE @ErrorMessage VARCHAR(500)

	UPDATE BillingAddress
	SET
	BillingAddress1	=	BADDR1	,
	BillingAddress2	=	BADDR2	,
	BillingAddress3	=	BADDR3	,
	BillingAddress4	=	BADDR4	,
	BillingAddress5	=	BADDR5	
	
	FROM _QBBillingAddressTable_Temp
	WHERE QBooksID  = REFNUM
	
SET @ErrorMessage = 'Information Message:> BillingAddress update count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

