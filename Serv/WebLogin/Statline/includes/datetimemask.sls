Function DateTimeMask(pKey, pcText)

KEY_BACKSPACE = 8
KEY_SPACE = 32
KEY_MINUS = 45
KEY_DECIMAL = 46
    
    'This module validates the date format   ##/##/##  ##:##
    
    Dim vText, vLength, vSelStart, vSelLength, vNewText, vNewLength

    'Get information
    vText = pcText.Text
    vLength = Len(vText)
    vSelStart = pcText.SelStart
    vSelLength = pcText.SelLength
    vNewText = Left(vText, vSelStart) & Chr(pKey) & Right(vText, vLength - vSelStart - vSelLength)
    vNewLength = Len(vNewText)
    
    'Check to see if control should be cleared
    If pKey = KEY_BACKSPACE And pcText.SelLength = vLength Then
        'Clear control and exit
        pcText = ""
        Exit Function
    End If
    
    'Check for backspace.
    'If the backspace is on the third or
    'sixth character, then allow the backspace
    'plus one additional to remove the '/'
    'character
    If pKey = KEY_BACKSPACE And vLength = 3 Then
            pcText.Text = Left(pcText.Text, 1)
            pcText.SelStart = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
    ElseIf pKey = KEY_BACKSPACE And vLength = 6 Then
            pcText.Text = Left(pcText.Text, 4)
            pcText.SelStart = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
    'Check for backspace.
    'If the backspace is on the tenth, or
    '13th character, then allow the backspace
    'plus one additional to remove either the two spaces, or
    'the ':'
    ElseIf pKey = KEY_BACKSPACE And vLength = 10 Then
            pcText.Text = Left(pcText.Text, 7)
            pcText.SelStart = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
    ElseIf pKey = KEY_BACKSPACE And vLength = 13 Then
            pcText.Text = Left(pcText.Text, 11)
            pcText.SelStart = Len(pcText.Text)
            DateTimeMask = 0
            Exit Function
    ElseIf pKey = KEY_BACKSPACE Then
            DateTimeMask = pKey
            Exit Function
    End If
    
    'check for space
    If pKey = KEY_SPACE Then          'Not allowed alone
        If RTrim(pcText.Text) = "" Then
            DateTimeMask = 0
            Exit Function
        End If
    End If
'694  
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
        If (Left(pcText.Text, 1) = 0) Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText + "/"
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If

    'if the first character is a 1 then
    'check the second character for 0, 1, or 2.
    'Default the '/' character after the second
    'character.
    If vLength = 1 Then
        If (Left(pcText.Text, 1) = 1) Then
            If pKey >= 48 And pKey <= 50 Then
                pcText.Text = vNewText + "/"
                pcText.SelStart = Len(pcText.Text)
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
        If Mid(pcText.Text, 4, 1) = 0 Then
            If pKey >= 49 And pKey <= 57 Then
                pcText.Text = vNewText + "/"
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If
    
    'if the fifth character is a 1 or 2 then
    'check the sixth for 0 - 9.
    'Default the '/' character after the fifth
    'character.
    If vLength = 4 Then
        If Mid(pcText.Text, 4, 1) = 1 _
        Or Mid(pcText.Text, 4, 1) = 2 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText + "/"
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If

    'If the fifth character is a 3 then
    'check the sixth for 0 or 1.
    'Default the '/' character after the fifth
    'character.
    If vLength = 4 Then
        If Mid(pcText.Text, 4, 1) = 3 Then
            If pKey >= 48 And pKey <= 49 Then
                pcText.Text = vNewText + "/"
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If
    
    'Check the seventh character for 0 or 9
    If vLength = 6 Then
        If pKey = 48 Or pKey = 57 Then
            DateTimeMask = pKey
            Exit Function
        End If
    End If
    
    'If the seventh character is a 9 then
    'check for 5 - 9.
    'Default the two spaces after the eighth
    'character.
    If vLength = 7 Then
        If Mid(pcText.Text, 7, 1) = 9 Then
            If pKey >= 53 And pKey <= 57 Then
                pcText.Text = vNewText + "  "
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If

    'If the seventh character is a 0 then
    'check for 0 - 9.
    'Default the two spaces after the eighth
    'character.
    If vLength = 7 Then
        If Mid(pcText.Text, 7, 1) = 0 Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText + "  "
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If
    
    
'830  
    
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
        If (Left(pcText.Text, 1) = 0) _
        Or (Left(pcText.Text, 1) = 1) Then
            If pKey >= 48 And pKey <= 57 Then
                pcText.Text = vNewText + ":"
                pcText.SelStart = Len(pcText.Text)
                DateTimeMask = 0
                Exit Function
            End If
        End If
    End If

    'if the first character is a 2 then
    'check the second character for 0-3.
    'Default the ':' character after the second
    'character.
    If vLength = 11 Then
        If (Left(pcText.Text, 1) = 2) Then
            If pKey >= 48 And pKey <= 51 Then
                pcText.Text = vNewText + ":"
                pcText.SelStart = Len(pcText.Text)
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
    DateTimeMask = 0
    Exit Function

'897
End Function

