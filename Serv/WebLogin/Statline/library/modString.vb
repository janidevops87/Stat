Module modString
    Function ReplaceSubString$(ByVal pString$, ByVal pOldSub$, ByVal pNewSub$)

        Dim i%

        i = InStr(1, pString$, pOldSub$, 0)
        While i > 0
            pString$ = Left$(pString$, i - 1) & pNewSub$ & Right$(pString$, Len(pString$) - (i - 1 + Len(pOldSub$)))
            i = InStr(i + Len(pNewSub$), pString$, pOldSub$, 0)
        End While

        ReplaceSubString$ = pString$

    End Function
End Module
