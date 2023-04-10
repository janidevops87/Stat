 /******************************************************************************
**	File: ReportType.sql
**	Name: Report type
**	Desc: This file adds additional report types for new reporting site
**	Auth: Pam Scheichenost
**	Date: 11/12/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/12/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/


SET IDENTITY_INSERT dbo.ReportType ON;

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Referrals')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(1, 'Referrals');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Messages')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(2, 'Messages');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Imports')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(3, 'Imports');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Referral Stats')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(4, 'Referral Stats');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'General')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(5, 'General');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Custom Reports')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(6, 'Custom Reports');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Schedules')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(7, 'Schedules');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Statistical')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(8, 'Statistical');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Admin')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(9, 'Admin');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'FTP')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(10, 'FTP');	
END


IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'Registry')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(11, 'Registry');	
END

IF NOT EXISTS(SELECT 1 FROM dbo.ReportType WHERE REPORTTYPENAME = 'QA')
BEGIN
	-- Add the deleted record
	INSERT INTO dbo.ReportType (REPORTTYPEID, REPORTTYPENAME) VALUES
	(12, 'QA');	
END

SET IDENTITY_INSERT dbo.ReportType OFF;
GO
