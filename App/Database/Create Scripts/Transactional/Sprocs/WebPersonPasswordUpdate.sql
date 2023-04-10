IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'WebPersonPasswordUpdate')
	BEGIN
		PRINT 'Dropping Procedure WebPersonPasswordUpdate';
		DROP  Procedure  WebPersonPasswordUpdate;
	END

GO

PRINT 'Creating Procedure WebPersonPasswordUpdate';
GO
CREATE Procedure [dbo].[WebPersonPasswordUpdate]
    @WebPersonID int, 
    @SaltValue  VARCHAR(100) , 
    @HashedPassword varchar(100),
    @PasswordExpiration datetime
AS
/******************************************************************************
**      File: WebPersonPasswordUpdate.sql
**      Name: WebPersonPasswordUpdate
**      Desc: Updates password and saltvalue
**
**              
** 
**      Called by:   
**              
**      Parameters:
**      Input                           Output
**     ----------                           -----------
**
**      Auth: Pam Scheichenost      
**      Date: 11/02/2020
*******************************************************************************
**      Change History
*******************************************************************************
**      Date:       Author:                 Description:
**      --------    --------                ------------------------------------
**      11/02/2020  Pamela Scheichenost     initial
*******************************************************************************/
UPDATE WebPerson
SET SaltValue = @SaltValue,
    HashedPassword = @HashedPassword,
    PasswordExpiration = @PasswordExpiration
WHERE WebPersonID = @WebPersonId;



GO

GRANT EXEC ON WebPersonPasswordUpdate TO PUBLIC;

GO
