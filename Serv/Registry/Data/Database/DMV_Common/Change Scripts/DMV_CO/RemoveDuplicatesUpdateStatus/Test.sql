/*
SELECT 
		Registry.LastName,
		Registry.FirstName,
		Registry.DOB,
		Registry.LastModified AS 'Reg_LastModified',
		DMV.LastModified AS 'DMV_LastModified',
		Registry.Donor AS 'Reg_Donor',
		Registry.DonorConfirmed AS 'Reg_Confirmed',
		Registry.PreviousDonorStateDMVDonor AS 'Reg_PreviousDMVDonor',
		Registry.PreviousDonorStateDonor AS 'Reg_PreviousDonor',
		Registry.PreviousDonorStateDonorConfirmed AS 'Reg_PreviousConfirmed',
		Registry.DMVDonor AS 'Reg_DMVDonor',
		DMV.Donor AS 'DMV_Donor',
		DMV.PreviousDonorState AS 'DMV_PreviousDonor'

FROM Registry, DMV
WHERE Registry.DOB = DMV.DOB
  AND Registry.LastName = DMV.LastName
  AND Registry.FirstName = DMV.FirstName

--Find DMV and Registry Donor mismatch for confirmed registry donors
  AND (Registry.Donor =1 AND Registry.DonorConfirmed = 1)
  AND Registry.DMVDonor <> DMV.Donor
*/

/* Finding Duplicates in Registry
SELECT  (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar)) AS 'Last_First_DOB', Count(LastName + '-' + FirstName + '-' + CAST(DOB AS varchar)) AS 'NumOccurrences'
FROM Registry
WHERE Donor = 1 And DonorConfirmed = 1
GROUP BY (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar))
HAVING (Count (LastName + '_' + FirstName + '_' + CAST(DOB AS varchar)) >1) 
ORDER BY NumOccurrences Desc

SELECT *
FROM Registry
WHERE PATINDEX((LastName + '_' + FirstName + '_' + CAST(DOB AS varchar)), 'GRIT_LOU_Jul 31 1947 12:00AM') > 0

--------------------------------
Use to list complete duplicates 
from registry
--------------------------------
(SELECT r.*
FROM Registry AS r
WHERE Exists (SELECT LastName, FirstName, DOB, Count(ID)
FROM Registry
WHERE Registry.LastName = r.LastName
   AND Registry.FirstName = r.FirstName
   AND Registry.DOB = r.DOB
   --AND Gender Is Not Null --removes duplicates 
GROUP BY Registry.LastName, Registry.FirstName, Registry.DOB
HAVING Count(Registry.ID) > 1))
-------------------------------
----------------------


--DELETE
--FROM Registry
--WHERE Registry.ID IN

-- List 1 - all rows that have duplicates
(SELECT r.*
FROM Registry AS r
WHERE Exists (SELECT LastName, FirstName, DOB, Count(ID)
FROM Registry
WHERE Registry.LastName = r.LastName
   AND Registry.FirstName = r.FirstName
   AND Registry.DOB = r.DOB
GROUP BY Registry.LastName, Registry.FirstName, Registry.DOB
HAVING Count(Registry.ID) > 2))

AND Registry.ID NOT IN

-- List 2 - one row from each set of duplicate
(SELECT Min(ID)
FROM Registry AS rr
WHERE Exists (SELECT LastName, FirstName, Count(ID)
FROM Registry
WHERE Registry.LastName = rr.LastName
   AND Registry.FirstName = rr.FirstName
   AND Registry.DOB = rr.DOB
GROUP BY Registry.FirstName, Registry.LastName
HAVING Count(Registry.ID) > 1)
GROUP BY LastName, FirstName, DOB);





/* Finding Duplicates in the DMV */
SELECT TOP 5 License, Count(License) AS 'NumOccurrences'
FROM DMV
WHERE Donor = 1 
GROUP BY License
HAVING Count(License) > 1

*/

*/