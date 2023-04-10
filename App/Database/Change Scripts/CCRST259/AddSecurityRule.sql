/******************************************************************************
**		File: AddSecurityRule.sql
**		Name: Add SecurityRule Record (to Triage_Coordinator for ST_Update)
**		Desc: Loads new Triage_Coordinator permission to the SecurityRule table
**
**		Auth: Mike Berenson
**		Date: 10/31/2017
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      10/31/2017	Mike Berenson		initial
**		10/31/2017	Mike Berenson		Set current date time to variable before passing to sp
*******************************************************************************/


DECLARE 
	@SecurityRule NVARCHAR(100),
	@SecurityExpression NVARCHAR(300),
	@StatlineAdminEmployeeID INTEGER,
	@LastModifiedDate DATETIME;

SELECT
	@SecurityRule = 'ST_Update',
	@SecurityExpression = 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User OR R:SL:Triage_Coordinator',
	@StatlineAdminEmployeeID = StatEmployeeID,
	@LastModifiedDate = GETDATE()
FROM StatEmployee
WHERE StatEmployeeFirstName = 'Statline Admin';

-- SELECT * FROM SecurityRule WHERE SecurityRule = @SecurityRule;
-- Data Captured From st-testsqloltp.ReferralTest
-- SecurityRuleID	SecurityRule	Expression	LastModified	LastStatEmployeeID	AuditLogTypeID
-- 10	ST_Update	R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User  OR I:kle  OR I:gmarpin  OR I:akentris  OR I:amsperr1  OR I:mrloya  OR I:jwboaz  OR I:taberube  OR I:kcottengim  OR I:pagivens  OR I:hardinpa  OR I:gijones  OR I:lmmundine  OR I:rapaisley  OR I:baparks  OR I:tlpenner  OR I:drreynolds  OR I:smrobbins  OR I:ssanfilippo  OR I:rasequeira  OR I:hhsimms  OR I:sostclair  OR I:rdwall  OR I:ldwest  OR I:djwhite  OR I:dlwoerner  OR I:skhughes1  OR I:jaroth  OR I:jwsharkey  OR I:srlocklair  OR I:knakai  OR I:dkhatfield   OR I:remartin  OR I:tnemecek   OR I:ecain  OR I:dmartinezmejia  OR I:esenne  OR I:aljohnson  OR I:award  OR I:mmaron  OR I:kwiederspan  OR I:jcalnan  OR I:sweatherford    OR I:achuckran  OR I:cparker  OR I:abutler  OR I:bhaag  OR I:lshore  OR I:jbryant  OR I:dcaro   OR I:eloomis  OR I:mswope  OR I:vlisser  OR I:aescobedo  OR I:swhite  OR I:lwest  OR I:jsharkey  OR I:afijalkowski  OR I:dbarcenas  OR I:degrafto  OR I:rpjefferson   OR I:tsalves  OR I:djohn  OR I:hpennington   OR I:hsiauw  OR I:tsharrell  OR I:testtest  OR I:chartel  OR I:eaustgen  OR I:cemonahan  OR I:jdexter  OR I:mmeeks  OR I:aridgway  OR I:cstiffler  OR I:kclark  OR I:gfisher  OR I:msutherland  OR I:rneale  OR I:llittle  OR I:cneal  OR I:dfaulkner  OR I:rbellrose   OR I:ebrost  OR I:kweiss  OR I:dhorner  OR I:dgarcia  OR I:tgoggin  OR I:eherzberg  OR I:cpadgett  OR I:dtucker  OR I:aleadford  OR I:wvarsos  OR I:kaltendorf  OR I:callen  OR I:sfritz  OR I:cjacobson  OR I:dylanc  OR I:dcooke  OR I:hmitchell  OR I:emilym  OR I:kheth  OR I:asandau  OR I:cadamson  OR I:elee  OR I:dnordquist  OR I:jstover  OR I:pwashington  OR I:hherman  OR I:mmcgee  OR I:ldamico  OR I:yrivas  OR I:mfarrell  OR I:lbrown  OR I:mmattive  OR I:tdemitchell  OR I:kbeddoe  OR I:dscanlan  OR I:pballage  OR I:dvaught  OR I:rwagaman  OR I:Jbree  OR I:icrawford  OR I:merickson  OR I:vallen  OR I:tmatthews  OR I:amartin  OR I:mallen  OR I:mloula  OR I:tnylander  OR I:eraab  OR I:ebjerke  OR I:ecato  OR I:jhughes  OR I:atorres  OR I:bbunch  OR I:cdethomas  OR I:anichols	2017-09-12 06:56:03.087	2089	3

IF EXISTS(SELECT 1 FROM SecurityRule WHERE SecurityRule = @SecurityRule AND Expression <> @SecurityExpression)
BEGIN
	-- Update SecurityRule record when it exists but has the wrong expression
	PRINT 'UPDATING Table - SecurityRule. Updating Existing SecurityRule Record.';
	DECLARE @SecurityRuleID INTEGER;
	SELECT TOP(1) @SecurityRuleID = SecurityRuleID 
	FROM SecurityRule
	WHERE SecurityRule = @SecurityRule;
	EXEC SecurityRuleUpdate @SecurityRuleID, @SecurityRule, @SecurityExpression, @LastModifiedDate, @StatlineAdminEmployeeID, 1;
END
ELSE IF NOT EXISTS(SELECT 1 FROM SecurityRule WHERE SecurityRule = @SecurityRule)
BEGIN
	-- Insert SecurityRule record when it doesn't already exist
	PRINT 'UPDATING Table - SecurityRule. Adding New SecurityRule Record.';
	EXEC SecurityRuleInsert @SecurityRuleID=null, @SecurityRule='ST_Update', @Expression=@securityExpression, @LastModified=@LastModifiedDate, @LastStatEmployeeID=@StatlineAdminEmployeeID, @AuditLogTypeID=1;
END