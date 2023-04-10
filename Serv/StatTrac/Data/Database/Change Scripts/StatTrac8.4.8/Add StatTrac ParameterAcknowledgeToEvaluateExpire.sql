 if(db_name() = '_ReferralProd' or db_name() = '_ReferralTest' or db_name() like '%dev%')
begin
	PRINT 'Adding Log Event data > StatTracParameters'


	SET IDENTITY_INSERT dbo.StatTracParameters ON


	IF (SELECT COUNT(*) FROM StatTracParameters WHERE StatTracParametersID IN (2)) = 0 
	BEGIN
			INSERT StatTracParameters(StatTracParametersID, ParameterName, parameterValueint) VALUES(2, 'Acknowledge_to_Evaluate_Expire', 3)
			
			PRINT '  -Insert row(s) added'
	END
	ELSE
	BEGIN
			PRINT '  -0 rows added - data already exists'
	END


	SET IDENTITY_INSERT dbo.StatTracParameters OFF

end
else
begin
	print 'only run add logevent on _ReferralProd'
end