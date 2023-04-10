 /******************************************************************************************
**		File: UpdateDMVLastModified.sql
**		Descr: Updates LastModified dates if value is null. The LastModified date is  
**		used in Actionable Designation reports.
**
**		Auth: ccarroll
**		Date: 09/08/2010 
**
**		HS 23683, WI 7685, CCRST126 for DMV_MA, DMV_NE databases
**		TEST SCRIPTS 
**		SELECT COUNT(*) FROM DMV WHERE LastModified Is NULL
**		SELECT TOP 1000 * FROM DMV WHERE CreateDate < '2009-07-02'-- AND LastModified Is NULL
*******************************************************************************************/

UPDATE DMV SET LastModified = IsNull(LastModified, CreateDate) 
WHERE CreateDate < '2009-07-02' AND LastModified Is NULL

