SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListRecovery]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListRecovery]
GO




/****** Object:  Stored Procedure dbo.sps_ListRecovery    Script Date: 2/24/99 1:12:45 AM ******/
CREATE    PROCEDURE sps_ListRecovery
	@vSourceCodeID	int	= null

AS

/*	Object:	Stored Procedure dbo.sps_ListRecovery
	ISE:	Christopher Carroll
	Date:	11/21/2006
	Inputs:
		vSourceCodeID - Added to allow configurable selection lists

	Notes: This sp allows customized Conversion selection list based on 
	SourceCode.

*/



IF @vSourceCodeID = 338 OR @vSourceCodeID = 346 OR @vSourceCodeID = 347
	BEGIN
		--Show all active items for sourcecode above
		SELECT DISTINCT
		ConversionID,
		ConversionName
		FROM Conversion
		WHERE Inactive <> 1
	END
ELSE 
	  BEGIN
		SELECT DISTINCT
		ConversionID,
		ConversionName
		FROM Conversion
		WHERE Inactive <> 1
 		-- de-activate Item 13 (No Jurisdiction) for other sourcecodes
		AND ConversionID <> 13
	  END
 




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

