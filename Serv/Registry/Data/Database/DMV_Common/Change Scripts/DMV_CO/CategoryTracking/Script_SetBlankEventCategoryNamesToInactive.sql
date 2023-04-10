/*** DMV_CO Set Blank Event Category names to Inactive  
	Filename: Script_SetBlankEventCategoryNamesToInactive.sql
	03/10/2011 ccarroll - initial
	Description: This update sets Event Categories having a blank name to inactive.
	This will remove them from the public view. Setting the EventName to 'Inactive Event' will
	allow the client to re-activate the event at a later time. 
	Per Client request 03/09/2011.
	
	Test WHERE 
	--SELECT * FROM EventCategory WHERE LTRIM(EventCategoryName) = ''
*/

 UPDATE EventCategory SET EventCategoryActive = 0, EventCategoryName = 'Inactive Event' WHERE LTRIM(EventCategoryName) = '' --AND EventCategoryActive = 1

GO 