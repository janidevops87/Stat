  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetCallIDList]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_GetCallIDList'
		DROP Function fn_GetCallIDList
	END
GO

PRINT 'Creating Function fn_GetCallIDList' 
GO

CREATE FUNCTION dbo.fn_GetCallIDList
	(
	@vStartDateTime as datetime,
	@vEndDateTime as datetime,
	@vCreated bit,
	@vModified bit
	)
RETURNS @CallIDTable TABLE
	(
		CallID int
	) 		
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_GetCallIDList
**		Desc: 
**
**		This function provides a list of CallIDs based on the provided paremeters.
**		The vCreated and vModified to determine which select statment is ran. Data
**		is select by create date, last modified or both
**		Called by:  
** 
**      StatFile.Net        
**		sps_StatFileMessageDetail.sql
**		sps_StatFileReferralDetail.sql
**		sps_StatFileReferralDetailFS.sql
**
**		Auth: Bret Knoll
**		Date: 10/10/2006
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
BEGIN
	
		IF (@vCreated = 1 AND @vModified <> 1 )
			BEGIN
				
				INSERT 
					@CallIDTable
				SELECT 
					CallID 
				FROM 
					Call	
				WHERE 
					Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime
			END

		IF (@vModified = 1 AND @vCreated <> 1 )
			BEGIN
				
				INSERT 
					@CallIDTable
				SELECT 
					CallID 
				FROM 
					Call	
				WHERE 
					Call.LastModified BETWEEN @vStartDateTime AND @vEndDateTime
				AND 
					Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime
			END
	
		IF (@vModified = 1 AND @vCreated = 1)
			BEGIN
				INSERT 
					@CallIDTable
				SELECT 
					CallID 
				FROM 
					Call	
				WHERE 
					Call.LastModified BETWEEN @vStartDateTime AND @vEndDateTime
				OR 
					Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime
			END
	RETURN
END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

