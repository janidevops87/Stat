SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ABATCH_UPDATECRITERIA]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ABATCH_UPDATECRITERIA]
GO



CREATE PROCEDURE ABATCH_UPDATECRITERIA AS

declare @NewCriteriaId int,
	@NewSubCriteriaID int,
	@i int,
	@Working_Status smallint,
	@Current_Status smallint,
	@Historical_Status smallint, 
	@Original_Status smallint,
	@UpdatedFlag_On smallint,
	@UpdatedFlag_Off smallint,

	@CriteriaId int,
	@CriteriaGroupName varchar(80),
	@DonorCategoryID int,
	@CriteriaMaleUpperAge smallint,
	@CriteriaMaleLowerAge smallint,
	@CriteriaFemaleUpperAge smallint,
	@CriteriaFemaleLowerAge smallint,
	@CriteriaGeneralRuleout varchar(255),
	@Unused1 varchar(255),
	@CriteriaMaleNotAppropriate smallint,
	@LastModified datetime,
	@CriteriaFemaleNotAppropriate smallint,
	@CriteriaReferNonPotential smallint,
	@Unused2 smallint,
	@CriteriaLowerWeight float,
	@CriteriaUpperWeight float,
	@CriteriaLowerAgeUnit varchar(6),
	@CriteriaDisableAppropriate smallint,
	@Unused3 int,
	@Unused4 smallint,
	@Unused5 smallint,
	@Unused6 smallint,
	@CriteriaMaleUpperAgeUnit varchar(6),
	@CriteriaMaleLowerAgeUnit varchar(6),
	@CriteriaFemaleUpperAgeUnit varchar(6),
	@CriteriaFemaleLowerAgeUnit varchar(6),
	@UpdatedFlag int,
	@DynamicDonorCategoryID int,
	@CriteriaStatus smallint,
	@WorkingStatusUpdatedFlag smallint,
	@WorkingCriteriaId int,
	@CriteriaDonorTracMap int,
	
	@CriteriaSourceCodeID int,
	@SourceCodeID int,
	@CSLastModified smalldatetime,
	@CSUpdatedFlag smallint,
	
	@CriteriaOrganizationID int,
	@OrganizationID int,
	@COLastModified smalldatetime,
	@COUpdatedFlag smallint,
	
	@CriteriaIndicationID int,
	@IndicationID int,
	@CILastModified smalldatetime,
	@IndicationHighRisk smallint,
	@IndicationStandardMRO smallint,
	@CIUpdatedFlag smallint,
	
	@CSGCriteriaScheduleGroupID int,
	@ScheduleGroupID int,
	@CSGLastModified smalldatetime,
	@CriteriaScheduleGroupOrgan smallint,
	@CriteriaScheduleGroupBone smallint,
	@CriteriaScheduleGroupTissue smallint,
	@CriteriaScheduleGroupSkin smallint,
	@CriteriaScheduleGroupValves smallint,
	@CriteriaScheduleGroupEyes smallint,
	@CriteriaScheduleGroupResearch smallint,
	@CriteriaScheduleNoContactOnDny smallint,
	@CriteriaScheduleContactOnCnsnt smallint,
	@CriteriaScheduleContactOnAprch smallint,
	@CriteriaScheduleContactOnCrnr smallint,
	@CriteriaScheduleContactOnStatSec smallint,
	@CriteriaScheduleContactOnStatCnsnt smallint,
	@CriteriaScheduleContactOnCoronerOnly smallint,
	
	--CRITERIASUBTYPE
	@CriteriaSubTypeID int,
	@CSTCriteriaID int,
	@SubTypeID int,
	@SubCriteriaPrecedence int,
	
	--CRITERIAPROCESSOR
	@CriteriaProcessorID int,
	@CPCriteriaID int,
	@CPOrganizationID int,
	
	--SUBCRITERIA
	@SubCriteriaID int,
	@SCCriteriaID int,
	@SCDonorCategoryID int,
	@SCSubtypeID int,
	@SCProcessorID int,
	@SCProcessorPrecedence int,
	@SubCriteriaMaleUpperAge smallint,
	@SubCriteriaMaleLowerAge smallint,
	@SubCriteriaFemaleUpperAge smallint,
	@SubCriteriaFemaleLowerAge smallint,
	@SubCriteriaGeneralRuleout varchar(255),
	@SubCriteriaMaleNotAppropriate smallint,
	@SubCriteriaFemaleNotAppropriate smallint,
	@SubCriteriaReferNonPotential smallint,
	@SubCriteriaLowerWeight float,
	@SubCriteriaUpperWeight float,
	@SubCriteriaLowerAgeUnit char(6),
	@SubCriteriaDisableAppropriate smallint,
	@SubCriteriaMaleUpperAgeUnit char(6),
	@SubCriteriaMaleLowerAgeUnit char(6),
	@SubCriteriaFemaleUpperAgeUnit char(6),
	@SubCriteriaFemaleLowerAgeUnit char(6),
	@SubCriteriaFemaleLowerWeight float,
	@SubCriteriaFemaleUpperWeight float,
	
	--PROCESSORCRITERIA_CONDITIONALRO
	@ProcessorCriteria_ConditionalROID int,
	@FSIndicationID int,
	@FSConditionID int,
	@FSAppropriateID int,
	@ROSubCriteriaID int,
	
	--SCSCHEDULEGROUP
	@SCScheduleGroupID int,
	@SUBScheduleGroupID int,
	@SUBSubCriteriaID int,
	@SCScheduleGroupOrgan smallint,
	@SCScheduleGroupBone smallint,
	@SCScheduleGroupTissue smallint,
	@SCScheduleGroupSkin smallint,
	@SCScheduleGroupValves smallint,
	@SCScheduleGroupEyes smallint,
	@SCScheduleGroupResearch smallint,
	@SCScheduleNoContactOnDny smallint,
	@SCScheduleContactOnCnsnt smallint,
	@SCScheduleContactOnAprch smallint,
	@SCScheduleContactOnCrnr smallint,
	@SCScheduleContactOnStatSec smallint,
	@SCScheduleContactOnStatCnsnt smallint,
	@SCScheduleContactOnCoronerOnly smallint,
	@SUBLastModified smalldatetime


	select @Working_Status = 0
	select @Current_Status = 1
	select @Historical_Status = 2
	select @Original_Status = 3
	select @UpdatedFlag_Off = 0
	select @UpdatedFlag_On = 1
	

/* CRITERIA ******************************************************************************************************************************/
declare cCriteria cursor for 
  --GET WORKING CRITERIA WHOSE UPDATED FLAG IS TURNED ON
  SELECT 
	CriteriaId,
	CriteriaGroupName,
	DonorCategoryID,
	CriteriaMaleUpperAge,
	CriteriaMaleLowerAge,
	CriteriaFemaleUpperAge,
	CriteriaFemaleLowerAge,
	CriteriaGeneralRuleout,
	Unused1,
	CriteriaMaleNotAppropriate,
	LastModified,
	CriteriaFemaleNotAppropriate,
	CriteriaReferNonPotential,
	Unused2,
	CriteriaLowerWeight,
	CriteriaUpperWeight,
	CriteriaLowerAgeUnit,
	CriteriaDisableAppropriate,
	Unused3,
	Unused4,
	Unused5,
	Unused6,
	CriteriaMaleUpperAgeUnit,
	CriteriaMaleLowerAgeUnit,
	CriteriaFemaleUpperAgeUnit,
	CriteriaFemaleLowerAgeUnit,
	UpdatedFlag,
	DynamicDonorCategoryID,
	CriteriaStatus,
	WorkingStatusUpdatedFlag,
	WorkingCriteriaId,
	CriteriaDonorTracMap  
  FROM Criteria 
  WHERE 
	criteriastatus = @Working_Status
  AND 
	workingstatusupdatedflag = @UpdatedFlag_On

open cCriteria
fetch next from cCriteria into @CriteriaId,@CriteriaGroupName,@DonorCategoryID,@CriteriaMaleUpperAge,@CriteriaMaleLowerAge,@CriteriaFemaleUpperAge,@CriteriaFemaleLowerAge,@CriteriaGeneralRuleout,@Unused1,@CriteriaMaleNotAppropriate,@LastModified,@CriteriaFemaleNotAppropriate,@CriteriaReferNonPotential,@Unused2,@CriteriaLowerWeight,@CriteriaUpperWeight,@CriteriaLowerAgeUnit,@CriteriaDisableAppropriate,@Unused3,@Unused4,@Unused5,@Unused6,@CriteriaMaleUpperAgeUnit,@CriteriaMaleLowerAgeUnit,@CriteriaFemaleUpperAgeUnit,@CriteriaFemaleLowerAgeUnit,@UpdatedFlag,@DynamicDonorCategoryID,@CriteriaStatus,@WorkingStatusUpdatedFlag,@WorkingCriteriaId,@CriteriaDonorTracMap
	
while @@fetch_status = 0
  begin
  
    --TURN OFF CRITERIA'S UPDATED FLAG
    update criteria
    set workingstatusupdatedflag = @UpdatedFlag_Off
    where criteriaid = @CriteriaId
  
    --CHANGE THE EXISTING CURRENT CRITERIA's STATUS TO HISTORICAL
    update criteria
    set criteriastatus = @Historical_Status
    where criteriastatus = @Current_Status
    and workingcriteriaid = @CriteriaId
    
    --MAKE A COPY OF THE WORKING CRITERIA AND MAKE IT THE NEW CURRENT CRITERIA
    insert criteria(CriteriaGroupName,DonorCategoryID,CriteriaMaleUpperAge,CriteriaMaleLowerAge,CriteriaFemaleUpperAge,CriteriaFemaleLowerAge,CriteriaGeneralRuleout,Unused1,CriteriaMaleNotAppropriate,LastModified,CriteriaFemaleNotAppropriate,CriteriaReferNonPotential,Unused2,CriteriaLowerWeight,CriteriaUpperWeight,CriteriaLowerAgeUnit,CriteriaDisableAppropriate,Unused3,Unused4,Unused5,Unused6,CriteriaMaleUpperAgeUnit,CriteriaMaleLowerAgeUnit,CriteriaFemaleUpperAgeUnit,CriteriaFemaleLowerAgeUnit,UpdatedFlag,DynamicDonorCategoryID,CriteriaStatus,WorkingStatusUpdatedFlag,WorkingCriteriaId,CriteriaDonorTracMap)
    values(@CriteriaGroupName,@DonorCategoryID,@CriteriaMaleUpperAge,@CriteriaMaleLowerAge,@CriteriaFemaleUpperAge,@CriteriaFemaleLowerAge,@CriteriaGeneralRuleout,@Unused1,@CriteriaMaleNotAppropriate,@LastModified,@CriteriaFemaleNotAppropriate,@CriteriaReferNonPotential,@Unused2,@CriteriaLowerWeight,@CriteriaUpperWeight,@CriteriaLowerAgeUnit,@CriteriaDisableAppropriate,@Unused3,@Unused4,@Unused5,@Unused6,@CriteriaMaleUpperAgeUnit,@CriteriaMaleLowerAgeUnit,@CriteriaFemaleUpperAgeUnit,@CriteriaFemaleLowerAgeUnit,@UpdatedFlag,@DynamicDonorCategoryID,@Current_Status,@UpdatedFlag_Off,@WorkingCriteriaId,@CriteriaDonorTracMap)
    --replaced getting the id with max method to using scope_identity 10/10 jim h
    SET @NewCriteriaId = SCOPE_IDENTITY()
    --select @NewCriteriaId = max(criteriaid) from criteria

    /* SOURCECODES ******************************************************************************************************************************/
   declare cSOURCECODE cursor for 
      SELECT 
		CriteriaSourceCodeID,
		CriteriaID,
		SourceCodeID,
		LastModified,
		UpdatedFlag      
	  FROM 
		criteriasourcecode 
	  WHERE criteriaid = @CriteriaId

    open cSOURCECODE
    fetch next from cSOURCECODE into @CriteriaSourceCodeID,@CriteriaID,@SourceCodeID,@CSLastModified,@CSUpdatedFlag
    
    while @@fetch_status = 0
    begin
    
      insert criteriasourcecode(CriteriaID,SourceCodeID,LastModified,UpdatedFlag)
      values(@NewCriteriaID,@SourceCodeID,@CSLastModified,@CSUpdatedFlag)
    
      fetch next from cSOURCECODE into @CriteriaSourceCodeID,@CriteriaID,@SourceCodeID,@CSLastModified,@CSUpdatedFlag
    end

    close cSOURCECODE
    deallocate cSOURCECODE

    /* ORGANIZATION ******************************************************************************************************************************/
    declare cORGANIZATION cursor for 
      select 
		CriteriaOrganizationID,
		CriteriaID,
		OrganizationID,
		LastModified,
		UpdatedFlag
      from 
		criteriaorganization where criteriaid = @CriteriaId

    open cORGANIZATION
    fetch next from cORGANIZATION into @CriteriaOrganizationID,@CriteriaID,@OrganizationID,@COLastModified,@COUpdatedFlag
    
    while @@fetch_status = 0
    begin
      insert criteriaorganization(CriteriaID,OrganizationID,LastModified,UpdatedFlag)
      values(@NewCriteriaID,@OrganizationID,@COLastModified,@COUpdatedFlag)
    
      fetch next from cORGANIZATION into @CriteriaOrganizationID,@CriteriaID,@OrganizationID,@COLastModified,@COUpdatedFlag
    end

    close cORGANIZATION
    deallocate cORGANIZATION

    /* INDICATION ******************************************************************************************************************************/
    declare cINDICATION cursor for 
      select 
      
		CriteriaIndicationID,
		CriteriaID,
		IndicationID,
		LastModified,
		IndicationHighRisk,
		IndicationStandardMRO,
		UpdatedFlag
		      
      from criteriaindication where criteriaid = @CriteriaId

    open cINDICATION
    fetch next from cINDICATION into @CriteriaIndicationID,@CriteriaID,@IndicationID,@CILastModified,@IndicationHighRisk,@IndicationStandardMRO,@CIUpdatedFlag
    
    while @@fetch_status = 0
    begin
      insert criteriaindication(CriteriaID,IndicationID,LastModified,IndicationHighRisk,IndicationStandardMRO,UpdatedFlag)
      values(@NewCriteriaID,@IndicationID,@CILastModified,@IndicationHighRisk,@IndicationStandardMRO,@CIUpdatedFlag)
    
      fetch next from cINDICATION into @CriteriaIndicationID,@CriteriaID,@IndicationID,@CILastModified,@IndicationHighRisk,@IndicationStandardMRO,@CIUpdatedFlag
    end

    close cINDICATION
    deallocate cINDICATION
    
    /* SCHEDULEGROUP ******************************************************************************************************************************/
	declare cSCHEDULEGROUP cursor for 
	  select 
	   
		CriteriaScheduleGroupID,
		CriteriaID,
		ScheduleGroupID,
		LastModified,
		CriteriaScheduleGroupOrgan,
		CriteriaScheduleGroupBone,
		CriteriaScheduleGroupTissue,
		CriteriaScheduleGroupSkin,
		CriteriaScheduleGroupValves,
		CriteriaScheduleGroupEyes,
		CriteriaScheduleGroupResearch,
		CriteriaScheduleNoContactOnDny,
		CriteriaScheduleContactOnCnsnt,
		CriteriaScheduleContactOnAprch,
		CriteriaScheduleContactOnCrnr,
		CriteriaScheduleContactOnStatSec,
		CriteriaScheduleContactOnStatCnsnt,
		CriteriaScheduleContactOnCoronerOnly
	  
	  from criteriaschedulegroup where criteriaid = @CriteriaId

	open cSCHEDULEGROUP
	fetch next from cSCHEDULEGROUP into @CSGCriteriaScheduleGroupID,@CriteriaID,@ScheduleGroupID,@CSGLastModified,@CriteriaScheduleGroupOrgan,@CriteriaScheduleGroupBone,@CriteriaScheduleGroupTissue,@CriteriaScheduleGroupSkin,@CriteriaScheduleGroupValves,@CriteriaScheduleGroupEyes,@CriteriaScheduleGroupResearch,@CriteriaScheduleNoContactOnDny,@CriteriaScheduleContactOnCnsnt,@CriteriaScheduleContactOnAprch,@CriteriaScheduleContactOnCrnr,@CriteriaScheduleContactOnStatSec,@CriteriaScheduleContactOnStatCnsnt,@CriteriaScheduleContactOnCoronerOnly

	while @@fetch_status = 0
	begin
	  insert criteriaschedulegroup(CriteriaID,ScheduleGroupID,LastModified,CriteriaScheduleGroupOrgan,CriteriaScheduleGroupBone,CriteriaScheduleGroupTissue,CriteriaScheduleGroupSkin,CriteriaScheduleGroupValves,CriteriaScheduleGroupEyes,CriteriaScheduleGroupResearch,CriteriaScheduleNoContactOnDny,CriteriaScheduleContactOnCnsnt,CriteriaScheduleContactOnAprch,CriteriaScheduleContactOnCrnr,CriteriaScheduleContactOnStatSec,CriteriaScheduleContactOnStatCnsnt,CriteriaScheduleContactOnCoronerOnly)
	  values(@NewCriteriaID,@ScheduleGroupID,@CSGLastModified,@CriteriaScheduleGroupOrgan,@CriteriaScheduleGroupBone,@CriteriaScheduleGroupTissue,@CriteriaScheduleGroupSkin,@CriteriaScheduleGroupValves,@CriteriaScheduleGroupEyes,@CriteriaScheduleGroupResearch,@CriteriaScheduleNoContactOnDny,@CriteriaScheduleContactOnCnsnt,@CriteriaScheduleContactOnAprch,@CriteriaScheduleContactOnCrnr,@CriteriaScheduleContactOnStatSec,@CriteriaScheduleContactOnStatCnsnt,@CriteriaScheduleContactOnCoronerOnly)

	  fetch next from cSCHEDULEGROUP into @CSGCriteriaScheduleGroupID,@CriteriaID,@ScheduleGroupID,@CSGLastModified,@CriteriaScheduleGroupOrgan,@CriteriaScheduleGroupBone,@CriteriaScheduleGroupTissue,@CriteriaScheduleGroupSkin,@CriteriaScheduleGroupValves,@CriteriaScheduleGroupEyes,@CriteriaScheduleGroupResearch,@CriteriaScheduleNoContactOnDny,@CriteriaScheduleContactOnCnsnt,@CriteriaScheduleContactOnAprch,@CriteriaScheduleContactOnCrnr,@CriteriaScheduleContactOnStatSec,@CriteriaScheduleContactOnStatCnsnt,@CriteriaScheduleContactOnCoronerOnly
	end

	close cSCHEDULEGROUP
	deallocate cSCHEDULEGROUP
    	
   /* CRITERIASUBTYPE ******************************************************************************************************************************/
   	declare cSUBTYPE cursor for 
             select              
				CriteriaSubTypeID,
				CriteriaID,
				SubTypeID,
				SubCriteriaPrecedence
             from criteriasubtype where criteriaid = @CriteriaId
       
           open cSUBTYPE
           fetch next from cSUBTYPE into @CriteriaSubTypeID,@CSTCriteriaID,@SubTypeID,@SubCriteriaPrecedence
           
           while @@fetch_status = 0
           begin
             insert criteriasubtype(CriteriaID,SubTypeID,SubCriteriaPrecedence)
             values(@NewCriteriaID,@SubTypeID,@SubCriteriaPrecedence)
           
             fetch next from cSUBTYPE into @CriteriaSubTypeID,@CSTCriteriaID,@SubTypeID,@SubCriteriaPrecedence
           end
       
        close cSUBTYPE
    	deallocate cSUBTYPE
    	
   /* CRITERIAPROCESSOR ******************************************************************************************************************************/
	declare cPROCESSOR cursor for 
		select 
		CriteriaProcessorID,
		CriteriaID,
		OrganizationID
		from criteriaprocessor where criteriaid = @CriteriaId

	      open cPROCESSOR
	      fetch next from cPROCESSOR into @CriteriaProcessorID,@CPCriteriaID,@CPOrganizationID

	      while @@fetch_status = 0
	      begin
		insert criteriaprocessor(CriteriaID,OrganizationID)
		values(@NewCriteriaID,@CPOrganizationID)

		fetch next from cPROCESSOR into @CriteriaProcessorID,@CPCriteriaID,@CPOrganizationID
	      end

	close cPROCESSOR
	deallocate cPROCESSOR
    	
   /* SUBCRITERIA ******************************************************************************************************************************/
	declare cSUBCRITERIA cursor for 
	   select  
	   
		SubCriteriaID,
		CriteriaID,
		DonorCategoryID,
		SubtypeID,
		ProcessorID,
		ProcessorPrecedence,
		SubCriteriaMaleUpperAge,
		SubCriteriaMaleLowerAge,
		SubCriteriaFemaleUpperAge,
		SubCriteriaFemaleLowerAge,
		SubCriteriaGeneralRuleout,
		SubCriteriaMaleNotAppropriate,
		SubCriteriaFemaleNotAppropriate,
		SubCriteriaReferNonPotential,
		SubCriteriaLowerWeight,
		SubCriteriaUpperWeight,
		SubCriteriaLowerAgeUnit,
		SubCriteriaDisableAppropriate,
		SubCriteriaMaleUpperAgeUnit,
		SubCriteriaMaleLowerAgeUnit,
		SubCriteriaFemaleUpperAgeUnit,
		SubCriteriaFemaleLowerAgeUnit,
		SubCriteriaFemaleLowerWeight,
		SubCriteriaFemaleUpperWeight
	   from subcriteria where criteriaid = @CriteriaId

	 open cSUBCRITERIA
	 fetch next from cSUBCRITERIA into @SubCriteriaID,@SCCriteriaID,@SCDonorCategoryID,@SCSubtypeID,@SCProcessorID,@SCProcessorPrecedence,@SubCriteriaMaleUpperAge,@SubCriteriaMaleLowerAge,@SubCriteriaFemaleUpperAge,@SubCriteriaFemaleLowerAge,@SubCriteriaGeneralRuleout,@SubCriteriaMaleNotAppropriate,@SubCriteriaFemaleNotAppropriate,@SubCriteriaReferNonPotential,@SubCriteriaLowerWeight,@SubCriteriaUpperWeight,@SubCriteriaLowerAgeUnit,@SubCriteriaDisableAppropriate,@SubCriteriaMaleUpperAgeUnit,@SubCriteriaMaleLowerAgeUnit,@SubCriteriaFemaleUpperAgeUnit,@SubCriteriaFemaleLowerAgeUnit,@SubCriteriaFemaleLowerWeight,@SubCriteriaFemaleUpperWeight

	 while @@fetch_status = 0
	 begin
	   insert subcriteria(CriteriaID,DonorCategoryID,SubtypeID,ProcessorID,ProcessorPrecedence,SubCriteriaMaleUpperAge,SubCriteriaMaleLowerAge,SubCriteriaFemaleUpperAge,SubCriteriaFemaleLowerAge,SubCriteriaGeneralRuleout,SubCriteriaMaleNotAppropriate,SubCriteriaFemaleNotAppropriate,SubCriteriaReferNonPotential,SubCriteriaLowerWeight,SubCriteriaUpperWeight,SubCriteriaLowerAgeUnit,SubCriteriaDisableAppropriate,SubCriteriaMaleUpperAgeUnit,SubCriteriaMaleLowerAgeUnit,SubCriteriaFemaleUpperAgeUnit,SubCriteriaFemaleLowerAgeUnit,SubCriteriaFemaleLowerWeight,SubCriteriaFemaleUpperWeight)
	   values(@NewCriteriaID,@SCDonorCategoryID,@SCSubtypeID,@SCProcessorID,@SCProcessorPrecedence,@SubCriteriaMaleUpperAge,@SubCriteriaMaleLowerAge,@SubCriteriaFemaleUpperAge,@SubCriteriaFemaleLowerAge,@SubCriteriaGeneralRuleout,@SubCriteriaMaleNotAppropriate,@SubCriteriaFemaleNotAppropriate,@SubCriteriaReferNonPotential,@SubCriteriaLowerWeight,@SubCriteriaUpperWeight,@SubCriteriaLowerAgeUnit,@SubCriteriaDisableAppropriate,@SubCriteriaMaleUpperAgeUnit,@SubCriteriaMaleLowerAgeUnit,@SubCriteriaFemaleUpperAgeUnit,@SubCriteriaFemaleLowerAgeUnit,@SubCriteriaFemaleLowerWeight,@SubCriteriaFemaleUpperWeight)

	   --Get the new SubCriteriaId
		--replaced getting the id with max method to using scope_identity 10/10 jim h
		SET @NewSubCriteriaId = SCOPE_IDENTITY()	
	   --select @NewSubCriteriaId = max(subcriteriaid) from subcriteria

	   /* SUBCRITERIA - PROCESSORCRITERIA_CONDITIONALRO ******************************************************************************************************************************/
	   	declare cCONDITIONALRO cursor for 
	   		select  
	   		
				ProcessorCriteria_ConditionalROID,
				FSIndicationID,
				FSConditionID,
				FSAppropriateID,
				SubCriteriaID
	   		from processorcriteria_conditionalro where subcriteriaid = @SubCriteriaID
	   
	   	      open cCONDITIONALRO
	   	      fetch next from cCONDITIONALRO into @ProcessorCriteria_ConditionalROID,@FSIndicationID,@FSConditionID,@FSAppropriateID,@ROSubCriteriaID
	   
	   	      while @@fetch_status = 0
	   	      begin
	   		insert processorcriteria_conditionalro(FSIndicationID,FSConditionID,FSAppropriateID,SubCriteriaID)
	   		values(@FSIndicationID,@FSConditionID,@FSAppropriateID,@NewSubCriteriaID)
	   
	   		fetch next from cCONDITIONALRO into @ProcessorCriteria_ConditionalROID,@FSIndicationID,@FSConditionID,@FSAppropriateID,@ROSubCriteriaID
	   	      end
	   
	   	close cCONDITIONALRO
		deallocate cCONDITIONALRO
		
	   /* SUBCRITERIA - SCSCHEDULEGROUP ******************************************************************************************************************************/
		declare cSCSCHEDULEGROUP cursor for 
			select 
			 
				SCScheduleGroupID,
				ScheduleGroupID,
				SubCriteriaID,
				SCScheduleGroupOrgan,
				SCScheduleGroupBone,
				SCScheduleGroupTissue,
				SCScheduleGroupSkin,
				SCScheduleGroupValves,
				SCScheduleGroupEyes,
				SCScheduleGroupResearch,
				SCScheduleNoContactOnDny,
				SCScheduleContactOnCnsnt,
				SCScheduleContactOnAprch,
				SCScheduleContactOnCrnr,
				SCScheduleContactOnStatSec,
				SCScheduleContactOnStatCnsnt,
				SCScheduleContactOnCoronerOnly,
				LastModified
			from scschedulegroup where subcriteriaid = @SubCriteriaID

		      open cSCSCHEDULEGROUP
		      fetch next from cSCSCHEDULEGROUP into @SCScheduleGroupID,@SUBScheduleGroupID,@SUBSubCriteriaID,@SCScheduleGroupOrgan,@SCScheduleGroupBone,@SCScheduleGroupTissue,@SCScheduleGroupSkin,@SCScheduleGroupValves,@SCScheduleGroupEyes,@SCScheduleGroupResearch,@SCScheduleNoContactOnDny,@SCScheduleContactOnCnsnt,@SCScheduleContactOnAprch,@SCScheduleContactOnCrnr,@SCScheduleContactOnStatSec,@SCScheduleContactOnStatCnsnt,@SCScheduleContactOnCoronerOnly,@SUBLastModified

		      while @@fetch_status = 0
		      begin
			insert scschedulegroup(ScheduleGroupID,SubCriteriaID,SCScheduleGroupOrgan,SCScheduleGroupBone,SCScheduleGroupTissue,SCScheduleGroupSkin,SCScheduleGroupValves,SCScheduleGroupEyes,SCScheduleGroupResearch,SCScheduleNoContactOnDny,SCScheduleContactOnCnsnt,SCScheduleContactOnAprch,SCScheduleContactOnCrnr,SCScheduleContactOnStatSec,SCScheduleContactOnStatCnsnt,SCScheduleContactOnCoronerOnly,LastModified)
			values(@SUBScheduleGroupID,@NewSubCriteriaID,@SCScheduleGroupOrgan,@SCScheduleGroupBone,@SCScheduleGroupTissue,@SCScheduleGroupSkin,@SCScheduleGroupValves,@SCScheduleGroupEyes,@SCScheduleGroupResearch,@SCScheduleNoContactOnDny,@SCScheduleContactOnCnsnt,@SCScheduleContactOnAprch,@SCScheduleContactOnCrnr,@SCScheduleContactOnStatSec,@SCScheduleContactOnStatCnsnt,@SCScheduleContactOnCoronerOnly,@SUBLastModified)

			fetch next from cSCSCHEDULEGROUP into @SCScheduleGroupID,@SUBScheduleGroupID,@SUBSubCriteriaID,@SCScheduleGroupOrgan,@SCScheduleGroupBone,@SCScheduleGroupTissue,@SCScheduleGroupSkin,@SCScheduleGroupValves,@SCScheduleGroupEyes,@SCScheduleGroupResearch,@SCScheduleNoContactOnDny,@SCScheduleContactOnCnsnt,@SCScheduleContactOnAprch,@SCScheduleContactOnCrnr,@SCScheduleContactOnStatSec,@SCScheduleContactOnStatCnsnt,@SCScheduleContactOnCoronerOnly,@SUBLastModified
		      end

		close cSCSCHEDULEGROUP
		deallocate cSCSCHEDULEGROUP


	 /* FETCH NEXT/CLOSE SUBCRITERIA CURSOR */
	   fetch next from cSUBCRITERIA into @SubCriteriaID,@SCCriteriaID,@SCDonorCategoryID,@SCSubtypeID,@SCProcessorID,@SCProcessorPrecedence,@SubCriteriaMaleUpperAge,@SubCriteriaMaleLowerAge,@SubCriteriaFemaleUpperAge,@SubCriteriaFemaleLowerAge,@SubCriteriaGeneralRuleout,@SubCriteriaMaleNotAppropriate,@SubCriteriaFemaleNotAppropriate,@SubCriteriaReferNonPotential,@SubCriteriaLowerWeight,@SubCriteriaUpperWeight,@SubCriteriaLowerAgeUnit,@SubCriteriaDisableAppropriate,@SubCriteriaMaleUpperAgeUnit,@SubCriteriaMaleLowerAgeUnit,@SubCriteriaFemaleUpperAgeUnit,@SubCriteriaFemaleLowerAgeUnit,@SubCriteriaFemaleLowerWeight,@SubCriteriaFemaleUpperWeight
	 end

	close cSUBCRITERIA
	deallocate cSUBCRITERIA



   /* FETCH NEXT/CLOSE CRITERIA CURSOR */
    fetch next from cCriteria into @CriteriaId,@CriteriaGroupName,@DonorCategoryID,@CriteriaMaleUpperAge,@CriteriaMaleLowerAge,@CriteriaFemaleUpperAge,@CriteriaFemaleLowerAge,@CriteriaGeneralRuleout,@Unused1,@CriteriaMaleNotAppropriate,@LastModified,@CriteriaFemaleNotAppropriate,@CriteriaReferNonPotential,@Unused2,@CriteriaLowerWeight,@CriteriaUpperWeight,@CriteriaLowerAgeUnit,@CriteriaDisableAppropriate,@Unused3,@Unused4,@Unused5,@Unused6,@CriteriaMaleUpperAgeUnit,@CriteriaMaleLowerAgeUnit,@CriteriaFemaleUpperAgeUnit,@CriteriaFemaleLowerAgeUnit,@UpdatedFlag,@DynamicDonorCategoryID,@CriteriaStatus,@WorkingStatusUpdatedFlag,@WorkingCriteriaId,@CriteriaDonorTracMap
  end
close cCriteria
deallocate cCriteria

--FOR TESTING ONLY; REMOVE TO GO LIVE
select 'ok'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

