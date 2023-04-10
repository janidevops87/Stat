PRINT 'Sproc: dbo.spu_Audit_QAErrorLocation'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLocation'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLocation
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLocation
(
 @QAErrorLocationID int 
,@OrganizationID int 
,@QAErrorLocationDescription varchar(255)
,@QAErrorLocationActive smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLocation
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation
**  04/28/2013	jth			fixed offsets, lastmodified, laststatemployeeid and auditlogtype 
***************************************************************************************************/

IF not (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QAErrorLocationDescription 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QAErrorLocationActive 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastModified 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AuditLogTypeID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QAErrorLocation
	WHERE 
		QAErrorLocationID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QAErrorLocation
(
 QAErrorLocationID
,OrganizationID
,QAErrorLocationDescription
,QAErrorLocationActive
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QAErrorLocationDescription, '') = '' THEN 'ILB'  ELSE @QAErrorLocationDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QAErrorLocationActive, 0) = 0 THEN 0 ELSE @QAErrorLocationActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
end
GO

