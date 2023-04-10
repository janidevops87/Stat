

IF 		( SELECT TOP 1 Count(*) 
		  FROM ServiceLevelSecondaryCtls
		  WHERE DisplayName = 'TBI' 
		)	> 0

	BEGIN
		Print '...TBI option found. Skipping TBI update'
	END

Else
	BEGIN
		Print 'Updating ServiceLevelCtls with TBI option'
				/* ccarroll - Create virtual table of current service level trees with parent IDs 
				then add TBI checkboxes to existing service levels  */


				/* ccarroll 09/25/2007 - Update ServiceLevel template */
				INSERT INTO ServiceLevelSecondaryCtls
					(
						ServiceLevelID,
						ParentID,
						ControlName,
						DisplayName,
						DisplayOrder,
						Visible,
						X,
						Y,
						Height,
						LeftPos,
						MaxChar
					) 

				VALUES  (
						0,
						13,
						'SecondaryTBINumber',
						'TBI',
						7,
						-1,
						Null,
						Null,
						Null,
						Null,
						250
					)




				/* Update Existing ServiceLevels */

				DECLARE @TempCtls TABLE
						(
							ID int identity(1,1),
							ServiceLevelID int NULL,
							ParentID int NULL
						)

				INSERT INTO @TempCtls (ServiceLevelID,ParentID)

				SELECT DISTINCT
						sl.ServiceLevelID,
						s1.ServiceLevelSecondaryCtlsID
						
						FROM ServiceLevelSecondaryCtls s1
						JOIN ServiceLevel sl ON s1.ServiceLevelID = sl.ServiceLevelID
						WHERE sl.ServiceLevelStatus = 0 --Active
						AND s1.DisplayName = 'Case Numbers'
						/* ccarroll 08/24/2007, Empirix 6610, was: (AND s1.Visible = -1)
						removed to include all service levels regardless if visible
						*/



				INSERT INTO ServiceLevelSecondaryCtls
					(
						ServiceLevelID,
						ParentID,
						ControlName,
						DisplayName,
						DisplayOrder,
						Visible,
						X,
						Y,
						Height,
						LeftPos,
						MaxChar
					) 

				SELECT 
						ServiceLevelID,
						ParentID,
						'SecondaryTBINumber',
						'TBI',
						7,
						0,
						Null,
						Null,
						Null,
						Null,
						250

					FROM @TempCtls

	END
GO
