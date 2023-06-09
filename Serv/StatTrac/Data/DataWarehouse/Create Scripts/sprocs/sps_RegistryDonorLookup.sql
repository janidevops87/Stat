SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RegistryDonorLookup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RegistryDonorLookup]
GO



CREATE PROCEDURE sps_RegistryDonorLookup

	@vSSN			varchar(11)	= null

AS

DECLARE
	@vConsented	varchar(255),
	@vKidney	bit,
	@vHeart	bit,
	@vLiver	bit,
	@vLungs	bit,
	@vPancreas	bit,
	@vSmbowel	bit,
	@vHeartVal	bit,
	@vSkinGraft	bit,
	@vEyes	bit,
	@vBonesAbove	bit,
	@vBonesBelow	bit,
	@vSoftTissues	bit
	
	SELECT DISTINCT	
	@vKidney = Kidney, 
	@vHeart = Heart,
	@vLiver = Liver,
	@vLungs = Lungs,
	@vPancreas = Pancreas,
	@vSmbowel = Smbowel,
	@vHeartVal = Heartval,
	@vSkinGraft = Skingraft,
	@vEyes = Eyes,
	@vBonesAbove = BonesAbove,
	@vBonesBelow = BonesBelow,
	@vSoftTissues = SoftTissue
	FROM 		LA_Donor_Registry
	WHERE	SSN = @vSSN

	IF @vKidney = 1
		SET @vConsented = @vConsented + 'Kidneys, '
	IF @vHeart = 1
		SET @vConsented = @vConsented + 'Heart, '
	IF @vLiver = 1
		SET @vConsented = @vConsented + 'Liver, '
	IF @vLungs = 1
		SET @vConsented = @vConsented + 'Lungs, '
	IF @vPancreas = 1
		SET @vConsented = @vConsented + 'Pancreas, '
	IF @vSmbowel = 1
		SET @vConsented = @vConsented + 'Small Bowel, '
	IF @vHeartVal = 1
		SET @vConsented = @vConsented + 'Heart Valves, '
	IF @vSkinGraft = 1
		SET @vConsented = @vConsented + 'Skin Grafts, '
	IF @vEyes = 1
		SET @vConsented = @vConsented + 'Eyes/Corneas, '
	IF @vBonesAbove = 1
		SET @vConsented = @vConsented + 'Bones Above Waist, '
	IF @vBonesBelow = 1
		SET @vConsented = @vConsented + 'Bones Below Waist, '
	IF @vSoftTissues = 1
	          	SET @vConsented = @vConsented + 'Soft Tissues '

	SELECT DISTINCT
		 	Purpose, Wishes, EContact1, EContact2, CONVERT(varchar(10), Scandate, 101)  AS Scandate, CONVERT(varchar(10), Matcdate, 101)  AS Matcdate, CONVERT(varchar(10), Iddate, 101)  AS Iddate,
			@vConsented As Consented
	FROM 		LA_Donor_Registry
	WHERE 	SSN = @vSSN
















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

