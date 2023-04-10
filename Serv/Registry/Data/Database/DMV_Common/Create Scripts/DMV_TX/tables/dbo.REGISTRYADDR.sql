/****** Object:  Table dbo.REGISTRYADDR    Script Date: 10/12/2016 9:17:06 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.REGISTRYADDR') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE dbo.REGISTRYADDR(
		ID int IDENTITY(1,1) NOT NULL,
		RegistryID int NOT NULL,
		AddrTypeID int NULL,
		Addr1 varchar(200) NULL,
		Addr2 varchar(20) NULL,
		City varchar(75) NULL,
		State varchar(2) NULL,
		Zip varchar(10) NULL,
		UserID int NULL,
		LastModified datetime NULL,
		CreateDate datetime NULL,
		msrepl_tran_version uniqueidentifier NOT NULL CONSTRAINT DF__REGISTRYA__msrep__5A3A55A2  DEFAULT (newid()),
	 CONSTRAINT PK_REGISTRYADDR PRIMARY KEY NONCLUSTERED 
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON IDX
	) ON [PRIMARY];
END
ELSE IF COL_LENGTH('dbo.REGISTRYADDR', 'Addr1') = 40
BEGIN
	ALTER TABLE dbo.REGISTRYADDR ALTER COLUMN Addr1 varchar(200) NULL;
	ALTER TABLE dbo.REGISTRYADDR ALTER COLUMN City varchar(75) NULL;
END;
GO

SET ANSI_PADDING OFF;
GO
