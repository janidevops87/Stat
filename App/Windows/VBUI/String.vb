Option Strict Off
Option Explicit On
Module modString

	Public Function StripChars(ByRef strIn As String, ByRef strStrip As String) As String
		' Comments  : Removes the specified character from a string
		' Parameters: strIn - String to modify
		'             strStrip - Character(s) to remove
		' Returns   : Modified string
		' Source    : Total VB SourceBook 6
		'
		Dim lngCounter As Integer
        Dim strTmp As String = ""
        Dim chrTmp As New VB6.FixedLengthString(1)

        On Error Resume Next

        ' Walk through the string
        For lngCounter = 1 To Len(strIn)
            ' Get the current character
            chrTmp.Value = Mid(strIn, lngCounter)
            If chrTmp.Value <> strStrip Then
                ' It its not in the list of characters to remove, keep it
                strTmp = strTmp & chrTmp.Value
            End If
        Next lngCounter

        ' Return the value
        StripChars = strTmp

    End Function

    Function GetWords(ByVal pString As String, ByVal pSeparator As String, ByRef prWords() As String) As Short

        Const BUFF_INCREMENT As Short = 100
        Const IN_SPACE As Short = 0
        Const IN_WORD As Short = 1

        Dim vLeft, vWord, vState, vPosition As Short
        Dim vChar As String = ""

        vState = IN_SPACE
        vWord = 0

        'Initialize result array
        ReDim prWords(BUFF_INCREMENT)

        'Scan for words
        For vPosition = 1 To Len(pString)

            vChar = Mid(pString, vPosition, 1)

            If vState = IN_SPACE Then
                If vChar = pSeparator Then
                    vState = IN_SPACE
                Else
                    vState = IN_WORD
                    vLeft = vPosition
                    vWord = vWord + 1
                End If
            Else
                If vChar = pSeparator Then
                    vState = IN_SPACE
                    If UBound(prWords, 1) < vWord - 1 Then
                        ReDim Preserve prWords(UBound(prWords) + BUFF_INCREMENT)
                    End If
                    prWords(vWord - 1) = Mid(pString, vLeft, vPosition - vLeft)
                Else
                    vState = IN_WORD
                End If
            End If

        Next vPosition

        'Look for last word
        If vState = IN_WORD Then
            If UBound(prWords, 1) < vWord - 1 Then
                ReDim Preserve prWords(UBound(prWords) + 1)
            End If
            prWords(vWord - 1) = Mid(pString, vLeft, vPosition - vLeft)
        End If

        'Size result array
        ReDim Preserve prWords(vWord - 1)

        'Return number of works found
        GetWords = vWord

    End Function
	
	
	Function ReplaceSubString(ByVal pString As String, ByVal pOldSub As String, ByVal pNewSub As String) As String
		
		Dim I As Short
		
		I = InStr(1, pString, pOldSub, 0)
		While I > 0
			pString = Left(pString, I - 1) & pNewSub & Right(pString, Len(pString) - (I - 1 + Len(pOldSub)))
			I = InStr(I + Len(pNewSub), pString, pOldSub, 0)
		End While
		
		ReplaceSubString = pString
		
	End Function
End Module