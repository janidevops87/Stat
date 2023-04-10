Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework

Module modStatValidate
    Const REFERRAL_PENDING_TAG As String = "Referral Pending:" 'mjd 05/28/2002 Page-AutoResponse


    Public Function ValidateReferral(ByRef pvForm As FrmReferral) As Object

        Dim vReturn As Short
        Dim I As Short
        Dim vText As String = ""
        Dim vMsg As String = ""
        Dim vErrorTrace As String = ""

        Dim vAnyConsent As Boolean
        Dim vAnyApproach As Boolean
        Dim vAnyAppropriate As Boolean

        On Error GoTo localError


        '********************************************************
        'Check for complete fields
        '********************************************************

        'Validate key fields for values
        'Require Age if DOB is disabled or enabled but not entered
        If (pvForm.CallerOrg.ServiceLevel.DOB = False And pvForm.CallerOrg.ServiceLevel.Age = True And Len(pvForm.TxtAge.Text) = 0) _
            Or (pvForm.CallerOrg.ServiceLevel.DOB = True And pvForm.CallerOrg.ServiceLevel.Age = True _
                And Len(pvForm.TxtDOB.Text) = 0 And Len(pvForm.TxtAge.Text) = 0) Then
            Call modMsgForm.FormValidate("Age", pvForm.TxtAge)
            ValidateReferral = False
            Exit Function
        Else
            ValidateReferral = True
        End If

        'Require Age Unit if DOB is disabled or enabled but not entered
        If (pvForm.CallerOrg.ServiceLevel.DOB = False And pvForm.CallerOrg.ServiceLevel.Age = True And modControl.GetID(pvForm.CboAgeUnit) = -1) _
            Or (pvForm.CallerOrg.ServiceLevel.DOB = True And pvForm.CallerOrg.ServiceLevel.Age = True _
                And Len(pvForm.TxtDOB.Text) = 0 And modControl.GetID(pvForm.CboAgeUnit) = -1) Then
            Call modMsgForm.FormValidate("Age Unit", pvForm.CboAgeUnit)
            ValidateReferral = False
            Exit Function
        Else
            ValidateReferral = True
        End If

        If pvForm.CallerOrg.ServiceLevel.Vent = True Then
            If modControl.GetID(pvForm.CboVent) = -1 Then
                Call modMsgForm.FormValidate("Vent Status", pvForm.CboVent)
                ValidateReferral = False
                Exit Function
            Else
                ValidateReferral = True
            End If
        End If

        If Not IsDate(pvForm.TxtAdmitDate.Text) And pvForm.TxtAdmitDate.Text <> "" Or (Len(pvForm.TxtAdmitDate.Text) < 8 And pvForm.TxtAdmitDate.Text <> "") Then
            Call modMsgForm.FormValidate("Admit Date", pvForm.TxtAdmitDate)
            ValidateReferral = False
            Exit Function
        End If

        If Not IsDate(pvForm.TxtDeathDate.Text) And pvForm.TxtDeathDate.Text <> "" Or (Len(pvForm.TxtDeathDate.Text) < 8 And pvForm.TxtDeathDate.Text <> "") Then
            Call modMsgForm.FormValidate("Date of Death", pvForm.TxtDeathDate)
            ValidateReferral = False
            Exit Function
        End If

        'Check for COD data
        If pvForm.CallerOrg.ServiceLevel.CauseOfDeath = True Then
            If pvForm.CboCauseOfDeath.Text = "" Then
                Call modMsgForm.FormValidate("Cause of Death", pvForm.CboCauseOfDeath)
                pvForm.TabDonor.TabIndex = 0
                ValidateReferral = False
                Exit Function
            Else
                ValidateReferral = True
            End If
        End If

        'Check for Race data
        If pvForm.CboRace.Enabled = True Then
            If pvForm.CboRace.Text = "" Then
                Call modMsgForm.FormValidate("Race", pvForm.CboRace)
                ValidateReferral = False
                Exit Function
            Else
                ValidateReferral = True
            End If
        End If


        If pvForm.TxtDeathDate.Enabled = False Then
            pvForm.TxtDeathDate.Text = ""
        End If

        If pvForm.TxtDeathTime.Enabled = False Then
            pvForm.TxtDeathTime.Text = ""
        End If

        If pvForm.TxtAdmitDate.Enabled = False Then
            pvForm.TxtAdmitDate.Text = ""
        End If

        If pvForm.TxtAdmitTime.Enabled = False Then
            pvForm.TxtAdmitTime.Text = ""
        End If

        If pvForm.TxtWeight.Enabled = False Then
            pvForm.TxtWeight.Text = ""
        End If

        'Verify appropriate fields
        If pvForm.CallerOrg.ServiceLevel.AppropriateOrgan = True Then
            'Check for blank appropriate value
            If pvForm.CboAppropriate(ORGAN).Text = "" Then
                Call modMsgForm.FormValidate("Organs", pvForm.CboAppropriate(ORGAN))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateBone = True Then
            If pvForm.CboAppropriate(BONE).Text = "" Then
                Call modMsgForm.FormValidate("Bone", pvForm.CboAppropriate(BONE))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateTissue = True Then
            If pvForm.CboAppropriate(TISSUE).Text = "" Then
                Call modMsgForm.FormValidate("Soft Tissue", pvForm.CboAppropriate(TISSUE))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateSkin = True Then
            If pvForm.CboAppropriate(SKIN).Text = "" Then
                Call modMsgForm.FormValidate("Organs", pvForm.CboAppropriate(SKIN))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateValves = True Then
            If pvForm.CboAppropriate(VALVES).Text = "" Then
                Call modMsgForm.FormValidate("Valves", pvForm.CboAppropriate(VALVES))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateEyes = True Then
            If pvForm.CboAppropriate(EYES).Text = "" Then
                Call modMsgForm.FormValidate("Eyes", pvForm.CboAppropriate(EYES))
                ValidateReferral = False
                Exit Function
            End If
        End If

        If pvForm.CallerOrg.ServiceLevel.AppropriateResearch = True Then
            If pvForm.CboAppropriate(RESEARCH).Text = "" Then
                Call modMsgForm.FormValidate("Other", pvForm.CboAppropriate(RESEARCH))
                ValidateReferral = False
                Exit Function
            End If
        End If



        '******************************************************************************************************
        '******************************************************************************************************
        '******************************************************************************************************

        'Check for approach data for all approach method types
        If pvForm.CallerOrg.ServiceLevel.ApproachMethod = True Then

            If modControl.GetID(pvForm.CboApproachType) = -1 Then
                Call modMsgForm.FormValidate("Approach Type", pvForm.CboApproachType)
                pvForm.TabDonor.TabIndex = 0
                ValidateReferral = False
                Exit Function
            Else
                ValidateReferral = True
            End If

            If modControl.GetID(pvForm.CboApproachType) = UNKNOWN Or modControl.GetID(pvForm.CboApproachType) = NOT_APPROACHED Then
                If pvForm.CboApproachedBy.Text <> "" Then
                    MsgBox("There is no approach, but an approach person is specified.")
                    ValidateReferral = False
                    Exit Function
                End If
                If pvForm.CboGeneralConsent.Text <> "" Then
                    MsgBox("There is no approach, but a general consent outcome is specified.")
                    ValidateReferral = False
                    Exit Function
                End If
            End If

            If modControl.GetID(pvForm.CboApproachType) <> UNKNOWN And modControl.GetID(pvForm.CboApproachType) <> NOT_APPROACHED Then

                If pvForm.CallerOrg.ServiceLevel.ApproachBy = True Then
                    If pvForm.CboApproachedBy.Text = "" Then
                        MsgBox("There is an approach specified, but no approach by person.")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachMethod = True Then
                    If pvForm.CboGeneralConsent.Text = "" Then
                        MsgBox("There is an approach specified, but no general consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

            End If

            If pvForm.CboApproachType.Text = "" Then
                If pvForm.CboApproachedBy.Text <> "" Then
                    MsgBox("There is no approach specified, but an approach person has been selected.")
                    ValidateReferral = False
                    Exit Function
                End If

                If pvForm.CboGeneralConsent.Text <> "" Then
                    MsgBox("There is no approach specified, but a general consent outcome has been specified.")
                    ValidateReferral = False
                    Exit Function
                End If
            End If

        End If


        '******************************************************************************************************
        '******************************************************************************************************
        '******************************************************************************************************


        'Check for additional approach data for disposition approach method types
        If pvForm.CallerOrg.ServiceLevel.ApproachMethod = True Then

            '******************************************************************************************************
            '******************************************************************************************************

            If modControl.GetID(pvForm.CboApproachType) <> UNKNOWN And modControl.GetID(pvForm.CboApproachType) <> NOT_APPROACHED Then

                '******************************************************************************************************


                'Verify Approach outcome
                If pvForm.CallerOrg.ServiceLevel.ApproachOrgan = True Then
                    If modControl.GetID(pvForm.CboAppropriate(ORGAN)) = APPROP_YES And pvForm.CboApproach(ORGAN).Text = "" Then
                        MsgBox("There is an approach specified, but no organ approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If


                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(ORGAN)) <> -1 And modControl.GetID(pvForm.CboAppropriate(ORGAN)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(ORGAN)) <> -1 And modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If

                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachBone = True Then
                    If modControl.GetID(pvForm.CboAppropriate(BONE)) = APPROP_YES And pvForm.CboApproach(BONE).Text = "" Then
                        MsgBox("There is an approach specified, but no bone approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(BONE)) <> -1 And modControl.GetID(pvForm.CboAppropriate(BONE)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(BONE)) <> -1 And modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachTissue = True Then
                    If modControl.GetID(pvForm.CboAppropriate(TISSUE)) = APPROP_YES And pvForm.CboApproach(TISSUE).Text = "" Then
                        MsgBox("There is an approach specified, but no soft tissue approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(TISSUE)) <> -1 And modControl.GetID(pvForm.CboAppropriate(TISSUE)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(TISSUE)) <> -1 And modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachSkin = True Then
                    If modControl.GetID(pvForm.CboAppropriate(SKIN)) = APPROP_YES And pvForm.CboApproach(SKIN).Text = "" Then
                        MsgBox("There is an approach specified, but no skin approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(SKIN)) <> -1 And modControl.GetID(pvForm.CboAppropriate(SKIN)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(SKIN)) <> -1 And modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachValves = True Then
                    If modControl.GetID(pvForm.CboAppropriate(VALVES)) = APPROP_YES And pvForm.CboApproach(VALVES).Text = "" Then
                        MsgBox("There is an approach specified, but no heart valves approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(VALVES)) <> -1 And modControl.GetID(pvForm.CboAppropriate(VALVES)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(VALVES)) <> -1 And modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachEyes = True Then
                    If modControl.GetID(pvForm.CboAppropriate(EYES)) = APPROP_YES And pvForm.CboApproach(EYES).Text = "" Then
                        MsgBox("There is an approach specified, but no eye approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(EYES)) <> -1 And modControl.GetID(pvForm.CboAppropriate(EYES)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(EYES)) <> -1 And modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ApproachResearch = True Then
                    If modControl.GetID(pvForm.CboAppropriate(RESEARCH)) = APPROP_YES And pvForm.CboApproach(RESEARCH).Text = "" Then
                        MsgBox("There is an approach specified, but no research approach outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for 'No,...' as 'Appropriate' info with no 'Approached' option info
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboAppropriate(RESEARCH)) <> -1 And modControl.GetID(pvForm.CboAppropriate(RESEARCH)) <> APPROP_YES) And (modControl.GetID(pvForm.CboApproach(RESEARCH)) <> -1 And modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YESREG) Then
                        vText = "An option must be appropriate before an approach may have a 'No' reason."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If


                '******************************************************************************************************


                'Verify Consent Outcome
                If pvForm.CallerOrg.ServiceLevel.ConsentOrgan = True Then
                    'Check for approach data without consent data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(ORGAN).Text = "" And (modControl.GetID(pvForm.CboApproach(ORGAN)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(ORGAN)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(ORGAN)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no organ consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(ORGAN)) <> -1 And (modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(ORGAN)) <> APRCH_YESREG) Then
                        vText = "Organ consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentBone = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(BONE).Text = "" And (modControl.GetID(pvForm.CboApproach(BONE)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(BONE)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(BONE)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no bone consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(BONE)) <> -1 And (modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(BONE)) <> APRCH_YESREG) Then
                        vText = "Bone consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentTissue = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(TISSUE).Text = "" And (modControl.GetID(pvForm.CboApproach(TISSUE)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(TISSUE)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(TISSUE)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no soft tissue consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(TISSUE)) <> -1 And (modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(TISSUE)) <> APRCH_YESREG) Then
                        vText = "Tissue consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentSkin = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(SKIN).Text = "" And (modControl.GetID(pvForm.CboApproach(SKIN)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(SKIN)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(SKIN)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no skin consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(SKIN)) <> -1 And (modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(SKIN)) <> APRCH_YESREG) Then
                        vText = "Skin consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentValves = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(VALVES).Text = "" And (modControl.GetID(pvForm.CboApproach(VALVES)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(VALVES)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(VALVES)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no heart valves consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(VALVES)) <> -1 And (modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(VALVES)) <> APRCH_YESREG) Then
                        vText = "Valves consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentEyes = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(EYES).Text = "" And (modControl.GetID(pvForm.CboApproach(EYES)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(EYES)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(EYES)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no eye consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(EYES)) <> -1 And (modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(EYES)) <> APRCH_YESREG) Then
                        vText = "Eye consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                If pvForm.CallerOrg.ServiceLevel.ConsentResearch = True Then
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If pvForm.CboConsent(RESEARCH).Text = "" And (modControl.GetID(pvForm.CboApproach(RESEARCH)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(RESEARCH)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(RESEARCH)) = APRCH_YESREG) Then
                        MsgBox("There is an approach specified, but no research consent outcome.")
                        ValidateReferral = False
                        Exit Function
                    End If
                    'Check for consent data without "Yes" approach data
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If modControl.GetID(pvForm.CboConsent(RESEARCH)) <> -1 And (modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(RESEARCH)) <> APRCH_YESREG) Then
                        vText = "Other consent without a 'Yes' approach."
                        Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                        ValidateReferral = False
                        Exit Function
                    End If
                End If

                '******************************************************************************************************

            End If

            '******************************************************************************************************
            '******************************************************************************************************

            'Continue checking additional approach and consent data for
            'apporach methods with disposition

            For I = ORGAN To RESEARCH

                'Check for not approached or Unknown with 'Yes' 'Approached' options
                '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                If modControl.GetID(pvForm.CboApproachType) = NOT_APPROACHED And (modControl.GetID(pvForm.CboApproach(I)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESREG) Then
                    vText = "Not approached with 'Yes' as 'Approached' option."
                    Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                    ValidateReferral = False
                    Exit Function
                End If

                If modControl.GetID(pvForm.CboAppropriate(I)) = APPROP_YES And pvForm.CboApproach(I).Enabled = True Then
                    vAnyAppropriate = True
                    '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                    If (modControl.GetID(pvForm.CboApproach(I)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESREG) Then
                        vAnyApproach = True
                    End If
                End If

                '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
                If (modControl.GetID(pvForm.CboApproach(I)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(I)) = APRCH_YESREG) And pvForm.CboApproach(I).Enabled = True Then
                    vAnyApproach = True
                End If

                'Check if general consent is consistent
                '10/18/01 drh Added check for CONSENT_YESDMV and CONSENT_YESREG
                If modControl.GetID(pvForm.CboConsent(I)) = CONSENT_YES Or modControl.GetID(pvForm.CboConsent(I)) = CONSENT_YESDMV Or modControl.GetID(pvForm.CboConsent(I)) = CONSENT_YESREG Then
                    vAnyConsent = True
                End If

            Next I

            'Check if general consent is consistent as no
            If vAnyConsent And modControl.GetID(pvForm.CboGeneralConsent) = 3 Then
                vText = "At least one option has consent but the general consent outcome is specified as 'No'."
                Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                ValidateReferral = False
                Exit Function
            End If

            'Check if general consent is consistent as yes
            If vAnyAppropriate And Not vAnyConsent And (modControl.GetID(pvForm.CboGeneralConsent) = 1 Or modControl.GetID(pvForm.CboGeneralConsent) = 2) Then
                vText = "The general consent outcome is specified as 'Yes', but no options have been consented."
                Call MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")
                ValidateReferral = False
                Exit Function
            End If

        End If


        'Make sure DateOfBirth precedes DateOfDeath
        Dim isDobValid As Boolean
        Dim isDodValid As Boolean

        'Make sure both DateOfBirth and DateOfDeath are valid
        isDobValid = pvForm.TxtDOB.Enabled And Len(pvForm.TxtDOB.Text) = 10 And IsDate(pvForm.TxtDOB.Text)
        isDodValid = pvForm.TxtDeathDate.Enabled And Len(pvForm.TxtDeathDate.Text) = 8 And IsDate(pvForm.TxtDeathDate.Text)

        'Compare DateOfBirth with DateOfDeath
        If (isDobValid And isDodValid) Then
            If CDate(pvForm.TxtDOB.Text).CompareTo(CDate(pvForm.TxtDeathDate.Text)) > 0 Then
                Call MsgBox("Date Of Death cannot precede Date Of Birth.", MsgBoxStyle.Exclamation, "Validation Error")
                ValidateReferral = False
                Exit Function
            End If
        End If

        'ccarroll 09/09/2011 Get PNE Warning instructions on save. CCRST151
        Dim isDisplayContactRequiredWarning As Boolean

        If pvForm.Name = "FrmReferral" Then
            isDisplayContactRequiredWarning = pvForm.GetPNEWarningOnSave()
        Else
            isDisplayContactRequiredWarning = True
        End If

        If modStatValidate.ValidateReferralContacts(pvForm, isDisplayContactRequiredWarning) Then
            ValidateReferral = True
        Else
            ValidateReferral = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function ServiceLevelGroup(ByRef pvForm As FrmServiceLevelGroup) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            ServiceLevelGroup = True
            Exit Function
        End If

        ServiceLevelGroup = False

    End Function


    Public Function AlertGroup(ByRef pvForm As FrmAlertGroup) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            AlertGroup = True
            Exit Function
        End If

        AlertGroup = False

    End Function

    Public Function Organization(ByRef pvForm As FrmOrganization) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)

        ElseIf pvForm.TxtAddress1.Text = "" Then
            Call modMsgForm.FormValidate("Address 1", pvForm.TxtAddress1)

        ElseIf pvForm.TxtCity.Text = "" Then
            Call modMsgForm.FormValidate("City", pvForm.TxtCity)

        ElseIf pvForm.CboState.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("State", pvForm.CboState)

        ElseIf pvForm.CboTimeZone.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Time Zone", pvForm.CboTimeZone)

        ElseIf pvForm.TxtZipCode.Text = "" Then
            Call modMsgForm.FormValidate("Zip Code", pvForm.TxtZipCode)

        ElseIf pvForm.CboCounty.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("County", pvForm.CboCounty)

        ElseIf pvForm.TxtCentralPhone.Text = "" Then
            Call modMsgForm.FormValidate("Central Phone", pvForm.TxtCentralPhone)

        ElseIf pvForm.CboOrganizationType.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Type", pvForm.CboOrganizationType)

        Else
            Organization = True
            Exit Function

        End If

        Organization = False

    End Function
    Public Function OrganizationProperties(ByRef pvForm As FrmOrganizationProperties) As Object


        If Not modStatValidate.OrganizationCallBack(pvForm) Then
            OrganizationProperties = False
            Exit Function

        End If

        'Validate key fields for values
        OrganizationProperties = True

    End Function

    Public Function Schedule(ByRef pvForm As FrmSchedule) As Object

        'Validate key fields for values
        If pvForm.CboScheduleGroup.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Schedule Group", pvForm.CboScheduleGroup)

        ElseIf pvForm.CboOrganization.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Organization", pvForm.CboOrganization)

        Else

            'ccarroll added check for lost Organization ID value
            If modControl.GetID(pvForm.CboOrganization) = 0 Then
                Schedule = False
                Exit Function
            End If

            Schedule = True
            Exit Function

        End If

        Schedule = False

    End Function
    Public Function Criteria(ByRef pvForm As FrmCriteria) As Object

        'Validate key fields for values
        If pvForm.CboCriteriaGroup.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Criteria Group", pvForm.CboCriteriaGroup)

        ElseIf pvForm.CboDonorCategory.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Donor Category", pvForm.CboDonorCategory)

        ElseIf pvForm.TxtLowerWeight.Text <> "" And pvForm.TxtUpperWeight.Text = "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtLowerWeight.Text = "" And pvForm.TxtUpperWeight.Text <> "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        Else
            Criteria = True
            Exit Function

        End If

        Criteria = False

    End Function

    Public Function CriteriaTemplate(ByRef pvForm As FrmCriteriaTemplate) As Object
        'FSProj drh 5/9/02

        'Validate key fields for values
        If pvForm.txtCriteriaTemplateName.Text = "" Then
            MsgBox("Please enter a name for the Criteria Template!")
        ElseIf LCase(pvForm.txtCriteriaTemplateName.Text) = "blank template" Then
            MsgBox("Please enter a different name for the Criteria Template!")
        ElseIf pvForm.TxtLowerWeight.Text <> "" And pvForm.TxtUpperWeight.Text = "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtLowerWeight.Text = "" And pvForm.TxtUpperWeight.Text <> "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtFemaleLowerWeight.Text <> "" And pvForm.TxtFemaleUpperWeight.Text = "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtFemaleLowerWeight.Text = "" And pvForm.TxtFemaleUpperWeight.Text <> "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        Else
            CriteriaTemplate = True
            Exit Function

        End If

        CriteriaTemplate = False

    End Function

    Public Function SubCriteria(ByRef pvForm As FrmCriteria) As Object
        'FSProj drh 5/16/02

        'Validate key fields for values
        If pvForm.TxtLowerWeightSub.Text <> "" And pvForm.TxtUpperWeightSub.Text = "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtLowerWeightSub.Text = "" And pvForm.TxtUpperWeightSub.Text <> "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtFemaleLowerWeightSub.Text <> "" And pvForm.TxtFemaleUpperWeightSub.Text = "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        ElseIf pvForm.TxtFemaleLowerWeightSub.Text = "" And pvForm.TxtFemaleUpperWeightSub.Text <> "" Then
            MsgBox("If weight criteria is used, it must be entered for both lower and upper limits!")
        Else
            SubCriteria = True
            Exit Function

        End If

        SubCriteria = False

    End Function
    Public Function ServiceLevel(ByRef pvForm As FrmServiceLevel) As Object

        'Validate key fields for values
        If pvForm.CboServiceLevelGroup.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Service Level Group", pvForm.CboServiceLevelGroup)

        ElseIf pvForm.CboTriageLevel.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Triage Level", pvForm.CboTriageLevel)

        Else
            ServiceLevel = True
            Exit Function

        End If

        ServiceLevel = False

    End Function

    Public Function ServiceLevelDataSource(ByRef pvForm As FrmServiceLevel, Optional ByRef pvNumSelected As Short = 0) As Object
        '03/11/03 drh - Validate dataSource

        Select Case pvForm.ActiveControl.Name
            Case "cmdRemoveDSN"

                If (pvForm.rbtnIntent(0).Checked Or (pvForm.rbtnIntent(1).Checked And pvForm.chkCheckRegistry.Checked = System.Windows.Forms.CheckState.Checked)) And pvForm.LstViewSelectedDSN.Items.Count <= pvNumSelected Then

                    pvForm.LstViewAvailableDSN.Select()
                    Call MsgBox("At least one Data Source must exist for the selected Verification Type/Registry settings.  Please modify the settings and try again.", MsgBoxStyle.Exclamation, "Validation Error")
                    ServiceLevelDataSource = False
                    Exit Function
                End If

            Case "chkCheckRegistry", "rbtnIntent"

                If (pvForm.rbtnIntent(0).Checked Or (pvForm.rbtnIntent(1).Checked And pvForm.chkCheckRegistry.Checked = System.Windows.Forms.CheckState.Checked)) And pvForm.LstViewSelectedDSN.Items.Count = 0 Then

                    pvForm.LstViewAvailableDSN.Select()
                    Call MsgBox("At least one Data Source must exist for the selected Verification Type/Registry settings.  Please add a Data Source to the list and try again.", MsgBoxStyle.Exclamation, "Validation Error")
                    ServiceLevelDataSource = False
                    Exit Function
                End If

        End Select

        ServiceLevelDataSource = True

    End Function
    Public Function Alert(ByRef pvForm As FrmAlert) As Object

        'Validate key fields for values
        If pvForm.CboAlertGroup.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Service Level Group", pvForm.CboAlertGroup)

        Else
            Alert = True
            Exit Function

        End If

        Alert = False

    End Function

    Public Function MessageVal(ByRef pvForm As FrmMessage) As Object

        'Validate key fields for values

        If pvForm.CboOrganization.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Location", pvForm.CboOrganization)

        ElseIf pvForm.CboName.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Name", pvForm.CboName)

        ElseIf pvForm.CboMessageType.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Message Type", pvForm.CboMessageType)

        Else
            MessageVal = True
            Exit Function

        End If

        MessageVal = False


    End Function

    Public Function NoCallVal(ByRef pvForm As FrmNoCall) As Object

        'Validate key fields for values
        If pvForm.CboNoCallType.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("No Call Type", pvForm.CboNoCallType)

        Else
            NoCallVal = True
            Exit Function

        End If

        NoCallVal = False


    End Function

    Public Function LogEvent(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: LogEvent
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Validates field contents based on Event Type
        'Returns: Nothing
        'Params: pvForm As Form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/9/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 196
        'Description:  Added Email Pending and Email Response event types.
        '====================================================================================
        'Date Changed: 6/16/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added new LogEvent types (APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME,
        '               APPROACH_OUTCOME, SECONDARY_ATTEMPTED_NO_OUTCOME
        '************************************************************************************
        '====================================================================================
        'Date Changed: 7/18/2005                        Changed by: Thien Ta
        'Release #: 8.0                               Task: 314
        'Description:  Added new LogEvent types Case_Update
        '************************************************************************************
        'Date Changed: 6/17/2008                        Changed by: ccarroll
        'Release #: 8.4                               Task: 8.4.6
        'Description:  Added new LogEvent types: IM_Conversation, Incoming_Secondary
        '************************************************************************************

        Dim strContactName As String = ""

        If pvForm.Name = "FrmLogEvent" Then
            strContactName = pvForm.CboName.Text
        Else
            strContactName = pvForm.TxtContactName.Text
        End If
        Dim ContactEventTypeId As Integer
        Try
            ContactEventTypeId = modControl.GetID(pvForm.CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ContactEventTypeId = -1
        End Try

        Select Case ContactEventTypeId
            Case INCOMING
                'Validate key fields for values

                If strContactName = "" Then
                    Call modMsgForm.FormValidate("Name", strContactName)
                Else
                    LogEvent = True
                    Exit Function
                End If
                'FSProj 6/25/02 drh - Added Funeral_Home
            Case OUTGOING, CORONER_CASE, FUNERAL_HOME, Family_Approached
                'Validate key fields for values
                If strContactName = "" Then
                    Call modMsgForm.FormValidate("Name", strContactName)
                ElseIf strContactName = "" Then
                    Call modMsgForm.FormValidate("Phone", pvForm.TxtContactPhone)
                    'Check to see if there is a contact phone and extention to lookup
                    'or if the contact phone or extention has changed.
                ElseIf Len(pvForm.TxtContactPhone.Text) < 14 And Len(pvForm.TxtContactPhone.Text) > 0 Then
                    'Validate there is a phone number
                    Call modMsgForm.FormValidate("Contact Phone #", pvForm.TxtContactPhone)
                Else
                    LogEvent = True
                    Exit Function
                End If
            Case CONSENT_PENDING, RECOVERY_PENDING, PAGE_PENDING, Incoming_Secondary, Acknowledge_to_Evaluate ',ONLINE_REVIEW_PENDING,
                'Validate key fields for values
                If strContactName = "" Then
                    Call modMsgForm.FormValidate("Name", strContactName)
                ElseIf pvForm.TxtContactPhone.Text = "" Then
                    Call modMsgForm.FormValidate("Phone", pvForm.TxtContactPhone.Text)
                    'Check to see if there is a contact phone and extention to lookup
                    'or if the contact phone or extention has changed.
                ElseIf Len(pvForm.TxtContactPhone.Text) < 14 And Len(pvForm.TxtContactPhone.Text) > 0 Then
                    'Validate there is a phone number
                    Call modMsgForm.FormValidate("Contact Phone #", pvForm.TxtContactPhone.Text)
                Else
                    LogEvent = True
                    Exit Function
                End If
                '10/8/01 drh Added Outgoing Fax validation
                'Added Email Response 12/1/04 - SAP
                'Added new LogEvent types for v. 8.0 6/16/05 - SAP
                'Bret 3/12/09 added donornet types DonorNet_Acceptance, DonorNet_Decline, Labs_Received
                'Andrey 2/5/2020 added Verification_Form_Sent
            Case CONSENT_RESPONSE, RECOVERY_RESPONSE, PAGE_RESPONSE, ONLINE_REVIEW_RESPONSE, ONLINE_REVIEW_PENDING, OUTGOING_FAX, FAX_PENDING, NO_CONSENT_RESPONSE, NO_RECOVERY_RESPONSE, NO_PAGE_RESPONSE, SECONDARY_RESPONSE, EMAIL_RESPONSE, Client_Consent_Outcome, Client_Recovery_Outcome, DonorNet_Acceptance, DonorNet_Decline, Labs_Received, No_Labs_Received, Verification_Form_Sent
                ' APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME, APPROACH_OUTCOME, SECONDARY_ATTEMPTED_NO_OUTCOME
                'Validate key fields for values
                If strContactName = "" Then
                    Call modMsgForm.FormValidate("Name", strContactName)
                Else
                    LogEvent = True
                    Exit Function
                End If
            Case SECONDARY_PENDING
                'Validate key fields for values
                If pvForm.TxtContactOrg.Text = "" Then
                    Call modMsgForm.FormValidate("Organization", pvForm.TxtContactOrg.Text)
                Else
                    LogEvent = True
                    Exit Function
                End If
                ' Added Email Pending event type.  12/1/04 - SAP
                ' Added Update_Event. 07/15/2005 - T.T
                'Bret 3/12/09 Donor_Card
            Case GENERAL, CASE_HAND_OFF, EMAIL_PENDING, Case_Update, QA_Note, Manual_Registry_Checked, Consent_Obtained, Paperwork_Completed, Paperwork_Faxed, IM_Conversation, Donor_Card, DECLARED_CTOD_CONFIRMED, DECLARED_CTOD_PENDING, ORGAN_MED_RO_CONFIRMED, ORGAN_MED_RO_PENDING, Process_Exception, EMAIL_SENT, PAGE_SENT, EREFERRAL_RESPONSE

                LogEvent = True
                Exit Function

            Case CALLBACK_PENDING, Labs_Pending
                If pvForm.TxtCalloutDate.Text = "" Or pvForm.TxtCalloutMins.Text = "" Then
                    Call modMsgForm.FormValidate("Callout Minutes", pvForm.TxtCalloutMins.Text)
                Else
                    LogEvent = True
                    Exit Function
                End If

        End Select

        LogEvent = False


    End Function
    Public Function Person(ByRef pvForm As FrmPerson) As Object

        'Validate key fields for values
        If pvForm.TxtFirst.Text = "" Then
            Call modMsgForm.FormValidate("First", pvForm.TxtFirst)

        ElseIf pvForm.TxtLast.Text = "" Then
            Call modMsgForm.FormValidate("Last", pvForm.TxtLast)

        ElseIf pvForm.CboOrganization.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Organization", pvForm.CboOrganization)

        ElseIf pvForm.CboPersonType.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Type", pvForm.CboPersonType)

        ElseIf modStatQuery.QueryDuplicatePerson(pvForm) = SUCCESS And pvForm.FormState = NEW_RECORD Then
            Call modMsgForm.DuplicateName()

            'add query to check for duplicate username and password across all organizations.

        Else
            Person = True
            Exit Function

        End If

        Person = False

    End Function

    Public Function County(ByRef pvForm As FrmCounty) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName.Text)

        ElseIf pvForm.CboState.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("State", pvForm.CboState.Text)

        Else
            County = True
            Exit Function

        End If

        County = False

    End Function

    Public Function ScheduleShift(ByRef pvForm As Object) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName.Text)

        ElseIf pvForm.CboDay.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Day", pvForm.CboDay.Text)

        ElseIf pvForm.TxtStart.Text = "" Then
            Call modMsgForm.FormValidate("Start", pvForm.TxtStart.Text)

        ElseIf pvForm.TxtEnd.Text = "" Then
            Call modMsgForm.FormValidate("End", pvForm.TxtEnd.Text)

        Else
            ScheduleShift = True
            Exit Function

        End If

        ScheduleShift = False
    End Function
    Public Function ScheduleShiftItem(ByRef pvForm As Object) As Object

        'Validate key fields for values
        If pvForm.FraSingle.Visible Then
            If pvForm.TxtName.Text = "" Then
                Call modMsgForm.FormValidate("Name", pvForm.TxtName.Text)

            ElseIf pvForm.CboStartTime.Text = "" Then
                Call modMsgForm.FormValidate("Start Time", pvForm.CboStartTime)

            ElseIf pvForm.CboEndTime.Text = "" Then
                Call modMsgForm.FormValidate("End Time", pvForm.CboEndTime)

            ElseIf pvForm.CboEndDate.Value.ToString = "" Then
                Call modMsgForm.FormValidate("End Date", pvForm.CboEndTime)

            ElseIf pvForm.CboStartDate.Value.ToString = "" Then
                Call modMsgForm.FormValidate("Start Date", pvForm.CboEndTime)

            Else
                ScheduleShiftItem = True
                Exit Function

            End If
        End If

        ScheduleShiftItem = False

    End Function

    Public Function OrganizationType(ByRef pvForm As FrmOrganizationType) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            OrganizationType = True
            Exit Function
        End If

        OrganizationType = False

    End Function
    Public Function PersonProperties(ByRef pvForm As FrmPersonProperties) As Object

        'Validate key fields for values
        If pvForm.TxtUserID.Text = "" Then
            Call modMsgForm.FormValidate("User ID", pvForm.TxtUserID)

            'drh 8/28/01 Validate this is not a duplicate UserId
        ElseIf modStatQuery.QueryDuplicateUser(pvForm) = SUCCESS Then
            Call modMsgForm.DuplicateUser()
        ElseIf pvForm.TxtPassword.Text = "" Then
            Call modMsgForm.FormValidate("Password", pvForm.TxtPassword)
        ElseIf pvForm.TxtConfirm.Text = "" Then
            Call modMsgForm.FormValidate("Confirm Password", pvForm.TxtConfirm)
        Else
            PersonProperties = True
            Exit Function
        End If

        PersonProperties = False

    End Function

    Public Function MessageType(ByRef pvForm As FrmMessageType) As Object

        'Validate key fields for values
        If pvForm.Controls.Find("TxtName", True).Length = 0 Then
            MessageType = True
            Exit Function

        End If
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            MessageType = True
            Exit Function
        End If

        MessageType = False

    End Function

    Public Function Reference(ByRef pvForm As FrmReference) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Text", pvForm.TxtName)
        Else
            Reference = True
            Exit Function
        End If

        Reference = False

    End Function


    Public Function NoCallType(ByRef pvForm As FrmNoCallType) As Object

        'Validate key fields for values
        If (pvForm.TxtName.Text = "" Or pvForm.TxtName.Text.Length > 50) Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            NoCallType = True
            Exit Function
        End If

        NoCallType = False

    End Function
    Public Function CauseOfDeath(ByRef pvForm As FrmCauseOfDeath) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            CauseOfDeath = True
            Exit Function
        End If

        CauseOfDeath = False

    End Function
    Public Function ReferralTypeDefault(ByRef pvForm As FrmReferral) As Object

        Dim I As Short
        Dim vReferralType As Short
        Dim vTempValue As Short
        Dim vTestRecoveryValue As String
        Dim vTestConsentValue As String
        Dim vTestAppropriateValue As String
        Dim vTestApproachValue As String

        'Get the current value
        vTempValue = modControl.GetID(pvForm.CboReferralType)

        If pvForm.CallerOrg.ServiceLevel.AppropriateOrgan = True Or pvForm.CallerOrg.ServiceLevel.AppropriateBone = True Or pvForm.CallerOrg.ServiceLevel.AppropriateTissue = True Or pvForm.CallerOrg.ServiceLevel.AppropriateSkin = True Or pvForm.CallerOrg.ServiceLevel.AppropriateValves = True Or pvForm.CallerOrg.ServiceLevel.AppropriateEyes = True Or pvForm.CallerOrg.ServiceLevel.AppropriateResearch = True Then

            vReferralType = RULEOUT
            pvForm.pvPrelimReferralType = RULEOUT
            'Test Organs
            vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(ORGAN))
            vTestConsentValue = modControl.GetID(pvForm.CboConsent(ORGAN))
            vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(ORGAN))
            vTestApproachValue = modControl.GetID(pvForm.CboApproach(ORGAN))
            If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = ORGAN_

            'Test all five tissue, when you have a yes go on to eyes
            vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(TISSUE))
            vTestConsentValue = modControl.GetID(pvForm.CboConsent(TISSUE))
            vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(TISSUE))
            vTestApproachValue = modControl.GetID(pvForm.CboApproach(TISSUE))
            If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, TISSUE_)
            If Not vReferralType.ToString().Contains(TISSUE_) Then
                vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(BONE))
                vTestConsentValue = modControl.GetID(pvForm.CboConsent(BONE))
                vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(BONE))
                vTestApproachValue = modControl.GetID(pvForm.CboApproach(BONE))
                If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, TISSUE_)
            End If
            If Not vReferralType.ToString().Contains(TISSUE_) Then
                vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(SKIN))
                vTestConsentValue = modControl.GetID(pvForm.CboConsent(SKIN))
                vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(SKIN))
                vTestApproachValue = modControl.GetID(pvForm.CboApproach(SKIN))
                If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, TISSUE_)
            End If
            If Not vReferralType.ToString().Contains(TISSUE_) Then
                vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(VALVES))
                vTestConsentValue = modControl.GetID(pvForm.CboConsent(VALVES))
                vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(VALVES))
                vTestApproachValue = modControl.GetID(pvForm.CboApproach(VALVES))
                If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, TISSUE_)
            End If
            If Not vReferralType.ToString().Contains(TISSUE_) Then
                vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(RESEARCH))
                vTestConsentValue = modControl.GetID(pvForm.CboConsent(RESEARCH))
                vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(RESEARCH))
                vTestApproachValue = modControl.GetID(pvForm.CboApproach(RESEARCH))
                If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, TISSUE_)
            End If

            'Test Eyes
            vTestRecoveryValue = modControl.GetID(pvForm.CboRecovery(EYES))
            vTestConsentValue = modControl.GetID(pvForm.CboConsent(EYES))
            vTestAppropriateValue = modControl.GetID(pvForm.CboAppropriate(EYES))
            vTestApproachValue = modControl.GetID(pvForm.CboApproach(EYES))
            If CreateReferralType(vTestRecoveryValue, vTestConsentValue, vTestAppropriateValue, vTestApproachValue) Then vReferralType = String.Concat(vReferralType, EYE_ONLY)

            'now the fun part...translate the end product...what was concatenated, make one of 8 referral types
            If vReferralType = 783 Then
                vReferralType = ORGAN_TISSUE_EYE
            ElseIf vReferralType = 78 Then
                vReferralType = ORGAN_TISSUE
            ElseIf vReferralType = 73 Then
                vReferralType = ORGAN_EYE
            ElseIf vReferralType = 7 Then
                vReferralType = ORGAN_
            ElseIf vReferralType = 48 Then
                vReferralType = TISSUE_
            ElseIf vReferralType = 483 Then
                vReferralType = TISSUE_EYE
            ElseIf vReferralType = 43 Then
                vReferralType = EYE_ONLY
            End If

            'this will do the prelim ref type value
            If modControl.GetID(pvForm.CboAppropriate(EYES)) = APPROP_YES Then
                pvForm.pvPrelimReferralType = EYE_ONLY
            End If

            If modControl.GetID(pvForm.CboAppropriate(VALVES)) = APPROP_YES Or modControl.GetID(pvForm.CboAppropriate(SKIN)) = APPROP_YES Or modControl.GetID(pvForm.CboAppropriate(TISSUE)) = APPROP_YES Or modControl.GetID(pvForm.CboAppropriate(BONE)) = APPROP_YES Then
                pvForm.pvPrelimReferralType = TISSUE_EYE
            End If

            If modControl.GetID(pvForm.CboAppropriate(ORGAN)) = APPROP_YES Then
                pvForm.pvPrelimReferralType = ORGAN_TISSUE_EYE
            End If

            If modControl.GetID(pvForm.CboAppropriate(ORGAN)) = APPROP_PREVIOUS_VENT Then
                If pvForm.CallerOrg.ServiceLevel.PrevVentClass = PREVVENT_OTE Then
                    pvForm.pvPrelimReferralType = ORGAN_TISSUE_EYE
                End If
            End If

            Call modControl.SelectID(pvForm.CboReferralType, vReferralType)

        End If

        'If the value did not change, call the click event
        If modControl.GetID(pvForm.CboReferralType) = vTempValue Then
            'Force a click event

            'ccarroll 06/28/2010 do not change if already at default setting
            'Changing causes vb.net to fire event for CboReferralType.Selected Index change
            If (modControl.GetID(pvForm.CboReferralType) <> 2) Then
                Call modControl.SelectNone(pvForm.CboReferralType)
            End If

            Call modControl.SelectID(pvForm.CboReferralType, vTempValue)
        End If

    End Function

    Public Function CreateReferralType(ByVal refCboRecovery As String, ByVal refCboConsent As String, ByVal refCboAppropriate As String, ByVal refCboApproach As String) As Boolean
        CreateReferralType = False
        'if you find a yes its good and return
        'else if you have have something other than yes and its not a blank its false and return
        'if you have a blank, keep going
        If refCboRecovery = RECOVER_YES Then
            CreateReferralType = True
            Exit Function
        Else
            If refCboRecovery <> RECOVER_YES And refCboRecovery <> RECOVER_BLANK Then
                CreateReferralType = False
                Exit Function
            End If
        End If
        If refCboConsent = CONSENT_YES Then
            CreateReferralType = True
            Exit Function

        Else
            If refCboConsent <> CONSENT_YES And refCboConsent <> CONSENT_BLANK Then
                CreateReferralType = False
                Exit Function
            End If
        End If
        If refCboApproach = APRCH_YES Then
            CreateReferralType = True
            Exit Function
        Else
            If refCboApproach <> APRCH_YES And refCboApproach <> APRCH_BLANK Then
                CreateReferralType = False
                Exit Function
            End If
        End If
        If refCboAppropriate = APPROP_YES Then
            CreateReferralType = True
            Exit Function
        Else
            If refCboAppropriate <> APPROP_YES And refCboAppropriate <> APPROP_BLANK Then
                CreateReferralType = False
                Exit Function
            End If
        End If

    End Function

    Public Function Misspelling(ByRef pvForm As FrmMisspelling) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            Misspelling = True
            Exit Function
        End If

        Misspelling = False

    End Function

    Public Function Indication(ByRef pvForm As FrmIndication) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            Indication = True
            Exit Function
        End If

        Indication = False

    End Function

    Public Function KeyCode(ByRef pvForm As FrmKeyCode) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            KeyCode = True
            Exit Function
        End If

        KeyCode = False

    End Function


    Public Function DictionaryItem(ByRef pvForm As FrmDictionaryItem) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            DictionaryItem = True
            Exit Function
        End If

        DictionaryItem = False

    End Function


    Public Function ScheduleGroup(ByRef pvForm As FrmScheduleGroup) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName.Text)
        Else
            ScheduleGroup = True
            Exit Function
        End If

        ScheduleGroup = False

    End Function

    Public Function CriteriaGroup(ByRef pvForm As Object) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            CriteriaGroup = True
            Exit Function
        End If

        CriteriaGroup = False

    End Function

    Public Function Phone(ByRef pvForm As FrmPersonPhone) As Object
        '************************************************************************************
        'Name: Phone
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Validates a phone number on a form
        'Returns: Boolean True or False
        'Params: pvForm As Form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/13/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Skip validation of phone if of type Email.
        '====================================================================================
        '************************************************************************************

        'Validate key fields for values
        If pvForm.CboPhoneType.SelectedIndex = -1 Then
            Call modMsgForm.FormValidate("Type", pvForm.CboPhoneType)
            Phone = False
            Exit Function
        Else
            Phone = True

        End If

        If pvForm.TxtPhone.Text = "" Or Len(pvForm.TxtPhone.Text) < 14 Then
            If UCase(pvForm.Name) = "FRMPERSONPHONE" Then
                'Don't require phone number for Email PhoneType (11).  Ver. 7.7.2 - 12/13/04 - SAP
                If pvForm.CboPhoneType.Items(pvForm.CboPhoneType.SelectedIndex).Value = 11 Then
                    If Len(pvForm.TxtAlpha.Text) = 0 Or InStr(1, pvForm.TxtAlpha.Text, "@") = 0 Then
                        Call modMsgForm.FormValidate("Alpha Pager Email Address", pvForm.TxtAlpha)
                    Else
                        Phone = True
                        Exit Function
                    End If
                End If
            End If

            Call modMsgForm.FormValidate("Phone #", pvForm.TxtPhone)
            Phone = False
            Exit Function

        Else
            Phone = True
            Exit Function

        End If

    End Function


    Public Function PersonType(ByRef pvForm As FrmPersonType) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            PersonType = True
            Exit Function
        End If

        PersonType = False

    End Function
    Public Function SubLocation(ByRef pvForm As FrmSubLocation) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            SubLocation = True
            Exit Function
        End If

        SubLocation = False

    End Function

    Public Function ValidateSpelling(ByRef pvTextbox As System.Windows.Forms.RichTextBox) As Object

        Dim I As Short
        Dim vAllMisspelledList As New Object
        Dim vText As String = ""
        Dim vReturn As DialogResult
        Dim regex As System.Text.RegularExpressions.Regex
        Dim message As String = String.Format("This word is misspelled or formated incorrectly!{0}Would you like to correct automatically?", ControlChars.CrLf)

        Call modUtility.Work()

        'Get the current text string
        vText = pvTextbox.Text

        'Set all the words to black
        pvTextbox.SelectionStart = 0
        pvTextbox.SelectionLength = Len(vText)
        pvTextbox.SelectionColor = Color.Black 'System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Black)


        pvTextbox.Text = " " + vText + " "

        'Get an array of all the misspelled words
        Try
            Call modStatQuery.QueryMisspellingDictionaryItems(vAllMisspelledList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Compare each misspelled word with the text passed to the function
        If TypeOf vAllMisspelledList Is Array Then
            For I = 0 To UBound(vAllMisspelledList, 2)
                'If there is a match, then...
                'Select the word
                Dim misSpelling As String = vAllMisspelledList(0, I).ToString()
                Dim pattern As String
                pattern = GetPattern(misSpelling)

                regex = New System.Text.RegularExpressions.Regex(pattern)

                Dim match As System.Text.RegularExpressions.Match = regex.Match(pvTextbox.Text.Replace(Chr(146), Chr(39)))

                'set the select position
                If match.Success Then
                    pvTextbox.SelectionStart = match.Index
                    'vStartPos
                    'select to the end of the matched word
                    pvTextbox.SelectionLength = match.Length
                    'turn the word red
                    pvTextbox.SelectionColor = Color.Red
                    pvTextbox.ScrollToCaret()

                    If (pvTextbox.SelectionLength > 0) Then

                        vReturn = System.Windows.Forms.MessageBox.Show(message, "Spellcheck", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1)

                        Select Case vReturn
                            Case MsgBoxResult.Yes
                                pvTextbox.SelectionColor = Color.Black
                                If pvTextbox.SelectionLength > 0 Then
                                    pvTextbox.SelectedText = vAllMisspelledList(1, I)
                                End If

                                pvTextbox.SelectionLength = 0
                                'Start from the beginning again
                                I = 0
                            Case MsgBoxResult.No
                                pvTextbox.SelectionColor = Color.Black
                                pvTextbox.SelectionLength = 0
                        End Select
                    End If
                End If
            Next I
        End If

        pvTextbox.SelectionLength = 0
        vText = pvTextbox.Text.Trim(" ")
        pvTextbox.Text = vText

        Call modUtility.Done()

        Return True
    End Function

    Private Function GetPattern(ByVal misSpelling As String) As String
        Dim pattern As String

        pattern = String.Format("(?<!=*[\w'\[\]])({0})(?!=*[\w'\[\]])", misSpelling.Replace("[", "\[").Replace("]", "\]").Replace("?", "\?").Replace("'", "\'").Replace(".", "\."))

        Return pattern
    End Function

    Public Function VerifyReferral(ByRef pvForm As FrmReferral, ByRef pvCheckVent As Object, ByRef pvCheckAge As Object, ByRef pvCheckMRO As Object, Optional ByRef pvShowVerifyMsg As Object = Nothing) As Object

        Dim I As Short
        Dim j As Short
        Dim vVent As Short
        Dim vHeartBeat As Short '01/08/04 mds variable to hold heart beat value
        Dim vNeuro As Boolean
        Dim vReferralTypeID As Short

        Dim vCriteriaReturn As New Object
        Dim vLowerAge As Single
        Dim vUpperAge As Single
        Dim vWeight As New Object
        Dim tempvar As String = ""

        Dim vIndicationReturn As New Object
        Dim vCase As String = ""

        Dim vVerifyList As New Object
        Dim vIndicationList As New Object
        Dim vTempRow As New Object
        Dim vTemp As New Object
        Dim vTempVar As Short
        Dim vAddRow As Boolean

        Dim vAgeEligible As Boolean
        Dim vWeightEligible As Boolean
        Dim vMedicalEligible As Boolean
        Dim vAnyUnconditional As Boolean
        Dim vAnyHighRisk As Boolean
        Dim vOnlyOption As Boolean
        Dim vAppropriate As New Hashtable
        Dim vIndicationRuleOut As Short 'T.T 12/05/2006 indication rule out



        For I = RESEARCH To ORGAN Step -1
            If pvForm.CboAppropriate(I).Text <> "" Then
                Try
                    vAppropriate.Add(I, modControl.GetID(pvForm.CboAppropriate(I)))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
            'Call modControl.SelectID(pvForm.CboAppropriate(I), vAppropriate(I))
        Next I
        Call modUtility.Work()

        'Default
        vAgeEligible = True

        'If not checking for medical ruleout conditions,
        'then assume the patient is medically eligible.
        If pvCheckMRO = False Then
            vMedicalEligible = True
        End If

        'FSProj drh 4/30/02 - Before we start, get Triage Options Criteria
        Try
            Call pvForm.PopulateCriteria()
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvCheckAge = True Then

            'Step backward to fill the VerifyList array from the bottom
            For I = RESEARCH To ORGAN Step -1

                If modStatValidate.OptionValid(pvForm, I) = True Then

                    'Set the donor category ID
                    pvForm.DonorCategoryID = I

                    'Get the criteria ID
                    'FSProj drh 4/30/02 - Remove the following line; will use ReferralTriageCriteria collection instead
                    'Call modStatQuery.QueryCategoryGroupsApplicable(pvForm)

                    'FSProj drh 4/30/02 - Get Criteria Group ID for this Triage Option from ReferralTriageCriteria collection
                    pvForm.CriteriaGroupID = pvForm.ReferralTriageCriteria.Item(CStr(I))

                    'First check if the option is appropriate
                    Dim categoryCriteriaAppropriate As Short = SQL_ERROR
                    Try
                        categoryCriteriaAppropriate = modStatQuery.QueryCategoryCriteria(pvForm, vCriteriaReturn)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    If categoryCriteriaAppropriate <> SUCCESS Then
                        MsgBox("There are no criteria available for " & pvForm.CmdOption(I).Text & ".")
                    Else


                        '***********************************************************************************************
                        '       Verify Age
                        '***********************************************************************************************

                        Select Case pvForm.CboGender.Text

                            Case "M"

                                'Convert the lower age on the referral into the same units as the criteria
                                If vCriteriaReturn(0, 23) = "Years" Then
                                    'Convert the age of the patient in to years
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 365
                                    End If
                                ElseIf vCriteriaReturn(0, 23) = "Months" Then
                                    'Convert the age of the patient to months
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) * 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 30.4
                                    End If
                                End If

                                'Convert the upper age on the referral into the same units as the criteria
                                If vCriteriaReturn(0, 22) = "Years" Then
                                    'Convert the age of the patient in to years
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 365
                                    End If
                                ElseIf vCriteriaReturn(0, 22) = "Months" Then
                                    'Convert the age of the patient to months
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) * 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 30.4
                                    End If
                                End If

                                If vCriteriaReturn(0, 9) = -1 Then
                                    Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_NOT_APPROPRIATE)
                                    pvForm.CboAppropriate(I).Tag = 0 'T.T 12/10/2006 appropriate tag 0
                                    vAgeEligible = False
                                Else
                                    If vLowerAge >= modConv.TextToInt(vCriteriaReturn(0, 4)) And vUpperAge <= modConv.TextToInt(vCriteriaReturn(0, 3)) Then
                                        'Age is not a ruleout
                                        vAgeEligible = True
                                        Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_YES)

                                    Else
                                        'Age is a ruleout
                                        vAgeEligible = False
                                        Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_AGE)
                                        pvForm.CboAppropriate(I).Tag = 2410 'T.T 12/05/2006 age ruleout added  for ruleoutcounts
                                    End If
                                End If


                            Case "F"

                                'Convert the lower age on the referral into the same units as the criteria
                                If vCriteriaReturn(0, 25) = "Years" Then
                                    'Convert the age of the patient in to years
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 365
                                    End If
                                ElseIf vCriteriaReturn(0, 25) = "Months" Then
                                    'Convert the age of the patient to months
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) * 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vLowerAge = modConv.TextToInt(pvForm.TxtAge.Text) / 30.4
                                    End If
                                End If

                                'Convert the upper age on the referral into the same units as the criteria
                                If vCriteriaReturn(0, 24) = "Years" Then
                                    'Convert the age of the patient in to years
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 365
                                    End If
                                ElseIf vCriteriaReturn(0, 24) = "Months" Then
                                    'Convert the age of the patient to months
                                    If modControl.GetText(pvForm.CboAgeUnit) = "Years" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) * 12
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Months" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text)
                                    ElseIf modControl.GetText(pvForm.CboAgeUnit) = "Days" Then
                                        vUpperAge = modConv.TextToInt(pvForm.TxtAge.Text) / 30.4
                                    End If
                                End If

                                If vCriteriaReturn(0, 11) = -1 Then
                                    Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_NOT_APPROPRIATE)
                                    pvForm.CboAppropriate(I).Tag = 0
                                    vAgeEligible = False
                                Else
                                    If vLowerAge >= modConv.TextToInt(vCriteriaReturn(0, 6)) And vUpperAge <= modConv.TextToInt(vCriteriaReturn(0, 5)) Then
                                        'Age is not a ruleout
                                        vAgeEligible = True
                                        'If pvForm.VerifiedOptions = False Then
                                        Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_YES)

                                        'End If
                                    Else
                                        'Age is a ruleout
                                        vAgeEligible = False
                                        Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_AGE)
                                        'vIndicationRuleOut = modStatQuery.QueryIndicationRuleOut("Age")                 'T.T 12/05/2006 lookup age ruleout for indication
                                        pvForm.CboAppropriate(I).Tag = 2410


                                    End If
                                End If
                        End Select

                        If vAgeEligible = True Then
                            'Get the weight
                            vWeight = modConv.TextToDbl(pvForm.TxtWeight.Text) 'T.T 11/01/2006 changed to conversion dbl

                            'Check if there is weight to verify
                            If pvForm.TxtWeight.Text = "" Then
                                vWeightEligible = True
                            Else

                                'Check weight eligibility
                                If vCriteriaReturn(0, 14) = "" Or vCriteriaReturn(0, 15) = "" Then
                                    vWeightEligible = True
                                Else
                                    If vWeight >= modConv.TextToDbl(vCriteriaReturn(0, 14)) And vWeight <= modConv.TextToDbl(vCriteriaReturn(0, 15)) Then 'T.T 11/01/2006 changed to conversion dbl
                                        vWeightEligible = True
                                    Else
                                        Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_MED_RO)
                                        'vIndicationRuleOut = modStatQuery.QueryIndicationRuleOut("Weight")
                                        pvForm.CboAppropriate(I).Tag = 2411
                                        vWeightEligible = False
                                    End If
                                End If
                            End If
                        End If

                        If vAgeEligible = True And pvCheckMRO = True And vWeightEligible = True Then

                            '***********************************************************************************************
                            '       Verify Medical Condition
                            '***********************************************************************************************

                            'Get the case and PMH of the patient
                            vCase = pvForm.TxtNotesCase.Text

                            If vCase <> "" Then

                                'Get the array of the indications of ruleout
                                Dim criteriaGroupIndicationAppropriate As Short = SQL_ERROR
                                Try
                                    criteriaGroupIndicationAppropriate = modStatQuery.QueryCriteriaGroupIndication(pvForm, , vIndicationReturn)
                                Catch ex As Exception
                                    StatTracLogger.CreateInstance().Write(ex)
                                End Try
                                If criteriaGroupIndicationAppropriate = SUCCESS Then

                                    vMedicalEligible = True
                                    vAnyUnconditional = False
                                    vAnyHighRisk = False

                                    'Compare each item in the indications array to the case history and PMH
                                    For j = 0 To UBound(vIndicationReturn)
                                        'If there is a match, add it to the indication results list
                                        If pvForm.TxtNotesCase.Find(vIndicationReturn(j, 1), 0, pvForm.TxtNotesCase.Text.Length, (System.Windows.Forms.RichTextBoxFinds.WholeWord + System.Windows.Forms.RichTextBoxFinds.MatchCase)) <> -1 Then
                                            If vIndicationReturn(j, 2) = "" Then
                                                vAddRow = False
                                                vMedicalEligible = False
                                                vAnyUnconditional = True
                                                pvForm.CboAppropriate(I).Tag = vIndicationReturn(j, 0) 'T.T 12/06/06 tracking rule outs
                                            Else
                                                ReDim vTempRow(0, 2)
                                                vTempRow(0, 0) = pvForm.CmdOption(I).Text
                                                vTempRow(0, 1) = vIndicationReturn(j, 1)
                                                vTempRow(0, 2) = vIndicationReturn(j, 2)
                                                vAddRow = True
                                                vMedicalEligible = False
                                                pvForm.CboAppropriate(I).Tag = vIndicationReturn(j, 0) 'T.T 12/06/06 tracking rule outs
                                            End If

                                            If vIndicationReturn(j, 3) = -1 Then
                                                vAnyHighRisk = True
                                                pvForm.CboAppropriate(I).Tag = vIndicationReturn(j, 0) 'T.T 12/06/06 tracking rule outs
                                            End If
                                        Else
                                            vAddRow = False
                                        End If

                                        'Join each new row
                                        If vAddRow Then
                                            If Not TypeOf vIndicationList Is Array Then  ' IsNothing(vIndicationList) Then
                                                Call modArray.Copy(vTempRow, vIndicationList)
                                            Else
                                                Call modArray.JoinRow(vTempRow, vIndicationList, vTemp)
                                                Call modArray.Copy(vTemp, vIndicationList)
                                            End If
                                        End If
                                    Next j

                                    'Set the appropriate selection
                                    If vMedicalEligible = False Then
                                        If vAnyHighRisk Then
                                            Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_HIGH_RISK)

                                        ElseIf vAnyUnconditional Then
                                            Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_MED_RO)
                                        Else
                                            Call modControl.SelectID(pvForm.CboAppropriate(I), -1) 'T.T 10/19/2004 added to no erase appropriate info
                                            Call modControl.SelectID(pvForm.CboAppropriate(I), vAppropriate(I))
                                            pvForm.CboAppropriate(I).BackColor = System.Drawing.Color.Yellow

                                            If Not TypeOf vVerifyList Is Array Then ' IsNothing(vVerifyList) 
                                                Call modArray.Copy(vIndicationList, vVerifyList)
                                            Else
                                                Call modArray.JoinRow(vIndicationList, vVerifyList, vTemp)
                                                Call modArray.Copy(vTemp, vVerifyList)
                                            End If
                                        End If
                                    End If

                                Else
                                    vMedicalEligible = True
                                End If
                            Else
                                vMedicalEligible = True
                            End If

                            vIndicationReturn = New Object
                            vIndicationList = New Object

                            '***********************************************************************************************
                            '       Verify General Condition
                            '***********************************************************************************************

                            If vCriteriaReturn(0, 7) <> "" Then

                                Dim appropriateID As Integer = -1
                                Try
                                    appropriateID = modControl.GetID(pvForm.CboAppropriate(I))
                                Catch ex As Exception
                                    StatTracLogger.CreateInstance().Write(ex)
                                End Try
                                If appropriateID = -1 Or appropriateID = APPROP_YES Then
                                    'vtempvar = modControl.GetID(pvForm.CboAppropriate(i))
                                    ReDim vTempRow(0, 2)
                                    vTempRow(0, 0) = pvForm.CmdOption(I).Text
                                    vTempRow(0, 1) = "General"
                                    vTempRow(0, 2) = vCriteriaReturn(0, 7)

                                    'If pvForm.CboAppropriate(i) = "" Then

                                    Call modControl.SelectID(pvForm.CboAppropriate(I), -1)
                                    Call modControl.SelectID(pvForm.CboAppropriate(I), vAppropriate(I))
                                    pvForm.CboAppropriate(I).BackColor = System.Drawing.Color.Yellow
                                    'Call modControl.SelectText(pvForm.CboAppropriate(i), "Yes")
                                    'End If

                                    If Not TypeOf vVerifyList Is Array Then  'IsNothing(vVerifyList) Then
                                        Call modArray.Copy(vTempRow, vVerifyList)
                                    Else
                                        Call modArray.JoinRow(vTempRow, vVerifyList, vTemp)
                                        Call modArray.Copy(vTemp, vVerifyList)
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            Next I

        End If


        'Check that all fields are filled
        If pvCheckVent = True And vAgeEligible = True And modStatValidate.OptionValid(pvForm, ORGAN) = True Then

            'Get the
            pvForm.DonorCategoryID = ORGAN

            'Get the criteria ID
            'FSProj drh 4/30/02 - Remove the following line; will use ReferralTriageCriteria collection instead
            'Call modStatQuery.QueryCategoryGroupsApplicable(pvForm)

            'FSProj drh 4/30/02 - Get Criteria Group ID for this Triage Option from ReferralTriageCriteria collection
            pvForm.CriteriaGroupID = pvForm.ReferralTriageCriteria.Item(CStr(ORGAN))

            If modStatQuery.QueryCategoryCriteria(pvForm, vCriteriaReturn) <> SUCCESS Then
                MsgBox("There are no criteria avaiable for " & pvForm.CmdOption(ORGAN).Text & ".")
            End If

            '*********************************
            ' START VENT AND HEART BEAT CHECK
            '*********************************

            'Get vent info
            vVent = modControl.GetID(pvForm.CboVent)

            '01/08/04 mds Get HeartBeat info
            vHeartBeat = modControl.GetID(pvForm.CboHeartBeat)

            'Get cause of death info
            If modControl.GetID(pvForm.CboCauseOfDeath) <> -1 Then
                Call modStatQuery.QueryCauseOfDeathPotential(modControl.GetID(pvForm.CboCauseOfDeath), vNeuro)
            Else
                vNeuro = True
            End If

            'mds 01/08/04 - determine which function to call to determine APPROPRIATE values
            'based on if the heartbeat field is being used for this service level

            If pvForm.CallerOrg.ServiceLevel.HeartBeat = True Then
                Call VentAndHeartBeat(pvForm, vVent, vMedicalEligible, vCriteriaReturn(0, 12), vNeuro, vHeartBeat)
            Else
                Call VentOnly(pvForm, vVent, vMedicalEligible, vCriteriaReturn(0, 12), vNeuro)
            End If

            'If it is vent only, then default yes to all to the other tissue types
            If pvCheckAge = False And pvCheckMRO = False Then
                For I = RESEARCH To BONE Step -1
                    Call modControl.SelectID(pvForm.CboAppropriate(I), APPROP_YES)
                Next I
            End If

        End If

        Call modStatValidate.ReferralTypeDefault(pvForm)
        'Check for pending contacts
        'Call modStatValidate.ValidateReferralContacts(pvForm, False)

        If IsNothing(pvShowVerifyMsg) Then

            Call modUtility.Done()

        Else

            Call modControl.ClearListView(pvForm.LstViewVerify)

            'Display verify status
            If Not (TypeOf vVerifyList Is Array) Then
                Call modUtility.Done()
            Else
                For I = 0 To UBound(vVerifyList, 1)
                    vVerifyList(I, 2) = vVerifyList(I, 0) & " - " & vVerifyList(I, 1) & Chr(10) & vVerifyList(I, 2)
                Next I

                Call modControl.SetListViewRows(vVerifyList, False, pvForm.LstViewVerify, False)
                pvForm.TxtConditional.Text = ""
                'pvForm.TxtNotesCase.Enabled = False
                If pvForm.TabDisposition.TabPages.IndexOf(pvForm.tabDispositionTable(RESULTS_TAB)) > -1 Then
                    'If pvForm.TabDisposition.SelectedIndex <> pvForm.TabDisposition.TabPages.IndexOf(pvForm.tabDispositionTable(DISPOSITION_TAB)) Then
                    pvForm.TabDisposition.SelectedIndex = pvForm.TabDisposition.TabPages.IndexOf(pvForm.tabDispositionTable(RESULTS_TAB))
                    'End If
                End If

                'pvForm.TxtNotesCase.Enabled = True
                'pvForm.vTabDispositionSelect = True

                'pvForm.LstViewVerify.SetFocus
                If pvForm.LstViewVerify.Items.Count > 0 Then
                    pvForm.LstViewVerify.Items(0).Selected = True
                    Call pvForm.SelectFirstResult()
                End If
                Call modUtility.Done()

            End If

        End If

        Call modUtility.Done()

        Return True

    End Function

    Public Function VentOnly(ByRef pvForm As FrmReferral, ByRef vVent As Short, ByRef vMedicalEligible As Boolean, ByRef vCriteriaReturn012 As Boolean, ByRef vNeuro As Boolean) As Object

        '*******************************************************************************
        '**** 01/08/04 mds
        '**** This function was created during the heartbeat change.  The code below is the
        '**** same logic that was formerly in the VerifyReferral function and will be used
        '**** when the heartbeat field is FALSE (disabled for the current service level)
        '*******************************************************************************

        'Check vent status first
        '01/08/04 mds: replaced (vCriteriaReturn(0, 12) = True) check with vCriteriaReturn012
        If vVent = CURRENT And vCriteriaReturn012 = True And vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

            '01/08/04 mds: replaced (vCriteriaReturn(0, 12) = True) check with vCriteriaReturn012
        ElseIf vVent = CURRENT And Not vNeuro And vCriteriaReturn012 <> True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)

        ElseIf vVent = CURRENT And vNeuro And vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

        ElseIf vVent = PREVIOUSLY And vNeuro And vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_PREVIOUS_VENT)

        ElseIf vVent = PREVIOUSLY And Not vNeuro Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)

        ElseIf vVent = NEVER Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)

        ElseIf vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

        End If

    End Function

    Function VentAndHeartBeat(ByRef pvForm As FrmReferral, ByRef vVent As Short, ByRef vMedicalEligible As Boolean, ByRef vCriteriaReturn012 As Boolean, ByRef vNeuro As Boolean, ByRef vHeartBeat As Short) As Object

        '*******************************************************************************
        '**** 01/08/04 mds
        '**** This function was created during the heartbeat change. It is called from
        '**** the VerifyReferral function in this module.  The code below is executed
        '**** when the heartbeat field is TRUE (enabled for the current service level)
        '**** It was copied from Bret's Heartbeat changes in April and May 2003 - his
        '**** comments and remain the code for this function, though this function wasn't
        '**** created until 01/08/04.
        '****
        '**** Updates are commented as they would be normally.
        '*******************************************************************************

        '04/29/03 BJK Heart Beat changes
        'Check vent status first

        '*******************
        'CURRENT VENT
        '*******************

        '04/29/03 bjk add heartbeat is yes
        '01/08/04 mds: replaced (vCriteriaReturn(0, 12) = True) check with vCriteriaReturn012
        If vVent = CURRENT And vHeartBeat = HEART_BEAT_YES And vCriteriaReturn012 = True And vMedicalEligible = True Then
            'vent is Current AND CriteriaReferNonPotential = TRUE
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

            '*****04/29/03 bjk add heartbeat is yes
            '01/08/04 mds: replaced (vCriteriaReturn(0, 12) = True) check with vCriteriaReturn012
        ElseIf vVent = CURRENT And vHeartBeat = HEART_BEAT_YES And Not vNeuro And vCriteriaReturn012 <> True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)
            pvForm.CboAppropriate(ORGAN).Tag = 2412 'T.T 12/05/2006 Vent ruleout added  for ruleoutcounts
            '*****04/29/03 bjk add heartbeat is yes
        ElseIf vVent = CURRENT And vHeartBeat = HEART_BEAT_YES And vNeuro And vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

            '****01/08/04 mds don't really need this one since it's not valid to have
            '****a vent = currently and heartbeat = no, but left in since this is
            '****what we'd want to happen if that ever does happen
        ElseIf vVent = CURRENT And vHeartBeat = HEART_BEAT_NO Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)
            pvForm.CboAppropriate(ORGAN).Tag = 2412 'T.T 12/05/2006 Vent ruleout added  for ruleoutcounts
            '*******************
            'PREVIOUS VENT
            '*******************

            '****04/29/03 bjk add heartbeat is no
            '****01/13/04 mds When vent = PREVIOUSLY, Heartbeat does not affect the outcome, so don't check it
        ElseIf vVent = PREVIOUSLY And vNeuro And vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_PREVIOUS_VENT)

        ElseIf vVent = PREVIOUSLY And Not vNeuro Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)
            pvForm.CboAppropriate(ORGAN).Tag = 2412 'T.T 12/05/2006 Vent ruleout added  for ruleoutcounts

            '*********
            'NEVER VENT
            '**********

            '*****01/13/04 MDS no heartbeat check needed since if vent=NEVER - it's always organs not appropriate
        ElseIf vVent = NEVER Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_NOT_APPROPRIATE)
            pvForm.CboAppropriate(ORGAN).Tag = 2412 'T.T 12/05/2006 Vent ruleout added  for ruleoutcounts
        ElseIf vMedicalEligible = True Then
            Call modControl.SelectID(pvForm.CboAppropriate(ORGAN), APPROP_YES)

        End If

    End Function



    Public Function OptionValid(ByRef pvForm As FrmReferral, ByRef pvOption As Short) As Boolean

        Select Case pvOption
            Case ORGAN
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateOrgan = True, True, False)
            Case BONE
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateBone = True, True, False)
            Case TISSUE
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateTissue = True, True, False)
            Case SKIN
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateSkin = True, True, False)
            Case VALVES
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateValves = True, True, False)
            Case EYES
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateEyes = True, True, False)
            Case RESEARCH
                OptionValid = IIf(pvForm.CallerOrg.ServiceLevel.AppropriateResearch = True, True, False)
        End Select

    End Function

    Public Function SetRefAlpha(ByRef pvForm As Object) As String
        '************************************************************************************
        'Name: SetRefAlpha
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of LstViewContact
        'Returns: String containing alpha pager message.
        'Params: pvForm As Form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 11/10/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 196
        'Description:  Added display of DOB to infomation sent to alpha pager.
        '====================================================================================
        '====================================================================================
        'Date Changed: 02/15/2007                        Changed by: Thien Ta
        'Release #: 8.3                                 Task:
        'Description:  added code for callID to be on utoResponse page
        '====================================================================================
        '************************************************************************************
        On Error GoTo localError

        SetRefAlpha = "#" & pvForm.CallId & " - " & "Confirm To Tel: " & AppMain.Queue & " x" & AppMain.Extension & "  Tel:"
        SetRefAlpha = SetRefAlpha & pvForm.LblPhone.Text

        'bret 3/2010 repalced pvForm.TxtExtension <> "" Then
        If Not pvForm.Controls.Find("TxtExtension", True).Length > 0 Then
            SetRefAlpha = SetRefAlpha & " x" & pvForm.LblExtension.Text & ", " & pvForm.LblName.Text & ", " & pvForm.LblOrganization.Text & ", " & "Pt. " & pvForm.TxtDonorFirstName.Text & " " & pvForm.TxtDonorLastName.Text & ", " & VB6.Format(pvForm.TxtDOB.Text, "mmm d yyyy") & ", " & pvForm.TxtAge.Text & " " & pvForm.CboAgeUnit.Text & ", " & pvForm.CboGender.Text & ", " & "Hx: " & pvForm.TxtNotesCase.Text
        Else
            SetRefAlpha = SetRefAlpha & ", " & pvForm.LblName.Text & ", " & pvForm.LblOrganization.Text & ", " & "Pt. " & pvForm.TxtDonorFirstName.Text & " " & pvForm.TxtDonorLastName.Text & ", " & VB6.Format(pvForm.TxtDOB.Text, "mmm d yyyy") & ", " & pvForm.TxtAge.Text & " " & pvForm.CboAgeUnit.Text & ", " & pvForm.CboGender.Text & ", " & "Hx: " & pvForm.TxtNotesCase.Text
        End If
        Exit Function
localError:
        Resume Next
        Resume
    End Function

    Public Function SetRefEmailSbj(ByRef pvForm As FrmReferral) As String
        '************************************************************************************
        'Name: SetRefEmailSbj
        'Date Created: 11/30/04                         Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates subject line of referral email sent by frmEmail
        'Returns: String containing email subject
        'Params: Calling Form
        'Stored Procedures: None
        '************************************************************************************
        On Error Resume Next

        SetRefEmailSbj = pvForm.SourceCode.Name & " - Referral #" & pvForm.CallNumber

    End Function

    Public Function SetRefEmail(ByRef pvForm As FrmReferral) As String
        '************************************************************************************
        'Name: SetRefEmail
        'Date Created: 11/29/04                         Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates text of referral email sent by frmEmail
        'Returns: String containing email body
        'Params: Calling Form
        'Stored Procedures: None
        '************************************************************************************
        On Error GoTo ERR_HANDLER

        Dim sEmailBody As String = ""
        Dim CR As String = ""
        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vRS As New Object
        Dim Ret As New Object
        Dim EmailDispositionEnabled As Boolean 'T.T 10/12/2005 enable servicelevel for dispo

        CR = vbNewLine

        sEmailBody = pvForm.SourceCode.NameUnAbbrev & CR ' Source Code description
        sEmailBody = sEmailBody & "Referral #: " & pvForm.CallNumber & CR
        sEmailBody = sEmailBody & "Referral Start: " & VB6.Format(pvForm.CallDate, "mm/dd/yyyy hh:mm") & " MT" & CR
        sEmailBody = sEmailBody & "Time Sent: " & VB6.Format(Now, "mm/dd/yyyy hh:mm") & " MT" & CR & CR

        sEmailBody = sEmailBody & "Tel: " & pvForm.LblPhone.Text
        If Len(pvForm.LblExtension.Text) > 0 Then
            sEmailBody = sEmailBody & "    Ext: " & pvForm.LblExtension.Text
        End If
        sEmailBody = sEmailBody & CR & "Prelim. Ref. Type: " & pvForm.sPrelimRefTypeDesc & CR
        sEmailBody = sEmailBody & "Current Ref. Type: " & pvForm.sCurrentRefTypeDesc & CR
        sEmailBody = sEmailBody & "Referral Facility: " & pvForm.LblOrganization.Text & CR
        If pvForm.SubLocationID > 0 Then
            vQuery = "select sublocationname from sublocation where sublocationID = " & pvForm.SubLocationID
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
            Ret = vRS("sublocationname").Value
            sEmailBody = sEmailBody & "Hospital Unit: " & Ret & CR
        Else
            sEmailBody = sEmailBody & "Hospital Unit: " & CR
        End If

        sEmailBody = sEmailBody & "Floor Unit: " & pvForm.LblLevel.Text & CR
        sEmailBody = sEmailBody & "Referring Person: " & pvForm.LblName.Text & CR
        sEmailBody = sEmailBody & "Title: " & pvForm.LblPersonType.Text & CR & CR

        sEmailBody = sEmailBody & "Heartbeat: " & pvForm.CboHeartBeat.Text & CR
        sEmailBody = sEmailBody & "Vent: " & pvForm.CboVent.Text & CR
        sEmailBody = sEmailBody & "Extubation: " & pvForm.TxtExtubated.Text & CR
        sEmailBody = sEmailBody & "Referral Name: " & pvForm.TxtDonorFirstName.Text & " " & pvForm.TxtDonorMI.Text & " " & pvForm.TxtDonorLastName.Text & CR
        'sEmailBody = sEmailBody & "Middle Initial: " & pvForm.TxtDonorMI.Text & CR
        If pvForm.ChkDOB.Checked = 0 Then
            sEmailBody = sEmailBody & "DOB: " & VB6.Format(pvForm.TxtDOB.Text, "mmm d yyyy") & CR
        Else
            sEmailBody = sEmailBody & "DOB: Unknown " & CR
        End If
        sEmailBody = sEmailBody & "Age: " & pvForm.TxtAge.Text & " " & pvForm.CboAgeUnit.Text & CR
        sEmailBody = sEmailBody & "Race: " & pvForm.CboRace.Text & CR
        sEmailBody = sEmailBody & "Sex: " & pvForm.CboGender.Text & CR
        'Hide "kg" if no weight is present.  12/20/04 - SAP
        If Len(pvForm.TxtWeight.Text) > 0 Then
            sEmailBody = sEmailBody & "Weight: " & pvForm.TxtWeight.Text & " kg" & CR
        Else
            sEmailBody = sEmailBody & "Weight: " & CR
        End If

        sEmailBody = sEmailBody & "Med Rec #: " & pvForm.TxtRecNum.Text & CR

        'ccarroll 09/19/2011 CCRST151 requirement wi 10337 
        sEmailBody = sEmailBody & "Declared CTOD: " & pvForm.TxtDeathDate.Text & " " & pvForm.TxtDeathTime.Text & CR
        If pvForm.Name = "FrmReferral" Then
            sEmailBody = sEmailBody & "LSA: " & pvForm.TxtLSADate.Text & " " & pvForm.TxtLSATime.Text & CR
        End If
        sEmailBody = sEmailBody & "Brain Death: " & pvForm.TxtBrainDeathDate.Text & " " & pvForm.TxtBrainDeathTime.Text & CR
        sEmailBody = sEmailBody & "Admit: " & pvForm.TxtAdmitDate.Text & " " & pvForm.TxtAdmitTime.Text & CR
        If pvForm.ChkDOA.Checked = 1 Then
            sEmailBody = sEmailBody & "DOA: Yes" & CR & CR
        Else
            sEmailBody = sEmailBody & "DOA: No" & CR & CR
        End If

        sEmailBody = sEmailBody & "COD: " & pvForm.CboCauseOfDeath.Text & CR
        sEmailBody = sEmailBody & "Method of Approach: " & pvForm.CboApproachType.Text & CR
        sEmailBody = sEmailBody & "Approacher: " & pvForm.CboApproachedBy.Text & CR
        sEmailBody = sEmailBody & "Reg Status: " & pvForm.cboRegistryStatus.Text & CR
        sEmailBody = sEmailBody & "Consent: " & pvForm.CboGeneralConsent.Text & CR
        sEmailBody = sEmailBody & "Medical History: " & pvForm.TxtNotesCase.Text & CR
        sEmailBody = sEmailBody & "Specific COD: " & pvForm.TxtSpecificCOD.Text & CR & CR

        sEmailBody = sEmailBody & "Next of Kin: " & pvForm.NOKFirstName & " " & pvForm.NOKLastName & CR
        'sEmailBody = sEmailBody & "NOK First Name: " & pvForm.NOKFirstName & CR
        'sEmailBody = sEmailBody & "NOK Last Name: " & pvForm.NOKLastName & CR
        sEmailBody = sEmailBody & "Relation: " & pvForm.NOKApproachRelation & CR
        sEmailBody = sEmailBody & "Phone: " & pvForm.NOKRefPhone & CR
        sEmailBody = sEmailBody & "Address: " & pvForm.NOKRefAddress & CR
        sEmailBody = sEmailBody & "City: " & pvForm.NOKCity & CR
        If pvForm.NOKStateID > 0 Then
            vQuery = "select stateabbrv from state where stateID  = " & pvForm.NOKStateID
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
            Ret = vRS("stateabbrv").Value
            sEmailBody = sEmailBody & "State: " & Ret & CR
        Else
            sEmailBody = sEmailBody & "State: " & CR
        End If



        sEmailBody = sEmailBody & "Zip: " & pvForm.NOKZip & CR & CR

        sEmailBody = sEmailBody & "Attending: " & pvForm.CboPhysician(0).Text & CR
        sEmailBody = sEmailBody & "Attending Phone: " & pvForm.TxtAttendingPhone.Text & CR
        sEmailBody = sEmailBody & "Pronouncing: " & pvForm.CboPhysician(1).Text & CR
        sEmailBody = sEmailBody & "Pronouncing Phone: " & pvForm.TxtPronouncingPhone.Text & CR & CR
        If pvForm.ChkCoronerCase.Checked = 1 Then
            sEmailBody = sEmailBody & "Coroner Case:  Yes" & CR
        Else
            sEmailBody = sEmailBody & "Coroner Case:  Unknown" & CR
        End If
        sEmailBody = sEmailBody & "State: " & pvForm.CboState.Text & CR
        sEmailBody = sEmailBody & "Organization: " & pvForm.CboCoronerOrg.Text & CR
        sEmailBody = sEmailBody & "Name: " & pvForm.CboCoronerName.Text & CR
        sEmailBody = sEmailBody & "Phone: " & pvForm.TxtCoronerPhone.Text & CR
        sEmailBody = sEmailBody & "Note: " & pvForm.TxtCoronerNote.Text & CR & CR & CR

        'Check to see servicelevel for approach T.T 10/12/2006
        If pvForm.Name = "FrmReferral" Then
            If pvForm.DispositionFieldEnabled = True Then
                EmailDispositionEnabled = True
            End If
        End If

        ' Configurable in Service Level whether or not this shows up in the email
        If pvForm.CallerOrg.ServiceLevel.ApproachLevel <> 1 Then 'T.T 09/06/2006 approach level = 1 means never show disposition
            If pvForm.CallerOrg.ServiceLevel.EmailDisposition = True Then
                If EmailDispositionEnabled = True Then

                    sEmailBody = sEmailBody & "Organs Appropriate: " & pvForm.CboAppropriate(ORGAN).Text & CR
                    sEmailBody = sEmailBody & "Organs Approach: " & pvForm.CboApproach(ORGAN).Text & CR
                    sEmailBody = sEmailBody & "Organs Consent: " & pvForm.CboConsent(ORGAN).Text & CR
                    sEmailBody = sEmailBody & "Organs Recovery: " & pvForm.CboRecovery(ORGAN).Text & CR & CR

                    sEmailBody = sEmailBody & "Bone Appropriate: " & pvForm.CboAppropriate(BONE).Text & CR
                    sEmailBody = sEmailBody & "Bone Approach: " & pvForm.CboApproach(BONE).Text & CR
                    sEmailBody = sEmailBody & "Bone Consent: " & pvForm.CboConsent(BONE).Text & CR
                    sEmailBody = sEmailBody & "Bone Recovery: " & pvForm.CboRecovery(BONE).Text & CR & CR

                    sEmailBody = sEmailBody & "Tissue Appropriate: " & pvForm.CboAppropriate(TISSUE).Text & CR
                    sEmailBody = sEmailBody & "Tissue Approach: " & pvForm.CboApproach(TISSUE).Text & CR
                    sEmailBody = sEmailBody & "Tissue Consent: " & pvForm.CboConsent(TISSUE).Text & CR
                    sEmailBody = sEmailBody & "Tissue Recovery: " & pvForm.CboRecovery(TISSUE).Text & CR & CR

                    sEmailBody = sEmailBody & "Skin Appropriate: " & pvForm.CboAppropriate(SKIN).Text & CR
                    sEmailBody = sEmailBody & "Skin Approach: " & pvForm.CboApproach(SKIN).Text & CR
                    sEmailBody = sEmailBody & "Skin Consent: " & pvForm.CboConsent(SKIN).Text & CR
                    sEmailBody = sEmailBody & "Skin Recovery: " & pvForm.CboRecovery(SKIN).Text & CR & CR

                    sEmailBody = sEmailBody & "Valves Appropriate: " & pvForm.CboAppropriate(VALVES).Text & CR
                    sEmailBody = sEmailBody & "Valves Approach: " & pvForm.CboApproach(VALVES).Text & CR
                    sEmailBody = sEmailBody & "Valves Consent: " & pvForm.CboConsent(VALVES).Text & CR
                    sEmailBody = sEmailBody & "Valves Recovery: " & pvForm.CboRecovery(VALVES).Text & CR & CR

                    sEmailBody = sEmailBody & "Eyes Appropriate: " & pvForm.CboAppropriate(EYES).Text & CR
                    sEmailBody = sEmailBody & "Eyes Approach: " & pvForm.CboApproach(EYES).Text & CR
                    sEmailBody = sEmailBody & "Eyes Consent: " & pvForm.CboConsent(EYES).Text & CR
                    sEmailBody = sEmailBody & "Eyes Recovery: " & pvForm.CboRecovery(EYES).Text & CR & CR

                    sEmailBody = sEmailBody & "Other Appropriate: " & pvForm.CboAppropriate(RESEARCH).Text & CR
                    sEmailBody = sEmailBody & "Other Approach: " & pvForm.CboApproach(RESEARCH).Text & CR
                    sEmailBody = sEmailBody & "Other Consent: " & pvForm.CboConsent(RESEARCH).Text & CR
                    sEmailBody = sEmailBody & "Other Recovery: " & pvForm.CboRecovery(RESEARCH).Text & CR
                End If
            End If
        End If

        SetRefEmail = sEmailBody
        Exit Function

ERR_HANDLER:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err, "Process Error, Call #: " & pvForm.CallId)

    End Function

    Public Function SetMessageEmailSbj(ByRef pvForm As FrmMessage) As String
        '************************************************************************************
        'Name: SetMessageEmailSbj
        'Date Created: 12/8/04                          Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates subject line of message email sent by frmEmail
        'Returns: String containing email subject
        'Params: Calling Form
        'Stored Procedures: None
        '************************************************************************************

        SetMessageEmailSbj = pvForm.SourceCode.Name & " - Referral #" & pvForm.CallNumber

    End Function

    Public Function SetMessageEmail(ByRef pvForm As FrmMessage) As String
        '************************************************************************************
        'Name: SetMessageEmail
        'Date Created: 12/07/04                         Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates text of message email sent by frmEmail
        'Returns: String containing email body
        'Params: Calling Form
        'Stored Procedures: None
        '************************************************************************************
        Dim sMsgEmailBody As String = ""
        Dim CR As String = ""

        CR = vbNewLine

        sMsgEmailBody = pvForm.SourceCode.NameUnAbbrev & CR ' Source Code description
        sMsgEmailBody = sMsgEmailBody & "Call #: " & pvForm.CallNumber & CR
        sMsgEmailBody = sMsgEmailBody & "Time Sent: " & VB6.Format(Now, "mm/dd/yyyy hh:mm") & " MT" & CR & CR

        sMsgEmailBody = sMsgEmailBody & "Caller Name: " & pvForm.LblName.Text & CR
        sMsgEmailBody = sMsgEmailBody & "Tel: " & pvForm.LblPhone.Text & " Ext: " & pvForm.LblExtension.Text & CR
        sMsgEmailBody = sMsgEmailBody & "From: " & pvForm.LblOrganization.Text & CR & CR

        sMsgEmailBody = sMsgEmailBody & "Message Type: " & pvForm.CboMessageType.Text & CR
        If pvForm.ChkUrgent.Checked = System.Windows.Forms.CheckState.Checked Then
            sMsgEmailBody = sMsgEmailBody & "Callback ASAP" & CR
        End If
        sMsgEmailBody = sMsgEmailBody & "Message: " & pvForm.TxtMessage.Text & CR & CR

        sMsgEmailBody = sMsgEmailBody & "For Organization: " & pvForm.CboOrganization.Text & CR
        sMsgEmailBody = sMsgEmailBody & "Name: " & pvForm.CboName.Text & CR
        sMsgEmailBody = sMsgEmailBody & "Role: " & pvForm.TxtPersonType.Text & CR
        SetMessageEmail = sMsgEmailBody

        Exit Function
    End Function

    Public Function ValidateReferralContacts(ByRef pvForm As FrmReferral, ByRef pvDisplayWarning As Boolean) As Object
        '************************************************************************************
        'Name: ValidateReferralContacts
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Tests whether required contacts have been made for a given referral.
        'Returns: Nothing
        'Params: pvForm As Form, pvDisplayWarning as boolean
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/20/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added check count emails sent as contacts made.
        '====================================================================================
        '************************************************************************************
        Dim vOption As Short
        Dim I As Short
        Dim j As Short
        Dim k As Short
        Dim m As Short

        Dim vScheduleGroups As New Object
        Dim vCriteriaScheduleGroups As New Object
        Dim vMsg As String = ""
        Dim vLogEventID As Integer

        Dim vGiveOptions As Boolean
        Dim Contact As Boolean

        Dim vConsentStatus As Short
        Dim vConsentPendingEvent As New Object

        Dim vSecondaryStatus As Short
        Dim vSecondaryPendingEvent As New Object
        Dim vSecondaryPendingValid As Boolean

        Dim vWarningDisplay As Boolean
        Dim vAddPendingContact As Boolean
        Dim vAlreadyListedScheduleGroups As New Object
        Dim vAlreadyContactedScheduleGroups As New Object

        Dim vNewItem As System.Windows.Forms.ListViewItem


        '7/9/01 drh
        Dim fsResults As New Object

        modUtility.Work()

        'FSProj drh 4/30/02 - Before we start, get Triage Options Criteria
        Try
            Call pvForm.PopulateCriteria()
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '******************************************************************************************************
        ' Verify schedule groups have been contacted
        '******************************************************************************************************

        'Initialize the vAlreadyListedScheduleGroups array - increased to RESEARCH count = 7
        ReDim vAlreadyListedScheduleGroups(1, 0)
        For I = 0 To UBound(vAlreadyListedScheduleGroups)
            vAlreadyListedScheduleGroups(I, 0) = 0
        Next I

        ReDim vAlreadyContactedScheduleGroups(1, 0)
        For I = 0 To UBound(vAlreadyContactedScheduleGroups)
            vAlreadyContactedScheduleGroups(I, 0) = 0
        Next I

        ValidateReferralContacts = True
        vGiveOptions = False
        vSecondaryPendingValid = False

        'Get an array of the schedule groups assigned to the selected organization
        Try
            Call modStatQuery.QueryScheduleGroupsOnCallAll(pvForm, vScheduleGroups)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        For vOption = ORGAN To RESEARCH

            'Initialize the warning display & contact list variables
            vWarningDisplay = pvDisplayWarning
            vAddPendingContact = True

            'Verify contact
            If pvForm.GetServiceLevel(GIVEN, vOption) Then
                'Check if the appropriate schedule group has been contacted.
                'Set the donor category ID
                pvForm.DonorCategoryID = vOption

                'Get the criteria ID
                'FSProj drh 4/30/02 - Remove the following line; will use ReferralTriageCriteria collection instead
                'Call modStatQuery.QueryCategoryGroupsApplicable(pvForm)

                'FSProj drh 4/30/02 - Get Criteria Group ID for this Triage Option from ReferralTriageCriteria collection
                pvForm.CriteriaGroupID = pvForm.ReferralTriageCriteria.Item(CStr(vOption))

                'Get the schedule group id
                Try
                    Call modStatQuery.QueryCriteriaScheduleGroup(pvForm, vCriteriaScheduleGroups)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                'Check each schedule group id against the referral's log events
                'bret 03/2010 changed from IsNothing(vCriteriaScheduleGroups) to check for Array
                If TypeOf vCriteriaScheduleGroups Is Array Then
                    'Check each schedule group assigned to the criteria
                    For I = 0 To UBound(vCriteriaScheduleGroups, 1)

                        'bjk 01/12/04 check if vScheduleGroups array is empty; do not loop if it is
                        If Not IsNothing(vScheduleGroups) AndAlso Validater.ObjectIsValidArray(vScheduleGroups, 2, 0, 1) Then

                            'Check if the criteria schedule group belongs to the
                            'schedule groups assigned to the current organization
                            For j = 0 To UBound(vScheduleGroups, 1)
                                If CInt(vScheduleGroups(j, 0)) = CInt(vCriteriaScheduleGroups(I, 0)) Then

                                    Contact = True

                                    For k = ORGAN To RESEARCH

                                        'First check if the schedule group has already been listed
                                        For m = 0 To UBound(vAlreadyListedScheduleGroups, 2)
                                            If vCriteriaScheduleGroups(I, k + 2) = 1 And k = vAlreadyListedScheduleGroups(1, m) Then
                                                Contact = False
                                            End If
                                        Next m

                                        'Second check if the schedule group has already been contacted
                                        For m = 0 To UBound(vAlreadyContactedScheduleGroups, 2)
                                            '10/26/01 drh Added check for "Never Brain Dead" Approach disposition in previous option

                                            If vCriteriaScheduleGroups(I, k + 2) = 1 And k = vAlreadyContactedScheduleGroups(1, m) Then
                                                Dim vAlreadyContactedScheduleGroupsValue As Short = vAlreadyContactedScheduleGroups(1, m)
                                                If (modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_NBD And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_UNKNOWN And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_FAMILY_UNAVAILABLE And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_CORONER_DENY And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_ARREST And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_MED_RO And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_LOGISTICS And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_HIGH_RISK And modControl.GetID(pvForm.CboApproach(vAlreadyContactedScheduleGroupsValue)) <> APRCH_UNAPPROACHABLE) Then
                                                    Contact = False
                                                End If
                                            End If
                                        Next m

                                        'add IF - ttw 05/10/01
                                        '10/26/01 drh Added check for "Never Brain Dead" Approach disposition in previous option
                                        If vCriteriaScheduleGroups(I, k + 2) = 1 And modControl.GetID(pvForm.CboAppropriate(k)) = APPROP_YES And k > 1 Then
                                            If (k > 1 And (modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_NBD And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_UNKNOWN And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_FAMILY_UNAVAILABLE And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_CORONER_DENY And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_ARREST And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_MED_RO And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_LOGISTICS And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_HIGH_RISK And modControl.GetID(pvForm.CboApproach(CShort(k - 1))) <> APRCH_UNAPPROACHABLE)) Then
                                                Contact = False
                                                'Unless...check if contact should be made option is not appropriate yet family consented
                                                If vCriteriaScheduleGroups(I, 12) = 1 And modControl.GetID(pvForm.CboGeneralConsent) <> 3 And modControl.GetID(pvForm.CboGeneralConsent) <> -1 Then
                                                    Contact = True
                                                End If
                                            End If
                                        End If

                                    Next k

                                    'Check if the option is appropriate or not (added Contact check ttw 05/10/01)
                                    If modControl.GetID(pvForm.CboAppropriate(vOption)) = APPROP_YES And Contact = True Then

                                        'Check if contact should not be made if consent was denied
                                        If vCriteriaScheduleGroups(I, 11) = 1 Then

                                            '10/17/01 drh Added checks for Approach = APRCH_YESDMV and Approach = APRCH_YESREG; Also added checks for CONSENT_YESDMV and CONSENT_YESREG
                                            If modControl.GetID(pvForm.CboGeneralConsent) = 3 Or ((pvForm.GetServiceLevel(APPROACHED, vOption) And (modControl.GetID(pvForm.CboApproach(vOption)) = APRCH_YES Or modControl.GetID(pvForm.CboApproach(vOption)) = APRCH_YESDMV Or modControl.GetID(pvForm.CboApproach(vOption)) = APRCH_YESREG)) And (pvForm.GetServiceLevel(CONSENT, vOption) And modControl.GetID(pvForm.CboConsent(vOption)) <> CONSENT_YES And modControl.GetID(pvForm.CboConsent(vOption)) <> CONSENT_YESDMV And modControl.GetID(pvForm.CboConsent(vOption)) <> CONSENT_YESREG And modControl.GetID(pvForm.CboConsent(vOption)) <> -1)) Then
                                                Contact = False
                                            End If

                                            '10/17/01 drh Added checks for Approach = APRCH_YESDMV and Approach = APRCH_YESREG and Approach = -1; also changed APRCH_YES condition to <> instead of >
                                            If pvForm.GetServiceLevel(APPROACHED, vOption) And modControl.GetID(pvForm.CboApproach(vOption)) <> APRCH_YES And modControl.GetID(pvForm.CboApproach(vOption)) <> APRCH_YESDMV And modControl.GetID(pvForm.CboApproach(vOption)) <> APRCH_YESREG And modControl.GetID(pvForm.CboApproach(vOption)) <> -1 And modControl.GetID(pvForm.CboApproach(vOption)) <> APRCH_UNKNOWN Then
                                                Contact = False
                                            End If

                                            If pvForm.GetServiceLevel(APPROACHED, vOption) And modControl.GetID(pvForm.CboApproach(vOption)) = APRCH_UNKNOWN And modControl.GetID(pvForm.CboApproachType) = NOT_APPROACHED Then
                                                Contact = False
                                            End If

                                        End If

                                        'Check if there has been an approach.
                                        If pvForm.CallerOrg.ServiceLevel.ApproachMethod Then

                                            'If there has been no approach, check if the approach should be made
                                            'by the hospital before contacting the schedule group.
                                            'If so, then don't contact the schedule group
                                            If modControl.GetID(pvForm.CboApproachType) = NOT_APPROACHED And vCriteriaScheduleGroups(I, 13) = 1 And modControl.GetID(pvForm.CboApproach(vOption)) = -1 Then

                                                If (modControl.GetID(pvForm.CboAppropriate(ORGAN)) <> APPROP_YES) Or (modControl.GetID(pvForm.CboAppropriate(ORGAN)) = APPROP_YES And modControl.GetID(pvForm.CboApproach(ORGAN)) > -1) Then

                                                    'Check if a consent pending for the calling organization
                                                    'already exists, if not then create one
                                                    Try
                                                        vConsentStatus = modStatQuery.QueryCreateConsentPending(pvForm)
                                                    Catch ex As Exception
                                                        StatTracLogger.CreateInstance().Write(ex)
                                                    End Try

                                                    If vConsentStatus = CREATE_CONSENT_PENDING And (pvForm.GetServiceLevel(APPROACHED, vOption) And modControl.GetID(pvForm.CboApproach(vOption)) = -1) Then

                                                        'Create a consent pending event
                                                        Try
                                                            vLogEventID = modStatSave.SaveLogEvent(pvForm, CONSENT_PENDING)
                                                        Catch ex As Exception
                                                            StatTracLogger.CreateInstance().Write(ex)
                                                        End Try

                                                        vNewItem = pvForm.LstViewPending.Items.Add("Consent Pending", CStr(vLogEventID))
                                                        vNewItem.Tag = vLogEventID
                                                        If vNewItem.SubItems.Count > 1 Then
                                                            vNewItem.SubItems(1).Text = pvForm.OrganizationName
                                                        Else
                                                            vNewItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, pvForm.OrganizationName))
                                                        End If

                                                        Contact = False

                                                    End If

                                                    If vConsentStatus = CREATE_CONSENT_PENDING Or vConsentStatus = CONSENT_PENDING_CURRENT Then
                                                        vGiveOptions = True
                                                        Contact = False
                                                    Else
                                                        vGiveOptions = False
                                                        Contact = False
                                                    End If

                                                    'If the family was not approached and the option's approach is unknown
                                                    'then don't contact
                                                    If pvForm.GetServiceLevel(APPROACHED, vOption) And modControl.GetID(pvForm.CboApproach(vOption)) = APRCH_UNKNOWN Then
                                                        Contact = False
                                                    End If

                                                End If

                                            End If

                                            'If there has been approach, check if the approach should be made
                                            'by the hospital before contacting the schedule group.
                                            'If so and there is currently a consent pending then remove it because there has
                                            'already been an approach and the hospital does not need a consent pending.
                                            If modControl.GetID(pvForm.CboApproachType) > NOT_APPROACHED And vCriteriaScheduleGroups(I, 13) = 1 Then

                                                'Check if a consent pending for the calling organization
                                                'already exists, delete it
                                                Try
                                                    vConsentStatus = modStatQuery.QueryCreateConsentPending(pvForm, vConsentPendingEvent)
                                                Catch ex As Exception
                                                    StatTracLogger.CreateInstance().Write(ex)
                                                End Try

                                                If vConsentStatus = CONSENT_PENDING_CURRENT And pvForm.FormState = NEW_RECORD Then
                                                    'Delete the consent pending event
                                                    Try
                                                        Call modStatSave.DeleteLogEventID(vConsentPendingEvent(0, 0), pvForm.CallId)
                                                    Catch ex As Exception
                                                        StatTracLogger.CreateInstance().Write(ex)
                                                    End Try
                                                End If

                                            End If

                                            'Check if there is a coroner's case
                                            If pvForm.ChkCoronerCase.Checked = System.Windows.Forms.CheckState.Checked And modControl.GetID(pvForm.CboGeneralConsent) <> 3 And modControl.GetID(pvForm.CboApproachType) <> NOT_APPROACHED Then
                                                If vCriteriaScheduleGroups(I, 14) = 1 Then
                                                    Contact = True
                                                End If
                                            Else
                                                If vCriteriaScheduleGroups(I, 14) = 1 Then
                                                    Contact = False
                                                End If
                                            End If


                                        End If

                                        'Check if there is a coroner's case
                                        '7/19/01 drh Added AND for Consent denied
                                        If pvForm.ChkCoronerCase.Checked = System.Windows.Forms.CheckState.Checked And modControl.GetID(pvForm.CboGeneralConsent) <> 3 Then
                                            If vCriteriaScheduleGroups(I, 17) = 1 Then
                                                Contact = True
                                                '7/19/01 drh Removed ELSE because it makes the original Contact Req go away (that's BAD!!)
                                                'Else
                                                'Contact = False
                                            End If
                                        Else
                                            If vCriteriaScheduleGroups(I, 17) = 1 Then
                                                Contact = False
                                            End If
                                        End If

                                        'Check if Statline should
                                        'perform a secondary screen.
                                        If vCriteriaScheduleGroups(I, 15) = 1 Then

                                            If (modControl.GetID(pvForm.CboAppropriate(ORGAN)) <> APPROP_YES) Or (modControl.GetID(pvForm.CboAppropriate(ORGAN)) = APPROP_YES And modControl.GetID(pvForm.CboApproach(ORGAN)) > 2) Then

                                                'Check if a Secondary pending for Statline
                                                'already exists, if not then create one
                                                Try
                                                    vSecondaryStatus = modStatQuery.QueryCreateSecondaryPending(pvForm)
                                                Catch ex As Exception
                                                    StatTracLogger.CreateInstance().Write(ex)
                                                End Try

                                                If vSecondaryStatus = CREATE_SECONDARY_PENDING And (pvForm.GetServiceLevel(CONSENT, vOption) And modControl.GetID(pvForm.CboConsent(vOption)) <= 1) Then

                                                    'Create a Secondary pending event
                                                    Try
                                                        vLogEventID = modStatSave.SaveLogEvent(pvForm, SECONDARY_PENDING)
                                                    Catch ex As Exception
                                                        StatTracLogger.CreateInstance().Write(ex)
                                                    End Try

                                                    '7/9/01 drh Save FS Case record
                                                    If modStatQuery.QueryFSCase(pvForm, fsResults) Then
                                                        '7/9/01 drh If FS Case execute additional logic
                                                        If IsNothing(fsResults) Then
                                                            Try
                                                                Call SaveFSLogEvent(pvForm, fsResults)
                                                            Catch ex As Exception
                                                                StatTracLogger.CreateInstance().Write(ex)
                                                            End Try
                                                        End If
                                                    End If

                                                    vNewItem = pvForm.LstViewPending.Items.Add("")
                                                    vNewItem.Tag = CStr(vLogEventID)
                                                    vNewItem.Text = "Secondary Pending"
                                                    If vNewItem.SubItems.Count > 1 Then
                                                        vNewItem.SubItems(1).Text = "Statline"
                                                    Else
                                                        vNewItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, "Statline"))
                                                    End If

                                                    Contact = False

                                                End If

                                                If vSecondaryStatus = CREATE_SECONDARY_PENDING Or vSecondaryStatus = SECONDARY_PENDING_CURRENT Then
                                                    vSecondaryPendingValid = True
                                                    Contact = False
                                                End If

                                            End If

                                        End If

                                        'Check if Statline should
                                        'perform consent.
                                        If vCriteriaScheduleGroups(I, 16) = 1 Then

                                            'Check if Statline is performing secondary screen
                                            If vCriteriaScheduleGroups(I, 15) = 1 Then
                                                'If Statline performs secondary screen, don't create a
                                                'consent pending until there is a secondary response created
                                                'Check if a Secondary pending or response exists for Statline
                                                vSecondaryStatus = modStatQuery.QueryCreateSecondaryPending(pvForm)

                                                If vSecondaryStatus = SECONDARY_PENDING_CLOSED Then
                                                    vConsentStatus = CREATE_CONSENT_PENDING
                                                Else
                                                    vConsentStatus = -1
                                                End If

                                            Else
                                                vConsentStatus = CREATE_CONSENT_PENDING
                                            End If

                                            If vConsentStatus = CREATE_CONSENT_PENDING Then

                                                'Check if a pending consent for statline
                                                'already exists, if not then create one
                                                Try
                                                    vConsentStatus = modStatQuery.QueryCreateStatlineConsentPending(pvForm)
                                                Catch ex As Exception
                                                    StatTracLogger.CreateInstance().Write(ex)
                                                End Try

                                                If vConsentStatus = CREATE_CONSENT_PENDING And (pvForm.GetServiceLevel(CONSENT, vOption) And modControl.GetID(pvForm.CboApproach(vOption)) = -1) Then

                                                    'Create a Secondary pending event
                                                    Try
                                                        vLogEventID = modStatSave.SaveLogEvent(pvForm, STATLINE_CONSENT_PENDING)
                                                    Catch ex As Exception
                                                        StatTracLogger.CreateInstance().Write(ex)
                                                    End Try

                                                    vNewItem = pvForm.LstViewPending.Items.Add("")
                                                    vNewItem.Tag = CStr(vLogEventID)
                                                    vNewItem.Text = "Consent Pending"
                                                    If vNewItem.SubItems.Count > 1 Then
                                                        vNewItem.SubItems(1).Text = "Statline"
                                                    Else
                                                        vNewItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, "Statline"))
                                                    End If

                                                    Contact = False

                                                End If

                                                If vConsentStatus = CREATE_CONSENT_PENDING Or vConsentStatus = CONSENT_PENDING_CURRENT Then
                                                    Contact = False
                                                End If

                                            End If

                                        End If

                                    Else
                                        'If option is not appropriate, then contact should not be made
                                        Contact = False

                                        'Unless...check if contact should be made option is not appropriate yet family consented
                                        If vCriteriaScheduleGroups(I, 12) = 1 And modControl.GetID(pvForm.CboGeneralConsent) <> 3 And modControl.GetID(pvForm.CboGeneralConsent) <> -1 Then
                                            Contact = True
                                        End If

                                        'Check if there is a coroner's case
                                        If pvForm.ChkCoronerCase.Checked = System.Windows.Forms.CheckState.Checked Then
                                            If vCriteriaScheduleGroups(I, 17) = 1 Then
                                                'drh 8/24/01; Commented this out because Coroner Required Contact should not be created for
                                                'medical ruleouts.  Left rest of code here in case we need to add it back in later.
                                                'Contact = True
                                            End If
                                        Else
                                            If vCriteriaScheduleGroups(I, 17) = 1 Then
                                                Contact = False
                                            End If
                                        End If
                                    End If

                                    If Contact = True Then

                                        'Determine LogEventScheduleID (bool)
                                        Dim LogEventScheduleID As Boolean
                                        Try
                                            LogEventScheduleID = modStatQuery.QueryLogEventScheduleID(pvForm, vCriteriaScheduleGroups(I, 0), vAlreadyContactedScheduleGroups, vOption)
                                        Catch ex As Exception
                                            StatTracLogger.CreateInstance().Write(ex)
                                        End Try

                                        'Check if a confirmed contact log event has been created for the schedule group
                                        'and that there is no callback pending event for the schedule group
                                        If LogEventScheduleID Then

                                            'There has been no contact, so check if the schedule group is already
                                            'in the pending contact list
                                            For k = 0 To UBound(vAlreadyListedScheduleGroups, 2)
                                                If vAlreadyListedScheduleGroups(0, k) = vCriteriaScheduleGroups(I, 0) Then
                                                    'Turn off the warning display
                                                    pvDisplayWarning = False
                                                    'Do not add to pending contacts list
                                                    vAddPendingContact = False
                                                End If
                                            Next k

                                            'The schedule group should be added to the pending contacts list
                                            If vAddPendingContact And Not pvDisplayWarning Then

                                                'First add to the listed array
                                                ReDim Preserve vAlreadyListedScheduleGroups(1, UBound(vAlreadyListedScheduleGroups, 2) + 1)
                                                vAlreadyListedScheduleGroups(0, UBound(vAlreadyListedScheduleGroups, 2)) = vCriteriaScheduleGroups(I, 0)
                                                vAlreadyListedScheduleGroups(1, UBound(vAlreadyListedScheduleGroups, 2)) = vOption

                                                'Next add to the pending events list
                                                vNewItem = pvForm.LstViewPending.Items.Add("")
                                                vNewItem.Tag = "|" & vCriteriaScheduleGroups(I, 10) & "|" & vCriteriaScheduleGroups(I, 0)
                                                vNewItem.Text = "Contact Req"
                                                If vNewItem.SubItems.Count > 1 Then
                                                    vNewItem.SubItems(1).Text = vCriteriaScheduleGroups(I, 2) & " - " & vCriteriaScheduleGroups(I, 1)
                                                Else
                                                    vNewItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, vCriteriaScheduleGroups(I, 2) & " - " & vCriteriaScheduleGroups(I, 1)))
                                                End If

                                            End If


                                            'Check if a warning should be displayed
                                            If pvDisplayWarning Then

                                                Call modUtility.Done()

                                                vMsg = "You must contact the following organization before the referral may be saved." & Chr(10) & Chr(13) & Chr(10) & Chr(13)
                                                vMsg = vMsg & "Option:" & Chr(9) & Chr(9) & modStatValidate.GetOptionString(vOption) & Chr(10) & Chr(13)
                                                vMsg = vMsg & "Organization:" & Chr(9) & vCriteriaScheduleGroups(I, 1) & Chr(10) & Chr(13)
                                                vMsg = vMsg & "Schedule:" & Chr(9) & vCriteriaScheduleGroups(I, 2) & Chr(10) & Chr(13) & Chr(10) & Chr(13)
                                                vMsg = vMsg & "Do you want to create an event which shows you contacted the agency? "

                                                If MsgBox(vMsg, MsgBoxStyle.YesNo, "Validation Error") = MsgBoxResult.Yes Then

                                                    pvForm.OpenOnCallEvent(vCriteriaScheduleGroups(I, 10), vCriteriaScheduleGroups(I, 0))

                                                    'ccarroll 05/05/2011 Added to prevent contact required data from being cleared
                                                    ' if OnCallEvent.Cancel is pressed. (wi:10467)
                                                    If isOnCallEventCancel Then
                                                        'Reset flag
                                                        isOnCallEventCancel = False

                                                        ValidateReferralContacts = False
                                                        Exit Function
                                                    End If
                                                    'Clear the grid
                                                    pvForm.LstViewLogEvent.Items.Clear()
                                                    pvForm.LstViewLogEvent.View = View.Details
                                                    'Fill Grid
                                                    Call modStatQuery.QueryOpenLogEvent(pvForm)

                                                    'Clear the grid
                                                    pvForm.LstViewPending.Items.Clear()
                                                    Call modStatQuery.QueryPendingEvents(pvForm)

                                                    ValidateReferralContacts = False
                                                    Exit Function


                                                End If

                                                ValidateReferralContacts = False
                                                Exit Function

                                            End If
                                        End If
                                    End If
                                End If
                            Next j
                        End If
                    Next I
                End If
            End If

        Next vOption


        'Check if any previously created secondary pending should be removed
        '8/21/01 drh Added switch for FSAlert items so they won't be deleted
        Dim vQuery As String = ""
        If vSecondaryPendingValid = False And pvForm.FSAlert <> True Then

            'Check if a secondary pending exists. If so, delete it
            vSecondaryStatus = modStatQuery.QueryCreateSecondaryPending(pvForm, vSecondaryPendingEvent)

            If vSecondaryStatus = SECONDARY_PENDING_CURRENT And pvForm.FormState = NEW_RECORD Then
                'Delete the secondary pending event
                Call modStatSave.DeleteLogEventID(vSecondaryPendingEvent(0, 0), pvForm.CallId)

                '7/26/01 drh If this is an FS Case, do not delete Secondary Pending Event
                If modStatQuery.QueryFSCase(pvForm, fsResults) Then
                    If Not IsNothing(fsResults) And fsResults(0, 4) = 0 Then
                        '8/2/01 drh Delete the FS Case record
                        vQuery = "delete fscase where callid = " & pvForm.CallId
                        '8/28/02 drh - Removed fsResults since there's no return value
                        'Call modODBC.Exec(vQuery, fsResults)
                        Call modODBC.Exec(vQuery)
                    End If
                End If

                'Clear the grid
                pvForm.LstViewPending.Items.Clear()
                Call modStatQuery.QueryPendingEvents(pvForm)
            End If

        End If

        If vGiveOptions Then
            pvForm.LblGive.Visible = True
        Else
            pvForm.LblGive.Visible = False
        End If

        Call modUtility.Done()

        Exit Function

    End Function

    Public Function GetOptionString(ByVal pvOption As Short) As String

        On Error Resume Next

        Select Case pvOption

            Case ORGAN
                GetOptionString = "Organ"
            Case BONE
                GetOptionString = "Bone"
            Case TISSUE
                GetOptionString = "Tissue"
            Case SKIN
                GetOptionString = "Skin"
            Case VALVES
                GetOptionString = "Valves"
            Case EYES
                GetOptionString = "Eyes"
            Case RESEARCH
                GetOptionString = "Other"
        End Select

    End Function

    Public Function OrganizationCallBack(ByRef pvForm As FrmOrganizationProperties) As Object

        'Check to see if there is a contact phone and extention to lookup
        'or if the contact phone or extention has changed.
        If (pvForm.ChkLeaseOrganization.Checked = True Or pvForm.OrganizationId = 194) And (Len(pvForm.TxtPhone.Text) < 14 And Len(pvForm.TxtPhone.Text) > 0 Or Len(pvForm.TxtPhone.Text) = 0) Then

            'Validate there is a phone number
            Call modMsgForm.FormValidate("Callback Phone #", pvForm.TxtPhone.Text)

        Else
            OrganizationCallBack = True
        End If
    End Function
    Public Function SetRefAutoResponse(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: SetRefAutoResponse
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of LstViewContact
        'Returns: String containing auto response pager message.
        'Params: pvForm As Form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/15/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 340
        'Description:  Removed REFERRAL_PENDING_TAG from body of text -
        '              functionality now handled in frmEmail by appending LogEventCode.
        '====================================================================================
        '====================================================================================
        'Date Changed: 02/15/2007                        Changed by: Thien Ta
        'Release #: 8.3                                 Task:
        'Description:  added code for callID to be on utoResponse page
        '====================================================================================
        '************************************************************************************
        'mjd 05/28/2002 Page-AutoResponse
        On Error Resume Next

        Dim vQuery As String = ""
        Dim s As String = ""
        Dim v As New Object
        Dim R As Boolean

        vQuery = "SELECT StatEmployeeFirstName, StatEmployeeLastName " & "FROM StatEmployee " & "WHERE StatEmployeeUserID = '" & AppMain.UserID & "';"

        R = modODBC.Exec(vQuery, v)

        s = "#" & pvForm.CallId & " - " & "Tel:" & pvForm.LblPhone.Text & ", " & pvForm.LblName.Text & Surround(pvForm.LblPersonType.Text, "-", ", ") & Surround(pvForm.LblOrganization.Text, , ", ") & Surround(pvForm.LblSubLocation.Text) & Surround(pvForm.LblLevel.Text, "-") & Environment.NewLine
        s = s & Surround(pvForm.TxtDonorFirstName.Text, "Donor:", " ") & Surround(pvForm.TxtDonorLastName.Text, , ", ") & Surround(pvForm.TxtSSN.Text, , ", ") & Surround(pvForm.TxtDOB.Text, , " ") & Surround(pvForm.TxtAge.Text, , " " & pvForm.CboAgeUnit.Text & ", ")
        s = s & Surround(pvForm.CboGender.Text, , ", ") & Surround(pvForm.CboRace.Text, , ", ") & Surround(pvForm.TxtWeight.Text, , pvForm.LblWeight.Text & ", ")
        s = s & Surround(pvForm.CboCauseOfDeath.Text, "COD:", ", ") & Surround(pvForm.TxtNotesCase.Text, "Hx:", ", ") & Surround(pvForm.CboVent.Text, "Vent:", ", ") & Surround(pvForm.TxtDeathDate.Text & " " & pvForm.TxtDeathTime.Text, "DOD:") & Environment.NewLine
        s = s & Surround(pvForm.NOKFirstName, "NOK:") & Surround(pvForm.NOKLastName, " ") & Surround(pvForm.NOKApproachRelation, " Relation:") & Surround(pvForm.NOKRefPhone, " ") & Environment.NewLine
        s = s & Surround(pvForm.CboPhysician(0).Text, "Attending:") & Environment.NewLine
        'Commented out for changes in ver. 7.7.2.  This info now contained in frmEmail.LogEventCode.  12/15/04 - SAP
        's = s & REFERRAL_PENDING_TAG & pad(pvForm.CallId, 10)
        s = s & Environment.NewLine

        s = s & v(0, 0) & " " & v(0, 1) & " " & AppMain.Queue & Surround(CStr(AppMain.Extension), " x")
        SetRefAutoResponse = s

    End Function

    Public Function SetRefAutoResponseSbj(ByRef pvForm As Object) As Object 'mjd 05/28/2002 Page-AutoResponse
        On Error Resume Next
        SetRefAutoResponseSbj = REFERRAL_PENDING_TAG & pad(pvForm.CallId, 10)
    End Function

    Public Function pad(ByRef v As Object, ByRef N As Object) As String 'mjd 05/28/2002 Page-AutoResponse
        If Len(v) > N Then
            pad = v
        Else
            pad = New String("0", N - Len(v)) & v
        End If
    End Function

    Public Function Surround(ByRef v As String, Optional ByRef pre As String = "", Optional ByRef post As String = "") As String 'mjd 05/28/2002 Page-AutoResponse
        On Error GoTo exit_Surround

        'bret 01/07/10 broke out single if statement to seperate IsNull and Trim$()
        'if v is Null set it to empty string
        If IsDbNull(v) Then
            v = ""
        End If

        If Trim(v) <> "" Then
            Surround = pre & v & post
        End If

exit_Surround:
        Exit Function

    End Function

    ''' <summary>
    ''' Checks if string is valid and SQL compatible date
    ''' </summary>
    ''' <param name="txtDate">Date as String</param>
    ''' <returns>Boolean: true if txtDate is a SQL compatible date, else false</returns>
    Public Function IsDateSqlCompat(txtDate As String)
        Dim response As Boolean

        Try
            response = (IsDate(txtDate) AndAlso TextToDate(txtDate) >= Data.SqlTypes.SqlDateTime.MinValue.Value.Date)
        Catch
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        End Try

        Return response
    End Function
End Module
