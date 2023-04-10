
/****** Object:  Trigger [denyUpdate]    Script Date: 05/12/2009 10:50:47 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[DenyUpdate]'))
BEGIN
	PRINT 'DROP TRIGGER [dbo].[DenyUpdate]'
	DROP TRIGGER [dbo].[DenyUpdate]
END
GO

/****** Object:  Trigger [dbo].[denyUpdate]    Script Date: 05/12/2009 10:50:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[DenyUpdate] 
   ON  [dbo].[RegistryDigitalCertificate] 
   INSTEAD OF UPDATE   
AS 
/******************************************************************************
**		File: 
**		Name: DenyUpdate Trigger
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   Table Update
**
**		Auth: Bret Knoll
**		Date: O5/12/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		O5/12/2009	Bret Knoll			Denies Update
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for trigger here
	PRINT 'UPDATES TO THE TABLE ARE NOT ALLOWED'
    

END

GO

