/******************************************************************************
**		File: CreateConstraintTable_QATracking.sql
**		Name: CreateConstraintTable_QATracking
**		Desc: Create table indexes and foregin keys on QA tables
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
  IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QATracking')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QATracking'
			ALTER TABLE QATracking
				ADD	 CONSTRAINT [PK_QATracking] PRIMARY KEY  NONCLUSTERED 
					 (
						[QATrackingID]
					 )  ON [IDX]
	END
 