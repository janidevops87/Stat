/******************************************************************************
**	File: Update_WebPerson.sql
**	Name: Update_WebPerson
**	Desc: Update [SaltValue] AND [HashedPassword] in [dbo].[WebPerson].
**	Auth: Ilya Osipov	
**	Date: May 25 2018
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  05/25/2018		Ilya Osipov				initial
**  08/13/2018		Ilya Osipov				Added where claus   [WebPersonPassword] IS NOT NULL AND [HashedPassword] IS NULL
*******************************************************************************/


UPDATE 
	[dbo].[WebPerson]
SET 
	[SaltValue] = 'Rkt0RGNFAO/v7+/v7+/v7w==',
	[HashedPassword] = CONVERT(VARCHAR(100),HASHBYTES('SHA1',[WebPersonPassword]+'Rkt0RGNFAO/v7+/v7+/v7w=='), 2)
WHERE [WebPersonPassword] IS NOT NULL AND [HashedPassword] IS NULL


