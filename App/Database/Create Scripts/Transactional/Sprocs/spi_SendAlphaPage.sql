SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_SendAlphaPage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_SendAlphaPage]
GO


CREATE PROCEDURE spi_SendAlphaPage 
	(@CallId int = 0,
	@Recipient varchar(100) = NULL,
	@Sender varchar(100) = NULL,
	@CC varchar(100) = NULL,
	@BC varchar(100) = NULL,
	@MessageSubject varchar(150) = NULL,
	@MessageBody varchar(7500) = NULL)

AS
/******************************************************************************
**	File: spi_SendAlphaPage.sql
**	Name: spi_SendAlphaPage
**	Desc: Sproc adds a record to AlphaPage table, creating addresses and message
**        for an email to be sent by the SQL Server, using DTS package "SQL Mail".
**	Auth: Scott Plummer
**	Date: 4/21/2005
**	Called By: Called by StatTrac
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	4/21/2005		Scott Plummer		Initial Sproc Creation
**	10/17/2019		Bret Knoll			Replaced call to extended procedure with 
** 										query to sysjobs tables
**	06/01/2021		Mike Berenson		Removed code that checks and calls SqlMailer job
*******************************************************************************/


SET NOCOUNT ON
-- Ensure that there is a Sender's email address.  4/27/05 - SAP
IF Len(@Sender) = 0
BEGIN
	SET @Sender = 'PGRRspnse@statline.org'  -- Used unusual capitalization to flag in db.
END

INSERT INTO AlphaPage(CallId, 
		AlphaPageRecipient, 
		AlphaPageSender, 
		AlphaPageCC, 
		AlphaPageBC, 
		AlphaPageSubject, 
		AlphaPageBody, 
		AlphaPageCreated, 
		AlphaPageComplete)
	VALUES(@CallId,
		@Recipient,
		@Sender,
		@CC,
		@BC,
		@MessageSubject,
		@MessageBody,
		GetDate(),
		0 );
