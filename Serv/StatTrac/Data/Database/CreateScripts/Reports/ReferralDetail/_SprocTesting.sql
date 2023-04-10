/* Sproc Testing */
exec sps_rpt_ReferralDetail_Triage Null, '11/04/2006 00:00', '11/06/2006 23:59', Null, Null, 37, Null, Null, Null, Null, Null, Null, 194, 1
--exec sps_rpt_ReferralDetail_Triage 5688733, Null, Null, Null, Null, 37, Null, Null, Null, Null, Null, Null, 194, 0

 SELECT * FROM Referral WHERE CallID = 5688733 --Secondary WHERE CallID > 5688704 AND CallID < 5688800
/*  Sproc Pamameter Inputs 

	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,
	@UserOrgID					int = Null,
	@DisplaySecondary			bit = Null
*/

--exec sps_rpt_ReferralDetail_EventLog 5812395, 'ET'
--exec sps_rpt_ReferralDetail '02/16/2007 00:00', '02/16/2007 23:59',NULL,NULL,NULL --7sec w/o call, 1sec w call and date
--exec sps_rpt_MedicationOtherList 5800893
--exec sps_rpt_MedicationOtherList 5800893, 'steroid'
--exec sps_rpt_MedicationOtherList 5800893, 'Antibiotic' 

--exec sps_rpt_ReferralDetail_Secondary 5812459
--exec sps_rpt_SecondaryDisposition 5812460 


