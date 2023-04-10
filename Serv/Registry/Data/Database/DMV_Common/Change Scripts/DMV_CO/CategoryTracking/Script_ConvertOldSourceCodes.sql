/* 1.0 Clean-correct existing SourceCode information prior to coversion
SELECT ID, SourceCode FROM Registry WHERE SourceCode = 'DA/ATF'
*/

/* Backup registry sourcecodes  */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_BackupRegistrySourcecodeIndex')
	BEGIN
		PRINT 'Dropping Table _BackupRegistrySourcecodeIndex'
		DROP  Table _BackupRegistrySourcecodeIndex
	END
GO
PRINT 'Creating Registry Sourcecode index backup'
	SELECT ID, Sourcecode INTO _BackupRegistrySourcecodeIndex FROM Registry 



IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_RegistrySourcecodeXref')
	BEGIN
		PRINT 'Dropping Table _RegistrySourcecodeXref'
		DROP  Table _RegistrySourcecodeXref
	END
GO
PRINT 'Creating Registry Sourcecode Cross-reference table'
	SELECT ID, Sourcecode INTO _RegistrySourcecodeXref FROM Registry 

GO


PRINT 'Clean-correct existing SourceCode: _RegistrySourcecodeXref'

PRINT '...2nd Creek Raceway'
/* 2nd Creek Raceway */
Update _RegistrySourcecodeXref SET Sourcecode = '2ndCreek'
WHERE ID IN(
10691,
10692,
10693,
10694,
10695,
10696,
10697,
10698,
10699
)

PRINT '...9 News Health Fair 2001'
/* 9 News Health Fair 2001 */
Update _RegistrySourcecodeXref SET Sourcecode = '9Health'
WHERE ID IN(
11020,
11021,
11022
)


PRINT '...9 News Health Fair 2002 OK '

PRINT '...9 News Health Fair 2003'
/* 9 News Health Fair 2003 */
Update _RegistrySourcecodeXref SET Sourcecode = '9HF03'
WHERE ID IN(
11023,
11024,
905
)


PRINT '...9 News Health Fair 2005'
/* 9 News Health Fair 2005 */
Update _RegistrySourcecodeXref SET Sourcecode = '9HF05'
WHERE ID IN(
12752
)

PRINT '...9 News Health Fair 2006'
/* 9 News Health Fair 2006 */
Update _RegistrySourcecodeXref SET Sourcecode = '9HF06'
WHERE ID IN(
16922,
16760,
16802,
16921,
16924,
16788,
16789,
16849,
16892,
16893,
16894,
16984,
17122,
17123,
17124,
17125,
17143,
17144
)

PRINT '...9 News Health Fair 2007'
/* 9 News Health Fair 2007 */
Update _RegistrySourcecodeXref SET Sourcecode = '9HF 07'
WHERE ID IN(
21084,
21085,
21146,
21147,
21148,
21150,
21151,
21152,
21153,
21310,
21416,
21609
)


PRINT '...AlloSource Registry Drive'
/* AlloSource Registry Drive */
Update _RegistrySourcecodeXref SET Sourcecode = 'WPL-ALLO'
WHERE ID IN(
14422
)


PRINT '...AlloSource Registry Drive'
/* AlloSource Registry Drive */
Update _RegistrySourcecodeXref SET Sourcecode = 'BONFIL'
WHERE ID IN(
634
)

/******* End of Data Correction **************/


truncate table EventRegistry;

/* 2.0 Add values */
PRINT 'Adding table values: EventRegistry'
IF (SELECT COUNT(*) FROM EventRegistry) = 0 
BEGIN

	INSERT INTO EventRegistry
			(
			RegistryID,
			EventCategoryID,
			EventSubCategoryID,
			EventCategorySpecifyText,
			EventSubCategorySpecifyText,
			LastModified,
			CreateDate
			)

		SELECT 	_RegistrySourcecodeXref.ID AS 'RegistryID',
			--This line removed for Import-- Registry.SourceCode,
			EventSubCategory.EventCategoryID,
			EventSubCategory.EventSubCategoryID,
			'' AS 'EventCategorySpecifyText',
			'' AS 'EventSubCategorySpecifyText',
			Null AS 'LastModified',
			GetDate() AS 'CreateDate'
		FROM _RegistrySourcecodeXref
		JOIN EventSubCategory ON _RegistrySourcecodeXref.SourceCode = EventSubCategory.EventSubCategorySourceCode
		ORDER BY _RegistrySourcecodeXref.ID --EventSubCategoryID


		PRINT 'Row add complete successfully'
END
ELSE

BEGIN
		PRINT '  -0 rows added - data already exists'
END
