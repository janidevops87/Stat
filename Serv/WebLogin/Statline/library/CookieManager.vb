Imports System
Imports System.Text
Imports System.ComponentModel
Imports System.Web
Imports System.Web.Security



Public Enum StateName
    DSN
    LogEventType
    StatEmployeeName
    OldCalloutDate
    OldCalloutMins
    PhoneID
    PersonID
    ScheduleGroupID
    OrganizationName
    FormLoad
    UpdatePendingEvent
    Saved
    ContactEmployeeID
    DefaultContactDesc
    DefaultContactType
    DefaultOrganizationID
    DefaultContactName
    WebUserID
    DefaultcontactPhone
    DefaultOrganization
    CallID
    ContactLogEventTypeID
    ContactLogEventID
    LogEventTypeList
    CallbackPending
    FormState
    StatEmployeeId
    CboOrganization_Text
    TxtPhone_Text
    CboName_Text
    WebUserOrganizationTimeZone
    WebUserOrganizationTimeZoneDiff
    WebUserOrganizationID
    currentLogEventID
    OrganizationID
    LogEventID
    CallNumber
End Enum

Public Class CookieManager

    Public Sub New()
        Try
            Me.DSN = CONVERT.ToString(GetCookie(StateName.DSN, GetType(String), ""))
            Me.OldCalloutDate = CONVERT.ToString(GetCookie(StateName.LogEventType, GetType(String), ""))
            Me.OldCalloutDate = CONVERT.ToString(GetCookie(StateName.StatEmployeeName, GetType(String), ""))
            Me.OldCalloutDate = CONVERT.ToString(GetCookie(StateName.OldCalloutDate, GetType(String), ""))
            Me.OldCalloutMins = CONVERT.ToString(GetCookie(StateName.OldCalloutMins, GetType(String), ""))
            Me.PhoneID = CONVERT.ToString(GetCookie(StateName.PhoneID, GetType(String), ""))
            Me.PersonID = CONVERT.ToString(GetCookie(StateName.PersonID, GetType(String), ""))
            Me.ScheduleGroupID = CONVERT.ToString(GetCookie(StateName.ScheduleGroupID, GetType(String), ""))
            Me.OrganizationName = CONVERT.ToString(GetCookie(StateName.OrganizationName, GetType(String), ""))
            Me.FormLoad = CONVERT.ToString(GetCookie(StateName.FormLoad, GetType(String), ""))
            Me.UpdatePendingEvent = CONVERT.ToString(GetCookie(StateName.UpdatePendingEvent, GetType(String), ""))

            Me.DefaultOrganizationID = CONVERT.ToString(GetCookie(StateName.DefaultOrganizationID, GetType(String), ""))
            Me.DefaultContactType = CONVERT.ToString(GetCookie(StateName.DefaultContactType, GetType(String), ""))
            Me.DefaultContactDesc = CONVERT.ToString(GetCookie(StateName.DefaultContactDesc, GetType(String), ""))
            Me.ContactEmployeeID = CONVERT.ToString(GetCookie(StateName.ContactEmployeeID, GetType(String), ""))
            Me.Saved = CONVERT.ToString(GetCookie(StateName.Saved, GetType(String), ""))
            Me.DefaultContactName = CONVERT.ToString(GetCookie(StateName.DefaultContactName, GetType(String), ""))
            Me.WebUserID = CONVERT.ToString(GetCookie(StateName.WebUserID, GetType(String), ""))
            Me.DefaultcontactPhone = CONVERT.ToString(GetCookie(StateName.DefaultcontactPhone, GetType(String), ""))
            Me.DefaultOrganization = CONVERT.ToString(GetCookie(StateName.DefaultOrganization, GetType(String), ""))
            Me.CallID = CONVERT.ToString(GetCookie(StateName.CallID, GetType(String), ""))
            Me.ContactLogEventTypeID = CONVERT.ToString(GetCookie(StateName.ContactLogEventTypeID, GetType(String), ""))
            Me.ContactLogEventID = CONVERT.ToString(GetCookie(StateName.ContactLogEventID, GetType(String), ""))
            Me.LogEventTypeList = CONVERT.ToString(GetCookie(StateName.LogEventTypeList, GetType(String), ""))
            Me.CallbackPending = GetCookie(StateName.CallbackPending, GetType(Integer), "")
            Me.FormState = GetCookie(StateName.FormState, GetType(Integer), "")
            Me.StatEmployeeId = GetCookie(StateName.StatEmployeeId, GetType(Integer), "")
            Me.CboOrganization_Text = GetCookie(StateName.CboOrganization_Text, GetType(Integer), -1)
            Me.TxtPhone_Text = GetCookie(StateName.TxtPhone_Text, GetType(Integer), -1)
            Me.CboName_Text = GetCookie(StateName.CboName_Text, GetType(String), "")
            Me.WebUserOrganizationTimeZone = GetCookie(StateName.WebUserOrganizationTimeZone, GetType(Integer), "")
            Me.WebUserOrganizationTimeZoneDiff = CONVERT.ToString(GetCookie(StateName.WebUserOrganizationTimeZoneDiff, GetType(String), ""))
            Me.WebUserOrganizationID = CONVERT.ToString(GetCookie(StateName.WebUserOrganizationID, GetType(String), ""))
            Me.currentLogEventID = CONVERT.ToString(GetCookie(StateName.currentLogEventID, GetType(String), ""))
            Me.OrganizationID = GetCookie(StateName.OrganizationID, GetType(Integer), -1)
            Me.LogEventID = GetCookie(StateName.LogEventID, GetType(Integer), "")
            Me.CallNumber = CONVERT.ToString(GetCookie(StateName.CallNumber, GetType(String), ""))
        Catch
        End Try
    End Sub

    Public Sub ClearCookies()
        SetCookie(StateName.DSN, Nothing)
        SetCookie(StateName.LogEventType, Nothing)
        SetCookie(StateName.StatEmployeeName, Nothing)
        SetCookie(StateName.OldCalloutDate, Nothing)
        SetCookie(StateName.OldCalloutMins, Nothing)
        SetCookie(StateName.PhoneID, Nothing)
        SetCookie(StateName.Saved, Nothing)
        SetCookie(StateName.PersonID, Nothing)
        SetCookie(StateName.ScheduleGroupID, Nothing)
        SetCookie(StateName.OrganizationName, Nothing)
        SetCookie(StateName.FormLoad, Nothing)
        SetCookie(StateName.UpdatePendingEvent, Nothing)

        SetCookie(StateName.DefaultOrganizationID, Nothing)
        SetCookie(StateName.DefaultContactType, Nothing)
        SetCookie(StateName.DefaultContactDesc, Nothing)
        SetCookie(StateName.ContactEmployeeID, Nothing)
        SetCookie(StateName.Saved, Nothing)
        SetCookie(StateName.DefaultContactName, Nothing)
        SetCookie(StateName.WebUserID, Nothing)
        SetCookie(StateName.DefaultcontactPhone, Nothing)
        SetCookie(StateName.DefaultOrganization, Nothing)
        SetCookie(StateName.CallID, Nothing)
        SetCookie(StateName.ContactLogEventTypeID, Nothing)
        SetCookie(StateName.ContactLogEventID, Nothing)
        SetCookie(StateName.LogEventTypeList, Nothing)
        SetCookie(StateName.CallbackPending, Nothing)
        SetCookie(StateName.FormState, Nothing)
        SetCookie(StateName.StatEmployeeId, Nothing)
        SetCookie(StateName.CboOrganization_Text, Nothing)
        SetCookie(StateName.TxtPhone_Text, Nothing)
        SetCookie(StateName.CboName_Text, Nothing)
        SetCookie(StateName.WebUserOrganizationTimeZone, Nothing)
        SetCookie(StateName.WebUserOrganizationTimeZoneDiff, Nothing)
        SetCookie(StateName.WebUserOrganizationID, Nothing)
        SetCookie(StateName.currentLogEventID, Nothing)
        SetCookie(StateName.OrganizationID, Nothing)
        SetCookie(StateName.LogEventID, Nothing)
        SetCookie(StateName.CallNumber, Nothing)
    End Sub

    Public Sub SaveCookies()

        SetCookie(StateName.DSN, Me.DSN)
        SetCookie(StateName.StatEmployeeName, Me.StatEmployeeName)
        SetCookie(StateName.OldCalloutDate, Me.OldCalloutDate)
        SetCookie(StateName.OldCalloutMins, Me.OldCalloutMins)
        SetCookie(StateName.PhoneID, Me.PhoneID)
        SetCookie(StateName.PersonID, Me.PersonID)
        SetCookie(StateName.ScheduleGroupID, Me.ScheduleGroupID)
        SetCookie(StateName.OrganizationName, Me.OrganizationName)
        SetCookie(StateName.FormLoad, Me.FormLoad)
        SetCookie(StateName.UpdatePendingEvent, Me.UpdatePendingEvent)

        SetCookie(StateName.DefaultOrganizationID, Me.DefaultOrganizationID)
        SetCookie(StateName.DefaultContactType, Me.WebUserID)
        SetCookie(StateName.DefaultContactDesc, Me.DefaultContactDesc)
        SetCookie(StateName.ContactEmployeeID, Me.ContactEmployeeID)
        SetCookie(StateName.Saved, Me.Saved)
        SetCookie(StateName.DefaultContactName, Me.DefaultContactName)
        SetCookie(StateName.WebUserID, Me.WebUserID)
        SetCookie(StateName.DefaultcontactPhone, Me.DefaultcontactPhone)
        SetCookie(StateName.DefaultOrganization, Me.DefaultOrganization)
        SetCookie(StateName.CallID, Me.CallID)
        SetCookie(StateName.ContactLogEventTypeID, Me.ContactLogEventTypeID)
        SetCookie(StateName.ContactLogEventID, Me.ContactLogEventID)
        SetCookie(StateName.LogEventTypeList, Me.LogEventTypeList)
        SetCookie(StateName.CallbackPending, Me.CallbackPending)
        SetCookie(StateName.FormState, Me.FormState)
        SetCookie(StateName.StatEmployeeId, Me.StatEmployeeId)
        SetCookie(StateName.CboOrganization_Text, Me.CboOrganization_Text)
        SetCookie(StateName.TxtPhone_Text, Me.TxtPhone_Text)
        SetCookie(StateName.CboName_Text, Me.CboName_Text)
        SetCookie(StateName.WebUserOrganizationTimeZone, Me.WebUserOrganizationTimeZone)
        SetCookie(StateName.WebUserOrganizationTimeZoneDiff, Me.WebUserOrganizationTimeZoneDiff)
        SetCookie(StateName.WebUserOrganizationID, Me.WebUserOrganizationID)
        SetCookie(StateName.currentLogEventID, Me.currentLogEventID)
        SetCookie(StateName.OrganizationID, Me.OrganizationID)
        SetCookie(StateName.LogEventID, Me.LogEventID)
        SetCookie(StateName.CallNumber, Me.CallNumber)
    End Sub
    Public mDSN As String
    Public Property DSN() As String
        Get
            Return Me.mDSN
        End Get
        Set(ByVal Value As String)
            Me.mDSN = Value
        End Set
    End Property
    Public mLogEventType As String
    Public Property LogEventType() As String
        Get
            Return Me.mLogEventType
        End Get
        Set(ByVal Value As String)
            Me.mLogEventType = Value
        End Set
    End Property
    Public mStatEmployeeName As String
    Public Property StatEmployeeName() As String
        Get
            Return Me.mStatEmployeeName
        End Get
        Set(ByVal Value As String)
            Me.mStatEmployeeName = Value
        End Set
    End Property
    Public mPersonID As String

    Public Property PersonID() As String
        Get
            Return Me.mPersonID
        End Get
        Set(ByVal Value As String)
            Me.mPersonID = Value
        End Set
    End Property
    Public mScheduleGroupID As String

    Public Property ScheduleGroupID() As String
        Get
            Return Me.mScheduleGroupID
        End Get
        Set(ByVal Value As String)
            Me.mScheduleGroupID = Value
        End Set
    End Property
    Public mOrganizationName As String

    Public Property OrganizationName() As String
        Get
            Return Me.mOrganizationName

        End Get
        Set(ByVal Value As String)
            Me.mOrganizationName = Value
        End Set
    End Property
    Public mFormLoad As String

    Public Property FormLoad() As String
        Get
            Return Me.mFormLoad
        End Get
        Set(ByVal Value As String)
            Me.mFormLoad = Value
        End Set
    End Property
    Public mUpdatePendingEvent As String

    Public Property UpdatePendingEvent() As String
        Get
            Return Me.mUpdatePendingEvent
        End Get
        Set(ByVal Value As String)
            Me.mUpdatePendingEvent = Value
        End Set
    End Property







    Public mOldCalloutDate As String

    Public Property OldCalloutDate() As String
        Get
            Return Me.mOldCalloutDate

        End Get
        Set(ByVal Value As String)
            Me.mOldCalloutDate = Value
        End Set
    End Property
    Public mOldCalloutMins As String

    Public Property OldCalloutMins() As String
        Get
            Return Me.mOldCalloutMins
        End Get
        Set(ByVal Value As String)
            Me.mOldCalloutMins = Value
        End Set
    End Property
    Public mPhoneID As String

    Public Property PhoneID() As String
        Get
            Return Me.mPhoneID
        End Get
        Set(ByVal Value As String)
            Me.mPhoneID = Value
        End Set
    End Property




    Public mDefaultOrganizationID As String

    Public Property DefaultOrganizationID() As String
        Get
            Return Me.mDefaultOrganizationID
        End Get
        Set(ByVal Value As String)
            Me.mDefaultOrganizationID = Value
        End Set
    End Property
    Public mDefaultContactType As String

    Public Property DefaultContactType() As String
        Get
            Return Me.mDefaultContactType
        End Get
        Set(ByVal Value As String)
            Me.mDefaultContactType = Value
        End Set
    End Property
    Public mDefaultContactDesc As String

    Public Property DefaultContactDesc() As String
        Get
            Return Me.mDefaultContactDesc

        End Get
        Set(ByVal Value As String)
            Me.mDefaultContactDesc = Value
        End Set
    End Property
    Public mContactEmployeeID As String

    Public Property ContactEmployeeID() As String
        Get
            Return Me.mContactEmployeeID
        End Get
        Set(ByVal Value As String)
            Me.mContactEmployeeID = Value
        End Set
    End Property
    Public mCallID As String

    Public Property CallID() As String
        Get
            Return Me.mCallID
        End Get
        Set(ByVal Value As String)
            Me.mCallID = Value
        End Set
    End Property
    Public mDefaultContactName As String

    Public Property DefaultContactName() As String
        Get
            Return Me.mDefaultContactName
        End Get
        Set(ByVal Value As String)
            Me.mDefaultContactName = Value
        End Set
    End Property
    Public mWebUserID As String

    Public Property WebUserID() As String
        Get
            Return Me.mWebUserID
        End Get
        Set(ByVal Value As String)
            Me.mWebUserID = Value
        End Set
    End Property
    Public mDefaultcontactPhone As String

    Public Property DefaultcontactPhone() As String
        Get
            Return Me.mDefaultcontactPhone

        End Get
        Set(ByVal Value As String)
            Me.mDefaultcontactPhone = Value
        End Set
    End Property
    Public mDefaultOrganization As String

    Public Property DefaultOrganization() As String
        Get
            Return Me.mDefaultOrganization
        End Get
        Set(ByVal Value As String)
            Me.mDefaultOrganization = Value
        End Set
    End Property
    Public mSaved As String

    Public Property Saved() As String
        Get
            Return Me.mSaved
        End Get
        Set(ByVal Value As String)
            Me.mSaved = Value
        End Set
    End Property
    Public mContactLogEventTypeID As String

    Public Property ContactLogEventTypeID() As String
        Get
            Return Me.mContactLogEventTypeID
        End Get
        Set(ByVal Value As String)
            Me.mContactLogEventTypeID = Value
        End Set
    End Property
    Public mContactLogEventID As String

    Public Property ContactLogEventID() As String
        Get
            Return Me.mContactLogEventID
        End Get
        Set(ByVal Value As String)
            Me.mContactLogEventID = Value
        End Set
    End Property
    Public mLogEventTypeList As String

    Public Property LogEventTypeList() As String
        Get
            Return Me.mLogEventTypeList
        End Get
        Set(ByVal Value As String)
            Me.mLogEventTypeList = Value
        End Set
    End Property
    Public mCallbackPending As Integer

    Public Property CallbackPending() As Integer
        Get
            Return Me.mCallbackPending
        End Get
        Set(ByVal Value As Integer)
            Me.mCallbackPending = Value
        End Set
    End Property
    Public mFormState As Integer

    Public Property FormState() As String
        Get
            Return Me.mFormState
        End Get
        Set(ByVal Value As String)
            Me.mFormState = Value
        End Set
    End Property
    Public mStatEmployeeId As Integer

    Public Property StatEmployeeId() As Integer
        Get
            Return Me.mStatEmployeeId
        End Get
        Set(ByVal Value As Integer)
            Me.mStatEmployeeId = Value
        End Set
    End Property
    Public mCboOrganization_Text As String

    Public Property CboOrganization_Text() As String
        Get
            Return Me.mCboOrganization_Text
        End Get
        Set(ByVal Value As String)
            Me.mCboOrganization_Text = Value
        End Set
    End Property
    Public mTxtPhone_Text As String

    Public Property TxtPhone_Text() As String
        Get
            Return Me.mTxtPhone_Text
        End Get
        Set(ByVal Value As String)
            Me.mTxtPhone_Text = Value
        End Set
    End Property
    Public mCboName_Text As String

    Public Property CboName_Text() As String
        Get
            Return Me.mCboName_Text
        End Get
        Set(ByVal Value As String)
            Me.mCboName_Text = Value
        End Set
    End Property
    Public mWebUserOrganizationTimeZone As Integer

    Public Property WebUserOrganizationTimeZone() As Integer
        Get
            Return Me.mWebUserOrganizationTimeZone
        End Get
        Set(ByVal Value As Integer)
            Me.mWebUserOrganizationTimeZone = Value
        End Set
    End Property
    Public mWebUserOrganizationTimeZoneDiff As String

    Public Property WebUserOrganizationTimeZoneDiff() As String
        Get
            Return Me.mWebUserOrganizationTimeZoneDiff
        End Get
        Set(ByVal Value As String)
            Me.mWebUserOrganizationTimeZoneDiff = Value
        End Set
    End Property
    Public mWebUserOrganizationID As String

    Public Property WebUserOrganizationID() As String
        Get
            Return Me.mWebUserOrganizationID
        End Get
        Set(ByVal Value As String)
            Me.mWebUserOrganizationID = Value
        End Set
    End Property
    Public mcurrentLogEventID As String

    Public Property currentLogEventID() As String
        Get
            Return Me.mcurrentLogEventID
        End Get
        Set(ByVal Value As String)
            Me.mcurrentLogEventID = Value
        End Set
    End Property
    Public mOrganizationID As Integer

    Public Property OrganizationID() As Integer
        Get
            Return Me.mOrganizationID
        End Get
        Set(ByVal Value As Integer)
            Me.mOrganizationID = Value
        End Set
    End Property
    Public mLogEventID As Integer

    Public Property LogEventID() As Integer
        Get
            Return Me.mLogEventID
        End Get
        Set(ByVal Value As Integer)
            Me.mLogEventID = Value
        End Set
    End Property
    Public mCallNumber As String

    Public Property CallNumber() As String
        Get
            Return Me.mCallNumber
        End Get
        Set(ByVal Value As String)
            Me.mCallNumber = Value
        End Set
    End Property

    Public Function GetStateStringBreak() As String
        Return Me.GetStateString("<br>")
    End Function

    Public Function GetStateStringNewLine() As String
        Return Me.GetStateString("" & Microsoft.VisualBasic.Chr(13) & "" & Microsoft.VisualBasic.Chr(10) & "")
    End Function

    Public Function GetStateString() As String
        Return Me.GetStateString("" & Microsoft.VisualBasic.Chr(13) & "" & Microsoft.VisualBasic.Chr(10) & "")
    End Function

    Public Function GetStateString(ByVal LineTerminator As String) As String
        Dim sb As StringBuilder = New StringBuilder
        sb.AppendFormat("{0}={1}{2}", "DSN", Me.DSN, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "LogEventType", Me.LogEventType, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "StatEmployeeName", Me.StatEmployeeName, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "OldCalloutDate", Me.OldCalloutDate, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "OldCalloutMins", Me.OldCalloutMins, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "PhoneID", Me.PhoneID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "PersonID", Me.PersonID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "ScheduleGroupID", Me.ScheduleGroupID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultContactName", Me.DefaultContactName, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "OrganizationName", Me.OrganizationName, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "FormLoad", Me.FormLoad, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "UpdatePendingEvent", Me.UpdatePendingEvent, LineTerminator)

        sb.AppendFormat("{0}={1}{2}", "DefaultContactType", Me.DefaultContactType, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultOrganizationID", Me.DefaultOrganizationID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultContactDesc", Me.DefaultContactDesc, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "ContactEmployeeID", Me.ContactEmployeeID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "Saved", Me.Saved, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "WebUserID", Me.WebUserID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultContactName", Me.DefaultContactName, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultcontactPhone", Me.DefaultcontactPhone, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "DefaultOrganization", Me.DefaultOrganization, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "CallID", Me.CallID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "ContactLogEventTypeID", Me.ContactLogEventTypeID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "ContactLogEventID", Me.ContactLogEventID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "LogEventTypeList", Me.LogEventTypeList, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "CallbackPending", Me.CallbackPending, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "FormState", Me.FormState, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "StatEmployeeId", Me.StatEmployeeId, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "CboOrganization_Text", Me.CboOrganization_Text, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "TxtPhone_Text", Me.TxtPhone_Text, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "WebUserOrganizationTimeZone", Me.WebUserOrganizationTimeZone, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "WebUserOrganizationTimeZoneDiff", Me.WebUserOrganizationTimeZoneDiff, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "WebUserOrganizationID", Me.WebUserOrganizationID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "currentLogEventID", Me.currentLogEventID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "OrganizationID", Me.OrganizationID, LineTerminator)
        sb.AppendFormat("{0}={1}{2}", "Search Count", Me.LogEventID, LineTerminator)
        Return sb.ToString
    End Function
    Public Shared cookiePrefix As String = "x"

    Public Shared Function CookieName(ByVal TheCookieName As StateName) As String
        Return cookiePrefix + TheCookieName.ToString
    End Function

    Public Shared Function GetCookie(ByVal TheCookieName As StateName, ByVal TheType As Type, ByVal DefaultValue As Object) As Object
        Dim thevalue As Object = Nothing
        If Not (HttpContext.Current.Request.Cookies(CookieName(TheCookieName)) Is Nothing) Then
            thevalue = HttpContext.Current.Request.Cookies(CookieName(TheCookieName)).Value
        End If
        If Not (thevalue Is Nothing) Then
            Return TypeDescriptor.GetConverter(TheType).ConvertFrom(thevalue)
        Else
            Return DefaultValue
        End If
    End Function

    Public Shared Sub SetCookie(ByVal TheCookieName As StateName, ByVal TheCookieValue As Object)
        If Not (TheCookieValue Is Nothing) AndAlso TheCookieValue.ToString.Length > 0 Then
            HttpContext.Current.Response.Cookies(CookieName(TheCookieName)).Value = TheCookieValue.ToString
        Else
            Try
                HttpContext.Current.Request.Cookies.Remove(CookieName(TheCookieName))
                HttpContext.Current.Response.Cookies.Remove(CookieName(TheCookieName))
            Catch
            End Try
        End If
    End Sub
End Class


