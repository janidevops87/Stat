--:setvar Publisher 'st-devsql-2'
--:setvar Distributor 'st-devsql-2'
--:setvar Publisher 'st-devsql-2'
--:setvar Subscriber 'st-devsql-2'
--:setvar TransactionDb 'ReferralTest'
--:setvar AuditTrailDb '_ReferralAuditTrail'

PRINT '----------------------------------- AuditTrail Create Subscription: ' + $(TransactionDb) + ' -----------------------------------'
DECLARE 
	@publication NVARCHAR(100)		= 'AuditTrail',
	@subscriber NVARCHAR(100)		= $(Subscriber),
	@destination_db NVARCHAR(100)	= $(AuditTrailDb),
	@sync_type NVARCHAR(100)		= 'automatic',
	@subscription_type NVARCHAR(100)= 'pull',
	@update_mode NVARCHAR(100)		='read only'




-- Create Subscription

EXEC sp_addsubscription
	@publication		= @publication,		
	@subscriber			= @subscriber,			
	@destination_db		= @destination_db,		
	@sync_type			= @sync_type,			
	@subscription_type	= @subscription_type,	
	@update_mode		= @update_mode		
