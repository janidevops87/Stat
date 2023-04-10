Option Strict On
Option Explicit On
Option Infer On

Imports System.Runtime.CompilerServices
Imports Statline.Common.Utilities

Friend Module DataSourceInfoExtensions

    <Extension()>
    Public Function GetState(dataSourceInfo As DataSourceInfo) As String
        Check.NotNull(dataSourceInfo, NameOf(dataSourceInfo))

        Return If(dataSourceInfo.Name?.Contains("DLA"),
            Nothing,
            dataSourceInfo.DbName?.Replace("DMV_", ""))

    End Function

End Module
