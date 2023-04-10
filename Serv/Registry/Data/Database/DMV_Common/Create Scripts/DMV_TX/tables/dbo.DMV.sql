/****** Object:  Table dbo.DMV    Script Date: 10/12/2016 9:25:04 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING OFF;
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DMV') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE dbo.DMV(
		ID int IDENTITY(1,1) NOT NULL,
		DMVImportLogID int NULL,
		STATEID int NULL,
		SSN varchar(11) NULL,
		License varchar(9) NULL,
		DOB datetime NULL,
		FirstName varchar(75) NULL,
		MiddleName varchar(75) NULL,
		LastName varchar(75) NULL,
		Suffix varchar(15) NULL,
		Gender varchar(1) NULL,
		Donor bit NOT NULL,
		CountyCode varchar(3) NULL,
		ImportDate datetime NULL,
		RenewalDate datetime NULL,
		DeceasedDate datetime NULL,
		CSORState varchar(2) NULL,
		CSORLicense varchar(25) NULL,
		UserID int NULL,
		LastModified datetime NULL,
		CreateDate datetime NULL,
		FullName varchar(715) NULL,
		FirstName_Display nvarchar(255) NULL,
		MiddleName_Display nvarchar(255) NULL,
		LastName_Display nvarchar(255) NULL,
	 CONSTRAINT PK_DMV PRIMARY KEY CLUSTERED 
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON IDX
	) ON IDX;
END
ELSE IF COL_LENGTH('dbo.DMV', 'FirstName') = 25
BEGIN
	ALTER TABLE dbo.DMV ALTER COLUMN FirstName varchar(75) NULL;
	ALTER TABLE dbo.DMV ALTER COLUMN MiddleName varchar(75) NULL;
	ALTER TABLE dbo.DMV ALTER COLUMN LastName varchar(75) NULL;
END;
GO

SET ANSI_PADDING OFF;
GO
