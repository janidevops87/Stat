/******************************************************************************
**	File: Drop_OldSprocs.sql
**	Name: Drop_OldSprocs
**	Desc:  Old\sps_StatFileMessageDetailLastMod  
**         Old\sps_StatFileMessageDetailCreated
**         Old\sps_StatFileMessageDetailCombined
**		   sps_GetStatTracDataSet
**		   sps_StatFileReferralEventLog
**		   sps_StatFileDonorTracDB
**		   sps_StatFileMessageDetail
**	Auth: Ilya Osipov	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  07/31/2018		Ilya Osipov				initial
*******************************************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileMessageDetailLastMod]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileMessageDetailLastMod]'
	DROP PROCEDURE [dbo].[sps_StatFileMessageDetailLastMod]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileMessageDetailCombined]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileMessageDetailCombined]'
	DROP PROCEDURE [dbo].[sps_StatFileMessageDetailCombined]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileMessageDetailCreated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileMessageDetailCreated]'
	DROP PROCEDURE [dbo].[sps_StatFileMessageDetailCreated]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileMessageDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileMessageDetail]'
	DROP PROCEDURE [dbo].[sps_StatFileMessageDetail]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileDonorTracDB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileDonorTracDB]'
	DROP PROCEDURE [dbo].[sps_StatFileDonorTracDB]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileReferralEventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileReferralEventLog]'
	DROP PROCEDURE [dbo].[sps_StatFileReferralEventLog]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetStatTracDataSet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_GetStatTracDataSet]'
	DROP PROCEDURE [dbo].[sps_GetStatTracDataSet]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileMessageEventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileMessageEventLog]'
	DROP PROCEDURE [dbo].[sps_StatFileMessageEventLog]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileReferralDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileReferralDetail]'
	DROP PROCEDURE [dbo].[sps_StatFileReferralDetail]
END

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_StatFileReferralDetailFS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_StatFileReferralDetailFS]'
	DROP PROCEDURE [dbo].[sps_StatFileReferralDetailFS]
END