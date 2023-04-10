/******************************************************************************
**		File: ExpireWebPersonPasswords.sql
**		Name: Expire WebPerson Passwords
**		Desc: Update our website users with an expired PasswordExpiration
**					Implement this in a staggered manner so we expire passwords 
**					on weekdays beginning 3/1/2021 and ending 8/1/2021.  We have
**					around 3300 records to update so we'll plan on 31 each day.
**
**		Auth: Mike Berenson	
**		Date: 01/15/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/15/2021	Mike Berenson		initial
**		01/19/2021	Mike Berenson		Increased stagger period from 2 months to 5
*******************************************************************************/

DROP TABLE IF EXISTS #WebPersonsToExpire;

-- Load #WebPersonsToExpire with WebPerson records that need to be updated
SELECT  
	wp.PersonID,
	CAST(NULL AS DATETIME) AS 'PasswordExpiration'
INTO #WebPersonsToExpire
FROM 
	WebPerson wp
	JOIN Person P ON p.PersonID = wp.PersonID
WHERE 
	p.Inactive = 0
	AND wp.PasswordExpiration IS NULL; 
	   
-- Initialize date parameters
DECLARE
	@FirstDate		DATE = '2021-03-01',
	@LastDate		DATE = '2021-07-31';
DECLARE 
	@CurrentDate	DATE = @FirstDate;


-- Update #WebPersonsToExpire setting 31 WebPerson records to expire each day
WHILE @CurrentDate <= @LastDate
BEGIN
	IF DATEPART(DW, @CurrentDate) BETWEEN 2 AND 6 -- weekdays only
	BEGIN

		-- Populate a PasswordExpiration (31 each day)
		UPDATE 
			wpte
		SET
			wpte.PasswordExpiration = CAST(@CurrentDate AS DATETIME)
		FROM
			(SELECT TOP (31) PasswordExpiration 
				FROM #WebPersonsToExpire
				WHERE PasswordExpiration IS NULL
				ORDER BY NEWID() -- random order to make sure we avoid expiring more in one organization than another
			)  wpte; 
			
	END

	SET @CurrentDate = DATEADD(DD, 1, @CurrentDate); -- add 1 to current day
END	
	
--SELECT * FROM #WebPersonsToExpire ORDER BY PersonID;

-- Update WebPerson
UPDATE WebPerson
SET WebPerson.PasswordExpiration = wpte.PasswordExpiration
FROM WebPerson 
	JOIN #WebPersonsToExpire wpte ON wpte.PersonID = WebPerson.PersonID;

DROP TABLE IF EXISTS #WebPersonsToExpire;

-- Check to make sure we don't have any WebPerson records without a PasswordExpiration
--SELECT  
--	wp.PersonID
--FROM 
--	WebPerson wp
--	JOIN Person P ON p.PersonID = wp.PersonID
--WHERE 
--	p.Inactive = 0
--	AND wp.PasswordExpiration IS NULL; 



