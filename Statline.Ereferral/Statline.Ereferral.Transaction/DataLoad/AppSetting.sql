IF NOT EXISTS(SELECT 1 FROM dbo.AppSetting WHERE Id = 1)
BEGIN
INSERT INTO dbo.AppSetting VALUES
(1, 'Confirmation', '<p>Your submission has been recorded. You will receive an e-mail confirmation shortly.</p>
<p>If any updates or corrections need to be made to this case, please call IIAM at 800-486-4426.</p>
<p>Please click <a href="/Login">here</a> to enter information for another donor.</p>')
END
GO

IF EXISTS(SELECT 1 FROM dbo.AppSetting a WHERE Id= 1 AND PATINDEX('%<p>Please%',a.[Value])>0)
	BEGIN
	UPDATE dbo.AppSetting 
	SET [Value] = '<p>Your submission has been recorded. You will receive an e-mail confirmation shortly.</p>
	<p>If any updates or corrections need to be made to this case, or if you have a new referral, click <a href="/Login">here</a> or call IIAM at 800-486-4426.'
	WHERE Id = 1;
	END
GO