
Public Class ScheduleItemPerson

    Private _scheduleItemID As Integer
    Private _scheduleGroupID As Integer
    Private _ShiftName As String
    Private _StartDate As Date
    Private _EndDate As Date
    Private _StartTime As String
    Private _EndTime As String
    Public Sub New()

    End Sub
    Public Sub New(ByVal scheduleItemID As Integer, ByVal scheduleGroupID As Integer, ByVal ShiftName As String, ByVal StartDate As Date, ByVal EndDate As Date, ByVal StartTime As String, ByVal EndTime As String)
        Me.ScheduleItemID = scheduleItemID
        Me.ScheduleGroupID = scheduleGroupID
        Me.ShiftName = ShiftName
        Me.StartDate = StartDate
        Me.EndDate = EndDate
        Me.StartTime = StartTime
        Me.EndTime = EndTime
    End Sub


    Public Property EndTime() As String
        Get
            Return _EndTime
        End Get
        Set(ByVal value As String)
            _EndTime = value
        End Set
    End Property

    Public Property StartTime() As String
        Get
            Return _StartTime
        End Get
        Set(ByVal value As String)
            _StartTime = value
        End Set
    End Property

    Public Property EndDate() As Date
        Get
            Return _EndDate
        End Get
        Set(ByVal value As Date)
            _EndDate = value
        End Set
    End Property

    Public Property StartDate() As Date
        Get
            Return _StartDate
        End Get
        Set(ByVal value As Date)
            _StartDate = value
        End Set
    End Property

    Public Property ShiftName() As String
        Get
            Return _ShiftName
        End Get
        Set(ByVal value As String)
            _ShiftName = value
        End Set
    End Property

    Public Property ScheduleGroupID() As Integer
        Get
            Return _scheduleGroupID
        End Get
        Set(ByVal value As Integer)
            _scheduleGroupID = value
        End Set
    End Property

    Public Property ScheduleItemID() As Integer
        Get
            Return _scheduleItemID
        End Get
        Set(ByVal value As Integer)
            _scheduleItemID = value
        End Set
    End Property

End Class
'Public Class ScheduleItemPersonList
'    Implements System.Collections.Generic.IList(Of ScheduleItemPerson)
'End Class