/******************************************************************************
**		File: Script_AddValues_Race.sql
**		Name: Script_AddValues_Race
**		Desc: Add values to Race lookup table for DMV and registry. 
**
**		Auth: ccarroll
**		Date: 07/16/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/16/2009	ccarroll			initial
*******************************************************************************/
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'I') = 0 
	BEGIN
		PRINT 'Adding table values: I-American Indian/Alaskan Native'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('I', 'American Indian/Alaskan Native', 1, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'A') = 0 
	BEGIN
		PRINT 'Adding table values: A-Asian/Pacific Islander'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('A', 'Asian/Pacific Islander', 2, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'B') = 0 
	BEGIN
		PRINT 'Adding table values: B-Black/African American'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('B', 'Black/African American', 3, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'O') = 0 
	BEGIN
		PRINT 'Adding table values: O-Other'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('O', 'Other', 4, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'U') = 0 
	BEGIN
		PRINT 'Adding table values: U-Unknown'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('U', 'Unknown', 5, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'W') = 0 
	BEGIN
		PRINT 'Adding table values: W-White/Caucasian'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('W', 'White/Caucasian', 6, Null, Null, GetDate(), GetDate(), Null)
END
IF (SELECT COUNT(*) FROM Race WHERE RaceDMVCode = 'H') = 0 
	BEGIN
		PRINT 'Adding table values: H-Hispanic/Latino'
		INSERT Race (RaceDMVCode, RaceName, SortOrder, Verified, Inactive, CreateDate, LastModified, UpdatedFlag) VALUES('H', 'Hispanic/Latino', 7, Null, Null, GetDate(), GetDate(), Null)
END