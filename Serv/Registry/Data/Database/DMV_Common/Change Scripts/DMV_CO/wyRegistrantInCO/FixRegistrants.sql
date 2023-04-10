USE DMV_WY
 SELECT 
	* 
 FROM 
 	DMV_CO..registry r
join 
	DMV_CO..registryaddr ra on ra.registryid = r.id
where state = 'wy'

DECLARE 
	@loopCount int,
	@loopMax int,
	@RegistryID int,
	@addrLoop int,
	@addrMax int,
	@RegistryAddrID int,
	@error int, 
	@rowcount int

DECLARE @WYREGISTRY TABLE (
	WYREGISTRYID int identity(1,1),
	[ID] [int] NOT NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Race] [int] NULL ,
	[EyeColor] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Phone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comment] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVID] [int] NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVDonor] [bit] NOT NULL ,
	[Donor] [bit] NOT NULL ,
	[DonorConfirmed] [bit] NOT NULL ,
	[SourceCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlineRegDate] [datetime] NULL ,
	[SignatureDate] [datetime] NULL ,
	[MailerDate] [datetime] NULL ,
	[DeleteFlag] [bit] NOT NULL ,
	[DeleteDate] [datetime] NULL ,
	[DeletedByID] [int] NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL, 
	[UpdateRegistry] BIT 
) 


DECLARE @WYREGISTRYADDR TABLE (
	WYADDRID INT IDENTITY(1,1),
	[ID] [int] NOT NULL ,
	[RegistryID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) 

INSERT @WYREGISTRY
select distinct 
		r.ID,
		SSN, 
		DOB, 
		FirstName, 
		MiddleName, 
		LastName, 
		Suffix, 
		Gender, 
		Race, 
		EyeColor, 
		Phone, 
		Comment, 
		DMVID, 
		License, 
		DMVDonor, 
		Donor, 
		DonorConfirmed, 
		SourceCode, 
		OnlineRegDate, 
		SignatureDate, 
		MailerDate, 
		DeleteFlag, 
		DeleteDate, 
		DeletedByID, 
		r.UserID, 
		r.LastModified, 
		r.CreateDate, 
		DeceasedDate,
		1
 from 
	DMV_CO..registry r
join 
	DMV_CO..registryaddr ra on ra.registryid = r.id
where state = 'wy'

UPDATE @WYREGISTRY
 SET [UpdateRegistry] = 0
FROM @WYREGISTRY wr
join registry r on r.FirstName = wr.FirstName
AND	WR.LastName = r.LastName
AND	
	WR.MiddleName = r.MiddleName
AND	
	WR.DOB = r.DOB

PRINT 'CHECK PRE PROCESS'		
SELECT 
	* 
FROM 
 	registry r
join 
	registryaddr ra on ra.registryid = r.id
JOIN
	@WYREGISTRY	WR ON WR.FirstName = r.FirstName
AND	
	WR.LastName = r.LastName
AND	
	WR.MiddleName = r.MiddleName
AND	
	WR.DOB = r.DOB
AND
	WR.License = r.License
--WHERE	WR.UpdateRegistry = 1

SELECT 
	@loopMax = Max(WYREGISTRYID) , 
	@loopCount = Min(WYREGISTRYID) 
FROM
	@WYREGISTRY
ALTER TABLE REGISTRY
		DISABLE TRIGGER ALL

ALTER TABLE REGISTRYADDR
		DISABLE TRIGGER ALL
		
WHILE @loopCount <= @loopMax
BEGIN
	BEGIN TRANSACTION
	PRINT 'INSERT Registry '
	SELECT @RegistryID  = 0
	INSERT Registry (
		
		SSN, 
		DOB, 
		FirstName, 
		MiddleName, 
		LastName, 
		Suffix, 
		Gender, 
		Race, 
		EyeColor, 
		Phone, 
		Comment, 
		DMVID, 
		License, 
		DMVDonor, 
		Donor, 
		DonorConfirmed, 
		SourceCode, 
		OnlineRegDate, 
		SignatureDate, 
		MailerDate, 
		DeleteFlag, 
		DeleteDate, 
		DeletedByID, 
		UserID, 
		LastModified, 
		CreateDate, 
		DeceasedDate)		
		
		SELECT 		
		SSN, 
		DOB, 
		FirstName, 
		MiddleName, 
		LastName, 
		Suffix, 
		Gender, 
		Race, 
		EyeColor, 
		Phone, 
		Comment, 
		DMVID, 
		License, 
		DMVDonor, 
		Donor, 
		DonorConfirmed, 
		SourceCode, 
		OnlineRegDate, 
		SignatureDate, 
		MailerDate, 
		DeleteFlag, 
		DeleteDate, 
		DeletedByID, 
		UserID, 
		LastModified, 
		CreateDate, 
		DeceasedDate 
	FROM  
		@WYREGISTRY
	WHERE 
		WYREGISTRYID = @loopCount
	AND	
		[UpdateRegistry] = 1
	select @error = @@Error, @rowcount = @@Rowcount
	IF @ERROR <> 0 
	BEGIN
		PRINT 'An error occurred loading Registry'
		ROLLBACK TRANSACTION
		RETURN 
	END	
	if @Rowcount > 0
		BEGIN
			
		SELECT @RegistryID  = SCOPE_IDENTITY( )
		PRINT 'INSERT  WYREGISTRYADDR ' + CONVERT(VARCHAR(100),@RegistryID)
		SELECT 
			@addrLoop = 0, 
			@addrMax = 0
		INSERT
			@WYREGISTRYADDR
			(
				[ID], 
				RegistryID, 
				AddrTypeID, 
				Addr1, 
				Addr2, 
				City, 
				State, 
				Zip, 
				UserID, 
				LastModified, 
				CreateDate		
			)
		SELECT	
			ID,
			@RegistryID, 
			AddrTypeID, 
			Addr1, 
			Addr2, 
			City, 
			State, 
			Zip, 
			UserID, 
			LastModified, 
			CreateDate 
		FROM
			DMV_CO..RegistryAddr
		WHERE
			RegistryID = (SELECT ID FROM @WYREGISTRY WHERE WYREGISTRYID = @loopCount)
		AND @RegistryID <> 0
		
		SELECT 
			@addrLoop = MIN(WYADDRID), 
			@addrMax = MAX(WYADDRID)
		FROM 
			@WYREGISTRYADDR	
		WHILE @addrLoop <= @addrMax
		BEGIN
			PRINT 'insert RegistryAddr'
			INSERT RegistryAddr
				(
				RegistryID, 
				AddrTypeID, 
				Addr1, 
				Addr2, 
				City, 
				State, 
				Zip, 
				UserID, 
				LastModified, 
				CreateDate 
				)
				
			SELECT
				RegistryID, 
				AddrTypeID, 
				Addr1, 
				Addr2, 
				City, 
				State, 
				Zip, 
				UserID, 
				LastModified, 
				CreateDate 
			FROM
				@WYREGISTRYADDR
			WHERE
				WYADDRID = @addrLoop
	
			IF @@ERROR <> 0 
			BEGIN
				PRINT 'An error occurred loading RegistryAddr'
				ROLLBACK TRANSACTION
				RETURN 
			END			
			SELECT @addrLoop = @addrLoop + 1
		END
	END

	PRINT 'Delete dmv_CO..RegistryAddr'
	DELETE
		dmv_CO..RegistryAddr
	WHERE
		RegistryID = (Select ID FROM @WYREGISTRY WHERE WYREGISTRYID = @loopCount)

		IF @@ERROR <> 0 
		BEGIN
			PRINT 'An error occurred Deleting Data from RegistryAddr'
			ROLLBACK TRANSACTION
			RETURN 
		END			
	PRINT 'Delete dmv_CO..Registry'
	DELETE
		dmv_CO..Registry		
	WHERE 
		ID = (Select ID FROM @WYREGISTRY WHERE WYREGISTRYID = @loopCount)
	
		IF @@ERROR <> 0 
		BEGIN
			PRINT 'An error occurred Deleting Data from Registry'
			ROLLBACK TRANSACTION
			RETURN 
		END			
			
	DELETE @WYREGISTRYADDR 
	COMMIT TRANSACTION
	SELECT @loopCount = @loopCount + 1

	
END

ALTER TABLE REGISTRY
		ENABLE TRIGGER ALL

ALTER TABLE REGISTRYADDR
		ENABLE TRIGGER ALL

PRINT 'CHECK POST PROCESS'		
 SELECT 
	* 
 FROM 
 	registry r
join 
	registryaddr ra on ra.registryid = r.id
JOIN
	@WYREGISTRY	WR ON WR.FirstName = r.FirstName
AND	
	WR.LastName = r.LastName
AND	
	WR.MiddleName = r.MiddleName
AND	
	WR.DOB = r.DOB
	
	
--- none of the referrals have a reference to any of the co registry records. 

