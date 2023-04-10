Option Strict Off
Option Explicit On

Imports Infragistics.Win.UltraWinGrid
Imports Statline.Stattrac.Framework
Imports System.Text.RegularExpressions

Friend Class clsSecondaryDisposition_rps

    Private Const ERR_ParseList As Short = 8000
    Private Const d As String = ";"

    Private Const FS_ReferralID As Short = 0
    Private Const FS_CallId As Short = 1
    Private Const FS_DonorCategoryID As Short = 2
    Private Const FS_DonorCategoryName As Short = 3
    Private Const FS_AppropriateID As Short = 4
    Private Const FS_ApproachID As Short = 5
    Private Const FS_ConsentID As Short = 6
    Private Const FS_RecoveryID As Short = 7
    Private Const FS_AppropriateName As Short = 8
    Private Const FS_ApproachName As Short = 9
    Private Const FS_ConsentName As Short = 10
    Private Const FS_RecoveryName As Short = 11

    Private Const GRP_Appropriate As Short = 1
    Private Const GRP_Approach As Short = 2
    Private Const GRP_Consent As Short = 3
    Private Const GRP_Recovery As Short = 4
    Private Const GRP_DonorCategoryID As Short = 5
    Private Const GRP_AppropriateAppropriate As Short = 6
    Private Const GRP_ApproachAppropriate As Short = 7
    Private Const GRP_ApproachApproach As Short = 8
    Private Const GRP_ConsentApproach As Short = 9
    Private Const GRP_ConsentConsent As Short = 10
    Private Const GRP_RecoveryConsent As Short = 11

    Private Const CALC_SubCriteriaID As Short = 1
    Private Const CALC_DonorCategoryID As Short = 2
    Private Const CALC_Appropriate As Short = 3
    Private Const CALC_Approach As Short = 4
    Private Const CALC_Consent As Short = 5
    Private Const CALC_Recovery As Short = 6

    Private Const POSi As Integer = 1
    Private Const POSv As String = "Yes"
    Private Const CONSENT_FSROi As Integer = 5
    Private Const RECOVERY_FSROi As Integer = 11
    Private Const CONSENT_FSROv As String = "No, Unknown"
    Private Const RECOVERY_FSROv As String = "CNR"

    Private Const RR_col As Short = 0
    Private Const RR_id As Short = 1
    Private Const RR_name As Short = 2

    Private mReportErrors As Object
    Private mRollupReasons As Object
    Private mTriageDisposition As Object
    Private mCallID As Integer

    Private LEAD As Integer

    Public Sub SaveTriageDisposition()
        On Error GoTo err_SaveTriageDisposition

        Dim sql As String = ""
        Dim Result As Object
        '3/15/2009 bret initialize array
        sql = "EXEC spu_SecondaryDispositionTriageDisposition "

        sql = sql & FormatParam_int(mTriageDisposition(0, FS_ReferralID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(0, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(1, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(2, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(3, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(4, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(5, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(6, FS_AppropriateID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(0, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(1, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(2, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(3, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(4, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(5, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(6, FS_ApproachID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(0, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(1, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(2, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(3, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(4, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(5, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(6, FS_ConsentID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(0, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(1, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(2, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(3, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(4, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(5, FS_RecoveryID)) & ", "
        sql = sql & FormatParam_int(mTriageDisposition(6, FS_RecoveryID))

        '8/28/02 drh - Removed ResultsArray parameter since there's no return value
        'Result = modODBC.Exec(sql$, ResultsArray)
        Result = modODBC.Exec(sql)

exit_SaveTriageDisposition:
        Exit Sub

err_SaveTriageDisposition:
        Select Case Err.Number
            Case 0
                Resume exit_SaveTriageDisposition
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_SaveTriageDisposition
                Resume
        End Select

    End Sub

    Private Function FormatParam_int(ByRef v As Object) As String
        On Error GoTo err_FormatParam_int

        'bret 01/07/10 seperated the IsNull check from the is empty ("") check.
        ' This was required because Trim was changed from Trim() Trim$() returning a string instead of variant
        If IsDBNull(v) Then
            FormatParam_int = "NULL"
            GoTo exit_FormatParam_int
        End If

        If Trim(v) = "" Then
            FormatParam_int = "NULL"
        Else
            FormatParam_int = CStr(CInt(v))
        End If


exit_FormatParam_int:
        Exit Function

err_FormatParam_int:
        Select Case Err.Number
            Case 0
                Resume exit_FormatParam_int
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_FormatParam_int
        End Select

    End Function

    Public Function RollupText(ByRef g As UltraGrid, ByRef CallId As Integer, ByRef GroupIndex As Short, ByRef gh As Infragistics.Win.UltraWinGrid.UltraGridGroupByRow, ByRef ReportErrors As Object, ByRef arDataDistinct As DispositionData(), ByRef arDataDistinctOrgan As DispositionData()) As String

        'Dim gh As UltraGridRow
        Dim CONSENT, Appropriate, Approach, Recovery As String
        Dim count, CR As Integer
        Dim dispositionData As DispositionData
        Dim dispositionValueColumnWidth As Double = 34
        RollupText = ""
        Me.ReportErrors = ReportErrors
        If CallId = 0 Then
            Exit Function
        End If

        'get he group by header row
        'gh = g.Rows(RowKey)

        gh.Description = RollupTextStripCharacters(gh.Description)
        'CalculateHeaderRowData(dispositionData, gh)

        Select Case GroupIndex ' g.Rows(RowKey) . .OutlineLevel
            'DonorCategory Group
            Case 0
                Dim donorCategory As String = gh.Value
                dispositionData = (From c In (From orig In arDataDistinctOrgan.ToList() Where Not IsDBNull(orig.DonorCategory)).ToList() Where c.DonorCategory = donorCategory).ToList.Item(0)

                CONSENT = ""
                Recovery = ""
                'IIf(dispositionData.ARO = 0, 1, 5)
                Appropriate = Get0Appropriate(dispositionData.DonorCategoryID, 82, gh.Value)
                Approach = Get0Approach(dispositionData.DonorCategoryID, dispositionData.SubCriteriaID, dispositionData.Approach, dispositionData(7), dispositionData(8), (dispositionValueColumnWidth))
                CONSENT = Get0Consent(dispositionData.DonorCategoryID, dispositionData.Consent, dispositionData(10), (dispositionValueColumnWidth))
                Recovery = Get0Recovery(dispositionData.DonorCategoryID, dispositionData.Recovery, dispositionData(12), (dispositionValueColumnWidth))

            Case Else
                Dim subTypeName As String = gh.Value
                Dim query = (From c In (From orig In arDataDistinct.ToList() Where Not IsDBNull(orig.SubTypeName)).ToList() Where c.SubTypeName = subTypeName)
                dispositionData = (From c In (From orig In arDataDistinct.ToList() Where Not IsDBNull(orig.SubTypeName)).ToList() Where c.SubTypeName = subTypeName).ToList.Item(0)

                'case 1 SubTypeName
                Appropriate = Get1Header(dispositionData.SubCriteriaID, dispositionData.Appropriate, 1, 82 - 8, Len(gh.Value))
                Approach = Get1Header(dispositionData.SubCriteriaID, dispositionData.Approach, 2, (dispositionValueColumnWidth), 3)
                CONSENT = Get1Header(dispositionData.SubCriteriaID, dispositionData.Consent, 3, (dispositionValueColumnWidth), 3)
                If (Len(Trim(Approach)) = 0) Then
                    'BRET 4/2010 do not include a rollup if Approach does not have a value
                    CONSENT = Regex.Replace(CONSENT, "[\w,]*", " ")

                End If
                Recovery = Get1Header(dispositionData.SubCriteriaID, dispositionData.Recovery, 4, (dispositionValueColumnWidth), 3)
        End Select

        RollupText = gh.Value & ":" & Appropriate & Approach & CONSENT & Recovery
        'gh.Height = 18
        dispositionData = Nothing

    End Function
    Public Function RollupTextStripCharacters(ByVal description As String) As String
        ' Strip the infragistics added text of " : (# of Items)"

        Dim descriptionBuilder As String = ""
        Dim startIndex As Integer
        Dim endIndex As Integer

        If (description.IndexOf("(") < 0 Or description.IndexOf(")") < 0) Then
            Return description
        End If

        ' get the string
        startIndex = (description.IndexOf("(") - 1) 'get  a start index for cleanup
        endIndex = description.IndexOf(")") - startIndex + 1 'get end index for cleanup


        If (description.Length >= startIndex + endIndex) Then ' make sure the cleanup will not break.
            descriptionBuilder = description.Remove(startIndex, endIndex)
            descriptionBuilder = descriptionBuilder.Replace(" : ", "")
        End If
        Return descriptionBuilder
    End Function

    Private Function TriageDisposition(ByRef CallId As Integer) As Object
        On Error GoTo err_TriageDisposition

        Dim sql As String = ""
        Dim Result As New Object
        Dim vReturn As New Object
        If (IsNothing(mTriageDisposition)) Then
            mTriageDisposition = New Object()
        End If

        sql = "exec sps_SecondaryDispositionTriageDisposition " & CallId
        Result = modODBC.Exec(sql, mTriageDisposition)

exit_TriageDisposition:
        Exit Function

err_TriageDisposition:
        Select Case Err.Number
            Case 0
                Resume exit_TriageDisposition
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_TriageDisposition
                Resume
        End Select
    End Function

    Private Function RollupReason(ByVal col As Integer, ByVal ID As Integer) As String


        For I As Integer = 0 To UBound(mRollupReasons, 1)

            If col = mRollupReasons(I, RR_col) And ID = mRollupReasons(I, RR_id) Then
                RollupReason = mRollupReasons(I, RR_name)
                Exit Function
            End If
        Next I


    End Function

    Private Function TriageDispositionAppropriate(ByVal DonorCategoryID As Integer, ByRef mReportErrors As Object) As String

        Dim I As Integer
        TriageDispositionAppropriate = ""
        For I = 0 To UBound(mTriageDisposition, 1)
            If mTriageDisposition(I, FS_DonorCategoryID) = DonorCategoryID Then
                TriageDispositionAppropriate = mTriageDisposition(I, FS_AppropriateName)
            End If

        Next I


    End Function
    '* Function Block - Level 0 *********************************************************************************************************'
    Private Function Get0Appropriate(ByVal DonorCategoryID As Integer, ByVal WidthProcessorName As Double, ByVal GroupingValue As String) As String
        Get0Appropriate = ""
        Get0Appropriate = TriageDispositionAppropriate(DonorCategoryID, ReportErrors)
        ''Get0Appropriate = Space(LEAD + 2) & padHeader(WidthProcessorName, (Len(GroupingValue)) - 7) & Get0Appropriate
        Get0Appropriate = padHeader(WidthProcessorName - 0, (Len(GroupingValue))) & Get0Appropriate

    End Function
    Private Function Get0Approach(ByVal DonorCategoryID As Integer, ByVal SubCriteriaID As String, ByRef Appropriate As String, ByVal AppropriateAppropriate As String, ByVal ApproachAppropriate As String, ByVal WidthAppropriate As Double) As String
        'bret 4/2010
        If (Appropriate = "") Then
            Appropriate = "-1"
        End If
        Get0Approach = CheckRO_Approach(DonorCategoryID, SubCriteriaID, Appropriate, AppropriateAppropriate, ApproachAppropriate, 2, POSi, POSv)
        Get0Approach = padHeader(WidthAppropriate, 2) & Get0Approach
    End Function
    Private Function Get0Consent(ByVal DonorCategoryID As Integer, ByRef ConsentConsent As String, ByVal RecoveryConsent As String, ByVal WidthApproach As Double) As String
        'bret 4/2010
        If (ConsentConsent = "") Then
            ConsentConsent = "-1"
        End If
        Get0Consent = CheckRO(DonorCategoryID, ConsentConsent, RecoveryConsent, 3, POSi, POSv, CONSENT_FSROi, CONSENT_FSROv)
        Get0Consent = padHeader(WidthApproach, 2) & Get0Consent
    End Function
    Private Function Get0Recovery(ByVal DonorCategoryID As Integer, ByRef ApproachApproach As String, ByVal ConsentApproach As String, ByVal WidthConsent As Double) As String
        'bret 4/2010
        If (ApproachApproach = "") Then
            ApproachApproach = "-1"
        End If
        Get0Recovery = CheckRO(DonorCategoryID, ApproachApproach, ConsentApproach, 4, POSi, POSv, RECOVERY_FSROi, RECOVERY_FSROv)
        Get0Recovery = padHeader(WidthConsent, 2) & Get0Recovery
    End Function
    '* Function Block - Level 1 *********************************************************************************************************'
    Private Function Get1Header(ByVal SubCriteriaID As String, ByVal dls As String, ByVal col As Integer, ByVal WidthPName As Double, ByVal b As Integer) As String
        Get1Header = ""
        If (SubCriteriaID = "") Then
            Exit Function
        End If
        If dls = "" Then
            dls = "0"
        End If
        If pl1(col, dls) Then
            Get1Header = RollupReason(col, 1)
        ElseIf ParseListCount(SubCriteriaID, d) = ParseListCount(dls, d) Then
            Get1Header = RollupReason(col, CInt(ParseListLast(dls, d)))
        End If
        'short circuting function
        'check the value of category  if it is not equal to 1 set i to Unknown.
        'If (col = 3 And dls > 1) Or (col = 3 And dls = 0) Then
        '    dls = 5
        'End If
        'If col = 4 And dls > 1 Then
        '    dls = 11
        'End If

        Get1Header = RollupReason(col, dls)
        Get1Header = padHeader(WidthPName, b) & Get1Header
    End Function

    Private Function CheckRO(ByRef DonorCategoryID As Integer, ByRef c1 As String, ByRef c2 As String, ByRef col As Integer, Optional ByRef POSi As Integer = 0, Optional ByRef POSv As String = "", Optional ByRef NEGi As Integer = 0, Optional ByRef NEGv As String = "") As Object
        'Const NULLi As Integer = -1
        'Const NULLv As String = ""

        Dim aID As Integer = c1
        Dim aName As String = RollupReason(col, c1)
        If (col = 4 And IsNothing(aName) And DonorCategoryID > 1 And aID > 1) Then
            aName = "CNR"
        End If
        CheckRO = aName



        Call TriageArrayUpdate(DonorCategoryID, col, aID, aName)

    End Function

    Private Function CheckRO_Approach(ByVal DonorCategoryID As Integer, ByVal SubCriteriaID As String, ByVal Approach As String, ByVal c1 As String, ByVal c2 As String, ByVal col As Integer, Optional ByVal POSi As Integer = 0, Optional ByVal POSv As String = "", Optional ByVal NEGi As Integer = 0, Optional ByVal NEGv As String = "") As Object
        'Const NULLi As Integer = -1
        'Const NULLv As String = ""
        'Const FSROi As Integer = 14
        'Const FSROv As String = "Secondary RO"

        Dim aID As Integer = Approach
        Dim aName As String = RollupReason(col, Approach)
        If col = 2 And Approach = APPRCH_SECONDARY_RO Then
            aName = "Secondary RO"
        End If
        CheckRO_Approach = aName


        Call TriageArrayUpdate(DonorCategoryID, col, aID, aName)

    End Function

    Private Function CheckR0(ByRef col As Integer, ByRef DonorCategoryID As Integer, ByRef SubCriteriaID As String, ByRef c As String, Optional ByRef POSi As Integer = 0, Optional ByRef POSv As String = "", Optional ByRef NEGi As Integer = 0, Optional ByRef NEGv As String = "") As Object
        Const NULLi As Integer = -1
        Const NULLv As String = ""

        Dim aID As Integer
        Dim aName As String = ""

        If POSi = 0 Then POSi = CInt(ParseListLast(c, d))
        If POSv = "" Then POSv = RollupReason(col, CInt(ParseListLast(c, d)))
        If NEGi = 0 Then NEGi = CInt(ParseListLast(c, d))
        If NEGv = "" Then NEGv = RollupReason(col, CInt(ParseListLast(c, d)))

        If pl1(col, c) Then
            CheckR0 = POSv
            aID = POSi
            aName = POSv
        Else
            If Len(Trim(SubCriteriaID)) > 0 And ParseListCount(SubCriteriaID, d) = ParseListCount(c, d) Then
                CheckR0 = NEGv
                aID = NEGi
                aName = NEGv
            Else
                aID = NULLi
                aName = NULLv
            End If
        End If

        Call TriageArrayUpdate(DonorCategoryID, col, aID, aName)

    End Function

    Private Function pl1(ByRef col As Integer, ByRef v As Object) As Boolean
        On Error GoTo err_pl1

        'Const L = "1": Const LL = ";1;": Const L1 = ";1": Const L2 = "1;"
        'If InStr(v, LL) Or Right$(v, 2) = L1 Or Left$(v, 2) = L2 Or Trim$(v) = L Then pl1 = True

        Const APPROPRIATE_1 As String = "1"
        Const APPROACH_1 As String = "1"
        Const APPROACH_12 As String = "12"
        Const APPROACH_13 As String = "13"
        Const CONSENT_1 As String = "1"
        Const CONSENT_7 As String = "7"
        Const CONSENT_8 As String = "8"
        Const RECOVERY_1 As String = "1"

        Select Case col
            Case 1
                If v = APPROPRIATE_1 Then
                    pl1 = True
                End If

            Case 2
                If v = APPROACH_1 Or v = APPROACH_12 Or v = APPROACH_13 Then pl1 = True
            Case 3
                If v = CONSENT_1 Then pl1 = True
                If v = CONSENT_7 Then pl1 = True
                If v = CONSENT_8 Then pl1 = True
            Case 4
                If v = RECOVERY_1 Then pl1 = True
        End Select

exit_pl1:
        Exit Function

err_pl1:
        Select Case Err.Number
            Case 0
                Resume exit_pl1
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_pl1
        End Select

    End Function
    Private Function padHeader(ByVal W As Double, ByVal b As Integer) As String
        Dim stringTemp As String = ""
        padHeader = ""
        'Dim doubleConversion As Double = (W / 3.833333333) - b
        Dim doubleConversion As Double = (W) - b
        If doubleConversion < 0 Then
            padHeader = ""
            Exit Function
        End If

        padHeader = stringTemp.PadLeft(doubleConversion, " ")
    End Function

    Private Function TriageArrayUpdate(ByVal DonorCategoryID As Integer, ByVal col As Integer, ByVal ID As Integer, ByVal Name As String) As Object
        On Error GoTo err_TriageArrayUpdate

        For I As Integer = 0 To UBound(mTriageDisposition, 1)
            If CStr(DonorCategoryID) = CStr(mTriageDisposition(I, FS_DonorCategoryID)) Then
                Select Case col
                    Case 1
                        mTriageDisposition(I, FS_AppropriateID) = CStr(ID)
                        mTriageDisposition(I, FS_AppropriateName) = Name
                    Case 2
                        mTriageDisposition(I, FS_ApproachID) = CStr(ID)
                        mTriageDisposition(I, FS_ApproachName) = Name
                    Case 3
                        mTriageDisposition(I, FS_ConsentID) = CStr(ID)
                        mTriageDisposition(I, FS_ConsentName) = Name
                    Case 4
                        mTriageDisposition(I, FS_RecoveryID) = CStr(ID)
                        mTriageDisposition(I, FS_RecoveryName) = Name
                End Select
                Exit Function
            End If
        Next I

exit_TriageArrayUpdate:
        Exit Function

err_TriageArrayUpdate:
        Select Case Err.Number
            Case 0
                Resume exit_TriageArrayUpdate
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_TriageArrayUpdate
        End Select

    End Function

    Private Function ParseListCount(ByRef v As Object, ByRef c As String) As Integer
        On Error GoTo err_ParseListCount

        Dim start, I, endd As Integer

        If IsDBNull(v) Or Len(v) = 0 Then StatTracLogger.CreateInstance().Write(New Exception(ERR_ParseList))
        endd = InStr(1, v, c) : If endd = 0 Then ParseListCount = 1
        Do While endd <> 1 And endd <> 0
            endd = InStr(endd, v, c) + 1
            ParseListCount = ParseListCount + 1
        Loop

exit_ParseListCount:
        Exit Function

err_ParseListCount:
        Select Case Err.Number
            Case 0
                Resume exit_ParseListCount
            Case ERR_ParseList
                ParseListCount = 0
                Resume exit_ParseListCount
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                ParseListCount = 0
                Resume exit_ParseListCount
        End Select

    End Function

    Private Function ParseListLast(ByRef v As Object, ByRef c As String) As String
        On Error GoTo err_ParseListLast

        If IsDBNull(v) Or Len(v) = 0 Then StatTracLogger.CreateInstance().Write(New Exception(ERR_ParseList))
        ParseListLast = Right(v, Len(v) - InStrRev(v, c))

exit_ParseListLast:
        Exit Function

err_ParseListLast:
        Select Case Err.Number
            Case 0
                Resume exit_ParseListLast
            Case ERR_ParseList
                ParseListLast = "-1"
                Resume exit_ParseListLast
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_ParseListLast
        End Select

    End Function

    Private Sub Class_Initialize_Renamed()
        On Error GoTo err_Class_Initialize

        'drh FSMOD 05/20/03 - Moved code to get rollup reasons to CallId [PropertyLet]

        LEAD = 7

exit_Class_Initialize:
        Exit Sub

err_Class_Initialize:
        Select Case Err.Number
            Case 0
                Resume exit_Class_Initialize
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_Class_Initialize
                Resume
        End Select
    End Sub
    Public Sub New()
        MyBase.New()
        Class_Initialize_Renamed()
        mTriageDisposition = New Object()
        mRollupReasons = New Object()

    End Sub

    Public Property ReportErrors() As Boolean
        Get
            ReportErrors = mReportErrors
        End Get
        Set(ByVal Value As Boolean)
            mReportErrors = Value
        End Set
    End Property

    Public Property CallId() As Integer
        Get
            CallId = mCallID
        End Get
        Set(ByVal Value As Integer)
            mCallID = Value

            'drh FSMOD 05/20/03 - Moved from class_initialize and added IIF stmt
            Dim sql As String = ""
            Dim Result As New Object
            sql = IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, "exec sps_SecondaryDispositionRollupReasons_FSTables", "exec sps_SecondaryDispositionRollupReasons")
            Result = modODBC.Exec(sql, mRollupReasons)

            Call TriageDisposition(mCallID)
        End Set
    End Property

End Class