Option Strict Off
Option Explicit On
Friend Class CInternetHTTP
	'Bret 1/06/10 add Option explicit for upgrade
	
	' Class       : CInternetHTTP
	' Description : This class offers code for working with HTTP connections,
	'               data, and sessions.
	' Source      : Total VB SourceBook 6
	
	' Property variables to maintain handles. Handles are hierarchical
	' as shown in the following comments:
	' m_lngSessionHandle    - handle to the WinINET DLL
	' m_lngConnectionHandle - handle to the session open
	'                                 through m_lngSessionHandle
	' m_lngHTTPRequestHandle        - handle to an HTTP request open
	'                                 through m_lngConnectionHandle
	Private m_lngSessionHandle As Integer
	Private m_lngConnectionHandle As Integer
	Private m_lngHTTPRequestHandle As Integer
	
	' Define the HTTP connection's user agent
	Private m_strUserAgent As String
	
	' Class variable to maintain the HitCacheFirst property
	Private m_fHitCacheFirst As Boolean
	
	' Private class variables to store the query properties
	Private m_strQContentType As String
	Private m_strQContentLength As String
	Private m_strQExpires As String
	Private m_strQLastModified As String
	Private m_strQPragma As String
	Private m_strQVersion As String
	Private m_strQStatusCode As String
	Private m_strQStatusText As String
	Private m_strQRequestHeaders As String
	Private m_strQRequestHeaders2 As String
	Private m_strQForwarded As String
	Private m_strQServer As String
	Private m_strQUserAgent As String
	Private m_strQSetCookie As String
	
	' Type to hold the version number of WinInet.DLL. Used when passing the
	' INTERNET_OPTION_VERSION flag to InternetQueryOption().
	Private Structure DLLVersion
		Dim lngMajorVersion As Integer
		Dim lngMinorVersion As Integer
	End Structure	
	
	' Open the connection to WinInet.DLL
	Private Declare Function InternetOpen Lib "wininet.dll"  Alias "InternetOpenA"(ByVal strAgent As String, ByVal lngAccessType As Integer, ByVal strProxyName As String, ByVal strProxyBypass As String, ByVal lngFlags As Integer) As Integer
	
	' Open an HTTP session
	Private Declare Function InternetConnect Lib "wininet.dll"  Alias "InternetConnectA"(ByVal lnghInternetSession As Integer, ByVal strServerName As String, ByVal intServerPort As Short, ByVal strUsername As String, ByVal strPassword As String, ByVal lngService As Integer, ByVal lngFlags As Integer, ByVal lngContext As Integer) As Integer
	
	' Open an HTTP request handle
	Private Declare Function HttpOpenRequest Lib "wininet.dll"  Alias "HttpOpenRequestA"(ByVal lnghHttpSession As Integer, ByVal strVerb As String, ByVal strObjectName As String, ByVal strVersion As String, ByVal strReferer As String, ByVal lngOther As Integer, ByVal lngFlags As Integer, ByVal lngContext As Integer) As Integer
	
	' Send a request to the HTTP server
	Private Declare Function HttpSendRequest Lib "wininet.dll" Alias "HttpSendRequestA" (ByVal lnghHttpRequest As Integer, ByVal strHeaders As String, ByVal lngHeadersLength As Integer, ByRef sOptional As Object, ByVal lngOptionalLength As Integer) As Short

    ' Queries for information about an HTTP request
    Private Declare Function HttpQueryInfo Lib "wininet.dll" Alias "HttpQueryInfoA" (ByVal lnghHttpRequest As Integer, ByVal lngInfoLevel As Integer, ByRef strBuffer As Object, ByRef lngBufferLength As Integer, ByRef lngIndex As Integer) As Short
	
	' Reads data from a handle opened by the HttpOpenRequest function
	Private Declare Function InternetReadFile Lib "wininet.dll" (ByVal lnghFile As Integer, ByVal strBuffer As String, ByVal lngNumBytesToRead As Integer, ByRef lngNumberOfBytesRead As Integer) As Short
	
	' Closes a single Internet handle or a subtree of Internet handles
	Private Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal lnghInet As Integer) As Short
	
	' Queries an Internet option on the specified handle
	Private Declare Function InternetQueryOption Lib "wininet.dll" Alias "InternetQueryOptionA" (ByVal lnghInternet As Integer, ByVal lngOption As Integer, ByRef strBuffer As Object, ByRef lngBufferLength As Integer) As Short
	' Constants for sending HTTP queries
	Private Const HTTP_QUERY_CONTENT_TYPE As Integer = 1
	Private Const HTTP_QUERY_CONTENT_LENGTH As Integer = 5
	Private Const HTTP_QUERY_EXPIRES As Integer = 10
	Private Const HTTP_QUERY_LAST_MODIFIED As Integer = 11
	Private Const HTTP_QUERY_PRAGMA As Integer = 17
	Private Const HTTP_QUERY_VERSION As Integer = 18
	Private Const HTTP_QUERY_STATUS_CODE As Integer = 19
	Private Const HTTP_QUERY_STATUS_TEXT As Integer = 20
	Private Const HTTP_QUERY_RAW_HEADERS As Integer = 21
	Private Const HTTP_QUERY_RAW_HEADERS_CRLF As Integer = 22
	Private Const HTTP_QUERY_FORWARDED As Integer = 30
	Private Const HTTP_QUERY_SERVER As Integer = 37
	Private Const HTTP_QUERY_USER_AGENT As Integer = 39
	Private Const HTTP_QUERY_SET_COOKIE As Integer = 43
	Private Const HTTP_QUERY_REQUEST_METHOD As Integer = 45
	
	' Add this to get the request flag
	Private Const HTTP_QUERY_FLAG_REQUEST_HEADERS As Integer = &H80000000
	
	' The following two values are the options for the HTTP request.
	' GET means we want to retrieve data from the server, POST
	' means we want to send data to the server
	Private Const mcstrVerbGet As String = "GET"
	Private Const mcstrVerbPost As String = "POST"
	
	' Additional constants for use with the WININET.DLL HTTP functions
	Private Const HTTP_ADDREQ_FLAG_ADD_IF_NEW As Integer = &H10000000
	Private Const HTTP_ADDREQ_FLAG_ADD As Integer = &H20000000
	Private Const HTTP_ADDREQ_FLAG_REPLACE As Integer = &H80000000
	Private Const INTERNET_OPTION_VERSION As Short = 40
	Private Const INTERNET_OPEN_TYPE_PRECONFIG As Short = 0
	Private Const INTERNET_DEFAULT_FTP_PORT As Short = 21
	Private Const INTERNET_DEFAULT_GOPHER_PORT As Short = 70
	Private Const INTERNET_DEFAULT_HTTP_PORT As Short = 80
	Private Const INTERNET_DEFAULT_HTTPS_PORT As Short = 443
	Private Const INTERNET_DEFAULT_SOCKS_PORT As Short = 1080
	Private Const INTERNET_SERVICE_FTP As Short = 1
	Private Const INTERNET_SERVICE_GOPHER As Short = 2
	Private Const INTERNET_SERVICE_HTTP As Short = 3
	Private Const INTERNET_FLAG_RELOAD As Integer = &H80000000
	
	Private Sub Class_Initialize_Renamed()
		' Code to initialize the class
		' Source: Total VB SourceBook 6
		
		' set the user agent property to a reasonable default
		m_strUserAgent = "FMS SourceBook"
		
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Public ReadOnly Property DLLVersion_Renamed() As String
		Get
			' Returns: The version of the WinInet.DLL library
			' Source: Total VB SourceBook 6
			'
			Dim GetDLLVersion As DLLVersion
			
			On Error GoTo PROC_ERR
			
			If CBool(m_lngSessionHandle) Then
				InternetQueryOption(m_lngSessionHandle, INTERNET_OPTION_VERSION, GetDLLVersion, Len(GetDLLVersion))
				
                DLLVersion_Renamed = CStr(GetDLLVersion.lngMajorVersion) & "." & CStr(GetDLLVersion.lngMinorVersion)
			Else
                DLLVersion_Renamed = ""
            End If

			
PROC_EXIT: 
			Exit Property
			
PROC_ERR: 
			MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "DLLVersion")
			Resume PROC_EXIT
			
		End Get
	End Property
	
	
	Public Property HitCacheFirst() As Boolean
		Get
			' Returns: The setting for the HitCacheFirst property
			' Source: Total VB SourceBook 6
			'
			HitCacheFirst = m_fHitCacheFirst
			
		End Get
		Set(ByVal Value As Boolean)
			' fValue: Set to True to have the local client cache examined first
			'         Set to False to ignore the local client cache and always
			'         get the latest data from the server.
			' Source: Total VB SourceBook 6
			
			m_fHitCacheFirst = Value
			
		End Set
	End Property
	
	Public ReadOnly Property QueryContentLength() As String
		Get
			' Returns: The result of the content length query
			' Source : Total VB SourceBook 6
			'
			QueryContentLength = m_strQContentLength
			
		End Get
	End Property
	
	Public ReadOnly Property QueryContentType() As String
		Get
			' Returns: The result of the content type query
			' Source : Total VB SourceBook 6
			'
			QueryContentType = m_strQContentType
			
		End Get
	End Property
	
	Public ReadOnly Property QueryExpires() As String
		Get
			' Returns: The result of the expires query
			' Source : Total VB SourceBook 6
			'
			QueryExpires = m_strQExpires
			
		End Get
	End Property
	
	Public ReadOnly Property QueryForwarded() As String
		Get
			' Returns: The result of the forwarded query
			' Source : Total VB SourceBook 6
			'
			QueryForwarded = m_strQForwarded
			
		End Get
	End Property
	
	Public ReadOnly Property QueryLastModified() As String
		Get
			' Returns: The result of the last modified query
			' Source : Total VB SourceBook 6
			'
			QueryLastModified = m_strQLastModified
			
		End Get
	End Property
	
	Public ReadOnly Property QueryPragma() As String
		Get
			' Returns: The result of the pragma query
			' Source : Total VB SourceBook 6
			'
			QueryPragma = m_strQPragma
			
		End Get
	End Property
	
	Public ReadOnly Property QueryRequestHeaders() As String
		Get
			' Returns: The result of the request headers query
			' Source : Total VB SourceBook 6
			'
			QueryRequestHeaders = m_strQRequestHeaders
			
		End Get
	End Property
	
	Public ReadOnly Property QueryRequestHeaders2() As String
		Get
			' Returns: The result of the request headers query (alternate method)
			' Source : Total VB SourceBook 6
			'
			QueryRequestHeaders2 = m_strQRequestHeaders2
			
		End Get
	End Property
	
	Public ReadOnly Property QueryServer() As String
		Get
			' Returns: The result of the server query
			' Source : Total VB SourceBook 6
			'
			QueryServer = m_strQServer
			
		End Get
	End Property
	
	Public ReadOnly Property QuerySetCookie() As String
		Get
			' Returns: The result of the set cookie query
			' Source : Total VB SourceBook 6
			'
			QuerySetCookie = m_strQSetCookie
			
		End Get
	End Property
	
	Public ReadOnly Property QueryStatusCode() As String
		Get
			' Returns: The result of the status code query
			' Source : Total VB SourceBook 6
			'
			QueryStatusCode = m_strQStatusCode
			
		End Get
	End Property
	
	Public ReadOnly Property QueryStatusText() As String
		Get
			' Returns: The result of the status text query
			' Source : Total VB SourceBook 6
			'
			QueryStatusText = m_strQStatusText
			
		End Get
	End Property
	
	Public ReadOnly Property QueryUserAgent() As String
		Get
			' Returns: The result of the user agent query
			' Source : Total VB SourceBook 6
			'
			QueryUserAgent = m_strQUserAgent
			
		End Get
	End Property
	
	Public ReadOnly Property QueryVersion() As String
		Get
			' Returns: The result of the version query
			' Source : Total VB SourceBook 6
			'
			QueryVersion = m_strQVersion
			
		End Get
	End Property
	
	
	Public Property UserAgent() As String
		Get
			' Returns: The string identifying the user agent
			' Source: Total VB SourceBook 6
			'
			UserAgent = m_strUserAgent
			
		End Get
		Set(ByVal Value As String)
			' strValue - string value to assign to the user agent
			' Source: Total VB SourceBook 6
			'
			m_strUserAgent = Value
			
		End Set
	End Property
	
	Public Sub CloseConnection()
		' Comments  : Closes the connnection handle
		' Parameters: None
		' Returns   : Nothing
		' Source    : Total VB SourceBook 6
		'
		On Error GoTo PROC_ERR
		
		InternetCloseHandle(m_lngConnectionHandle)
		
PROC_EXIT: 
		Exit Sub
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "CloseConnection")
		Resume PROC_EXIT
		
	End Sub
	
	Public Sub CloseHTTPRequest()
		' Comments  : Closes the HTTP request handle
		' Parameters: None
		' Returns   : Nothing
		' Source    : Total VB SourceBook 6
		'
		On Error GoTo PROC_ERR
		
		InternetCloseHandle(m_lngHTTPRequestHandle)
		
PROC_EXIT: 
		Exit Sub
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "CloseHTTPRequest")
		Resume PROC_EXIT
		
	End Sub
	
	Public Sub CloseSession()
		' Comments  : Closes the session handle to the WinINET dll.
		' Parameters: None
		' Returns   : Nothing
		' Source    : Total VB SourceBook 6
		'
		On Error GoTo PROC_ERR
		
		InternetCloseHandle(m_lngSessionHandle)
		
PROC_EXIT: 
		Exit Sub
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "CloseSession")
		Resume PROC_EXIT
		
	End Sub
	
	Public Function GetHTMLFromURL() As String
		' Comments  : Returns the HTML text from the current URL
		' Parameters: None
		' Returns   : String
		' Source    : Total VB SourceBook 6
		'
		Dim intRetval As Short
		Dim fLoop As Boolean
		Dim strReadBuf As New VB6.FixedLengthString(2048)
		Dim lngBytesRead As Integer
        Dim strBuffer As String = ""
		Dim lngFlags As Integer
		
		On Error GoTo PROC_ERR
		
		fLoop = True
		
		' If HitCacheFirst is True, then have the engine look
		' in the local cache first. If False, force the request
		' to get the data from the server even if it is in the cache.
		If m_fHitCacheFirst Then
			lngFlags = 0
		Else
			lngFlags = INTERNET_FLAG_RELOAD
		End If
		
		m_lngHTTPRequestHandle = HttpOpenRequest(m_lngConnectionHandle, "GET", "", "HTTP/1.0", vbNullString, 0, lngFlags, 0)
		
		' Send the request
		intRetval = HttpSendRequest(m_lngHTTPRequestHandle, vbNullString, 0, 0, 0)
		
		If intRetval Then
			
			While fLoop
				' Loop while the number of bytes read is not returned as False
				
				' Initialize the passed buffer to Null
				strReadBuf.Value = vbNullString
				
				' Call the DLL to read the HTTP data into the buffer
				fLoop = InternetReadFile(m_lngHTTPRequestHandle, strReadBuf.Value, Len(strReadBuf.Value), lngBytesRead)
				
				' Add the temporary buffer to the final buffer
				strBuffer = strBuffer & Left(strReadBuf.Value, lngBytesRead)
				
				' Check for end of data condition
				If Not CBool(lngBytesRead) Then
					fLoop = False
				End If
				
			End While
			
			GetHTMLFromURL = strBuffer
		Else
			GetHTMLFromURL = ""
		End If
		
PROC_EXIT: 
		Exit Function
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "GetHTMLFromURL")
		Resume PROC_EXIT
		
	End Function
	
	Public Function GotoURL(ByRef strURL As String) As Boolean
		' Comments  : Opens a connection on the named URL
		' Parameters: strURL - URL to open
		' Returns   : True if successful, False otherwise
		' Source    : Total VB SourceBook 6
		'
		Dim strBuffer As New VB6.FixedLengthString(1024)
		Dim lngBufferLen As Integer
		
		On Error GoTo PROC_ERR
		
		lngBufferLen = Len(strBuffer.Value)
		
		If CBool(m_lngSessionHandle) Then
			
			m_lngConnectionHandle = InternetConnect(m_lngSessionHandle, strURL, INTERNET_DEFAULT_HTTP_PORT, vbNullString, vbNullString, INTERNET_SERVICE_HTTP, 0, 0)
			
			GotoURL = True
		Else
			GotoURL = False
		End If
		
PROC_EXIT: 
		Exit Function
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "GotoURL")
		Resume PROC_EXIT
		
	End Function
	
	Public Function OpenSession() As Boolean
		' Comments  : Opens a session handle to the WinINET dll. This must
		'             be done before any other parts of the class are called.
		' Parameters: None
		' Returns   : True if successful, False otherwise
		' Source    : Total VB SourceBook 6
		'
		On Error GoTo PROC_ERR
		
		' Make the call to initialize the DLL
		m_lngSessionHandle = InternetOpen(m_strUserAgent, INTERNET_OPEN_TYPE_PRECONFIG, vbNullString, vbNullString, 0)
		
		' Return value of 0 means failure, anything else means success
		OpenSession = CBool(m_lngSessionHandle)
		
PROC_EXIT: 
		Exit Function
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "OpenSession")
		Resume PROC_EXIT
		
	End Function
	
	Public Sub SendQuery()
		' Comments  : Queries the server. Call this method before accessing
		'             the Query... properties
		' Parameters: None
		' Returns   : Nothing
		' Source    : Total VB SourceBook 6
		'
		Dim strBuffer As New VB6.FixedLengthString(1024)
		Dim lngBufLen As Integer
		Dim lngFlags As Integer
		
		On Error GoTo PROC_ERR
		
		' We need to pass the length of the buffer to the API call
		lngBufLen = Len(strBuffer.Value)
		
		' If HitCacheFirst is True, then have the engine look
		' in the local cache first. If False, force the request
		' to get the data from the server even if it is in the cache.
		If m_fHitCacheFirst Then
			lngFlags = 0
		Else
			lngFlags = INTERNET_FLAG_RELOAD
		End If
		
		' Create a request
		m_lngHTTPRequestHandle = HttpOpenRequest(m_lngConnectionHandle, "GET", vbNullString, "HTTP/1.0", vbNullString, 0, lngFlags, 0)
		
		' Send the request
		HttpSendRequest(m_lngHTTPRequestHandle, vbNullString, 0, 0, 0)
		
		' Call the query to get each piece of information
		
		' Content type
		m_strQContentType = QueryDispatch(HTTP_QUERY_CONTENT_TYPE)
		
		' Content length
		m_strQContentLength = QueryDispatch(HTTP_QUERY_CONTENT_LENGTH)
		
		' Expires
		m_strQExpires = QueryDispatch(HTTP_QUERY_EXPIRES)
		
		' Last Modified
		m_strQLastModified = QueryDispatch(HTTP_QUERY_LAST_MODIFIED)
		
		' Pragma
		m_strQPragma = QueryDispatch(HTTP_QUERY_PRAGMA + HTTP_QUERY_FLAG_REQUEST_HEADERS)
		
		' Version
		m_strQVersion = QueryDispatch(HTTP_QUERY_VERSION)
		
		' Status code
		m_strQStatusCode = QueryDispatch(HTTP_QUERY_STATUS_CODE)
		
		' Status text
		m_strQStatusText = QueryDispatch(HTTP_QUERY_STATUS_TEXT)
		
		' Request headers
		m_strQRequestHeaders = QueryDispatch(HTTP_QUERY_FLAG_REQUEST_HEADERS + HTTP_QUERY_RAW_HEADERS_CRLF)
		
		' Request headers 2
		m_strQRequestHeaders2 = QueryDispatch(HTTP_QUERY_FLAG_REQUEST_HEADERS + HTTP_QUERY_REQUEST_METHOD)
		
		' Forwarded
		m_strQForwarded = QueryDispatch(HTTP_QUERY_FORWARDED)
		
		' Server
		m_strQServer = QueryDispatch(HTTP_QUERY_SERVER)
		
		' User agent
		m_strQUserAgent = QueryDispatch(HTTP_QUERY_USER_AGENT + HTTP_QUERY_FLAG_REQUEST_HEADERS)
		
		' Set Cookie
		m_strQSetCookie = QueryDispatch(HTTP_QUERY_SET_COOKIE)
		
PROC_EXIT: 
		Exit Sub
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "SendQuery")
		Resume PROC_EXIT
		
	End Sub
	
	Private Function QueryDispatch(ByRef lngQueryType As Integer) As String
		' Comments  : Sends the specified query to the server
		' Parameters: lngQueryType - type of query to send
		' Returns   : String results of query
		' Source    : Total VB SourceBook 6
		'
		Dim strBuffer As New VB6.FixedLengthString(2048)
		Dim lngBufLen As Integer
		
		On Error GoTo PROC_ERR
		
		' We need to pass the size of the buffer to the API
		lngBufLen = Len(strBuffer.Value)
		
		' Send the query
		HttpQueryInfo(m_lngHTTPRequestHandle, lngQueryType, strBuffer.Value, lngBufLen, 0)
		
		' Trim the result
		QueryDispatch = TrimNulls(strBuffer.Value)
		
PROC_EXIT: 
		Exit Function
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "QueryDispatch")
		Resume PROC_EXIT
		
	End Function
	
	Private Function TrimNulls(ByRef strIn As String) As String
		' Comments  : Removes terminator from a string
		' Parameters: strIn - String to modify
		' Returns   : Modified string
		' Source    : Total VB SourceBook 6
		'
		Dim intChr As Short
		
		On Error GoTo PROC_ERR
		
		intChr = InStr(strIn, Chr(0))
		
		If intChr > 0 Then
			TrimNulls = Left(strIn, intChr - 1)
		Else
			TrimNulls = strIn
		End If
		
PROC_EXIT: 
		Exit Function
		
PROC_ERR: 
		MsgBox("Error: " & Err.Number & ". " & Err.Description,  , "TrimNulls")
		Resume PROC_EXIT
		
	End Function
End Class