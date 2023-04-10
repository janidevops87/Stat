Option Strict Off
Option Explicit On
Module modMask
	
	'Public Constants
	Public Const KEY_BACKSPACE As Short = 8
	Public Const KEY_SPACE As Short = 32
	Public Const KEY_MINUS As Short = 45
	Public Const KEY_DECIMAL As Short = 46
    Public Function PhoneMask(ByVal pKey As Short, ByRef pcText As Object) As Object

        'This module masks a phone format (###)###-####.
        Dim txttest As String = ""



        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        'Check to see if control should be cleared
        If pKey = KEY_BACKSPACE And pcText.SelectionLength = vLength Then
            'Clear control and exit
            pcText.Text = ""
            Exit Function
        End If

        'Check for backspace.
        'If the backspace is on the second, sixth, or
        'tenth character, then allow the backspace
        'plus one additional to remove the '(', ')', or '-'
        'character
        If pKey = KEY_BACKSPACE And vLength = 2 Then
            pcText.Text = Left(pcText.Text, 0)
            pcText.SelectionStart() = Len(pcText.Text)
            PhoneMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 3)
            pcText.SelectionStart() = Len(pcText.Text)
            PhoneMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 10 Then
            pcText.Text = Left(pcText.Text, 8)
            pcText.SelectionStart() = Len(pcText.Text)
            PhoneMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            PhoneMask = pKey
            Exit Function
        End If


        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                PhoneMask = 0
                Exit Function
            End If
        End If

        'Check the first character for a number
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = "(" & vNewText
                pcText.SelectionStart() = Len(pcText.Text)
                PhoneMask = 0
                Exit Function
            End If
        End If

        'Check the second and third characters for 0-9
        If vLength = 1 Or vLength = 2 Then
            If pKey >= 48 And pKey <= 57 Then
                PhoneMask = pKey
                Exit Function
            End If
        End If

        'Check the third character for 0-9
        'and default the ') ' character
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText & ") "
                pcText.SelectionStart() = Len(pcText.Text)
                PhoneMask = 0
                Exit Function
            End If
        End If

        'Check characters 6 & 7 for 0-9
        If vLength = 6 Or vLength = 7 Then
            If pKey >= 48 And pKey <= 57 Then
                PhoneMask = pKey
                Exit Function
            End If
        End If

        'Check the eighth character for 0-9
        'and default the '-' character
        If vLength = 8 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText & "-"
                pcText.SelectionStart() = Len(pcText.Text)
                PhoneMask = 0
                Exit Function
            End If
        End If

        'Check characters 10,11,12,13 for 0-9
        If vLength = 10 Or vLength = 11 Or vLength = 12 Or vLength = 13 Then
            If pKey >= 48 And pKey <= 57 Then
                PhoneMask = pKey
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        PhoneMask = 0
        Exit Function

    End Function

    Public Function SSNMask(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox) As Object
        '  (###) ###-####
        'This module masks a social security number format ###-##-####
        'Char  123_45_6789
        'Len   01234567890
        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        'Check to see if control should be cleared
        If pKey = KEY_BACKSPACE And pcText.SelectionLength = vLength Then
            'Clear control and exit
            pcText.Text = ""
            Exit Function
        End If

        'Check for backspace.
        'If the backspace is on the fifth or
        'eighth character, then allow the backspace
        'plus one additional to remove the '-' character
        If pKey = KEY_BACKSPACE And vLength = 4 Then
            pcText.Text = Left(pcText.Text, 2)
            pcText.SelectionStart() = Len(pcText.Text)
            SSNMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 7 Then
            pcText.Text = Left(pcText.Text, 5)
            pcText.SelectionStart() = Len(pcText.Text)
            SSNMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            SSNMask = pKey
            Exit Function
        End If


        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                SSNMask = 0
                Exit Function
            End If
        End If

        'Check the first character for a number
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText
                pcText.SelectionStart() = Len(pcText.Text)
                SSNMask = 0
                Exit Function
            End If
        End If

        'Check the second character for 0-9
        If vLength = 1 Then
            If pKey >= 48 And pKey <= 57 Then
                SSNMask = pKey
                Exit Function
            End If
        End If

        'Check the third character for 0-9
        'and default the '-' character
        If vLength = 2 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText & "-"
                pcText.SelectionStart() = Len(pcText.Text)
                SSNMask = 0
                Exit Function
            End If
        End If

        'Check the fourth character for 0-9
        If vLength = 4 Then
            If pKey >= 48 And pKey <= 57 Then
                SSNMask = pKey
                Exit Function
            End If
        End If

        'Check the fifth character for 0-9
        'and default the '-' character
        If vLength = 5 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText & "-"
                pcText.SelectionStart() = Len(pcText.Text)
                SSNMask = 0
                Exit Function
            End If
        End If

        'Check characters 6,7,8,9 for 0-9
        If vLength = 7 Or vLength = 8 Or vLength = 9 Or vLength = 10 Then
            If pKey >= 48 And pKey <= 57 Then
                SSNMask = pKey
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        SSNMask = 0
        Exit Function

    End Function

    Sub DefaultTime(ByRef pcText As System.Windows.Forms.TextBox, Optional ByRef pvTimeZone As Object = Nothing)

        Dim vTime As String = ""

        'Only default if the time is blank
        If pcText.Text = "" Then

            vTime = VB6.Format(TimeOfDay, "hh:mm")

            'Add time zone designator
            If Not IsNothing(pvTimeZone) Then
                pcText.SelectedText() = vTime & " " + pvTimeZone
            End If

        End If

    End Sub

    Public Function NumMask(ByVal pKey As Short, ByVal pDigits As Short, ByRef pcText As System.Windows.Forms.TextBox) As Object

        'This module masks a number format for as based on the
        'number of digits parameter

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)


        'Check for backspace
        If pKey = KEY_BACKSPACE Then 'Allowed
            NumMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed
            If Trim(pcText.Text) = "" Then
                NumMask = 0
                Exit Function
            End If
        End If

        'Check the character for a number
        If vNewLength <= pDigits Then
            If pKey < 48 Or pKey > 57 Then
                NumMask = 0
                Exit Function
            Else
                pcText.Text = vNewText
                pcText.SelectionStart() = Len(pcText.Text)
                NumMask = 0
                Exit Function
            End If
        End If

    End Function

    Public Function DecimalMask(ByVal pKey As Short, ByVal pDigits As Short, ByVal pScale As Short, ByRef pcText As System.Windows.Forms.TextBox) As Object
        'drh FSMod 06/16/03 - New Function

        'This module masks a decimal format for as based on the
        'number of digits parameter

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)


        'Check for backspace
        If pKey = KEY_BACKSPACE Then 'Allowed
            DecimalMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed
            If Trim(pcText.Text) = "" Then
                DecimalMask = 0
                Exit Function
            End If
        End If

        'Check the character for a number
        If vNewLength <= pDigits Then
            If pKey > 47 And pKey < 58 Then
                If InStr(1, pcText.Text, Chr(46)) > 0 And Len(Right(pcText.Text, Len(pcText.Text) - InStr(1, pcText.Text, Chr(46)))) + 1 > pScale Then
                    DecimalMask = 0
                    Exit Function
                Else
                    pcText.Text = vNewText
                    pcText.SelectionStart() = Len(pcText.Text)
                    DecimalMask = 0
                    Exit Function
                End If

            ElseIf pKey = 46 Then  'drh FSMod 06/16/03 - Check if it's a decimal point
                If InStr(1, pcText.Text, Chr(pKey)) > 0 Then
                    DecimalMask = 0
                    Exit Function
                Else
                    pcText.Text = vNewText
                    pcText.SelectionStart() = Len(pcText.Text)
                    DecimalMask = 0
                    Exit Function
                End If

            Else
                DecimalMask = 0
                Exit Function
            End If
        End If

    End Function

    Public Function DateMask_LY(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing, Optional ByVal pAnyDate As Object = Nothing) As Object
        '02/05/03 drh - New Function: Modified DateMask to add checks for valid number of days
        'in month, including leap year checks

        'This module validates the date format ##/##/##.

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        If IsNothing(pAnyDate) Then
            pAnyDate = False
        End If

        'Check for backspace.
        'If the backspace is on the third or
        'sixth character, then allow the backspace
        'plus one additional to remove the '/'
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask_LY = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask_LY = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            DateMask_LY = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                DateMask_LY = 0
                Exit Function
            End If
        End If

        'Check the first character for 0 or 1
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 49 Then
                DateMask_LY = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 then
        'check the second character for 1 - 9 or
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask_LY = 0
                    Exit Function
                End If
            End If
        End If

        'if the first character is a 1 then
        'check the second character for 0, 1, or 2.
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 50 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask_LY = 0
                    Exit Function
                End If
            End If
        End If

        'Check the fourth character for 0, 1, 2, or 3
        If vLength = 3 Then
            '02/05/03 drh - If month is Feb., only allow 0, 1, or 2
            If (Mid(pcText.Text, 1, 1) = "/" Or Mid(pcText.Text, 2, 1) = "/") Then
                DateMask_LY = pKey
                Exit Function
            End If
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 1, 1), 0) _
                AndAlso DoubleTryParseAndCompare(Mid(pcText.Text, 2, 1), 2)) Then
                If pKey >= 48 And pKey <= 50 Then
                    DateMask_LY = pKey
                    Exit Function
                End If
            Else
                If pKey >= 48 And pKey <= 51 Then
                    DateMask_LY = pKey
                    Exit Function
                End If
            End If
        End If

        'if the fourth character is a 0 then
        'check for 1 - 9 for fifth character.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask_LY = 0
                    Exit Function
                End If
            End If
        End If

        'if the fourth character is a 1 or 2 then
        'check for 0 - 9 for fifth character.  If
        'the fourth character is a 3 then
        'check for 0 - 1 for fifth character.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            '02/05/03 drh - Combine two If stmts
            Select Case Mid(pcText.Text, 4, 1)
                Case CStr(1), CStr(2)
                    If pKey >= 48 And pKey <= 57 Then
                        pcText.Text = vNewText & "/"
                        pcText.SelectionStart() = Len(pcText.Text)
                        DateMask_LY = 0
                        Exit Function
                    End If
                Case CStr(3)
                    Select Case CShort(CStr(Mid(pcText.Text, 1, 1)) & CStr(Mid(pcText.Text, 2, 1)))
                        Case 4, 6, 9, 11
                            'Months with 30 days
                            If pKey = 48 Then
                                pcText.Text = vNewText & "/"
                                pcText.SelectionStart() = Len(pcText.Text)
                                DateMask_LY = 0
                                Exit Function
                            End If
                        Case Else
                            'Months with 31 days
                            If pKey >= 48 And pKey <= 49 Then
                                pcText.Text = vNewText & "/"
                                pcText.SelectionStart() = Len(pcText.Text)
                                DateMask_LY = 0
                                Exit Function
                            End If
                    End Select
            End Select
        End If

        'Check the seventh character
        If vLength = 6 Then
            If pAnyDate Then
                'Check character for 0 - 9
                If pKey >= 48 And pKey <= 57 Then
                    DateMask_LY = pKey
                    Exit Function
                End If
            Else
                'Check character for 0 or 9
                'ccarroll 12/30/2009 - changed date range for > 2009
                If pKey >= 48 And pKey <= 57 Then
                    DateMask_LY = pKey
                    Exit Function
                End If
            End If
        End If

        'Check the eighth character for 0 - 9
        Dim num As Short
        Dim I As Short
        If vLength = 7 Then
            If pKey >= 48 And pKey <= 57 Then
                '02/05/03 drh - If Feb. 29th, check for leap year
                '02/21/03 drh - Bug Fix: Added Mid$(pcText.Text, 1, 1) = 0 to the If stmt. so 12/29/02 is 
                If Not IsNumeric(Mid(pcText.Text, 1, 1)) Or Not IsNumeric(Mid(pcText.Text, 2, 1)) Or Not IsNumeric(Mid(pcText.Text, 4, 1)) Or Not IsNumeric(Mid(pcText.Text, 5, 1)) Then
                    '07/27/10 bret check for "/" to allow modifying dates. 
                    If (Mid(pcText.Text, 3, 1) = "/" Or Mid(pcText.Text, 5, 1) = "/") Then
                        DateMask_LY = pKey
                        Exit Function
                    End If
                    DateMask_LY = 1
                    Exit Function
                End If
                If (DoubleTryParseAndCompare(Mid(pcText.Text, 1, 1), 0) _
                    AndAlso DoubleTryParseAndCompare(Mid(pcText.Text, 2, 1), 2) _
                    AndAlso DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 2) _
                    AndAlso DoubleTryParseAndCompare(Mid(pcText.Text, 5, 1), 9)) Then
                    I = 0
                    num = CShort(CStr(Mid(pcText.Text, 7, 1)) & CStr(pKey - 48))
                    Do While I < (num + 1)
                        If num = I Then
                            DateMask_LY = pKey
                            Exit Function
                        End If

                        I = I + 4
                    Loop

                    Call MsgBox("Feb. only has 28 days, except in leap years.  Leap years occur every four years (ie. 1996, 2000, 2004, etc...)", MsgBoxStyle.OkOnly, "Invalid Date")
                    DateMask_LY = 0
                    Exit Function
                Else
                    DateMask_LY = pKey
                    Exit Function
                End If
            End If
        End If

        'Check if there is a maximum
        If Not IsNothing(pMax) Then
            'Test against maximum
            If Not IsDBNull(pMax) And CObj(vNewText) > pMax Then
                DateMask_LY = 0
                Exit Function
            End If
        End If

        'Check if there is a minium
        If Not IsNothing(pMin) Then
            'Test against minimum
            If Not IsDBNull(pMin) And CObj(vNewText) < pMin Then
                DateMask_LY = 0
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        DateMask_LY = 0
        Exit Function

    End Function
    Public Function DateMask(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing, Optional ByVal pAnyDate As Object = Nothing) As Object

        'This module validates the date format ##/##/##.

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        If IsNothing(pAnyDate) Then
            pAnyDate = False
        End If

        'Check for backspace.
        'If the backspace is on the third or
        'sixth character, then allow the backspace
        'plus one additional to remove the '/'
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            DateMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                DateMask = 0
                Exit Function
            End If
        End If

        'Check the first character for 0 or 1
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 49 Then
                DateMask = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 then
        'check the second character for 1 - 9 or
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask = 0
                    Exit Function
                End If
            End If
        End If

        'if the first character is a 1 then
        'check the second character for 0, 1, or 2.
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 50 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask = 0
                    Exit Function
                End If
            End If
        End If

        'Check the fourth character for 0, 1, 2, or 3
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 51 Then
                DateMask = pKey
                Exit Function
            End If
        End If

        'if the fifth character is a 0 then
        'check for 1 - 9.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask = 0
                    Exit Function
                End If
            End If
        End If

        'if the fifth character is a 1 or 2 then
        'check for 0 - 9.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 1) Or DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 2)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask = 0
                    Exit Function
                End If
            End If
        End If



        'If the fifth character is a 3 then
        'check for 0 or 1.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 3)) Then
                If pKey >= 48 And pKey <= 49 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask = 0
                    Exit Function
                End If
            End If
        End If


        'Check the seventh character
        If vLength = 6 Then
            If pAnyDate Then
                'Check character for 0 - 9
                If pKey >= 48 And pKey <= 57 Then
                    DateMask = pKey
                    Exit Function
                End If
            Else
                'Check character for 0 or 9
                If pKey >= 48 And pKey <= 57 Then
                    DateMask = pKey
                    Exit Function
                End If
            End If
        End If

        'Check the seventh character for 0 - 9
        If vLength = 7 Then
            If pKey >= 48 And pKey <= 57 Then
                DateMask = pKey
                Exit Function
            End If
        End If

        'Check if there is a maximum
        If Not IsNothing(pMax) Then
            'Test against maximum
            If Not IsDBNull(pMax) And CObj(vNewText) > pMax Then
                DateMask = 0
                Exit Function
            End If
        End If

        'Check if there is a minium
        If Not IsNothing(pMin) Then
            'Test against minimum
            If Not IsDBNull(pMin) And CObj(vNewText) < pMin Then
                DateMask = 0
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        DateMask = 0
        Exit Function

    End Function
    Public Function DateMask2000(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing) As Object

        'This module validates the date format ##/##/##.

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)


        'Check for backspace.
        'If the backspace is on the third or
        'sixth character, then allow the backspace
        'plus one additional to remove the '/'
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask2000 = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            DateMask2000 = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            DateMask2000 = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                DateMask2000 = 0
                Exit Function
            End If
        End If

        'Check the first character for 0 or 1
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 49 Then
                DateMask2000 = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 then
        'check the second character for 1 - 9 or
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask2000 = 0
                    Exit Function
                End If
            End If
        End If

        'if the first character is a 1 then
        'check the second character for 0, 1, or 2.
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 50 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask2000 = 0
                    Exit Function
                End If
            End If
        End If

        'Check the fourth character for 0, 1, 2, or 3
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 51 Then
                DateMask2000 = pKey
                Exit Function
            End If
        End If

        'if the fifth character is a 0 then
        'check for 1 - 9.
        'Default the '/' character after the sixth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/19"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask2000 = 0
                    Exit Function
                End If
            End If
        End If

        'if the fifth character is a 1 or 2 then
        'check for 0 - 9.
        'Default the '/' character after the sixth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 1) Or DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 2)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & "/19"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask2000 = 0
                    Exit Function
                End If
            End If
        End If

        'If the fifth character is a 3 then
        'check for 0 or 1.
        'Default the '/' character after the sixth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 3)) Then
                If pKey >= 48 And pKey <= 49 Then
                    pcText.Text = vNewText & "/19"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateMask2000 = 0
                    Exit Function
                End If
            End If
        End If


        'Check the seventh character
        If vLength = 6 Then
            'Check character for 1 or 2
            If pKey >= 49 And pKey <= 50 Then
                DateMask2000 = pKey
                Exit Function
            End If
        End If

        'If the seventh character is a 1 then
        'allow only 9 or 8 for the eighth character
        If vLength = 7 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 7, 1), 1)) Then
                If pKey = 56 Or pKey = 57 Then
                    DateMask2000 = pKey
                    Exit Function
                End If
            End If
        End If

        'If the seventh character is a 2 then
        'allow only 0 for the eighth character
        If vLength = 7 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 7, 1), 2)) Then
                If pKey = 48 Then
                    DateMask2000 = pKey
                    Exit Function
                End If
            End If
        End If

        'Check the ninth character for 0 - 9
        If vLength = 8 Then
            If pKey >= 48 And pKey <= 57 Then
                DateMask2000 = pKey
                Exit Function
            End If
        End If

        'Check the tenth character for 0 - 9
        If vLength = 9 Then
            If pKey >= 48 And pKey <= 57 Then
                DateMask2000 = pKey
                Exit Function
            End If
        End If

        'Check if there is a maximum
        If Not IsNothing(pMax) Then
            'Test against maximum
            If Not IsDBNull(pMax) And CObj(vNewText) > pMax Then
                DateMask2000 = 0
                Exit Function
            End If
        End If

        'Check if there is a minium
        If Not IsNothing(pMin) Then
            'Test against minimum
            If Not IsDBNull(pMin) And CObj(vNewText) < pMin Then
                DateMask2000 = 0
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        DateMask2000 = 0
        Exit Function

    End Function


    Public Function DateTimeMask(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing) As Object

        'This module validates the date format   ##/##/##  ##:##

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        'Check to see if control should be cleared
        If pKey = KEY_BACKSPACE And pcText.SelectionLength = vLength Then
            'Clear control and exit
            pcText.Text = ""
            Exit Function
        End If

        'Check for backspace.
        'If the backspace is on the third or
        'sixth character, then allow the backspace
        'plus one additional to remove the '/'
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
            'Check for backspace.
            'If the backspace is on the tenth, or
            '13th character, then allow the backspace
            'plus one additional to remove either the two spaces, or
            'the ':'
        ElseIf pKey = KEY_BACKSPACE And vLength = 10 Then
            pcText.Text = Left(pcText.Text, 7)
            pcText.SelectionStart() = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 13 Then
            pcText.Text = Left(pcText.Text, 11)
            pcText.SelectionStart() = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE Then
            DateTimeMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                DateTimeMask = 0
                Exit Function
            End If
        End If

        '***********************************************************
        'Date Section
        '***********************************************************

        'Check the first character for 0 or 1
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 49 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 then
        'check the second character for 1 - 9 or
        'Default the '/' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
                'if the first character is a 1 then
                'check the second character for 0, 1, or 2.
                'Default the '/' character after the second
                'character.
            ElseIf (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 50 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
            End If
        End If


        'Check the fifth character for 0, 1, 2, or 3
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 51 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'if the fifth character is a 0 then
        'check the sixth for 1 - 9.
        'Default the '/' character after the fifth
        'character.
        If vLength = 4 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 0)) Then
                If pKey >= 49 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
                'if the fifth character is a 1 or 2 then
                'check the sixth for 0 - 9.
                'Default the '/' character after the fifth
                'character.
            ElseIf (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 1) Or DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 2)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
                'If the fifth character is a 3 then
                'check the sixth for 0 or 1.
                'Default the '/' character after the fifth
                'character.
            ElseIf (DoubleTryParseAndCompare(Mid(pcText.Text, 4, 1), 3)) Then
                If pKey >= 48 And pKey <= 49 Then
                    pcText.Text = vNewText & "/"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
            End If
        End If

        'Check the seventh character for 0 or 9
        '
        If vLength = 6 Then
            If pKey >= 48 And pKey <= 57 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'If the seventh character is a 9 then
        'check for 5 - 9.
        'Default the two spaces after the eighth
        'character.
        If vLength = 7 Then
            If (DoubleTryParseAndCompare(Mid(pcText.Text, 7, 1), 9)) Then
                If pKey >= 53 And pKey <= 57 Then
                    pcText.Text = vNewText & "  "
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
                'If the seventh character is a 0 then
                'check for 0 - 9.
                'Default the two spaces after the eighth
                'character.
            ElseIf (DoubleTryParseAndCompare(Mid(pcText.Text, 7, 1), 0, CompareOperationEnum.GreaterOrEqual) _
                Or DoubleTryParseAndCompare(Mid(pcText.Text, 7, 1), 9, CompareOperationEnum.LessOrEqual)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & "  "
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
            End If
        End If




        '***********************************************************
        'Time Section
        '***********************************************************

        'Check the first character for 0, 1, or 2
        If vLength = 10 Then
            If pKey >= 48 And pKey <= 50 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 or 1 then
        'check the second character for 0 - 9.
        'Default the ':' character after the second
        'character.
        If vLength = 11 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Or (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
                'if the first character is a 2 then
                'check the second character for 0-3.
                'Default the ':' character after the second
                'character.
            ElseIf (DoubleTryParseAndCompare(Left(pcText.Text, 1), 2)) Then
                If pKey >= 48 And pKey <= 51 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    DateTimeMask = 0
                    Exit Function
                End If
            End If
        End If


        'Check the fourth character for 0-5
        If vLength = 13 Then
            If pKey >= 48 And pKey <= 53 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'Check the fifth character for 0 - 9.
        If vLength = 14 Then
            If pKey >= 48 And pKey <= 57 Then
                DateTimeMask = pKey
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        DateTimeMask = 0
        Exit Function

    End Function

    Public Function TimeMask(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByRef vTimeZone As Object = Nothing, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing) As Object

        'This module validates the time format ##:## ?T.
        'Military time plus time zone.

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short
        Dim vFirstChar, vChar As String

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()

        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        'Check to see if control should be cleared
        If pKey = KEY_BACKSPACE And pcText.SelectionLength = vLength Then
            'Clear control and exit
            pcText.Text = ""
            Exit Function
        End If

        'Check for backspace.
        'If the backspace is on the third, sixth, or
        'eight character, then allow the backspace
        'plus one additional to remove the ':' or space
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            TimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            TimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 8 Then
            If IsNothing(vTimeZone) Then
                pcText.Text = Left(pcText.Text, 6)
                pcText.SelectionStart() = Len(pcText.Text)
                TimeMask = 0
                Exit Function
            Else
                pcText.Text = Left(pcText.Text, 4)
                pcText.SelectionStart() = Len(pcText.Text)
                TimeMask = 0
                Exit Function
            End If
        ElseIf pKey = KEY_BACKSPACE Then
            TimeMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                TimeMask = 0
                Exit Function
            End If
        End If


        'Check the first character for 0, 1, or 2
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 50 Then
                TimeMask = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 or 1 then
        'check the second character for 0 - 9.
        'Default the ':' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Or (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    TimeMask = 0
                    Exit Function
                End If
            End If
        End If

        'if the first character is a 2 then
        'check the second character for 0-3.
        'Default the ':' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 2)) Then
                If pKey >= 48 And pKey <= 51 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    TimeMask = 0
                    Exit Function
                End If
            End If
        End If

        'Check the fourth character for 0-5
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 53 Then
                TimeMask = pKey
                Exit Function
            End If
        End If

        'Check the fifth character for 0 - 9.
        'Default a space character after the fifth
        'character.
        If vLength = 4 Then
            If pKey >= 48 And pKey <= 57 Then
                If IsNothing(vTimeZone) Then
                    pcText.Text = vNewText & " "
                    pcText.SelectionStart() = Len(pcText.Text)
                    TimeMask = 0
                    Exit Function
                Else
                    pcText.Text = vNewText & " " & vTimeZone
                    pcText.SelectionStart() = Len(pcText.Text)
                    TimeMask = 0
                    Exit Function
                End If
            End If
        End If

        If IsNothing(vTimeZone) Then
            'Check the seventh character a legitamite time zone
            'Default a 'T' character after the sixth
            'character.
            If vLength = 6 Then
                'Convert to capital letter
                pKey = Asc(UCase(Chr(pKey)))
                'Check zone for 'E' or 'e'astern, 'C' or 'c'entral,
                ''M' or 'm'ountain, 'P' or 'p'acific
                If (pKey = 69 Or pKey = 67 Or pKey = 77 Or pKey = 80 Or pKey = 99 Or pKey = 101 Or pKey = 109 Or pKey = 112) Then
                    pcText.Text = UCase(vNewText) & "T"
                    pcText.SelectionStart() = Len(pcText.Text)
                    TimeMask = 0
                    Exit Function
                End If
            End If
        End If


        'Check if there is a maximum
        If Not IsNothing(pMax) Then
            'Test against maximum
            If Not IsDBNull(pMax) And CObj(vNewText) > pMax Then
                TimeMask = 0
                Exit Function
            End If
        End If

        'Check if there is a minimum
        If Not IsNothing(pMin) Then
            'Test against minimum
            If Not IsDBNull(pMin) And CObj(vNewText) < pMin Then
                TimeMask = 0
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the
        'conditions above.
        Beep()
        TimeMask = 0
        Exit Function

    End Function

    Public Function DateTimeColumn(ByRef pvGridList As Object, ByRef pvGridColumn As Short, Optional ByRef pvFormat As Object = Nothing) As Object

        'drh 12/16/03 - Changed to a Long
        Dim I As Integer

        If IsNothing(pvFormat) Then
            For I = 0 To UBound(pvGridList, 1)
                pvGridList(I, pvGridColumn) = VB6.Format(pvGridList(I, pvGridColumn), "mm/dd/yy    hh:mm")
            Next I
        Else
            For I = 0 To UBound(pvGridList, 1)
                pvGridList(I, pvGridColumn) = VB6.Format(pvGridList(I, pvGridColumn), pvFormat)
            Next I
        End If

    End Function

    Public Function DateColumn2000(ByRef pvGridList As Object, ByRef pvGridColumn As Short) As Object

        Dim I As Short

        For I = 0 To UBound(pvGridList, 1)
            pvGridList(I, pvGridColumn) = VB6.Format(pvGridList(I, pvGridColumn), "mm/dd/yyyy")
        Next I

    End Function


    Public Function TimeColumn(ByRef pvGridList As Object, ByRef pvGridColumn As Short) As Object

        Dim I As Short

        For I = 0 To UBound(pvGridList, 1)
            pvGridList(I, pvGridColumn) = VB6.Format(pvGridList(I, pvGridColumn), "hh:mm")
        Next I

    End Function

    Public Function MilitaryTimeMask(ByVal pKey As Short, ByRef pcText As System.Windows.Forms.TextBox, Optional ByRef vTimeZone As Object = Nothing, Optional ByVal pMax As Object = Nothing, Optional ByVal pMin As Object = Nothing) As Object
        'Added 07/2001: BJK
        'vTimeZone, pMax and pMin are not used

        'This module validates the time format ##:## ?T.
        'Military time plus time zone.

        Dim vText, vNewText As String
        Dim vSelLength, vLength, vSelStart, vNewLength As Short
        Dim vFirstChar, vChar As String

        'Get information
        vText = pcText.Text
        vLength = Len(vText)
        vSelStart = pcText.SelectionStart()
        vSelLength = pcText.SelectionLength
        vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
        vNewLength = Len(vNewText)

        'Check to see if control should be cleared
        If pKey = KEY_BACKSPACE And pcText.SelectionLength = vLength Then
            'Clear control and exit
            pcText.Text = ""
            Exit Function
        End If

        'Check for backspace.
        'If the backspace is on the third, sixth, or
        'eight character, then allow the backspace
        'plus one additional to remove the ':' or space
        'character
        If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelectionStart() = Len(pcText.Text)
            MilitaryTimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelectionStart() = Len(pcText.Text)
            MilitaryTimeMask = 0
            Exit Function
        ElseIf pKey = KEY_BACKSPACE And vLength = 8 Then
            If IsNothing(vTimeZone) Then
                pcText.Text = Left(pcText.Text, 6)
                pcText.SelectionStart() = Len(pcText.Text)
                MilitaryTimeMask = 0
                Exit Function
            Else
                pcText.Text = Left(pcText.Text, 4)
                pcText.SelectionStart() = Len(pcText.Text)
                MilitaryTimeMask = 0
                Exit Function
            End If
        ElseIf pKey = KEY_BACKSPACE Then
            MilitaryTimeMask = pKey
            Exit Function
        End If

        'check for space
        If pKey = KEY_SPACE Then 'Not allowed alone
            If Trim(pcText.Text) = "" Then
                MilitaryTimeMask = 0
                Exit Function
            End If
        End If


        'Check the first character for 0, 1, or 2
        If vLength = 0 Then
            If pKey >= 48 And pKey <= 50 Then
                MilitaryTimeMask = pKey
                Exit Function
            End If
        End If

        'If the first character is a 0 or 1 then
        'check the second character for 0 - 9.
        'Default the ':' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 0)) Or (DoubleTryParseAndCompare(Left(pcText.Text, 1), 1)) Then
                If pKey >= 48 And pKey <= 57 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    MilitaryTimeMask = 0
                    Exit Function
                End If
            End If
        End If

        'if the first character is a 2 then
        'check the second character for 0-3.
        'Default the ':' character after the second
        'character.
        If vLength = 1 Then
            If (DoubleTryParseAndCompare(Left(pcText.Text, 1), 2)) Then
                If pKey >= 48 And pKey <= 51 Then
                    pcText.Text = vNewText & ":"
                    pcText.SelectionStart() = Len(pcText.Text)
                    MilitaryTimeMask = 0
                    Exit Function
                End If
            End If
        End If

        'Check the fourth character for 0-5
        If vLength = 3 Then
            If pKey >= 48 And pKey <= 53 Then
                MilitaryTimeMask = pKey
                Exit Function
            End If
        End If

        'Check the fifth character for 0 - 9.
        'Default a space character after the fifth
        'character.
        If vLength = 4 Then
            If pKey >= 48 And pKey <= 57 Then
                MilitaryTimeMask = pKey
                Exit Function
            End If
        End If

        'Do not allow any keys that do not meet the

        'conditions above.
        Beep()
        MilitaryTimeMask = 0
        Exit Function


    End Function
End Module