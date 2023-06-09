SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_PersonPhone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_PersonPhone]
GO

CREATE PROCEDURE  SPI_PersonPhone
                  @PersonId Int = 0,
	     @PhoneId Int = 0,
	     @PhoneAlphaPagerEmail VarChar(100) = NULL
AS

/* Inserts a new record in PersonPhone when given PersonId, PhoneId and PhoneAlphaPagerEmail.
    Returns PersonPhoneId just inserted.  Used by DTS package: 
    Created 12/29/04 - SAP  */

DECLARE @iRtn Int

IF @PersonId <> 0 AND @PhoneId <> 0
    BEGIN
	INSERT INTO PersonPhone (PersonId, PhoneId, PhoneAlphaPagerEmail, LastModified)
		VALUES (@PersonId, @PhoneId, @PhoneAlphaPagerEmail, GetDate());

	SET @iRtn = (SELECT IDENT_CURRENT('PersonPhone'));

	SELECT @iRtn AS PersonPhoneId

    END

RETURN @iRtn
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

