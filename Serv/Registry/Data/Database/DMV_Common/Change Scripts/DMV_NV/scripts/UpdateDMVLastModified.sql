 /******************************************************************************************
**		File: UpdateDMVLastModified.sql
**		Descr: Updates LastModified dates if value is null. The LastModified date is  
**		used in Actionable Designation reports.
**
**		Auth: ccarroll
**		Date: 09/08/2010 
**
**		HS 24904, WI 7677, CCRST126 for DMV_NV database
**		TEST SCRIPTS 
**		SELECT COUNT(*) FROM DMV WHERE LastModified Is NULL
*******************************************************************************************/

UPDATE DMV SET LastModified = IsNull(LastModified, CreateDate) 
