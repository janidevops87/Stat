IF EXISTS (SELECT * FROM sysobjects WHERE xtype = 'FN' AND name = 'fn_rpt_DonorAgeYear')
	BEGIN
		PRINT 'Dropping Function fn_rpt_DonorAgeYear'
		DROP  Function  fn_rpt_DonorAgeYear
	END

GO

PRINT 'Creating Function fn_rpt_DonorAgeYear'
GO


CREATE FUNCTION dbo.fn_rpt_DonorAgeYear
	(
	@DOB DATETIME = NULL,	-- Date of Birth 
	@DOD DATETIME = NULL,	-- Date of Death (CardiaicDeathDatetime)
	@Age varchar(4) = NULL, -- Donor Age
	@AgeUnit varchar(10) = NULL -- Donor Age Unit
	)
RETURNS Decimal(6,3)
AS 
/******************************************************************************
**		File: dbo.fn_rpt_DonorAgeYear.sql
**		Name: dbo.fn_rpt_DonorAgeYear
**		Desc: Calculates age based on Cardiaic Death Datetime, Date of Birth or
**			  by Age and AgeUnit. If either DOB or DOD are missing, the Age and AgeType
**			  will be used to calculate the donor's age. The Output is returned in 
**			  decimal year format. For example, 27 Months would appear as: 2.25 Years
**
**		Report Usage Example:
**			WHERE fn_rpt_DonorAgeYear(DOB, DOD, Age, AgeType) Between (LowerAge) AND (UpperAge)
**
**		Used by the following reports 
**				1. ReferralOutcome 
**				2. Referral Detail
**              
**		Return values:
** 
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll	
**		Date: 4/28/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**		04/28/2008	ccarroll			Initial 
*******************************************************************************/
BEGIN
DECLARE @Output AS Decimal(6,3)

SET @Output = -1.0 -- select nothing by default

	IF @DOB Is Null OR @DOD Is Null
	BEGIN -- Calculation based on Donor AGE
		SET @Output = 	CASE @AgeUnit
				WHEN 'Years' THEN CAST(@Age AS Decimal)
				WHEN 'Months' THEN (CAST(@Age AS Decimal)/12)
				WHEN 'Days' THEN (CAST(@Age AS Decimal)/365.25)
				ELSE -1.0 -- select nothing
				END 
	END
	ELSE
	BEGIN -- Calculation based on DOB and DOD times
		SET @Output = 	DATEDIFF(Day, @DOB, @DOD) / 365.25
	END

-- IF the person is over 2 do not use a fraction of a year. 
IF  @Output > 2
	SET @Output = CONVERT(INT, @Output)


RETURN @Output
END
GO
