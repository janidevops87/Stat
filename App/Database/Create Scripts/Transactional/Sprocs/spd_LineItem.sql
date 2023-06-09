SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_LineItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_LineItem]
GO

CREATE PROCEDURE spd_LineItem
(
    @LineItemID int
)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LineItem
     WHERE LineItemID = @LineItemID

   DELETE LineItemFormula 
   WHERE LineItemID = @LineItemID

    IF (@@error!=0)
    BEGIN
        RAISERROR(20002, -1, -1, 'LineItem: Cannot delete because foreign keys still exist in LineItem ')
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

