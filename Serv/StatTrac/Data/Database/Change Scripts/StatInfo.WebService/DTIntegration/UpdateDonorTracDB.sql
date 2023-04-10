 DECLARE 
	@DonorTracOrganizationGUID uniqueidentifier,
	@DonorTracUpdate bit,
	@OrganizationID int

-- TXLG 
SET	@DonorTracOrganizationGUID = '2A74812B-0EBE-4227-B345-A55BBB93A8E9'
SET	@DonorTracUpdate = 0
SET @OrganizationID = 2257


 UPDATE    DonorTracDB
 SET              DonorTracOrganizationGUID = @DonorTracOrganizationGUID, DonorTracUpdate = @DonorTracUpdate
 WHERE     (OrganizationID = @OrganizationID)
 
-- OHLB 
SET	@DonorTracOrganizationGUID = '0C7636F5-08F4-4764-83C4-51BB8B68A94E'
SET	@DonorTracUpdate = 0
SET @OrganizationID = 1100


 UPDATE    DonorTracDB
 SET              DonorTracOrganizationGUID = @DonorTracOrganizationGUID, DonorTracUpdate = @DonorTracUpdate
 WHERE     (OrganizationID = @OrganizationID) 
 
-- LOOP 
SET	@DonorTracOrganizationGUID = 'C097A085-E555-42FD-8926-EA986F5B0BAE'
SET	@DonorTracUpdate = 1
SET @OrganizationID = 5115


 UPDATE    DonorTracDB
 SET              DonorTracOrganizationGUID = @DonorTracOrganizationGUID, DonorTracUpdate = @DonorTracUpdate
 WHERE     (OrganizationID = @OrganizationID) 
 
 -- GOLM 
SET	@DonorTracOrganizationGUID = '7380B13D-63B1-4773-ACE4-F6B0386CC6AA'
SET	@DonorTracUpdate = 0
SET @OrganizationID = 2309
	

 UPDATE    DonorTracDB
 SET              DonorTracOrganizationGUID = @DonorTracOrganizationGUID, DonorTracUpdate = @DonorTracUpdate
 WHERE     (OrganizationID = @OrganizationID) 
 
 -- CAOL 
SET	@DonorTracOrganizationGUID = '4324FCFC-B1E2-41C1-AD4B-22F3EF5E3BC7'
SET	@DonorTracUpdate = 0
SET @OrganizationID = 5146


 UPDATE    DonorTracDB
 SET              DonorTracOrganizationGUID = @DonorTracOrganizationGUID, DonorTracUpdate = @DonorTracUpdate
 WHERE     (OrganizationID = @OrganizationID) 
 
 