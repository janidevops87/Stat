PRINT 'Sproc: dbo.spu_Audit_QAMonitoringForm'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAMonitoringForm'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAMonitoringForm
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAMonitoringForm
(
 @QAMonitoringFormID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QAMonitoringFormName varchar(255)
,@QAMonitoringFormCalculateScore smallint 
,@QAMonitoringFormRequireReview smallint 
,@QAMonitoringFormActive smallint 
,@QAMonitoringFormInactiveComments varchar(1000)
,@QAMonitoringFormScore decimal 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAMonitoringForm
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
**  04/28/2013	jth			fixed offsets, lastmodified, laststatemployeeid and auditlogtype 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QATrackingTypeID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QAMonitoringFormName 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QAMonitoringFormCalculateScore 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --QAMonitoringFormRequireReview 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --QAMonitoringFormActive 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --QAMonitoringFormInactiveComments 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --QAMonitoringFormScore 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --LastModified 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AuditLogTypeID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QAMonitoringForm
	WHERE 
		QAMonitoringFormID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QAMonitoringForm
(
 QAMonitoringFormID
,OrganizationID
,QATrackingTypeID
,QAMonitoringFormName
,QAMonitoringFormCalculateScore
,QAMonitoringFormRequireReview
,QAMonitoringFormActive
,QAMonitoringFormInactiveComments
,QAMonitoringFormScore
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QAMonitoringFormName, '') = '' THEN 'ILB'  ELSE @QAMonitoringFormName END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QAMonitoringFormCalculateScore, 0) = 0 THEN 0 ELSE @QAMonitoringFormCalculateScore END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@QAMonitoringFormRequireReview, 0) = 0 THEN 0 ELSE @QAMonitoringFormRequireReview END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@QAMonitoringFormActive, 0) = 0 THEN 0 ELSE @QAMonitoringFormActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@QAMonitoringFormInactiveComments, '') = '' THEN 'ILB'  ELSE @QAMonitoringFormInactiveComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@QAMonitoringFormScore, 0) = 0 THEN 0 ELSE @QAMonitoringFormScore END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
end
GO

