SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_DonorData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_DonorData'
		DROP procedure [dbo].[spu_Audit_DonorData]
	END
GO

	PRINT 'Creating Procedure spu_Audit_DonorData'
GO


create procedure spu_Audit_DonorData
	@DonorDataId int,
	@CallID int,
	@DonorDataMiddleName varchar(20),
	@DonorDataLicense varchar(9),
	@DonorDataAddress varchar(40),
	@DonorDataCity varchar(25),
	@DonorDataState varchar(2),
	@DonorDataZip varchar(10),
	@DonorDataNotAvailable bit,
	@LastModified smalldatetime,
	@MultipleDonorsFound smallint,
	@LastStatEmployeeID int,
	@AuditLogTypeID int,
	@pkc1 int,
	@bitmap binary(2)
AS
/******************************************************************************
**		File: spu_Audit_DonorData.sql
**		Name: spu_Audit_DonorData
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
**		02/19/2018	Mike Berenson		Fixed field order TFS54790
*******************************************************************************/
	DECLARE 
		@lastModifiedFromLookup datetime,
		@LastStatEmployeeIDFromLookup int,
		@auditLogTypeIDFromLookup int,
		@callIDFromLookup int
IF NOT (
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- DonorDataId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- DonorDataMiddleName
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- DonorDataLicense
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- DonorDataAddress
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- DonorDataCity
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- DonorDataState
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- DonorDataZip
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- DonorDataNotAvailable
		AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- MultipleDonorsFound
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- AuditLogTypeID
	   )
BEGIN	   

	SELECT TOP 1
		@lastModifiedFromLookup = LastModified,
		@LastStatEmployeeIDFromLookup = LastStatEmployeeID,
		@auditLogTypeIDFromLookup = ISNULL(@AuditLogTypeID, AuditLogTypeID),
		@callIDFromLookup = CallID
	FROM
		DonorData
	WHERE 
		DonorDataId = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- DonorDataId
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- DonorDataMiddleName
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- DonorDataLicense
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- DonorDataAddress
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- DonorDataCity
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- DonorDataState
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- DonorDataZip
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- DonorDataNotAvailable
		AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- MultipleDonorsFound
		-- AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- LastStatEmployeeID
		-- AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- AuditLogTypeID
		AND @auditLogTypeIDFromLookup = 3	
	)
BEGIN
		SET @auditLogTypeIDFromLookup = 2	-- Review
END


insert into DonorData
	( 
	DonorDataId, 
	CallID, 
	DonorDataMiddleName,
	DonorDataLicense, 
	DonorDataAddress, 
	DonorDataCity, 
	DonorDataState, 
	DonorDataZip, 
	DonorDataNotAvailable, 
	LastModified, 
	MultipleDonorsFound, 
	LastStatEmployeeID, 
	AuditLogTypeID  
 )

values ( 
	@pkc1,
	@callIDFromLookup,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@DonorDataMiddleName, '') = '' THEN 'ILB' ELSE @DonorDataMiddleName END,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@DonorDataLicense, '') = '' THEN 'ILB' ELSE @DonorDataLicense END,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@DonorDataAddress, '') = '' THEN 'ILB' ELSE @DonorDataAddress END,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@DonorDataCity, '') = '' THEN 'ILB' ELSE @DonorDataCity END,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@DonorDataState, '') = '' THEN 'ILB' ELSE @DonorDataState END,
	CASE WHEN SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@DonorDataZip, '') = '' THEN 'ILB' ELSE @DonorDataZip END,
	@DonorDataNotAvailable,
	ISNULL(@LastModified, @lastModifiedFromLookup),
	@MultipleDonorsFound,
	ISNULL(@LastStatEmployeeID, @LastStatEmployeeIDFromLookup),
	@auditLogTypeIDFromLookup
 )

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

