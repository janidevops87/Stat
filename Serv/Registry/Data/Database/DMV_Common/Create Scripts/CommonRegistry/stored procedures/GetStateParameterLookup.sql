IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetStateParameterLookup')
	BEGIN
		PRINT 'Dropping Procedure GetStateParameterLookup'
		DROP  Procedure  GetStateParameterLookup
	END

GO

PRINT 'Creating Procedure GetStateParameterLookup'
GO
CREATE Procedure GetStateParameterLookup
	@State VARCHAR(50)
AS
/******************************************************************************
**		File: GetStateParameterLookup.SQL
**		Name: GetStateParameterLookup
**		Desc: Queries list of (fullname) states used in report
**
** 
**		Called by:   
**              
**
**		Auth: ccarroll	
**		Date: 05/2/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**    05/20/2009	ccarroll		Initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @StateParameterDisplay AS Varchar(200)
DECLARE @Count AS int
DECLARE @StateTable table(
ID int identity (1,1) NOT NULL,
StateName varchar(50)
)

SELECT @StateParameterDisplay = ''

INSERT INTO @StateTable
	SELECT StateDisplayName FROM StateDSNLookup
	WHERE PATINDEX('%' + State + '%' , @State) > 0
	ORDER BY StateDisplayName DESC
	SELECT @Count = (SELECT Count(*) FROM @StateTable)

WHILE @Count > 0
	BEGIN
		SET @StateParameterDisplay = @StateParameterDisplay +(SELECT StateName FROM @StateTable WHERE ID = @Count) + ', '
		SET @Count = (@Count - 1)
	END 

/* Remove last ', ' */
SET @StateParameterDisplay =  LEFT(@StateParameterDisplay, (LEN(@StateParameterDisplay) -1))

SELECT @StateParameterDisplay AS ParameterDisplayState
