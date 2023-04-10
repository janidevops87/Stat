  /***************************************************************************************************
**	Name: County
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	01/28/2011	Bret Knoll		Initial Script Creation
**	08/15/2011  ccarroll		HS:29024 Added Morgan County to Ohio StateId 33 
***************************************************************************************************/

 
 
 
 Update County
set Inactive = 0
WHERE Inactive IS NULL

Update County
set UpdatedFlag = 1
where UpdatedFlag is null

UPDATE County
SET Verified = 0
WHERE Verified IS NULL


--HS:29024 ccarroll 08/15/2011 Add County Morgan to OHIO(StateID 33)
IF (SELECT Count(*) FROM County WHERE CountyName = 'Morgan' AND StateID = 33) < 1
BEGIN
	INSERT County (CountyName, StateID, Verified, Inactive, LastModified, UpdatedFlag) VALUES('Morgan',33, 0, 0, GETDATE(), 1)
END