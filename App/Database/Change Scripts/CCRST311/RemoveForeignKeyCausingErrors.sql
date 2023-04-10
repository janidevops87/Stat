IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_dbo_Person_TrainedRequestorID_dbo_TrainedRequestor_TrainedRequestorID]') AND type = 'F')
BEGIN
	ALTER TABLE [dbo].[Person] DROP CONSTRAINT [FK_dbo_Person_TrainedRequestorID_dbo_TrainedRequestor_TrainedRequestorID]
END
GO