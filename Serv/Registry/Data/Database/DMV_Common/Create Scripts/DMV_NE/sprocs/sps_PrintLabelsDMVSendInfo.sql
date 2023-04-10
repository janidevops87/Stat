if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PrintLabelsDMVSendInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_PrintLabelsDMVSendInfo'
	drop procedure [dbo].[sps_PrintLabelsDMVSendInfo]
END
GO

PRINT 'Creating Procedure: sps_PrintLabelsDMVSendInfo'
GO

CREATE PROCEDURE sps_PrintLabelsDMVSendInfo
	@StartDatetime datetime = Null,
	@EndDatetime datetime = Null,
	@Donor varchar(3) = Null
AS
/******************************************************************************
**		File: sps_PrintLabelsDMVSendInfo.sql
**		Name: sps_PrintLabelsDMVSendInfo
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 07/21/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      07/22/2009		ccarroll				initial
*******************************************************************************/
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

CREATE TABLE #PrintDMVLabelList(
	PrintDMVLabelListID int identity(1,1),
	License varchar(9)
)

INSERT #PrintDMVLabelList
SELECT 
		DMV.License
 FROM	DMV 
 WHERE	DMV.RenewalDate >= IsNull(@StartDatetime, DMV.RenewalDate) AND DMV.RenewalDate <= IsNull(@EndDatetime, DMV.RenewalDate)
  AND	Patindex('%'+ IsNull(@Donor, '-') +'%', '-' + CAST(IsNull(DMV.Donor, 0)AS varchar(1))) > 0 
  AND	IsNull(DMV.SendInfoFlag, 0) = 1 


SELECT 
	DMV.FirstName,
	DMV.MiddleName,
	DMV.LastName,
	DMV.Suffix,
	DMVAddr.ADDR1 AS 'ADDR1',
	DMVAddr.ADDR2 AS 'ADDR2',
	DMVAddr.CITY AS 'CITY',
	DMVAddr.STATE AS 'STATE',
	DMVAddr.ZIP AS 'ZIP',
	DMV.RenewalDate,
	CASE Donor WHEN 1 THEN 'Y' WHEN 0 THEN 'N' ELSE '' END AS 'Donor'
FROM DMV 
JOIN #PrintDMVLabelList PrintDMVLabelList ON PrintDMVLabelList.License = DMV.License
LEFT JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND DMVAddr.AddrTypeID = 1
ORDER BY 
	DMV.FirstName,
	DMV.MiddleName
ASC


/* Update SendInfoDate */
--ALTER TABLE DMV DISABLE TRIGGER Update_DMV
--GO
	UPDATE DMV SET SendInfoDate = GetDate()
	FROM DMV
	JOIN #PrintDMVLabelList PrintDMVLabelList ON DMV.License = PrintDMVLabelList.License

--ALTER TABLE DMV ENABLE TRIGGER Update_DMV
--GO

DROP TABLE #PrintDMVLabelList