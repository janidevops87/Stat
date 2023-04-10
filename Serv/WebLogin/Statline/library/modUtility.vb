Module modUtility
    Public Function GetReturnID&(ByVal pvDataSet As DataSet)
        On Error GoTo errHandler

        'Set the data
        Dim vTable As DataTable
        Dim vRow As DataRow

        vTable = pvDataSet.Tables(0)
        vRow = vTable.Rows(0)
        GetReturnID = vRow(vTable.Columns(0))

        Exit Function
errHandler:
        GetReturnID = -1

    End Function


    Function DaylightSavings(ByVal LocalDate)
        If CDate(LocalDate) >= GetSunday(4, DatePart("yyyy", LocalDate), "First") _
        And CDate(LocalDate) <= GetSunday(10, DatePart("yyyy", LocalDate), "Last") Then
            DayLightSavings = True

        Else
            DayLightSavings = False
        End If

    End Function

    Function GetSunday(ByVal Month, ByVal Year, ByVal FirstLast) ' GetSunday returns the Date of the day requested

        Dim ForLoopCounter
        Dim CurrentDate
        'if FirstLast = First loop through given month and year until reaching first sunday
        If FirstLast = "First" Then
            For ForLoopCounter = 1 To 31

                CurrentDate = Month & "/" & ForLoopcounter & "/" & Year & " 02:00:00"

                If IsDate(CurrentDate) Then  'if CurrentDate is not a date loop 
                    'if CurrentDate is date check if it is Sunday.
                    If WeekDay(CurrentDate) = 1 Then
                        GetSunday = CDate(CurrentDate)
                        Exit Function
                    End If

                End If

            Next
            'if FirstLast = Last loop through given month and year starting with the last day of the month	
        ElseIf FirstLast = "Last" Then
            For ForLoopCounter = 31 To 1 Step -1
                CurrentDate = Month & "/" & ForLoopcounter & "/" & Year & " 02:00:00"

                If IsDate(CurrentDate) Then  'if CurrentDate is not a date loop 
                    'if CurrentDate is date check if it is Sunday.
                    If WeekDay(CurrentDate) = 1 Then
                        GetSunday = CDate(CurrentDate)
                        Exit Function
                    End If

                End If
            Next
        End If

    End Function

End Module
