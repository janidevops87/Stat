/******************************************************************************
**		File: RemoveAppropriateCounts.sql
**		Name: Remove AppropriateCounts table, sprocs
**		Desc: Looks like obsolete table that is not used
**
**		Auth: Pam Scheichenost
**		Date: 01/15/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/15/2020	Pam Scheichenost	initial
*******************************************************************************/

IF EXISTS(SELECT 1 from sys.tables where name = 'AppropriateCounts')
BEGIN
	DROP TABLE dbo.AppropriateCounts;
END

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'spi_AppropriateCount')
BEGIN
	DROP PROCEDURE dbo.spi_AppropriateCount;
END

