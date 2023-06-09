SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ApproachServiceLevel]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_ApproachServiceLevel]
GO


CREATE FUNCTION fn_ApproachServiceLevel(
		@vServiceLevel int
		
)

RETURNS int  AS  

BEGIN 
DECLARE
		@ServiceLevelApproachOrgan int,
		@ServiceLevelApproachBone int,
		@ServiceLevelApproachTissue int,
		@ServiceLevelApproachSkin int,
		@ServiceLevelApproachValves int,
		@ServiceLevelApproachRsch int,
		@ServiceLevelConsentOrgan int,
		@ServiceLevelConsentBone int,
		@ServiceLevelConsentTissue int,
		@ServiceLevelConsentSkin int,
		@ServiceLevelConsentValves int,
		@ServiceLevelConsentRsch int,
		@ServiceLevelRecoveryOrgan int,
		@ServiceLevelRecoveryBone int,
		@ServiceLevelRecoveryTissue int,
		@ServiceLevelRecoverySkin int,
		@ServiceLevelRecoveryValves int,
		@ServiceLevelRecoveryRsch int,
		@ServiceLevelEnabled int

set @ServiceLevelEnabled = -1

Select @ServiceLevelApproachOrgan = ServiceLevelApproachOrgan,
		@ServiceLevelApproachBone =ServiceLevelApproachBone,
		@ServiceLevelApproachTissue = ServiceLevelApproachTissue,
		@ServiceLevelApproachSkin = ServiceLevelApproachSkin,
		@ServiceLevelApproachValves = ServiceLevelApproachValves,
		@ServiceLevelApproachRsch = ServiceLevelApproachRsch,
		@ServiceLevelConsentOrgan = ServiceLevelConsentOrgan,
		@ServiceLevelConsentBone = ServiceLevelConsentBone,
		@ServiceLevelConsentTissue = ServiceLevelConsentTissue,
		@ServiceLevelConsentSkin = ServiceLevelConsentSkin,
		@ServiceLevelConsentValves = ServiceLevelConsentValves,
		@ServiceLevelConsentRsch = ServiceLevelConsentRsch,
		@ServiceLevelRecoveryOrgan = ServiceLevelRecoveryOrgan,
		@ServiceLevelRecoveryBone = ServiceLevelRecoveryBone,
		@ServiceLevelRecoveryTissue = ServiceLevelRecoveryTissue,
		@ServiceLevelRecoverySkin = ServiceLevelRecoverySkin,
		@ServiceLevelRecoveryValves = ServiceLevelRecoveryValves,
		@ServiceLevelRecoveryRsch = ServiceLevelRecoveryRsch
		from ServiceLevel where ServiceLevelID = @vServiceLevel

		if @ServiceLevelApproachOrgan  = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelApproachBone  = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelApproachTissue = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelApproachSkin  = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelApproachValves =-1  set @ServiceLevelEnabled = 0
		if @ServiceLevelApproachRsch= -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelConsentOrgan= -1 set  @ServiceLevelEnabled = 0
		if @ServiceLevelConsentBone = -1 set  @ServiceLevelEnabled = 0
		if @ServiceLevelConsentTissue= -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelConsentSkin =-1  set @ServiceLevelEnabled = 0
		if @ServiceLevelConsentValves= -1set @ServiceLevelEnabled = 0
		if @ServiceLevelConsentRsch = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelRecoveryOrgan = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelRecoveryBone= -1 set  @ServiceLevelEnabled = 0
		if @ServiceLevelRecoveryTissue = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelRecoverySkin = -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelRecoveryValves= -1  set @ServiceLevelEnabled = 0
		if @ServiceLevelRecoveryRsch = -1  set @ServiceLevelEnabled = 0 
		 


 


return @ServiceLevelEnabled
END
 







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

