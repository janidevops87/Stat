if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_CalculateOverallDisposition]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_CalculateOverallDisposition]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.fn_CalculateOverallDisposition
	(
		@OptionID			int,
		@OptionAppropriate	int,
		@OptionApproach		int,
		@OptionConsent		int,
		@OptionConverstion	int
	)
RETURNS int
AS

/******************************************************************************
**		File: 
**		Name: fn_CalculateOverallDisposition
**		Desc: This function will calculate the OverallDisposition 
**			  during the Insert and Update of Referral. 
**			  OverDisposition is calculated by querying the SetDisposition Table
**
**              
**		Return values: 
**			Returns the Disposition value based on the parameters passed.
**			If no disposition is selected and the value is null 9 is returned. 
**			9 = unknown
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 5/8/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/8/07		Bret Knoll			initial StatTrac 8.4.3.8 AuditTrail
*******************************************************************************/

	BEGIN
		DECLARE @OverallDisposition int
		SELECT 
			@OverallDisposition = DispositionID 
		FROM 
			SetDisposition 
		WHERE 
			OptionID = @OptionID
		AND 
			AppropriateID = @OptionAppropriate
		AND 
			ApproachID = @OptionApproach 
		AND 
			ConsentID = @OptionConsent   
		AND 
			RecoveryID = @OptionConverstion
	
	RETURN ISNULL(@OverallDisposition, 9) -- 9 = Unknown
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

