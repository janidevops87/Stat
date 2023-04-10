 /******************************************************************************
**		File: CreateConstraintTable_QATrackingStatus.sql
**		Name: CreateConstraintTable_QATrackingStatus
**		Desc: Create table constraints on QA update tables
**
**		Auth: ccarroll
**		Date: 01/20/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/20/2009	ccarroll			initial
*******************************************************************************/
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QATrackingStatus')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QATrackingStatus'
			ALTER TABLE QATrackingStatus
				ADD	 CONSTRAINT [PK_QATrackingStatus] PRIMARY KEY  NONCLUSTERED 
					 (
						[QATrackingStatusID]
					 )  ON [IDX]
	END

