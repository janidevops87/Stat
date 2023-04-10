/****** Object:  Table dbo.DMVARCHIVE    Script Date: 10/11/2016 9:45:13 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DMVARCHIVE') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE dbo.DMVARCHIVE(
		ID int NOT NULL,
		DMVIMPORTLOGID int NULL,
		CAID int NULL,
		SSN varchar(11) NULL,
		License varchar(9) NULL,
		DOB datetime NULL,
		FirstName varchar(75) NULL,
		MiddleName varchar(75) NULL,
		LastName varchar(75) NULL,
		Suffix varchar(15) NULL,
		Gender varchar(1) NULL,
		Donor bit NOT NULL CONSTRAINT DF_DMVARCHIVE_Donor  DEFAULT (0),
		CountyCode varchar(3) NULL,
		ImportDate datetime NULL,
		RenewalDate datetime NULL,
		DeceasedDate datetime NULL,
		CSORState varchar(2) NULL,
		CSORLicense varchar(25) NULL,
		UserID int NULL,
		LastModified datetime NULL,
		CreateDate datetime NULL,
		FULLNAME varchar(255) NULL,
		DisplacedBy int NULL,
		RecordType varchar(50) NULL,
	 CONSTRAINT PK_DMVARCHIVE PRIMARY KEY NONCLUSTERED 
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON IDX
	) ON [PRIMARY];
END
ELSE IF COL_LENGTH('dbo.DMVARCHIVE', 'FirstName') = 25
BEGIN
	ALTER TABLE dbo.DMVARCHIVE ALTER COLUMN FirstName varchar(75) NULL;
	ALTER TABLE dbo.DMVARCHIVE ALTER COLUMN MiddleName varchar(75) NULL;
	ALTER TABLE dbo.DMVARCHIVE ALTER COLUMN LastName varchar(75) NULL;
END;
GO

SET ANSI_PADDING OFF;
GO
