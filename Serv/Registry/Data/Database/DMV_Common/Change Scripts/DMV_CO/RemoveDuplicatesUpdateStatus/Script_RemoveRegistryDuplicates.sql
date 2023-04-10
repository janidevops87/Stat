


DECLARE @TempDuplicates TABLE
	(
		Last_First_DOB 		varchar(100) NULL,
		NumberOfOccurrences 	int NULL
 	)
  
 INSERT @TempDuplicates
 
	SELECT  (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar)) AS 'Last_First_DOB', Count(LastName + '-' + FirstName + '-' + CAST(DOB AS varchar)) AS 'NumOccurrences'
	FROM Registry
	WHERE Donor = 1 And DonorConfirmed = 1
	GROUP BY (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar))
	HAVING (Count (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar)) >1) 
	ORDER BY NumOccurrences Desc
 
--SELECT * FROM @TempDuplicates 


SELECT * FROM Registry
JOIN @TempDuplicates ON  (@TempDuplicates.LastName + '_' + @TempDuplicates.FirstName + '_' + CAST(@TempDuplicatesDOB AS varchar) = 
 (Registry.LastName + '_' + Registry.FirstName + '_' + CAST(Registry.DOB AS varchar)