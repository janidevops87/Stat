<%

Function GetHospitalReportCaseStatment()
	Dim BuildQuery
	BuildQuery = ""
	
	BuildQuery = "_AND_DateDiff(minute,DATEADD(hour,DeathHour,DATEADD(minute,DeathMinute,ReferralDonorDeathDate)),"
	BuildQuery = BuildQuery & "DATEADD(hour,(CASE_OrganizationTimeZone_" 
	BuildQuery = BuildQuery & "When_'AT'_Then_3_"        
    BuildQuery = BuildQuery & "When_'ET'_Then_2_"          
	BuildQuery = BuildQuery & "When_'CT'_Then_1_"          
    BuildQuery = BuildQuery & "When_'MT'_Then_0_"
    BuildQuery = BuildQuery & "When_'PT'_Then_-1_"          
    BuildQuery = BuildQuery & "When_'KT'_Then_-2_"           
    BuildQuery = BuildQuery & "When_'HT'_Then_-3_"          
    BuildQuery = BuildQuery & "When_'ST'_Then_-4_"

    BuildQuery = BuildQuery & "When_'AS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_2_Else_3_End)_"
	BuildQuery = BuildQuery & "When_'ES'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_1_Else_2_End)_"
    BuildQuery = BuildQuery & "When_'CS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_0_Else_1_End)_" 
	BuildQuery = BuildQuery & "When_'MS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_-1_Else_0_End)_" 
    BuildQuery = BuildQuery & "When_'PS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_-2_Else_-1_End)_" 
	BuildQuery = BuildQuery & "When_'KS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_-3_Else_-2_End)_" 
    BuildQuery = BuildQuery & "When_'HS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_-4_Else_-3_End)_" 
	BuildQuery = BuildQuery & "When_'SS'_Then_(Case_When_DATEPART(m,CallDateTime)_between_4_and_10_Then_-5_Else_-4_End)_"
	BuildQuery = BuildQuery & "END),CallDateTime))"
	
	
	
	GetHospitalReportCaseStatment = BuildQuery
End Function



%>

