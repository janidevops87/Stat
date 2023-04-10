/***************************************************************************************************
**	Name: TcssRecipientCandidate
**	Desc: Creates new table TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientCandidate')
BEGIN
	-- DROP TABLE dbo.TcssRecipientCandidate
	PRINT 'Creating table TcssRecipientCandidate'
	CREATE TABLE dbo.TcssRecipientCandidate
	(
		TcssRecipientCandidateId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NOT NULL,
		TcssListRefusedByOtherCenterId int NULL,
		Why varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssRecipientCandidate TO PUBLIC
GO
