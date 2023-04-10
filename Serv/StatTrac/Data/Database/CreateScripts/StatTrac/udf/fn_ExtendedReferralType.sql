 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ExtendedReferralType]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_ExtendedReferralType]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION fn_ExtendedReferralType
	(
	@ReferralTypeID INT , 
	@ReferralOrganAppropriateID INT , 
	@ReferralBoneAppropriateID INT , 
	@ReferralTissueAppropriateID INT , 
	@ReferralSkinAppropriateID INT , 
	@ReferralEyesTransAppropriateID INT , 
	@ReferralEyesRschAppropriateID INT , 
	@ReferralValvesAppropriateID INT  
	)
RETURNS VARCHAR(25) -- Cubic Centimeters.
WITH SCHEMABINDING
AS
BEGIN
   RETURN ( SELECT 

		CASE	
			WHEN
			/* OTE */
				@ReferralTypeID = 1
			THEN			
				'Organ/Tissue/Eye'
		
			WHEN
				/* Tissue * */
				@ReferralTypeID = 2 		 
				AND 	@ReferralOrganAppropriateID <>1  
				AND 	@ReferralEyesTransAppropriateID <>1
				AND 	( @ReferralBoneAppropriateID = 1 
				OR 	@ReferralTissueAppropriateID = 1
				OR 	@ReferralSkinAppropriateID = 1
				OR 	@ReferralValvesAppropriateID = 1) 	
			THEN
				'Tissue'	
			/* TE */
		
			WHEN
				@ReferralTypeID = 2 		 
				AND 	@ReferralOrganAppropriateID <>1  
				AND 	@ReferralEyesTransAppropriateID =1
				AND 	( @ReferralBoneAppropriateID = 1 
				OR 	@ReferralTissueAppropriateID = 1
				OR 	@ReferralSkinAppropriateID = 1
				OR 	@ReferralValvesAppropriateID = 1) 		
			THEN
				'Tissue/Eye'
			/* Eye */
			WHEN
				@ReferralTypeID = 3 		 
				AND 	@ReferralOrganAppropriateID <>1  
				AND 	@ReferralEyesTransAppropriateID =1
				AND	@ReferralBoneAppropriateID <> 1
				AND	@ReferralTissueAppropriateID <> 1
				AND	@ReferralSkinAppropriateID <> 1
				AND	@ReferralValvesAppropriateID <> 1
				AND	@ReferralEyesRschAppropriateID <> 1	
			THEN
				'Eye'
			/* Other */	
			WHEN
				@ReferralTypeID = 4 		 
				AND 	@ReferralOrganAppropriateID <>1  
				AND 	@ReferralEyesTransAppropriateID <>1
				AND	@ReferralBoneAppropriateID <> 1
				AND	@ReferralTissueAppropriateID <> 1
				AND	@ReferralSkinAppropriateID <> 1
				AND	@ReferralValvesAppropriateID <> 1
				AND	@ReferralEyesRschAppropriateID = 1	
			THEN
				'Other'
			/* Other/Eye */
			WHEN	
				(@ReferralTypeID = 4 		 
				OR
				@ReferralTypeID = 3)
				AND 	@ReferralOrganAppropriateID <>1  
				AND 	@ReferralEyesTransAppropriateID = 1
				AND	@ReferralBoneAppropriateID > 1
				AND	@ReferralTissueAppropriateID > 1
				AND	@ReferralSkinAppropriateID > 1
				AND	@ReferralValvesAppropriateID > 1
				AND	@ReferralEyesRschAppropriateID = 1	
			THEN
				'Other/Eye'
			/* Age/RO */
			WHEN	
				@ReferralTypeID = 4
				AND	@ReferralBoneAppropriateID <> 4
				AND	@ReferralBoneAppropriateID <> 3
				AND	@ReferralTissueAppropriateID <> 4
				AND	@ReferralTissueAppropriateID <> 3
				AND	@ReferralSkinAppropriateID <> 4
				AND	@ReferralSkinAppropriateID <> 3
				AND	@ReferralValvesAppropriateID <> 4
				AND	@ReferralValvesAppropriateID <> 3
				AND	@ReferralEyesTransAppropriateID <> 4
				AND	@ReferralEyesTransAppropriateID <> 3	
				AND	@ReferralEyesRschAppropriateID <> 1	
			THEN
				'AGE RO'
			
			/* MED/RO */
			WHEN
				@ReferralTypeID = 4
				AND	(@ReferralBoneAppropriateID = 4
				OR 	@ReferralBoneAppropriateID = 3
				OR	@ReferralTissueAppropriateID = 4
				OR	@ReferralTissueAppropriateID = 3
				OR	@ReferralSkinAppropriateID = 4
				OR	@ReferralSkinAppropriateID = 3
				OR	@ReferralValvesAppropriateID = 4
				OR	@ReferralValvesAppropriateID = 3
				OR	@ReferralEyesTransAppropriateID = 4
				OR	@ReferralEyesTransAppropriateID = 3)
				AND	@ReferralEyesRschAppropriateID <> 1
		
			THEN
				'MED RO'
		
			END
	 )
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

