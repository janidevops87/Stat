	/******************************************************************************
		**	File: WebPerson.sql 
		**	Name: WebPerson
		**	Desc: Loads data into the table WebPerson
		**	Auth: Bret Knoll
		**	Date: 07/14/2011
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------		--------		-------------------------------------------
		**	07/14/2011		Bret Knoll		Initial 
		*******************************************************************************/

print 'remove records'
 delete 
	WebPerson 
where 
	PersonID not in (select personid from person)