Option Strict Off
Option Explicit On
Module modSecondaryDisposition
	
	Public Const FS_APPROP_YES As Short = 1 'Appropriate constants
	Public Const FS_APPROP_AGE As Short = 2
	Public Const FS_APPROP_HIGH_RISK As Short = 3
	Public Const FS_APPROP_MED_RO As Short = 4
	Public Const FS_APPROP_NOT_APPROPRIATE As Short = 5
	Public Const FS_APPROP_PREVIOUS_VENT As Short = 6
	Public Const FS_APPROP_CONDITIONAL_RULEOUT As Short = 7
	Public Const FS_APPROP_HIGHRISK As Short = 16
	
	Public Const FS_APRCH_YES As Short = 1 'Approach constants
	Public Const FS_APRCH_UNKNOWN As Short = 2
	Public Const FS_APRCH_FAMILY_UNAVAILABLE As Short = 3
	Public Const FS_APRCH_CORONER_DENY As Short = 4
	Public Const FS_APRCH_ARREST As Short = 5
	Public Const FS_APRCH_MED_RO As Short = 6
	Public Const FS_APRCH_LOGISTICS As Short = 7
	Public Const FS_APRCH_NBD As Short = 8
	Public Const FS_APRCH_HIGH_RISK As Short = 9
	Public Const FS_APRCH_UNAPPROACHABLE As Short = 11
	Public Const FS_APRCH_YESDMV As Short = 12
	Public Const FS_APRCH_YESREG As Short = 13
	
	Public Const FS_CONSENT_YES As Short = 1 'Consent constants
	Public Const FS_CONSENT_ETHNIC As Short = 2
	Public Const FS_CONSENT_RELIGIOUS As Short = 3
	Public Const FS_CONSENT_EMOTIONAL As Short = 4
	Public Const FS_CONSENT_UNKNOWN As Short = 5
	Public Const FS_CONSENT_PREV_DISCUSSION As Short = 6
	Public Const FS_CONSENT_YESDMV As Short = 7
	Public Const FS_CONSENT_YESREG As Short = 8
	
	Public Const FS_RECOVER_YES As Short = 1 'Recovery constants
	Public Const FS_RECOVER_CORONER_DENY As Short = 2
	Public Const FS_RECOVER_ARREST As Short = 3
	Public Const FS_RECOVER_NBD As Short = 4
	Public Const FS_RECOVER_MED_RO As Short = 5
	Public Const FS_RECOVER_HIGH_RISK As Short = 6
	Public Const FS_RECOVER_LOGISTICS As Short = 7
	Public Const FS_RECOVER_HEART_TXABLE As Short = 8
	Public Const FS_RECOVER_UNKNOWN As Short = 9
	Public Const FS_RECOVER_FAMILY_RO As Short = 10

    'bret 10/06/10 removed from witin method/function
    Const SC_SubCriteriaID As Short = 0
    Const sc_CriteriaID As Short = 1
    Const sc_DonorCategoryID As Short = 2
    Const sc_SubtypeID As Short = 3
    Const sc_ProcessorID As Short = 4
    Const sc_ProcessorPrecedence As Short = 5
    Const sc_MaleUpperAge As Short = 6
    Const sc_MaleLowerAge As Short = 7
    Const sc_FemaleUpperAge As Short = 8
    Const sc_FemaleLowerAge As Short = 9
    Const sc_GeneralRuleout As Short = 10
    Const sc_MaleNotAppropriate As Short = 11
    Const sc_FemaleNotAppropriate As Short = 12
    Const sc_ReferNonPotential As Short = 13
    Const sc_LowerWeight As Short = 14
    Const sc_UpperWeight As Short = 15
    Const sc_LowerAgeUnit As Short = 16
    Const sc_DisableAppropriate As Short = 17
    Const sc_MaleUpperAgeUnit As Short = 18
    Const sc_MaleLowerAgeUnit As Short = 19
    Const sc_FemaleUpperAgeUnit As Short = 20
    Const sc_FemaleLowerAgeUnit As Short = 21
    Const sc_FemaleLowerWeight As Short = 22
    Const sc_FemaleUpperWeight As Short = 23


	Public Const SD_CallID As Short = 0
	Public Const SD_CriteriaID As Short = 1
	Public Const SD_DonorCategoryID As Short = 2
	Public Const SD_DonorCategory As Short = 3
	Public Const SD_SubCriteriaID As Short = 4
	Public Const SD_SubTypeID As Short = 5
	Public Const SD_SubTypename As Short = 6
	Public Const SD_ProcessorID As Short = 7
    Public Const SD_btn1 As Short = 8
	Public Const SD_btn2 As Short = 9
	Public Const SD_ProcessorName As Short = 10
	Public Const SD_Appropriate As Short = 11
	Public Const SD_Approach As Short = 12
	Public Const SD_Consent As Short = 13
	Public Const SD_Recovery As Short = 14
	Public Const SD_Buffer As Short = 15
	Public Const SD_SLAppropriate As Short = 16
	Public Const SD_SLApproach As Short = 17
	Public Const SD_SLConsent As Short = 18
	Public Const SD_SLRecovery As Short = 19
	Public Const SD_ARO As Short = 20
	Public Const SD_CRO As Short = 21
	Public Const SD_PRO As Short = 22
    Public Const SD_ProcessorOrder As Short = 23

	Public Const CR_CallID As Short = 0
	Public Const CR_CriteriaID As Short = 1
	Public Const CR_DonorCategoryID As Short = 2
	Public Const CR_SubCriteriaID As Short = 3
	Public Const CR_SubTypeID As Short = 4
	Public Const CR_SubTypeName As Short = 5
	Public Const CR_ProcessorID As Short = 6
	Public Const CR_ProcessorName As Short = 7
	Public Const CR_ScheduleGroupID As Short = 8
	Public Const CR_ScheduleGroupName As Short = 9
	Public Const CR_SCScheduleGroupOrgan As Short = 10
	Public Const CR_SCScheduleGroupBone As Short = 11
	Public Const CR_SCScheduleGroupTissue As Short = 12
	Public Const CR_SCScheduleGroupSkin As Short = 13
	Public Const CR_SCScheduleGroupValves As Short = 14
	Public Const CR_SCScheduleGroupEyes As Short = 15
	Public Const CR_SCScheduleGroupResearch As Short = 16
	Public Const CR_SCScheduleNoContactOnDny As Short = 17
	Public Const CR_SCScheduleContactOnCnsnt As Short = 18
	Public Const CR_SCScheduleContactOnAprch As Short = 19
	Public Const CR_SCScheduleContactOnCrnr As Short = 20
	Public Const CR_SCScheduleContactOnStatSec As Short = 21
	Public Const CR_SCScheduleContactOnStatCnsnt As Short = 22
	Public Const CR_SCScheduleContactOnCoronerOnly As Short = 23
	
	Public Const IN_CallID As Short = 0
	Public Const IN_CriteriaID As Short = 1
	Public Const IN_DonorCategoryID As Short = 2
	Public Const IN_SubCriteriaID As Short = 3
	Public Const IN_SubTypeID As Short = 4
	Public Const IN_SubTypename As Short = 5
	Public Const IN_ProcessorID As Short = 6
	Public Const IN_ProcessorName As Short = 7
    Public Const IN_FSIndicationName As Short = 8

    Const IN_ProcessorCriteria_ConditionalROID As Short = 0
    Const IN_FSAppropriateID As Short = 1
    Const IN_FSIndicationID As Short = 2
    Const IN_IndicationName As Short = 3
	
    Public Function CheckCriteria(ByRef f As System.Windows.Forms.Form, ByRef v As DispositionData(), ByRef ChkVent As Boolean, ByRef ChkAge As Boolean, ByRef chkMRO As Boolean, ByRef ReportErrors As Boolean, Optional ByRef ShowVerifyMsg As Boolean = False) As Integer

        Dim CriteriaGeneral, ParentRowConsent, ParentRowAppropriate, Appropriate, SubTypeID, DonorCategoryID, SubCriteriaID, ParentRowSubTypeID, ParentRowApproach, ParentRowRecovery, CriteriaConditional As Integer
        Dim dirty As Boolean
        Dim ConsentCheck, AppropriateCheck, ApproachCheck As Integer
        Dim R As Boolean

        If (IsNothing(AppMain.frmReferralView)) Then
            Exit Function
        End If
        AppMain.frmReferralView.DispositionNotFinished = False

        'For BigBird& = 1 To MAX_BIRD&      '1/13/03 drh - Shouldn't need outer loop because ParentRow always preceeds current row in array
        If (TypeOf v Is Array) Then


            For I As Integer = 0 To v.Length - 1

                DonorCategoryID = ReadCell(v, I, SD_DonorCategoryID, ReportErrors)
                SubTypeID = ReadCell(v, I, SD_SubTypeID, ReportErrors)
                SubCriteriaID = ReadCell(v, I, SD_SubCriteriaID, ReportErrors)
                Appropriate = ReadCell(v, I, SD_Appropriate, ReportErrors)
                ParentRowSubTypeID = ReadCell(v, I - 1, SD_SubTypeID, ReportErrors)
                ParentRowAppropriate = ReadCell(v, I - 1, SD_Appropriate, ReportErrors)
                ParentRowApproach = ReadCell(v, I - 1, SD_Approach, ReportErrors)
                ParentRowConsent = ReadCell(v, I - 1, SD_Consent, ReportErrors)
                ParentRowRecovery = ReadCell(v, I - 1, SD_Recovery, ReportErrors)

                'T.T 06/05/2007 check dispo
                AppropriateCheck = ReadCell(v, I - 1, SD_Appropriate, ReportErrors)
                ApproachCheck = ReadCell(v, I - 1, SD_Approach, ReportErrors)

                If AppropriateCheck = 1 And ApproachCheck = 0 Then
                    'MsgBox "Not Finished"
                    AppMain.frmReferralView.DispositionNotFinished = True
                End If
                'Disable finalize if disposition not finished
                If AppMain.frmReferralView.DispositionNotFinished = True Then
                    AppMain.frmReferralView.chkFinal.Enabled = False
                End If
                If AppMain.frmReferralView.DispositionNotFinished = False Then
                    AppMain.frmReferralView.chkFinal.Enabled = True
                End If
                ApproachCheck = ReadCell(v, I - 1, SD_Approach, ReportErrors)
                ConsentCheck = ReadCell(v, I - 1, SD_Consent, ReportErrors)

                If ApproachCheck = 1 And ConsentCheck = 0 Then
                    AppMain.frmReferralView.DispositionNotFinished = True
                End If
                'Disable finalize if disposition not finished
                If AppMain.frmReferralView.DispositionNotFinished = True Then
                    AppMain.frmReferralView.chkFinal.Enabled = False
                End If
                If AppMain.frmReferralView.DispositionNotFinished = False Then
                    AppMain.frmReferralView.chkFinal.Enabled = True
                End If
                'Try

                If Not v(I)(SD_ARO) Then
                    If CheckEligble(SubTypeID, ParentRowSubTypeID, ParentRowAppropriate, ParentRowApproach, ParentRowConsent, ParentRowRecovery) Then
                        CriteriaGeneral = CheckCriteriaGeneral(f, SubCriteriaID, v(I)(SD_CRO), ChkVent, ChkAge, chkMRO, ShowVerifyMsg, dirty, ReportErrors)
                        CriteriaConditional = CheckCriteriaConditional(f, SubCriteriaID, dirty, ReportErrors)
                        R = crResult(CriteriaGeneral, CriteriaConditional, v(I)(SD_Appropriate), v(I)(SD_CRO))
                    Else
                        v(I)(SD_Appropriate) = System.DBNull.Value
                        v(I)(SD_PRO) = TriState.True
                    End If
                End If
                'Catch ex As Exception

                '    modError.LogError("modSecondaryDisposition.CheckCriteria " & ex.Message)
                '    Exit Function
                'End Try

            Next I
        End If

    End Function

    Private Function crResult(ByRef crGeneral As Integer, ByRef crConditional As Integer, ByRef Appropriate As Object, ByRef CRO As Object) As Boolean

        Dim iAppropriate As Integer

        iAppropriate = modConv.TextToInt(Appropriate & "")

        If crGeneral <> APPROP_YES Then
            Appropriate = crGeneral
            CRO = TriState.True
        ElseIf crConditional <> APPROP_YES Then
            Appropriate = crConditional
            CRO = TriState.True
        ElseIf iAppropriate = 0 And crGeneral = APPROP_YES And crGeneral = APPROP_YES Then
            Appropriate = APPROP_YES
            CRO = TriState.False
        ElseIf CRO = TriState.True And crGeneral = APPROP_YES And crConditional = APPROP_YES Then
            Appropriate = APPROP_YES
            CRO = TriState.False
        Else
            CRO = TriState.False
        End If
    End Function

    Private Function CheckEligble(ByRef SubTypeID As Integer, ByRef ParentRowSubTypeID As Integer, ByVal ParentRowAppropriate As Integer, ByVal ParentRowApproach As Integer, ByVal ParentRowConsent As Integer, ByVal ParentRowRecovery As Integer) As Boolean

        If SubTypeID <> 0 And SubTypeID <> ParentRowSubTypeID Then
            CheckEligble = True
        End If

        If SubTypeID <> 0 And SubTypeID = ParentRowSubTypeID And ArrayDeadEnd(ParentRowAppropriate, ParentRowApproach, ParentRowConsent, ParentRowRecovery) Then
            CheckEligble = True
        End If

    End Function

    Public Function ArrayDeadEnd(ByVal Appropriate As Object, ByVal Approach As Object, ByVal CONSENT As Object, ByVal Recovery As Object) As Boolean
        If isRO(1, Appropriate, False) Or isRO(2, Approach, False) Or isRO(3, CONSENT, False) Or isRO(4, Recovery, False) Then
            ArrayDeadEnd = True
        End If

    End Function


    Public Function ReadCell(ByRef v As DispositionData(), ByRef Row As Integer, ByRef col As Integer, ByRef ReportErrors As Boolean) As Integer
        Dim returnValue As Integer = 0


        If IsNothing(v) Then
            Return returnValue
        End If

        If Row > UBound(v) Or Row = -1 Then
            Return returnValue
        End If
        If IsNothing(v(Row)) Then
            Return returnValue
        End If

        If IsDBNull(v(Row)(col)) Then
            Return returnValue
        ElseIf v(Row)(col).ToString().Length < 1 Then
            Return returnValue
        Else
            Try
                returnValue = CInt(v(Row)(col))
            Catch ex As Exception
                modError.LogError("modSecondaryDisposition.ReadCell " & ex.Message)
                Return returnValue
            End Try

        End If

        Return returnValue



    End Function

    Private Function UT(ByRef v As Object) As Object
        Dim stringValue As String = ""
        If IsNothing(v) Then
            Return stringValue
        End If
        If v.ToString.Length = 0 Then
            Return stringValue
        End If

        stringValue = UCase(Trim(v))
        Return stringValue

    End Function

    Public Function CheckCriteriaGeneral(ByRef f As FrmReferralView, ByRef SubCriteriaID As Integer, ByRef CRO As Object, ByRef ChkVent As Boolean, ByRef ChkAge As Boolean, ByRef chkMRO As Boolean, ByRef dirty As Boolean, ByRef ReportErrors As Boolean, Optional ByRef ShowVerifyMsg As Boolean = False) As Integer


        Dim vCriteriaReturn As New Object
        Dim crUpperAge As Double
        Dim crLowerAge As Double
        Dim crLowerWeight As Double
        Dim crUpperWeight As Double
        Dim Age As Double
        Dim Weight As Double
        Dim AgeUpperUnitPOS As Integer
        Dim AgeLowerUnitPOS As Integer
        Dim AgeUpperPOS As Integer
        Dim AgeLowerPOS As Integer
        Dim GenderNotAppropriate As Double '03/03/03 drh - Added variable for Gender appropriateness

        If IsNothing(f) Then
            Exit Function
        End If

        If QueryCategoryCriteriaSecondary(SubCriteriaID, vCriteriaReturn, ReportErrors, f.subCriteriaHash) <> SUCCESS Then
            MsgBox("There are no criteria available for SubCriteriaID: " & SubCriteriaID)
        Else
            '03/03/03 drh - Set variable for Gender appropriateness
            Select Case UT(f.Gender)
                Case "M"
                    AgeUpperUnitPOS = sc_MaleUpperAgeUnit
                    AgeLowerUnitPOS = sc_MaleLowerAgeUnit
                    AgeUpperPOS = sc_MaleUpperAge
                    AgeLowerPOS = sc_MaleLowerAge
                    GenderNotAppropriate = vCriteriaReturn(0, sc_MaleNotAppropriate)
                Case "F"
                    AgeUpperUnitPOS = sc_FemaleUpperAgeUnit
                    AgeLowerUnitPOS = sc_FemaleLowerAgeUnit
                    AgeUpperPOS = sc_FemaleUpperAge
                    AgeLowerPOS = sc_FemaleLowerAge
                    GenderNotAppropriate = vCriteriaReturn(0, sc_FemaleNotAppropriate)
            End Select
            'Try

            Select Case UT(vCriteriaReturn(0, AgeUpperUnitPOS))
                Case "YEARS"
                    crUpperAge = modConv.TextToInt(vCriteriaReturn(0, AgeUpperPOS))
                Case "MONTHS"
                    crUpperAge = modConv.TextToInt(vCriteriaReturn(0, AgeUpperPOS)) / 12
                Case "DAYS"
                    crUpperAge = modConv.TextToInt(vCriteriaReturn(0, AgeUpperPOS)) / 365
            End Select
            'Catch ex As Exception
            '    modError.LogError("modSecondaryDisposition.CheckCriteriaGeneral : Faile to set crUpperAge :" & ex.Message)
            '    crUpperAge = 0
            'End Try
            'Try

            Select Case UT(vCriteriaReturn(0, AgeLowerUnitPOS))
                Case "YEARS"
                    crLowerAge = modConv.TextToInt(vCriteriaReturn(0, AgeLowerPOS))
                Case "MONTHS"
                    crLowerAge = modConv.TextToInt(vCriteriaReturn(0, AgeLowerPOS)) / 12
                Case "DAYS"
                    crLowerAge = modConv.TextToInt(vCriteriaReturn(0, AgeLowerPOS)) / 365
            End Select
            'Catch ex As Exception
            '    modError.LogError("modSecondaryDisposition.CheckCriteriaGeneral : Faile to set crLowerAge :" & ex.Message)
            '    crLowerAge = 0

            'End Try
            'Try

            Select Case UT(f.AgeUnit)
                Case "YEARS"
                    Age = modConv.TextToInt(f.Age)
                Case "MONTHS"
                    Age = modConv.TextToInt(f.Age) / 12
                Case "DAYS"
                    Age = modConv.TextToInt(f.Age) / 365
            End Select
            'Catch ex As Exception
            '    modError.LogError("modSecondaryDisposition.CheckCriteriaGeneral : Faile to set Age :" & ex.Message)
            '    Age = 0

            'End Try

            'ccarroll 10/24/2007 - Empirix 6880, changed TextToInt to TextToDbl to accommodate floating point Weight
            Select Case UT(f.Gender)
                Case "M"
                    crUpperWeight = modConv.TextToDbl(vCriteriaReturn(0, sc_UpperWeight))
                    crLowerWeight = modConv.TextToDbl(vCriteriaReturn(0, sc_LowerWeight))
                Case "F"
                    crUpperWeight = modConv.TextToDbl(vCriteriaReturn(0, sc_FemaleUpperWeight))
                    crLowerWeight = modConv.TextToDbl(vCriteriaReturn(0, sc_FemaleLowerWeight))
            End Select

            Weight = modConv.TextToDbl(f.Weight)


            If ChkAge = TriState.True Then
                '03/03/03 drh - Added check for Gender appropriateness
                Dim vCriteriaReturnGeneralRuleout As Double
                If (vCriteriaReturn(0, sc_GeneralRuleout).ToString().Length < 1) Or (vCriteriaReturn(0, sc_GeneralRuleout).ToString().Length > 1) Then
                    vCriteriaReturnGeneralRuleout = TriState.UseDefault

                Else
                    vCriteriaReturnGeneralRuleout = vCriteriaReturn(0, sc_GeneralRuleout)
                End If
                If vCriteriaReturnGeneralRuleout = TriState.True Or GenderNotAppropriate = TriState.True Then 'General Ruleout
                    CheckCriteriaGeneral = APPROP_NOT_APPROPRIATE
                ElseIf ((crUpperAge <> 0) And (Age <> 0) And ((Age > crUpperAge) Or (Age < crLowerAge))) Then  'Age is a ruleout
                    CheckCriteriaGeneral = APPROP_AGE
                ElseIf ((crUpperWeight <> 0) And (Weight <> 0) And ((Weight > crUpperWeight) Or (Weight < crLowerWeight))) Then  'Weight is a ruleout
                    CheckCriteriaGeneral = APPROP_MED_RO
                Else 'There are no ruleouts
                    CheckCriteriaGeneral = APPROP_YES
                End If

            End If
        End If


    End Function

    Public Function CheckCriteriaConditional(ByRef f As System.Windows.Forms.Form, ByRef SubCriteriaID As Integer, ByRef dirty As Boolean, ByRef ReportErrors As Boolean) As Integer
        CheckCriteriaConditional = CheckCriteria_ConditionalIndications(f, SubCriteriaID, dirty, ReportErrors)
    End Function

    Private Function QueryCategoryCriteriaSecondary(ByRef SubCriteriaID As Integer, ByRef pvReturn As Object, ByRef ReportErrors As Object, ByRef subCriteriaHash As Hashtable) As Integer

        If TypeOf subCriteriaHash(SubCriteriaID) Is Array Then
            pvReturn = subCriteriaHash(SubCriteriaID)
            QueryCategoryCriteriaSecondary = SUCCESS
            Return QueryCategoryCriteriaSecondary
        End If

        Dim vQuery As String
        Dim vReturn As New Object

        vQuery = String.Format("SELECT [SubCriteriaID], [CriteriaID], [DonorCategoryID], [SubtypeID], [ProcessorID], [ProcessorPrecedence], [SubCriteriaMaleUpperAge], [SubCriteriaMaleLowerAge], [SubCriteriaFemaleUpperAge], [SubCriteriaFemaleLowerAge], [SubCriteriaGeneralRuleout], [SubCriteriaMaleNotAppropriate], [SubCriteriaFemaleNotAppropriate], [SubCriteriaReferNonPotential], [SubCriteriaLowerWeight], [SubCriteriaUpperWeight], [SubCriteriaLowerAgeUnit], [SubCriteriaDisableAppropriate], [SubCriteriaMaleUpperAgeUnit], [SubCriteriaMaleLowerAgeUnit], [SubCriteriaFemaleUpperAgeUnit], [SubCriteriaFemaleLowerAgeUnit], [SubCriteriaFemaleLowerWeight], [SubCriteriaFemaleUpperWeight] FROM SubCriteria WHERE SubCriteriaID = {0};", SubCriteriaID)

        Try

            QueryCategoryCriteriaSecondary = modODBC.Exec(vQuery, vReturn)
            If QueryCategoryCriteriaSecondary = SUCCESS Then
                pvReturn = vReturn
                subCriteriaHash.Add(SubCriteriaID, vReturn)
                Return QueryCategoryCriteriaSecondary
            End If
        Catch ex As Exception
            QueryCategoryCriteriaSecondary = SQL_ERROR
            modError.LogError("modSecondaryDisposition.QueryCategoryCriteriaSecondary " & ex.Message)
            Exit Function

        End Try



    End Function

    Private Function CheckCriteria_ConditionalIndications(ByRef f As FrmReferralView, ByRef SubCriteriaID As Integer, ByRef dirty As Boolean, ByRef ReportErrors As Boolean) As Integer


        Dim vQuery As String
        Dim vReturn As New Object
        Dim vReturnCode As Integer

        If Not TypeOf f.processorConditionalHash(SubCriteriaID) Is Array Then

            vQuery = String.Format("EXEC SelectCheckCriteriaConditionalIndications @SubCriteriaID = {0}, @FSConditionID = 0;", SubCriteriaID)

            Try

                vReturnCode = modODBC.Exec(vQuery, vReturn)
                f.processorConditionalHash.Add(SubCriteriaID, vReturn)
            Catch ex As Exception

                modError.LogError("modSecondaryDisposition.CheckCriteria_ConditionalIndications " & ex.Message)
                CheckCriteria_ConditionalIndications = -1
            End Try
        Else

            vReturnCode = SUCCESS
            vReturn = f.processorConditionalHash(SubCriteriaID)

        End If

        CheckCriteria_ConditionalIndications = FS_APPROP_YES

        If vReturnCode = SUCCESS Then
            For I As Integer = 0 To UBound(vReturn, 1)
                If Not IsDBNull(vReturn(I, IN_IndicationName)) Then
                    If f.Find(vReturn(I, IN_IndicationName)) Then
                        CheckCriteria_ConditionalIndications = vReturn(I, IN_FSAppropriateID)
                        dirty = True
                    End If
                End If
            Next I
        End If


    End Function



    Public Sub Discharge(ByRef v As DispositionData(), ByRef DonorCategoryID As Integer, ByRef ProcessorID As Integer, ByRef Appropriate As Object, ByRef Approach As Object, ByRef CONSENT As Object, ByRef Recovery As Object, ByRef ARO As Object, ByRef CRO As Object, ByRef ReportErrors As Boolean)
        On Error GoTo err_Discharge

        Dim I As Integer

        For I = 0 To UBound(v)
            If v(I)(SD_DonorCategoryID) = DonorCategoryID And v(I)(SD_ProcessorID) = ProcessorID.ToString() And v(I)(SD_ARO) <> TriState.True And v(I)(SD_CRO) <> TriState.True Then
                v(I)(SD_Appropriate) = Appropriate.ToString()
                v(I)(SD_Approach) = Approach.ToString()
                v(I)(SD_Consent) = CONSENT.ToString()
                v(I)(SD_Recovery) = Recovery.ToString()
            End If
        Next I

exit_Discharge:
        Exit Sub

err_Discharge:
        Select Case Err.Number
            Case 0
                Resume exit_Discharge
            Case Else
                If ReportErrors Then MsgBox(Err.Description)
                Resume exit_Discharge
                Resume
        End Select

    End Sub

    Public Function QSDIndications(ByRef CallId As Integer, ByRef v As Object, ByRef ReportErrors As Boolean) As Object

        Dim sql As String = ""
        Dim Result As New Object

        sql = String.Format("sps_SecondaryDispositionRetrieveIndications {0};", CallId)
        Try
            Result = modODBC.Exec(sql, v)
        Catch ex As Exception

            modError.LogError("modSecondaryDisposition.QSDIndications " & ex.Message)

            Result = SQL_ERROR
        End Try



    End Function


    Public Function CheckIndications(ByRef f As FrmReferralView, ByRef SubCriteriaID As Integer, ByRef v As Object, ByRef ReportErrors As Boolean) As Boolean
        Dim check As Boolean = False

        If Not TypeOf v Is Array Then
            Return check
        End If
        For I As Integer = 0 To UBound(v, 1)
            If CStr(v(I, IN_SubCriteriaID)) = CStr(SubCriteriaID) Then
                If f.Find(modConv.NullToText(v(I, IN_FSIndicationName))) Then
                    check = True
                    Return check
                End If

            End If
        Next I

        Return check

    End Function

    Public Function isRO(ByRef c As Integer, ByRef v As Object, ByRef ReportErrors As Boolean) As Boolean
        If IsDBNull(v) Or IsDBNull(c) Then Exit Function
        If Trim(v) = "" Or Trim(c) = "" Then Exit Function
        Try

            v = CInt(v)
        Catch ex As Exception

            modError.LogError("modSecondaryDisposition.isRO: could not convert param to Int " & ex.Message)

        End Try

        Select Case c
            Case 1 : Select Case v
                    Case 0, 1 : Case Else : isRO = True : End Select
            Case 2 : Select Case v
                    Case 0, 1, 12, 13 : Case Else : isRO = True : End Select
            Case 3 : Select Case v
                    Case 0, 1, 7, 8 : Case Else : isRO = True : End Select
            Case 4 : Select Case v
                    Case 0, 1 : Case Else : isRO = True : End Select
        End Select


    End Function

    Public Function isYES(ByRef c As Integer, ByRef v As Object, ByRef ReportErrors As Boolean) As Boolean
        Dim result As Boolean = False

        If IsDBNull(v) Then Return result
        If Trim(v) = "" Then Return result

        v = CInt(v)

        Select Case c
            Case 1 : Select Case v
                    Case 1 : result = True : Case Else : End Select
            Case 2 : Select Case v
                    Case 1, 12, 13 : result = True : Case Else : End Select
            Case 3 : Select Case v
                    Case 1, 7, 8 : result = True : Case Else : End Select
            Case 4 : Select Case v
                    Case 1 : result = True : Case Else : End Select
        End Select

        Return result


    End Function
End Module