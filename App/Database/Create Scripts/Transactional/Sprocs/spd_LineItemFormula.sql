SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_LineItemFormula]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_LineItemFormula]
GO

CREATE PROCEDURE spd_LineItemFormula
(
    @LineItemFormulaID int
)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LineItemFormula
     WHERE LineItemFormulaID = @LineItemFormulaID

    IF (@@error!=0)
    BEGIN
        RAISERROR(20002, -1, -1, 'LineItemFormula: Cannot delete because foreign keys still exist in LineItemFormula ')
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

