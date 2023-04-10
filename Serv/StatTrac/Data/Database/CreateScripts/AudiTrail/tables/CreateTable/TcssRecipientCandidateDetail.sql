/***************************************************************************************************
**	Name: TcssRecipientCandidateDetail
**	Desc: Creates new table TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Table Creation 
**  03/29/2011  jth				evaluatedby needs to be varchar and not int
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientCandidateDetail')
BEGIN
	-- DROP TABLE dbo.TcssRecipientCandidateDetail
	PRINT 'Creating table TcssRecipientCandidateDetail'
	CREATE TABLE dbo.TcssRecipientCandidateDetail
	(
		TcssRecipientCandidateDetailId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NULL,
		SequenceNumber int NULL,
		CandidateFirstName varchar(50) NULL,
		CandidateLastName varchar(50) NULL,
		EvaluatedBy int NULL,
		TcssListOfferStatusId int NULL,
		PrimaryTcssListRefusalReasonId int NULL,
		SecondaryTcssListRefusalReasonId int NULL,
		PrimaryTcssListRefusalReasonComment varchar(100) NULL,
		SecondaryTcssListRefusalReasonComment varchar(100) NULL,
		RefusalComment varchar(250) NULL
	)
END
GO
IF NOT EXISTS(SELECT sys.types.* FROM sys.objects 
join sys.columns on sys.objects.object_id = sys.columns.object_id
join sys.types on sys.columns.system_type_id = sys.types.system_type_id
where sys.objects.name = 'TcssRecipientCandidateDetail' 
and sys.columns.name = 'EvaluatedBy'
and sys.types.name = 'varchar')
Begin
	ALTER TABLE TcssRecipientCandidateDetail
			ALTER COLUMN EvaluatedBy VARCHAR(50) NULL 
end
GRANT SELECT ON TcssRecipientCandidateDetail TO PUBLIC
GO
