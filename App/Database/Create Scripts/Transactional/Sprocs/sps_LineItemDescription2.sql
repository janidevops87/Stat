SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LineItemDescription2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LineItemDescription2]
GO




/* 
 * PROCEDURE: LineItemDescription 
 */
-- SELECT * from LineItemDescription 
CREATE PROCEDURE sps_LineItemDescription2
(
    @LineItemDescriptionID       int =null)
AS
BEGIN
    SELECT LineItemDescriptionID,
           LTRIM(RTRIM(LineItemDescriptionName)),
           LineItemPrice,
 	   LineItemProductID,
	   LineItemDescriptionReconcile
      FROM LineItemDescription
     WHERE LineItemDescriptionID = ISNULL(@LineItemDescriptionID,LineItemDescriptionID)
     ORDER BY LineItemDescriptionName,  LineItemPrice

    RETURN(0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

