Option Strict On
Option Explicit On
Option Infer On

Imports System.Collections.Generic
Imports System.Runtime.CompilerServices

Public Module AdoDbRecordsetExtensions
    <Extension()>
    Public Iterator Function ToEnumerable(Of TItem)(
        recordset As Recordset,
        itemSelector As Func(Of Fields, TItem)) As IEnumerable(Of TItem)

        If recordset Is Nothing Then
            Throw New ArgumentNullException(NameOf(recordset))
        End If

        If recordset.State = ObjectStateEnum.adStateClosed OrElse
           recordset.RecordCount = 0 Then
            Exit Function
        End If

        'Reset from any previous enumerations.
        recordset.MoveFirst()

        Do While Not recordset.EOF
            Yield itemSelector(recordset.Fields)
            recordset.MoveNext()
        Loop
    End Function

End Module
