PRINT 'Sproc: dbo.spu_Audit_QAErrorLogHowIdentified'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLogHowIdentified'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLogHowIdentified
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLogHowIdentified
(
 @QAErrorLogHowIdentifiedID int 
,@QAErrorLogHowIdentifiedDescription varchar(250)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLogHowIdentified
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QAErrorLogHowIdentifiedDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --AuditLogTypeID 
)


INSERT INTO dbo.QAErrorLogHowIdentified
(
 QAErrorLogHowIdentifiedID
,QAErrorLogHowIdentifiedDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QAErrorLogHowIdentifiedDescription, '') = '' THEN 'ILB'  ELSE @QAErrorLogHowIdentifiedDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO

