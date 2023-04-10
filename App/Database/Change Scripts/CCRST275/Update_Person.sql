/******************************************************************************
**	File: Update_Person.sql
**	Name: Update_Person
**	Desc: Update [Inactive] value for persons with passwords in ('seeya', 'gone')
**	Auth: Ilya Osipov	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  07/19/2018		Ilya Osipov				initial
*******************************************************************************/

UPDATE 
	[Person]
SET 
	[Person].Inactive = 1
FROM 
	[Person]
JOIN 
	[WebPerson] ON [Person].PersonID = [WebPerson].PersonID
WHERE 
	Inactive = 0
AND 
	WebPersonPassword in ('seeya', 'gone');


