Option Strict Off
Option Explicit On
Module modLogon
	'Bret 1/06/10 add Option explicit for upgrade
	
	'drh 09/23/03 - Integrated Logon: New Module
	
	'drh 09/23/03 - Integrated Logon: Declare the Win32 functions/constant
	Public Declare Function GetUserName Lib "advapi32"  Alias "GetUserNameA"(ByVal lpBuffer As String, ByRef nSize As Integer) As Integer
	
	Private Const MAX_USERNAME As Integer = 15
	
	Public Function GetThreadUserName() As String
		
		'drh 09/23/03 - Integrated Logon: Retrieves the user name of the current thread. This is the name of the user
		'currently logged onto the system. If the current thread is impersonating
		'another client, GetUserName returns the user name of the client that the
		'thread is impersonating.
		
        Dim buff As String = ""
        Dim nSize As Integer

        buff = Space(MAX_USERNAME)
        nSize = Len(buff)

        If GetUserName(buff, nSize) = 1 Then

            GetThreadUserName = TrimNull(buff)
            Exit Function

        End If

    End Function


    Public Function TrimNull(ByRef startstr As String) As String
        'bret 01/08/10 Left$(startstr, lstrlenW(StrPtr(startstr)))
        'replace statement to remove the StrPtr function

        TrimNull = Left(startstr, Len(Trim(startstr)) - 1)

    End Function
End Module