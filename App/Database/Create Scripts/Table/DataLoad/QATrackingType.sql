/***************************************************************************************************
**	Name: QATraining Type
**	Desc: Data Load for table QATrackingType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author		Description
**	----------	------------	--------------------------------------------------------------------
**	10/2011		jth				Initial 
**	06/15/2012	ccarroll		Add Tracking Type and Logo for IIAM  		
***************************************************************************************************/

/* Add QA Tracking Type: IIAM
	Adding a QA Tracking Type requires adding data to the following tables:
	1. QALogo
	2. QA TrackingType 

	Declare QA Tracking Type to be added:
*/

DECLARE @QATrackingTypeDescription AS varchar(255) = 'IIAM',
		@QATrackingTypeImageName AS varchar(50) = 'statline.jpg',
		@QATrackingTypeId AS Int,
		@OrganizationID AS Int = 194, -- Statline
		@LastStatEmployeeId AS Int = 1100,
		@AuditLogTypeId AS Int = 1 -- Create

IF NOT EXISTS (SELECT TOP 1 QATrackingTypeId FROM QATrackingType WHERE QATrackingTypeDescription = @QATrackingTypeDescription )
BEGIN

/* Insert QA Tracking Type */
PRINT 'Adding Tracking Type: ' + @QATrackingTypeDescription
INSERT dbo.QATrackingType (
	OrganizationID,
	QATrackingTypeDescription,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
	) VALUES (
	@OrganizationID, --OrganizationID
	@QATrackingTypeDescription,
	GETDATE(), -- LastModified
	@LastStatEmployeeId,
	@AuditLogTypeId
	)

SET @QATrackingTypeId = @@IDENTITY

/* Insert QA Logo */
PRINT 'Adding Tracking Type Logo: ' + @QATrackingTypeImageName + ' - ' + @QATrackingTypeDescription
INSERT dbo.QALogos (
	LogoName,
	OrganizationID,
	TrackingTypeID,
	ImageName
	) VALUES (
	@QATrackingTypeDescription, --LogoName
	@OrganizationID, --OrganizationID
	@QATrackingTypeId, --TrackingTypeID,
	@QATrackingTypeImageName --ImageName
	)

END