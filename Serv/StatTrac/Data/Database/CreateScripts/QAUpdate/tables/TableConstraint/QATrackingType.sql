/******************************************************************************
**		File: CreateConstraintTable_QATrackingType.sql
**		Name: CreateConstraintTable_QATrackingType
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
 IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'K' AND name = 'PK_QATrackingType')
	BEGIN
		PRINT 'Creating Table Constraint: PK_QATrackingType'
			ALTER TABLE QATrackingType
				ADD	 CONSTRAINT [PK_QATrackingType] PRIMARY KEY  NONCLUSTERED 
					 (
						[QATrackingTypeID]
					 )  ON [IDX]
	END
	