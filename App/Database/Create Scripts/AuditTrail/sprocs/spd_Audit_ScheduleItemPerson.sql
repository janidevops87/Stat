/****************************************************************************
**  
**  File: spd_Audit_ScheduleItemPerson.sql  
**  Name: spd_Audit_ScheduleItemPerson
**  Desc:
**  
**  Date:     	Author:    		Description:  
**  --------    --------   		-------------------------------------------  
**  06/14/2011  Steve Barron  	Delete Audit records for DBO.OrganizationPhone
**  03/24/2021	James Gerberich	Copied for ScheduleItemPerson table
*******************************************************************************/

SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_ScheduleItemPerson]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	BEGIN 
		DROP PROCEDURE [dbo].[spd_Audit_ScheduleItemPerson];
		PRINT 'Drop Sproc: spd_Audit_ScheduleItemPerson';
	END   
GO 

PRINT 'Create Sproc: spd_Audit_ScheduleItemPerson';
GO

CREATE PROCEDURE [dbo].[spd_Audit_ScheduleItemPerson]
	@ScheduleItemPersonId int
AS

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO