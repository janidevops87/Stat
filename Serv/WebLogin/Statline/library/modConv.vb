Module modConv
    Function DblToText$(ByVal pDbl#)

        If pDbl = 0 Then
            DblToText$ = "0"
        Else
            DblToText$ = LTrim$(Str(pDbl))
        End If

    End Function

    Function TextToLng&(ByVal pText)

        On Error GoTo TextToLngEH

        TextToLng = CLng(pText)
        Exit Function

TextToLngEH:

        TextToLng = 0
        Exit Function

    End Function

    Public Function DBNullToText$(ByVal pvValue)

        On Error GoTo localError

        If IsDBNull(pvValue) Then
            DBNullToText = ""
        Else
            DBNullToText = pvValue
        End If

        Exit Function

localError:

        DBNullToText = ""

    End Function

    Function DBNullToLng&(ByVal pvValue)

        On Error GoTo DBNullToLngEH

        If IsDBNull(pvValue) Then
            DBNullToLng = 0
        Else
            DBNullToLng = pvValue
        End If

        Exit Function

DBNullToLngEH:

        DBNullToLng = 0
        Exit Function

    End Function
End Module
