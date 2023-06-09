SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LineItemDescription]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LineItemDescription]
GO






/* 
 * PROCEDURE: LineItemDescription 
 */
-- SELECT * from LineItemDescription 
CREATE PROCEDURE sps_LineItemDescription
(
    @LineItemDescriptionID       int =null)
AS
BEGIN
    SELECT LineItemDescriptionID,
           LineItemDescriptionName,
           LineItemPrice,
 	   LineItemProductID
      FROM LineItemDescription
     WHERE LineItemDescriptionID = ISNULL(@LineItemDescriptionID,LineItemDescriptionID)
     ORDER BY LineItemDescriptionName, LineItemPrice

    RETURN(0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

