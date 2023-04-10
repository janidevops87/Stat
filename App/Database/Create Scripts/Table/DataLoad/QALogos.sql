/***************************************************************************************************
**	Name: QALogos Type
**	Desc: Data Load for table QALogos
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	10/2011		jth				Initial 
**	06/15/2012	ccarroll		Correct Logo image for MTF
***************************************************************************************************/

/* Update MTF to correct Logo*/
DECLARE @LogoName AS nvarchar(50) = 'MTF'
DECLARE @ImageName AS nvarchar(50) = 'mtf.jpg'
 
IF EXISTS (SELECT TOP 1 * FROM QALogos WHERE LogoName = @LogoName )
BEGIN
	PRINT 'Updating QA Logo: ' + @ImageName +' for ' + @LogoName 
	UPDATE QALogos SET ImageName = @ImageName 
	WHERE LogoName = @LogoName
END