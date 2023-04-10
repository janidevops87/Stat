/****** Object:  Table dbo.REGISTRY    Script Date: 10/12/2016 9:04:52 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.REGISTRY') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE dbo.REGISTRY(
		ID int IDENTITY(1,1) NOT NULL,
		ImportLogID int NULL,
		STATEID int NULL,
		SSN varchar(11) NULL,
		DOB datetime NULL,
		FirstName varchar(75) NULL,
		MiddleName varchar(75) NULL,
		LastName varchar(75) NULL,
		Suffix varchar(4) NULL,
		FullName varchar(75) NULL,
		Gender varchar(1) NULL,
		Race int NULL,
		Phone varchar(10) NULL,
		Email varchar(100) NULL,
		License varchar(9) NULL,
		STATE_ID varchar(9) NULL,
		Donor bit NOT NULL,
		DonorConfirmed bit NOT NULL,
		SourceCode varchar(10) NULL,
		OnlineRegDate datetime NULL,
		DeleteFlag bit NOT NULL DEFAULT ((0)),
		PreviousDonor bit NULL,
		PreviousDonorConfirmed bit NULL,
		UserID int NULL,
		LastModified datetime NULL,
		CreateDate datetime NULL,
		msrepl_tran_version uniqueidentifier NOT NULL CONSTRAINT DF__REGISTRY__msrepl__64B7E415  DEFAULT (newid()),
	 CONSTRAINT PK_REGISTRY PRIMARY KEY NONCLUSTERED 
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON IDX
	) ON [PRIMARY];
END
ELSE IF COL_LENGTH('dbo.REGISTRY', 'FirstName') = 20
BEGIN
	ALTER TABLE dbo.REGISTRY ALTER COLUMN FirstName varchar(75) NULL;
	ALTER TABLE dbo.REGISTRY ALTER COLUMN MiddleName varchar(75) NULL;
	ALTER TABLE dbo.REGISTRY ALTER COLUMN LastName varchar(75) NULL;
END;
GO

SET ANSI_PADDING OFF;
GO
