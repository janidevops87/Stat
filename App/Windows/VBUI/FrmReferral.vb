Option Strict Off
Option Explicit On
Option Infer On
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Threading.Tasks
Imports Newtonsoft.Json
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant
Imports Statline.Stattrac.Framework
Imports Statline.Stattrac.Framework.Validater
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Windows.UI
Imports Stattrac.Services.Donor
Imports Stattrac.Services.Donor.Registry.Model
Imports Stattrac.UIServices.Donor.Search
Imports VB = Microsoft.VisualBasic

Public Class FrmReferral
    'Inherits System.Windows.Forms.Form
    Inherits BaseFormReferralData
    'bret 01/12/2010 moved Form Variables to FrmOrganizationProperties

    'Form Variables
    Public RegistrySource As String 'T.T 07/25/2007 release 8.4 req 3.5.1
    Public CODStateFocus As Boolean 'T.T 07/10/2007 release 8.4 req 3.4
    Public RegMatchClicked As Boolean 'T.T 05/31/2007 release 8.4 req 2.4
    Public WeightRuleOut As Boolean 'T.T 05/31/2007 release 8.4 flag to determine weight ruleout
    Public vVerifyWeight As Boolean 'T.T 05/30/2007  release 8.4  req 3.4
    Public vVerifySex As Boolean 'T.T 05/30/2007  release 8.4  req 3.4
    Public FormState As Short
    Public vOldDeathDate As String
    Public vOldDeathTime As String
    Public vOldBrainDeathDate As String
    Public vOldTextLblOrganization As String
    Public vOriginalOrgId As Integer
    Public vOriginalSC As Integer
    Public vOriginalAMD As Integer
    Public vOriginalPMD As Integer
    Public vOriginalLName As String
    Public vTxtLNameChng As Boolean
    Public vTxtMedicalRecordChng As Boolean
    Public vTabIndex As Integer
    Public vOpenEventLog As Boolean
    Public CallType As Short
    Private _CallId As Integer

    Public Property CallId As Integer
        Get
            Return _CallId
        End Get
        Set(value As Integer)
            _CallId = value
            SessionDetails.callId = value
        End Set
    End Property
    Public ReferralId As Integer
    Public LOCallID As Integer
    Public CallNumber As String
    Public fvCallDate As Date
    Public fvCallTotalTime As Date
    Public fvLOCallTotalTime As Date
    Public TimeSnapshot As Date
    Public SortOrder As Short
    Public CallOpenByID As Integer
    Public CallFSCase As Boolean
    Public CallExclusive As Boolean
    Public CallPending As Boolean
    Public HoldCount As Short
    Public HoldCountCboName As Short
    Public CallComplete As Boolean
    Public Cancel As Boolean
    Public vtxtnoteschng As Boolean
    Public vReturnSC As Short

    '08/26/2011 ccarroll - If registry database not found prevent registry note wi:13238
    Public RegistryDatabaseNotFound As Boolean

    Public CallPhoneNumberID As Integer
    Public OrganizationId As Integer
    Public OrganizationName As String
    Public OrganizationTimeZone As String
    Public OrganizationCountyID As Integer
    Public CallPhoneNumber As String
    Public CallPhoneExtension As String
    Public SubLocationID As Integer
    Public SubLocation As String
    Public SubLocationLevel As String
    Public PersonID As Integer
    Public Person As String
    Public PersonType As String
    Public ApproachedByID As Integer
    Public CoronerLogEventID As Integer
    Public CoronerOrgID As Integer
    Public OrganServiceLevel As Short
    Public TissueServiceLevel As Short
    Public EyesServiceLevel As Short
    Public TissueServiceLevelApproach As Short
    Public EyesServiceLevelApproach As Short
    Dim AppropriateIndication(7) As Short 'T.T 12/05/2006 appropriate ruleout

    Public LastPhone As String
    Public OldValue As String
    Public PreviousField As String
    Public CaseNotes As String

    Public DonorCategoryID As Integer
    Public CriteriaGroupID As Integer
    Public CurrentLogEventID As Integer
    Public ScheduleAlert As String
    Public AlertType As Short

    Public VerifiedOptions As Boolean

    Public Saved As Short
    Public FormLoad As Short

    Public OrganDispositionID As Object
    Public BoneDispositionID As Object
    Public TissueDispositionID As Object
    Public SkinDispositionID As Object
    Public ValvesDispositionID As Object
    Public EyesDispositionID As Object
    Public RschDispositionID As Object
    Public AllTissueDispositionID As Object

    Public AttendingMDID As Integer
    Public PronouncingMDID As Integer
    Public AttendingMDPhone As String
    Public PronouncingMDPhone As String

    'New NOK data before release 8.0 Char Chaput
    Public NOKID As Integer
    Public NOKFirstName As String
    Public NOKLastName As String
    Public NOKRefPhone As String
    Public NOKRefAddress As String
    Public NOKCity As String
    Public NOKStateID As Short
    Public NOKZip As String
    Public NOKApproachRelation As String
    Public ModNOK As Boolean
    Public AddNOK As Boolean

    'New MD Phone for release 8.0 Char Chaput
    Public MDPhone As Boolean
    'Char Chaput 04/25/06 Added this flag to determine if cancelled from New Call screen type = 1 from new call
    'then use modstatquery.QueryRecycledNC so doesn't produce a bunch of db errors when there's an error in errorprodquery
    Public RecycledNCType As Short
    'This is checked in FrmOpenAll
    'Char Chaput 04/25/06 Added this flag to determine if recycled call
    Public RecycledNC As Boolean

    'ccarroll 060706 - to allow QA Access 8.0 release
    Public AllowQA As Boolean
    Public QAAccess As Boolean

    'Old NOK data before release 8.0 Char Chaput
    Public NOK As String
    Public NOKRelation As String
    Public NOKPhone As String
    Public NOKAddress As String
    Public NOKData As Boolean

    Public ShiftKey As Boolean

    Public ReferralCall As New clsCall
    Public CallerOrg As New clsOrganization
    Public SourceCode As New clsSourceCode
    Public ReferralSecondary As New clsReferralSecondary

    Public ApproachTime As Short
    Public ConsentTime As Short
    Public DispositionFieldEnabled As Boolean 'T.T 8/31/2006 added to flag if dispo is enabled

    Public strRegistryMessage As String

    '8/21/01 drh
    Public FSAlert As Boolean

    'ccarroll 06/06/2007 StatTrac 8.4 release, requirement 3.6 - TBI Number
    'Used to generate TBI Number
    Public TBIUpdateFlag As Boolean
    Public TBIAccess As Boolean
    Public TBIDate As String
    Public TBIPrefix As String
    Public TBINoteText As String


    '01/08/04 mds: ExecuteClick is a flag used to avoid executing the click function for
    'CboHeartBeat when the form is loading; otherwise, it automatically executes and
    'viewing an existing referral may make a message box appear when certain heartbeat
    'and vent combinations exist for the referral
    Private ExecuteClick As Boolean

    '02/18/02 bjk: CboVentChanged is a flag to determine if the coordinator changes the value
    Public CboVentChanged As Boolean

    '01/06/04 mds CboHeartBeatChanged is a flag to determine if the coordinator changes the value
    Public CboHeartBeatChanged As Boolean

    'FSProj drh 4/30/02 - Temporary store for Triage Option Criteria ID's
    Public ReferralTriageCriteria As New Collection

    'FSProj drh 5/01/02 - Save Historical Referral Status
    Public HistoricalReferral As Boolean

    'FSProj drh 5/2/02 - Temporary store for Service Level Id
    Public ServiceLevelId As Integer

    '10/02/02 drh
    Public AuditLogId As Integer

    ' Variables used to track preliminary and current referral types.  V. 8.0, 6/13/05 - SAP
    Public pvPrelimReferralType As Short
    Public pvCurrentReferralType As Short

    Public sPrelimRefTypeDesc As String
    Public sCurrentRefTypeDesc As String
    'bret 02/17/2010 replaced old vb6 control arrays
    'Public CboApproach(7) As System.Windows.Forms.ComboBox
    'Public CboAppropriate(7) As System.Windows.Forms.ComboBox
    'Public CboConsent(7) As System.Windows.Forms.ComboBox
    'Public CboRecovery(7) As System.Windows.Forms.ComboBox
    Public CboApproach As Hashtable
    Public CboAppropriate As Hashtable
    Public CboConsent As Hashtable
    Public CboRecovery As Hashtable
    Public CmdOption As Hashtable
    Public tabDispositionTable As Hashtable
    Private tabDonorTable As Hashtable
    Public CboPhysician(2) As System.Windows.Forms.ComboBox
    Public CmdPhysicianDetail(2) As Button
    Public LblPhysician(2) As Label

    Public CmdPhysicianPhone(2) As Button
    Public TxtAlerts(2) As RichTextBox

    'bret 02/17/2010 add references to forms
    Private frmColorKey As FrmColorKey
    Private frmCriteria As FrmCriteria
    Private frmCustom1 As FrmCustom1
    Private frmDonorIntent As FrmDonorIntent
    Private frmEventLogDescription As FrmEventLogDescription
    Private frmList As FrmList
    Private frmLogEvent As FrmLogEvent
    'bret 02/01/11 
    Private uIMap As UIMap

    Private frmOnCallEvent As FrmOnCallEvent
    Private frmDCDPotential As FrmDCDPotential
    Private frmPossibleDCDCase As FrmPossibleDCDCase

    Private frmVerifySex As FrmVerifySex
    Private frmVerifyWeight As FrmVerifyWeight

    'bret 4/2010 added to move functionality to FrmNew
    Public vOriginalVent As Boolean
    Public vOriginalHB As Boolean

    'ccarroll 06/21/2010 use to reset approach if donor lastname changes
    Public MethodOfApproachReset As Boolean
    Public vTabDispositionSelect As Boolean
    Public vLastActiveControlName As String
    Public vLastActiveControl As Control
    Private isDuplicate As Boolean

    'ccarroll 04/07/2011 Added switch to prevent MsgBox focus (wi:11418)
    'MsgBox is now handled in the Shown event.
    Public OrganizationNotAssignedToServiceLevel As Boolean

    'ccarroll 09/12/2011 CTOD CCRST151
    Public DeclaredCTODUpdateFlag As Boolean

    'ccarroll 07/16/2014 Organ Med RO CCRST175
    Public OrganMedROUpdateFlag As Boolean

    'ccarroll 12/19/2011 PNE Validating Dispo Issue CCRST165
    Public IsPNEActive As Boolean

    Public bolDCDPotentialSelected As Boolean = False

    'TODO: Use validation event trigger instead of this method
    'TODO: Add time field validation
    Public Function DateValidate() As Boolean
        DateValidate = True

        '02/13/03 drh - Check for valid dates
        If TxtAdmitDate.Text <> "" AndAlso (Len(TxtAdmitDate.Text) < 8 Or Not DateTimeTryParseExact(TxtAdmitDate.Text)) Then
            Call MsgBox("AdmitDate field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If

        '02/13/03 drh - Check for valid dates
        If TxtDeathDate.Text <> "" AndAlso (Len(TxtDeathDate.Text) < 8 Or Not DateTimeTryParseExact(TxtDeathDate.Text)) Then
            Call MsgBox("DeathDate field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If

        '02/13/03 drh - Check for valid dates
        If TxtDOB.Text <> "" AndAlso (Len(TxtDOB.Text) < 10 Or Not DateTimeTryParseExact(TxtDOB.Text)) Then
            Call MsgBox("AdmitDate field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If

        If TxtLSADate.Text <> "" AndAlso (Len(TxtLSADate.Text) < 8 Or Not DateTimeTryParseExact(TxtLSADate.Text)) Then
            Call MsgBox("LSA date field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If

        If TxtBrainDeathDate.Text <> "" AndAlso (Len(TxtBrainDeathDate.Text) < 8 Or Not DateTimeTryParseExact(TxtBrainDeathDate.Text)) Then
            Call MsgBox("Brain death date field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If

        If TxtAdmitDate.Text <> "" AndAlso (Len(TxtAdmitDate.Text) < 8 Or Not DateTimeTryParseExact(TxtAdmitDate.Text)) Then
            Call MsgBox("Admit date field contains an invalid date.  Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
            DateValidate = False
            Exit Function
        End If
    End Function
    Public Function GetPNEWarningOnSave() As Boolean
        '************************************************************************************
        'Name: GetPNEWarningOnSave()
        'Date: 09/09/2011
        'Created by:    ccarroll
        'Release:       StatTac CCRST151                             
        'Description:   PNE – Allow Saving without Addressing Contact Required Events.
        ' 				This function Determines if the user is allowed to save a Patient Not Expired case
        '               without(addressing)	the contact required events if certain criteria exists.
        '====================================================================================

        'GetPNEWarningOnSave returns True by default.
        'If GetPNEWarningOnSave is True, then contact required will need to be addressed before save is allowed.
        GetPNEWarningOnSave = True 'Default 

        Dim isPNEReferralTypeAllowed As Boolean
        Dim isPNECTODAllowed As Boolean

        'Check ServiceLevel active
        If Me.CallerOrg.ServiceLevel.PNEAllowSaveWithoutContactRequired = -1 Then

            'Check for allowable Preliminary PNE Referral Types
            Select Case Me.pvPrelimReferralType
                Case TISSUE_EYE,
                     EYE_ONLY,
                     RULEOUT

                    'if any of the above is true: 
                    isPNEReferralTypeAllowed = True
            End Select

            'May need to add Current Referral Type check

            'Check for CTOD or LSA or DOA condition based on what is enabled
            If Me.TxtDeathDate.Enabled And ChkDOA.Enabled = False Then
                ' Only two conditions required
                If Me.TxtDeathTime.Text.Length < 1 And Me.TxtLSATime.Text.Length < 1 Then
                    isPNECTODAllowed = True
                End If
            ElseIf ChkDOA.Enabled And Me.TxtDeathDate.Enabled Then
                'All three conditions required
                If ChkDOA.Checked = False And Me.TxtDeathTime.Text.Length < 1 And Me.TxtLSATime.Text.Length < 1 Then
                    isPNECTODAllowed = True
                End If
            Else
                If ChkDOA.Enabled And Me.TxtDeathDate.Enabled = False Then
                    'Only DOA condition evaluation required
                    If ChkDOA.Checked = False Then
                        isPNECTODAllowed = True
                    End If
                End If
            End If


            'if PNE criteria is valid then
            If isPNEReferralTypeAllowed And isPNECTODAllowed Then
                If Me.FormState = EXISTING_RECORD And Me.FormLoad <> True Then
                    'Display banner for Patient Not Expired
                    Me.lblPNEBorderLeft.Visible = True
                    Me.lblPNEBorderRight.Visible = True
                    Me.lblPNELabel.Visible = True

                    'isPNEActive is used to test if referral validation should be run to evaluate disposition.
                    'If isPNEActive is false, disposition will re-evaluate because the DOB calculation has changed
                    'when the death date was entered.
                    IsPNEActive = True
                End If

                'Setting return value to false suppresses warning when validating referral
                'and allows saving referral without addressing contact required.
                GetPNEWarningOnSave = False
            End If

        End If 'End ServiceLevel check 

    End Function



    Public Function ZeroCriteria() As Object
        'FSProj drh 5/3/02 - New function: populates criteria collection with zero values
        Dim I As Integer

        If Me.ReferralTriageCriteria.Count() > 0 Then
            'Empty the collection
            For I = Me.ReferralTriageCriteria.Count() To 1 Step -1
                Call Me.ReferralTriageCriteria.Remove(I)
            Next I
        End If

        'Populate with zero's
        For I = ORGAN To RESEARCH
            Call Me.ReferralTriageCriteria.Add(0, CStr(I))
        Next I


    End Function

    Public Function ClearCriteria() As Object
        'FSProj drh 5/3/02 - New function: empties criteria collection
        Dim I As Integer

        If Me.ReferralTriageCriteria.Count() = 0 Then
            Exit Function
        Else
            'Empty the collection
            For I = Me.ReferralTriageCriteria.Count() To 1 Step -1
                Call Me.ReferralTriageCriteria.Remove(I)
            Next I
        End If

    End Function

    Public Function CriteriaValid() As Object
        'FSProj drh 5/3/02 - New function: checks whether the criteria collection contains valid criteria
        Dim I As Integer
        CriteriaValid = False

        'If there are less than seven items, Criteria is not valid
        If Me.ReferralTriageCriteria.Count() < 7 Then
            Exit Function
        Else
            'If at least one item is greater than zero, then the Criteria is valid
            For I = ORGAN To RESEARCH
                If Me.ReferralTriageCriteria.Item(CStr(I)) > 0 Then
                    CriteriaValid = True
                    Exit Function
                End If
            Next I
        End If

    End Function



    '9/28/01 drh
    Public Function GetCheckRegistryValue(ByVal pvServiceLevelStatusID As Integer, Optional ByRef pvServiceLevelId As Integer = 0) As Boolean
        'FSProj drh 5/3/02 - Added pvServiceLevelStatusId and optional pvServiceLevel parameter
        'ccarroll 10/12/2010 changed GetCheckRegistryValue to return boolean
        Dim vQuery As String = ""
        Dim ResultsArray As New Object
        Dim Result As New Object

        '10/23/01 bjk set default value for return
        GetCheckRegistryValue = -1

        'FSProj drh 5/3/02 - If we have a ServiceLevelId, use it (added If statement)
        If pvServiceLevelId > 0 Then
            vQuery = "SELECT ServiceLevelCheckRegistry From ServiceLevel Where ServiceLevelID = " & pvServiceLevelId
        Else
            'FSProj drh 5/3/02 - Added AND clause so we get the correct Service Level for our status (ServiceLevelStatus)
            vQuery = "SELECT ServiceLevelCheckRegistry From ServiceLevel Where ServiceLevelID in " & "(SELECT DISTINCT ServiceLevel30Organization.ServiceLevelID  " & "From ServiceLevel30Organization " & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID " & "Where OrganizationID = " & Me.OrganizationId & " AND ServiceLevelSourceCode.SourceCodeID = " & Me.SourceCode.ID & ")" & " AND ServiceLevelStatus = " & pvServiceLevelStatusID
        End If

        '10/23/01 bjk changed return value from GetCheckRegistryValue to Result
        Try
            Result = modODBC.Exec(vQuery, ResultsArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '10/23/01 bjk changed check value from GetCheckRegistryValue to Result
        If Result = SUCCESS AndAlso ObjectIsValidArray(ResultsArray, 2, 0, 0) Then
            GetCheckRegistryValue = ResultsArray(0, 0)

        End If

    End Function


    Public Function InitializePhysician(ByRef pvForm As FrmReferral) As Object
        'Set physician
        If pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
            Call modControl.Disable(pvForm.CboPhysician(0))
            Call modControl.Disable(pvForm.CboPhysician(1))
            Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
            Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
            Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
            Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
            Try
                Call modStatQuery.QueryLocationPhysicians(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.Disable(pvForm.CboPhysician(0))
            Call modControl.Enable(pvForm.CboPhysician(1))
            Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
            Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
            Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
            Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            'if CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
            Try
                Call modStatQuery.QueryLocationPhysicians(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.Enable(pvForm.CboPhysician(0))
            Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
            Call modControl.Disable(pvForm.CboPhysician(1))
            Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
            Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
            'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
            Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
            Try
                Call modStatQuery.QueryLocationPhysicians(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.Enable(pvForm.CboPhysician(0), True) 'T.T 10/03/2004 added to skip enable
            Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
            Call modControl.Enable(pvForm.CboPhysician(1), True) 'T.T 10/03/2004 added to skip enable
            Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
            Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
            Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
            'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
            'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
            If pvForm.CboVent.Text = "Previously" Or pvForm.CboVent.Text = "Currently" Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Disable(pvForm.CboPhysician(0))
                Call modControl.Enable(pvForm.CboPhysician(1))
                Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
                pvForm.CboPhysician(1).BackColor = System.Drawing.Color.White
                Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            Else
                Call modControl.Disable(pvForm.CboPhysician(0))
                If pvForm.CboPhysician(0).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(0), 0)
                    Me.AttendingMDID = 0
                    Me.TxtAttendingPhone.Text = ""
                    Me.AttendingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CboPhysician(1))
                If pvForm.CboPhysician(1).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(1), 0)
                    Me.PronouncingMDID = 0
                    Me.TxtPronouncingPhone.Text = ""
                    Me.PronouncingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            End If
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
            If pvForm.CboVent.Text = "Previously" Or pvForm.CboVent.Text = "Currently" Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Enable(pvForm.CboPhysician(0))
                Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
                Call modControl.Enable(pvForm.CboPhysician(1))
                'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            Else
                Call modControl.Enable(pvForm.CboPhysician(0))
                Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
                Call modControl.Disable(pvForm.CboPhysician(1))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
                'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            End If
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_VENT And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
            Try
                Call modStatQuery.QueryLocationPhysicians(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            If pvForm.CboVent.Text = "Previously" Or pvForm.CboVent.Text = "Currently" Then
                Call modControl.Enable(pvForm.CboPhysician(0))
                Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
                Call modControl.Enable(pvForm.CboPhysician(1))
                Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
                Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
                'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            Else
                Call modControl.Disable(pvForm.CboPhysician(0))
                Call modControl.Enable(pvForm.CboPhysician(1))
                Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
                Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            End If
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_VENT And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
            If pvForm.CboVent.Text = "Previously" Or pvForm.CboVent.Text = "Currently" Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Enable(pvForm.CboPhysician(0))
                Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
                pvForm.CboPhysician(0).BackColor = System.Drawing.Color.White
                Call modControl.Disable(pvForm.CboPhysician(1))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
                'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            Else
                Call modControl.Disable(pvForm.CboPhysician(0))
                If pvForm.CboPhysician(0).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(0), 0)
                    Me.AttendingMDID = 0
                    Me.TxtAttendingPhone.Text = ""
                    Me.AttendingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CboPhysician(1))
                If pvForm.CboPhysician(1).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(1), 0)
                    Me.PronouncingMDID = 0
                    Me.TxtPronouncingPhone.Text = ""
                    Me.PronouncingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            End If
        ElseIf pvForm.CallerOrg.ServiceLevel.AttendingMD = MD_VENT And pvForm.CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
            If pvForm.CboVent.Text = "Previously" Or pvForm.CboVent.Text = "Currently" Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Enable(pvForm.CboPhysician(0))
                Call modControl.SelectID(pvForm.CboPhysician(0), Me.AttendingMDID)
                pvForm.CboPhysician(0).BackColor = System.Drawing.Color.White
                Call modControl.Enable(pvForm.CboPhysician(1))
                Call modControl.SelectID(pvForm.CboPhysician(1), Me.PronouncingMDID)
                pvForm.CboPhysician(1).BackColor = System.Drawing.Color.White
                Call modControl.Enable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Enable(pvForm.CmdPhysicianDetail(1))
                'If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(0)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                'If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(pvForm.CmdPhysicianPhone(1)) Else Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            Else
                Call modControl.Disable(pvForm.CboPhysician(0))
                If pvForm.CboPhysician(0).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(0), 0)
                    Me.AttendingMDID = 0
                    Me.TxtAttendingPhone.Text = ""
                    Me.AttendingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CboPhysician(1))
                If pvForm.CboPhysician(1).SelectedValue > 0 Then
                    Call modControl.SelectID(pvForm.CboPhysician(1), 0)
                    Me.PronouncingMDID = 0
                    Me.TxtPronouncingPhone.Text = ""
                    Me.PronouncingMDPhone = ""
                End If
                Call modControl.Disable(pvForm.CmdPhysicianDetail(0))
                Call modControl.Disable(pvForm.CmdPhysicianDetail(1))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(0))
                Call modControl.Disable(pvForm.CmdPhysicianPhone(1))
            End If
        End If


    End Function
    Public Function PopulateCriteria() As Object
        'FSProj drh 5/3/02 - New function: populates Criteria collection if it isn't already populated
        Dim I As Integer
        Dim applicableStatus As Short

        'FSProj drh 4/30/02 - Before we start, loop through Triage Options and add the applicable Criteria to the Referral Criteria ID collection if necessary
        '*************************************************************************************
        Dim vCriteriaStatus As Integer
        If Not Me.CriteriaValid Then
            'Clear the criteria
            Call Me.ClearCriteria()

            'Get the correct Criteria Status value to use in Criteria query based
            If Me.HistoricalReferral Then
                vCriteriaStatus = ORIGINAL_CRITERIA
            Else
                vCriteriaStatus = CURRENT_CRITERIA
            End If

            'Query the Criteria
            For I = ORGAN To RESEARCH
                Me.DonorCategoryID = I

                'Look up applicable status             
                Try
                    applicableStatus = modStatQuery.QueryCategoryGroupsApplicable(Me, vCriteriaStatus)
                Catch ex As Exception
                    applicableStatus = SQL_ERROR
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If applicableStatus = SUCCESS Then
                    Call Me.ReferralTriageCriteria.Add(Me.CriteriaGroupID, CStr(I))
                Else
                    Call Me.ReferralTriageCriteria.Add(0, CStr(I))
                End If
            Next I

        End If
        '*************************************************************************************
        'criteria should be loaded. Check each criteria, if the criteria is 0 try to reload


        'Query the Criteria
        For I = ORGAN To RESEARCH
            Me.DonorCategoryID = I
            If Me.ReferralTriageCriteria.Item(CStr(I)) = 0 Then

                'Look up applicable status
                Try
                    applicableStatus = modStatQuery.QueryCategoryGroupsApplicable(Me, vCriteriaStatus)
                Catch ex As Exception
                    applicableStatus = SQL_ERROR
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If applicableStatus = SUCCESS Then
                    Me.ReferralTriageCriteria.Remove(CStr(I))
                    Call Me.ReferralTriageCriteria.Add(Me.CriteriaGroupID, CStr(I))

                End If
            End If
        Next I


    End Function

    Public Sub SelectFirstResult()

        'LstViewVerify.Items.Item(0).Selected = True        
        Try
            LstViewVerify_Click(LstViewVerify.Items.Item(0), New System.EventArgs())
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Sub

    Public Property CallTotalTime() As Object
        Get

            CallTotalTime = VB6.Format(fvCallTotalTime, "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvCallTotalTime = CDate(VB6.Format(TimeValue(Value), "hh:mm:ss"))

        End Set
    End Property
    Public Property LOCallTotalTime() As Object
        Get

            LOCallTotalTime = VB6.Format(fvLOCallTotalTime, "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvLOCallTotalTime = CDate(VB6.Format(TimeValue(Value), "hh:mm:ss"))

        End Set
    End Property


    Public Property CallDate() As Object
        Get

            CallDate = VB6.Format(fvCallDate, "mm/dd/yy  hh:mm")

            'Check for invalid date and log details if we find one
            If CallDate = VB6.Format("12/30/1999 00:00", "mm/dd/yy  hh:mm") Then
                Dim exMessage As String = "FrmReferral.CallDate(get) - CallDate returned as: " + CallDate +
                    ", fvCallDate provided as: " + fvCallDate + " for CallID: " + Me.CallId.ToString()
                Dim ex As Exception = New Exception("StatTrac Validation Failure: " + exMessage)
                StatTracLogger.CreateInstance().Write(ex, TraceEventType.Warning)
            End If

        End Get
        Set(ByVal Value As Object)

            fvCallDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm"))

        End Set
    End Property

    Public Function GetFSStage() As Boolean

        Dim vResults As New Object
        Dim vFSStage As New Object 'Stage FS Case is in currently

        Dim FS_CREATED As Object 'Secondary Event has been created
        Dim FS_OPEN As Object 'FS Case marked "Open"
        Dim FS_SYSEVENT As Object 'FS Case marked "System Events"
        Dim FS_SECCOMP As Object 'FS Case marked "Secondary Complete"
        Dim FS_APPROACHED As Object 'FS Case marked "Approached"
        Dim FS_FINAL As Object 'FS Case marked "Final"

        Dim vFSOpenUserId As New Object 'Id of Person who marked FS Case "Open"
        Dim vFSSysEventUserId As New Object 'Id of Person who created first Event after FS Case was marked "Open"
        Dim vFSSecCompUserId As New Object 'Id of Person who marked FS Case "Secondary Complete"
        Dim vFSApproachUserId As New Object 'Id of Person who marked FS Case "Approached"
        Dim vFSFinalUserId As New Object 'Id of Person who marked FS Case "Final"

        Dim vFSOpenName As New Object 'Name of Person who marked FS Case "Open"
        Dim vFSSysEventName As New Object 'Name of Person who created first Event after FS Case was marked "Open"
        Dim vFSSecCompName As New Object 'Name of Person who marked FS Case "Secondary Complete"
        Dim vFSApproachName As New Object 'Name of Person who marked FS Case "Approached"
        Dim vFSFinalName As New Object 'Name of Person who marked FS Case "Final"

        Dim vFSOpenDateTime As New Object 'Date/time FS Case was marked "Open"
        Dim vFSSysEventDateTime As New Object 'Date/time first Event after FS Case was marked "Open"
        Dim vFSSecCompDateTime As New Object 'Date/time FS Case was marked "Secondary Complete"
        Dim vFSApproachDateTime As New Object 'Date/time FS Case was marked "Approached"
        Dim vFSFinalDateTime As New Object 'Date/time FS Case was marked "Final"

        '7/23/01 drh Set Stage constants (variables)
        FS_CREATED = 1
        FS_OPEN = 2
        FS_SYSEVENT = 3
        FS_SECCOMP = 4
        FS_APPROACHED = 5
        FS_FINAL = 6

        '7/23/01 drh Get FS Case record
        Try
            Call modStatQuery.QueryFSCase(Me, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '7/23/01 drh Get info for each stage
        'Make sure we got valid results from QueryFSCase
        If ObjectIsValidArray(vResults, 2, 0, 20) Then
            Try
                vFSOpenUserId = vResults(0, 4)
                vFSSysEventUserId = vResults(0, 6)
                vFSSecCompUserId = vResults(0, 8)
                vFSApproachUserId = vResults(0, 10)
                vFSFinalUserId = vResults(0, 12)
                vFSOpenName = vResults(0, 16)
                vFSSysEventName = vResults(0, 17)
                vFSSecCompName = vResults(0, 18)
                vFSApproachName = vResults(0, 19)
                vFSFinalName = vResults(0, 20)
                vFSOpenDateTime = vResults(0, 5)
                vFSSysEventDateTime = vResults(0, 7)
                vFSSecCompDateTime = vResults(0, 9)
                vFSApproachDateTime = vResults(0, 11)
                vFSFinalDateTime = vResults(0, 13)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                vFSOpenUserId = 0
                vFSSysEventUserId = 0
                vFSSecCompUserId = 0
                vFSApproachUserId = 0
                vFSFinalUserId = 0
            End Try

            If vFSFinalUserId <> 0 Then
                vFSStage = FS_FINAL
            Else
                If vFSApproachUserId <> 0 Then
                    vFSStage = FS_APPROACHED
                Else
                    If vFSSecCompUserId <> 0 Then
                        vFSStage = FS_SECCOMP
                    Else
                        If vFSSysEventUserId <> 0 Then
                            vFSStage = FS_SYSEVENT
                        Else
                            If vFSOpenUserId <> 0 Then
                                vFSStage = FS_OPEN
                            Else
                                vFSStage = FS_CREATED
                            End If
                        End If
                    End If
                End If
            End If
        Else
            'Not a Family Services Case, so exit
            Exit Function
        End If

        '7/23/01 drh Initialize Family Services components (Secondary tab)
        'Me.lblSecondaryStatus.Visible = True 'ccarroll 06/06/2007 removed
        Me.chkCaseOpen.Visible = True
        Me.chkCaseOpen.Enabled = False
        Me.chkCaseOpen.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.lblCaseOpenPersonDateTime.Visible = False
        Me.chkSystemEvents.Visible = True
        Me.chkSystemEvents.Enabled = False
        Me.chkSystemEvents.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.lblSystemEventsPersonDateTime.Visible = False
        Me.chkSecondaryComplete.Visible = True
        Me.chkSecondaryComplete.Enabled = False
        Me.chkSecondaryComplete.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.lblSecondaryCompletePersonDateTime.Visible = False
        Me.chkApproached.Visible = True
        Me.chkApproached.Enabled = False
        Me.chkApproached.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.lblApproachedPersonDateTime.Visible = False
        Me.chkFinal.Visible = True
        'Me.chkFinal.Enabled = True
        'Me.chkFinal.Value = 0
        Me.lblFinalPersonDateTime.Visible = False


        '7/23/01 drh Set FS components according to whether each Stage has been reached
        If vFSOpenUserId <> 0 Then
            Me.chkCaseOpen.CheckState = System.Windows.Forms.CheckState.Checked
            lblCaseOpenPersonDateTime.Visible = True
            lblCaseOpenPersonDateTime.Text = vFSOpenName & " - " & vFSOpenDateTime

            'If Family Services Case has been marked "Open", display FAMILY SERVICES label on form
            Me.lblFSBorderLeft.Visible = True
            Me.lblFSBorderRight.Visible = True
            Me.lblFSLabel.Visible = True

            'FSProj drh 7/1/02 - New Business Rule: Once a Secondary Case is marked "Open", SC and Org cannot be changed.
            'Me.CmdChangeSource.Enabled = False
            'Me.CboOrganization.Enabled = False
            '9/20/02 drh - Disable Coroner Case for Secondaries
            Me.ChkCoronerCase.Enabled = False
        Else
            Me.chkCaseOpen.Enabled = True
        End If

        If vFSSysEventUserId <> 0 Then
            Me.chkSystemEvents.CheckState = System.Windows.Forms.CheckState.Checked
            lblSystemEventsPersonDateTime.Visible = True
            lblSystemEventsPersonDateTime.Text = vFSSysEventName & " - " & vFSSysEventDateTime
        End If

        If vFSSecCompUserId <> 0 Then
            Me.chkSecondaryComplete.CheckState = System.Windows.Forms.CheckState.Checked
            lblSecondaryCompletePersonDateTime.Visible = True
            lblSecondaryCompletePersonDateTime.Text = vFSSecCompName & " - " & vFSSecCompDateTime
        Else
            If vFSStage = FS_SYSEVENT Then
                Me.chkSecondaryComplete.Enabled = True
            End If
        End If

        If vFSApproachUserId <> 0 Then
            Me.chkApproached.CheckState = System.Windows.Forms.CheckState.Checked
            lblApproachedPersonDateTime.Visible = True
            lblApproachedPersonDateTime.Text = vFSApproachName & " - " & vFSApproachDateTime
        Else
            If vFSStage = FS_SECCOMP Then
                Me.chkApproached.Enabled = True
            End If
        End If

        If vFSFinalUserId <> 0 Then
            Me.chkFinal.Enabled = True
            Me.chkFinal.CheckState = System.Windows.Forms.CheckState.Checked
            lblFinalPersonDateTime.Visible = True
            lblFinalPersonDateTime.Text = vFSFinalName & " - " & vFSFinalDateTime

            'Disable everything if Final
            Me.chkCaseOpen.Enabled = False
            Me.chkSecondaryComplete.Enabled = False
            Me.chkApproached.Enabled = False

            'FSProj drh 7/1/02 - New Business Rule: Once a Secondary Case is marked "Open", SC and Org cannot be changed.
            'Me.CmdChangeSource.Enabled = False
            'Me.CboOrganization.Enabled = False

        Else
            lblFinalPersonDateTime.Visible = True
            lblFinalPersonDateTime.Text = ""

        End If


        'If Person Type is Triage Coordinator or another person has the Referral open, disable all checkboxes
        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Or (Me.CallOpenByID <> 0 And Me.CallOpenByID <> AppMain.ParentForm.StatEmployeeID) Then
            Me.chkCaseOpen.Enabled = False
            Me.chkSystemEvents.Enabled = False
            Me.chkSecondaryComplete.Enabled = False
            Me.chkApproached.Enabled = False
            Me.chkFinal.Enabled = False

        End If

    End Function

    Private Sub SetDispositionForDonorIntent()

        Dim I As Short

        'Set Approach Type, Approached By, and General Consent
        '04/10/03 bjk - check what the Registry Type is set to if 0 reset values
        If DonorSearchState.HasDonor Then
            Call modControl.SelectID(CboApproachType, Registry)

            'set ApproachedBy field
            '04/10/03 bjk - if the registry type is 0 reset the appoach by berson

            ''        If CboApproachedBy.Text = "" Then           'T.T 10/06/2004 to prevent data erasing of approach data when it has been filled in
            'We don't know what the Id will be for "Registry Approach", so we have to search for the text (every applicable org will have a "Registry Approach" person)
            For I = 0 To CboApproachedBy.Items.Count - 1
                CboApproachedBy.SelectedIndex = I

                'drh 05/23/03 - Modified to check for "Registry Approach" or "Registry Approach*" (ie. Designated Requestor)
                If CboApproachedBy.Text Like "Registry Approach*" Then
                    Exit For
                End If
            Next I
            '        End If
            'Set General Consent
            '"Yes - Written"
            Call modControl.SelectID(CboGeneralConsent, 1)
        End If

        'Set Disposition fields
        For I = ORGAN To RESEARCH
            If CboAppropriate(I).Text = "Yes" Then
                If CboApproach(I).SelectedIndex = -1 Then
                    '10/3/01 drh Determine if it's Registry or DMV and select the correct ListIndex
                    If DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.WebRegistry Then
                        'Registry info from Donor Registry
                        'T.T 09/18/2004 added to remove yes-registry from disposition
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboApproach(I), APRCH_YES) 'T.T 10/12/06 NOT removed to be able to add anything to consent,apporach
                        Else
                            Call modControl.SelectID(CboApproach(I), APRCH_YESREG) 'T.T 10/12/06 NOT removed to be able to add anything to consent,apporach
                        End If
                        CboApproach(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                        Call modControl.Enable(CboConsent(I))
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.StateRegistry Then
                        'Registry info from DMV
                        'T.T 09/18/2004 added to remove yes-registry from disposition
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboApproach(I), APRCH_YES) 'T.T 10/12/06 NOT removed to be able to add anything to consent,apporach
                        Else
                            Call modControl.SelectID(CboApproach(I), APRCH_YESDMV) 'T.T 10/12/06 NOT removed to be able to add anything to consent,apporach
                        End If
                        CboApproach(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                        Call modControl.Enable(CboConsent(I))
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.DlaRegistry Then
                        'Registry info from DLA
                        'TODO:"DlaRegistry" is not how this status looks in the DB ("DLA Registry")
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text = "DlaRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboApproach(I), APRCH_YES)
                        Else
                            Call modControl.SelectID(CboApproach(I), APRCH_YESDLA)
                        End If
                        CboApproach(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                        Call modControl.Enable(CboConsent(I))
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.Unknown Then
                        'No Registry Informatio exists
                        'Char Chaput 06/15/06 took out was causing data to erase if dob changed
                        'Call modControl.SelectID(CboApproach(I), -1)
                        'CboApproach(i).ForeColor = &H0&
                        Call modControl.Disable(CboConsent(I))
                    End If

                Else
                    'No Registry Informatio exists
                    Call modControl.SelectID(CboApproach(I), -1)
                    'CboApproach(i).ForeColor = &H0&
                    Call modControl.Disable(CboConsent(I))
                End If

                '10/15/01 drh In addition to being blank, Consent must be enabled; otherwise, don't change
                If CboConsent(I).SelectedIndex = -1 And CboConsent(I).Enabled Then
                    '10/3/01 drh Determine if it's Registry or DMV and select the correct ListIndex
                    If DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.WebRegistry Then
                        'Registry info from Donor Registry
                        'T.T 09/18/2004 added to remove yes-registry from disposition
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboConsent(I), CONSENT_YES)
                        Else
                            Call modControl.SelectID(CboConsent(I), CONSENT_YESREG)
                        End If
                        CboConsent(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.StateRegistry Then
                        'Registry info from DMV
                        'T.T 09/18/2004 added to remove yes-registry from disposition
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboConsent(I), CONSENT_YES)
                        Else
                            Call modControl.SelectID(CboConsent(I), CONSENT_YESDMV)
                        End If
                        CboConsent(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.DlaRegistry Then
                        'Registry info from DMV
                        'TODO:"DlaRegistry" is not how this status looks in the DB ("DLA Registry")
                        If Me.cboRegistryStatus.Text = "WebRegistry" Or Me.cboRegistryStatus.Text = "StateRegistry" Or Me.cboRegistryStatus.Text = "DlaRegistry" Or Me.cboRegistryStatus.Text <> "" Then
                            Call modControl.SelectID(CboConsent(I), CONSENT_YES)
                        Else
                            Call modControl.SelectID(CboConsent(I), CONSENT_YESDLA)
                        End If
                        CboConsent(I).ForeColor = System.Drawing.ColorTranslator.FromOle(&H0)
                    ElseIf DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.Unknown Then
                        'Registry info from DMV
                        'Char Chaput 06/15/06 took out was causing data to erase if dob changed
                        'Call modControl.SelectID(CboConsent(I), -1)
                        'CboConsent(i).ForeColor = &H0&
                    End If
                Else
                    'Registry info from DMV
                    Call modControl.SelectID(CboConsent(I), -1)
                    'CboConsent(i).ForeColor = &H0&

                End If
            End If
        Next I

    End Sub

    Public Function SetFSStage(ByRef vStage As Short) As Boolean

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        Select Case vStage
            Case 1
                vField1 = "FSCaseOpenUserId"
                vField2 = "FSCaseOpenDateTime"
            Case 2
                vField1 = "FSCaseSysEventsUserId"
                vField2 = "FSCaseSysEventsDateTime"
            Case 3
                vField1 = "FSCaseSecCompUserId"
                vField2 = "FSCaseSecCompDateTime"
            Case 4
                vField1 = "FSCaseApproachUserId"
                vField2 = "FSCaseApproachDateTime"
            Case 5
                vField1 = "FSCaseFinalUserId"
                vField2 = "FSCaseFinalDateTime"
        End Select

        vQuery = "UPDATE FSCase SET " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = getdate() "
        vQuery = vQuery & "WHERE CallId = " & Me.CallId

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetFSStage()

    End Function
    Public Function ReverseSetFSStage(ByRef vStage As Short) As Boolean

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        Select Case vStage
            Case 1
                vField1 = "FSCaseOpenUserId"
                vField2 = "FSCaseOpenDateTime"
            Case 2
                vField1 = "FSCaseSysEventsUserId"
                vField2 = "FSCaseSysEventsDateTime"
            Case 3
                vField1 = "FSCaseSecCompUserId"
                vField2 = "FSCaseSecCompDateTime"
            Case 4
                vField1 = "FSCaseApproachUserId"
                vField2 = "FSCaseApproachDateTime"
            Case 5
                vField1 = "FSCaseFinalUserId"
                vField2 = "FSCaseFinalDateTime"
        End Select

        vQuery = "UPDATE FSCase SET " & vField1 & " = " & 0 & ", " & vField2 & " = null "
        vQuery = vQuery & "WHERE CallId = " & Me.CallId

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetFSStage()

    End Function


    '10/1/01 drh
    Public Sub SetNOKComponents(ByRef vState As String)

        '************************************************************************************
        'Name: SetNOKComponents
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: sets NOK components
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/2007                           Changed by: Thien Ta
        'Release #: 8.4                             Task: requirement 3.2
        'Description:  disable DonorIntent button for Always pop Registry Service Level
        '====================================================================================

        If vState = "Enable" Then
            If LblRegistry.Text = "Donor Reg." Or LblRegistry.Text = "DMV Reg." Then
                EnableDonorIntent()
            End If


            'If we've already completed donor intent once, set Donor Intent Button color to vbBlue
            If Me.DonorIntentDone Then
                EnableDonorIntent(Color.Blue)
            End If

            'Turn Save button "ON" (if we don't have a search in progress)
            If rtbSearching.Visible = False Then
                CmdOK.Enabled = True
            End If

        ElseIf vState = "Disable" Then

            'If we've already completed donor intent once, do not disable Save and NOK; Set Donor Intent button to vbBlue
            If Me.DonorIntentDone Then
                EnableDonorIntent(Color.Blue)

                'Turn Save button "ON" (if we don't have a search in progress)
                If rtbSearching.Visible = False Then
                    CmdOK.Enabled = True
                End If

                If LblRegistry.Text = "Donor Reg." Or LblRegistry.Text = "DMV Reg." Then
                    EnableDonorIntent()
                End If

            Else
                EnableDonorIntent()
            End If
        End If

        'T.T 06/20/2007 disable Donor Intent for pop registry
        If Me.cboRegistryStatus.Text = "Not Checked" OrElse
           Me.cboRegistryStatus.Text = "Not On Registry" Then
            Me.cmdDonorIntent.Enabled = False
        End If
    End Sub

    'TODO: What's the point of this method? It does nothing.
    Public Function VerifyAppropriateForDonorIntent() As Boolean
        '10/1/01 drh
        'This function checks if all enabled Appropriate fields are filled out
        'AND at least one of them is marked "Yes".

        VerifyAppropriateForDonorIntent = True

    End Function


    Private Sub ValidateForDonorIntent()
        '************************************************************************************
        'Name: ValidateForDonorIntent
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Checks for existence of patient in registry
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 3/1/05                           Changed by: Scott Plummer
        'Release #: 7.7.31                              Task: 378
        'Description:  Check for changes in donor name and DOB before performing checks.
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/17/05                           Changed by: Char Chaput
        'Release #: 8.0
        'Description:  Added Middle Initial.
        '====================================================================================
        '************************************************************************************

        cmdDonorIntent.Enabled = False 'T.T 08/16/2004

        '10/2/01 drh
        'For Orgs with Donor Intent checked in Service level, this sub checks Registry if necessary,
        'verifies Appropriate fields for RO, and sets the NOK components appropriately

        'If Donor Intent "ON" and an organization has been chosen, see if Registry has been checked
        '12/05/03 bjk removed the check for cause of death in the if statement
        'If CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent And CboOrganization.Text <> "" And CboCauseOfDeath.Text <> "" And Me.FormLoad <> True Then
        If CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent And
           LblOrganization.Text <> "" And
           Me.FormLoad <> True Then

            If DonorSearchState.HasDonor AndAlso
               VerifyAppropriateForDonorIntent() Then 'Check if it's appropriate
                'If a donor and appropriate, disable Save and NOK components; enable Donor Intent button
                SetNOKComponents("Disable")
            Else
                'If they are not appropriate or not a donor, enable Save 
                'and NOK components; disable Donor Intent button
                SetNOKComponents("Enable")
            End If
        Else
            modControl.Enable(Me.cboRegistryStatus)
            modControl.cbofill(Me.RegStatus, "", False, True)
        End If

    End Sub


    Private Sub CboAgeUnit_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboAgeUnit.Enter

        OldValue = CboAgeUnit.Text

    End Sub

    Private Sub CboAgeUnit_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboAgeUnit.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboAgeUnit_KeyPress(CboAgeUnit, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub


    Private Sub CboAgeUnit_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboAgeUnit.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboAgeUnit, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboAgeUnit_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboAgeUnit.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        Dim vAge As Single
        Dim vDays As Single

        'Check age against DOB
        'If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "CboAgeUnit" Then
        If TxtAge.Text <> "" And CboAgeUnit.Text <> "" And TxtDOB.Text <> "" Then

            'Convert date into age
            'Get the number of days between today and birth date
            If TxtDeathDate.Text <> "" Then
                vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtDeathDate.Text, "mm/dd/yyyy")))
            Else
                vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtCallDate.Text, "mm/dd/yyyy")))
            End If

            If vDays = 0 Then
                vDays = vDays + 1
            End If

            'If less than 31 days, set the age and age unit to days
            If vDays <= 31 Then
                If CDbl(TxtAge.Text) <> vDays Or CboAgeUnit.Text <> "Days" Then
                    Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                    Cancel = True
                    GoTo EventExitSub
                End If
            End If

            'If greater than 31 days but less than 730 days (24 months),
            'then convert to months
            If vDays > 31 And vDays < 730 Then
                If CDbl(TxtAge.Text) <> (modConv.AgeMonths(TxtDOB.Text)) Or CboAgeUnit.Text <> "Months" Then
                    Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                    Cancel = True
                    GoTo EventExitSub
                End If
            End If

            'If greater than 730 days, set the age and age unit to years
            If vDays >= 730 Then
                If CDbl(TxtAge.Text) <> (modConv.Age((TxtDOB.Text))) Or CboAgeUnit.Text <> "Years" Then
                    Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                    Cancel = True
                    GoTo EventExitSub
                End If
            End If

        End If

        If CallerOrg.ServiceLevel.Age Then
            If TxtAge.Text <> "" And CboAgeUnit.Text = "" Then
                Call MsgBox("Please enter an age unit.")
                Cancel = True
            End If
        End If

        Call Check_ServiceLevel_Weight()

        'Verify
        If CboAgeUnit.Text <> OldValue Then
            If TxtAge.Text <> "" And CboAgeUnit.Text <> "" And CboGender.Text <> "" Then
                Select Case CallerOrg.ServiceLevel.TriageLevel

                    Case VENT_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, False, False, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, False, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_MRO
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, True, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                End Select
            End If
        End If
        'End If

        OldValue = ""

        '10/2/01 drh
        'Call ValidateForDonorIntent

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub


    Private Sub CboApproach_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CboApproach_1.SelectedIndexChanged, _CboApproach_2.SelectedIndexChanged, _CboApproach_3.SelectedIndexChanged, _CboApproach_4.SelectedIndexChanged, _CboApproach_5.SelectedIndexChanged, _CboApproach_6.SelectedIndexChanged, _CboApproach_7.SelectedIndexChanged

        Dim Index As Short
        Index = modControl.GetHasTableKey(CboApproach, eventSender)

        Dim approachId As Integer = -1
        Try
            Call modStatValidate.ReferralTypeDefault(Me)
            approachId = modControl.GetID(CboApproach(Index))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If GetServiceLevel(APPROACHED, Index) Then
            '10/18/01 drh Added checks for APRCH_YESDMV and APRCH_YESREG and -1; changed APRCH_YES to <> instead of >
            If approachId <> APRCH_YES And approachId <> APRCH_YESDMV And approachId <> APRCH_YESREG And approachId <> -1 Then
                CboApproach(Index).ForeColor = System.Drawing.Color.Red
            Else
                CboApproach(Index).ForeColor = System.Drawing.SystemColors.WindowText
            End If

        End If

        If GetServiceLevel(CONSENT, Index) Then
            '10/18/01 drh Added checks for APRCH_YESDMV and APRCH_YESREG
            If approachId = APRCH_YES Or approachId = APRCH_YESDMV Or approachId = APRCH_YESREG Then
                Call modControl.Enable(CboConsent(Index))
            Else
                CboConsent(Index).Text = ""
                modControl.SelectID(CboConsent(Index), -1) ' -1 is the disabled value
                Call modControl.Disable(CboConsent(Index))
            End If
        End If

        If GetServiceLevel(CONVERT, Index) Then

            Dim consentId As Integer = -1
            Try
                consentId = modControl.GetID(CboConsent(Index))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '10/18/01 drh Added checks for CONSENT_YESDMV and CONSENT_YESREG
            If consentId <> CONSENT_YES And consentId <> CONSENT_YESDMV And consentId <> CONSENT_YESREG Then
                CboRecovery(Index).Text = ""
                Call modControl.Disable(CboRecovery(Index))
            End If
        End If
        Exit Sub
    End Sub

    Private Sub CboApproach_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _CboApproach_1.KeyPress, _CboApproach_2.KeyPress, _CboApproach_3.KeyPress, _CboApproach_4.KeyPress, _CboApproach_5.KeyPress, _CboApproach_6.KeyPress, _CboApproach_7.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = modControl.GetHasTableKey(CboApproach, eventSender)
        'Carroll 10/11/2006 - Removed for selection of list items
        'Allow the delete key to clear the combo box
        'If KeyAscii = 100 Or KeyAscii = 114 Then         'T.T 10/05/2004 added to remove dmv and registry options *CodeReview
        '        KeyAscii = 121
        'End If
        Call modControl.AllowDelete(CboApproach(Index), KeyAscii)
        Call modControl.ComboSearch(CboApproach(Index), KeyAscii, True)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cboApproachedBy_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboApproachedBy.SelectedIndexChanged

        'Get the ID of the selected person
        Me.ApproachedByID = modControl.GetID(CboApproachedBy)

    End Sub

    Private Sub CboApproachedBy_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboApproachedBy.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call cboApproachedBy_KeyPress(CboApproachedBy, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub


    Private Sub cboApproachedBy_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboApproachedBy.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboApproachedBy, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboApproachedBy_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboApproachedBy.Leave

        'Get the ID of the selected person
        Me.ApproachedByID = modControl.GetID(CboApproachedBy)
        Me.CboApproachedBy.Tag = 1 'T.T 09/22/04 set tag to 1 to not hold cbobox
        Call modControl.HoldControl((Me.CboApproachedBy)) 'T.T 09/22/04 added to track data erasing
    End Sub
    Private Sub CboApproachType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboApproachType.SelectedIndexChanged

        Dim I As Short

        If Me.ActiveControl Is Nothing Then
            Exit Sub
        End If

        If Me.ActiveControl.Name = "CboApproachType" Then
            vLastActiveControl = Me.ActiveControl
        End If

        Dim approachTypeId As Integer = -1
        Try
            approachTypeId = modControl.GetID(CboApproachType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If Me.FormState = NEW_RECORD And modControl.GetID(CboApproachType) <> -1 Then

            If (approachTypeId = PREREF_COUPLED Or approachTypeId = PREREF_DECOUPLED Or approachTypeId = FAMILY_INITIATED) Then

                'Set approach data
                For I = ORGAN To RESEARCH

                    Dim appropriateID As Integer = -1
                    Try
                        appropriateID = modControl.GetID(CboAppropriate(I))
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    If appropriateID = APPROP_YES And Me.GetServiceLevel(APPROACHED, I) Then
                        'Call modControl.SelectID(CboApproach(i), APRCH_YES)      'T.T 10/13/2006 commented out so that not triggered from approach
                        'Me.TabDisposition.SelectedIndex = 0
                        If CallerOrg.ServiceLevel.ApproachLevel = 0 Then
                            'Me.TabDisposition.TabVisible(DISPOSITION_TAB) = True

                            'ccarroll 06/18/2010 capture/set active control after tabindex change
                            Dim lastActiveControl As String = ActiveControl.Name.ToString()
                            Me.TabDisposition.TabIndex = 0
                            ActiveControl.Name = lastActiveControl

                        End If
                    End If
                Next I

            End If

        End If

        If approachTypeId = NOT_APPROACHED Or approachTypeId = UNKNOWN Or approachTypeId = -1 Then

            'Disable other approach controls
            Call modControl.Disable(CboApproachedBy)
            Call modControl.SelectNone(CboApproachedBy)
            Call modControl.Disable(CmdApproachedByDetail)
            Call modControl.SelectNone(CboGeneralConsent)
            Call modControl.Disable(CboGeneralConsent)

        Else
            'If service level turned on, enable other approach controls
            If CallerOrg.ServiceLevel.ApproachBy Then
                Call modControl.Enable(CboApproachedBy)
                Call modControl.Enable(CmdApproachedByDetail)
                Call modControl.Enable(CboGeneralConsent)
            End If
        End If

        If CboApproachType.Enabled = True Then
            CboApproachType.BackColor = System.Drawing.Color.White
        End If

    End Sub

    Private Sub CboApproachType_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboApproachType.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboApproachType_KeyPress(CboApproachType, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub


    Private Sub CboApproachType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboApproachType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboApproachType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub




    Private Sub CboAppropriate_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _
        _CboAppropriate_1.SelectedIndexChanged,
        _CboAppropriate_2.SelectedIndexChanged,
        _CboAppropriate_3.SelectedIndexChanged,
        _CboAppropriate_4.SelectedIndexChanged,
        _CboAppropriate_5.SelectedIndexChanged,
        _CboAppropriate_6.SelectedIndexChanged,
        _CboAppropriate_7.SelectedIndexChanged

        Dim Index As Short = modControl.GetHasTableKey(CboAppropriate, eventSender)
        ProcessAppropriateValueChange(eventSender, Index)


    End Sub

    Private Sub ProcessAppropriateValueChange(ByVal eventSender As Object, ByVal Index As Short)

        If GetServiceLevel(GIVEN, Index) Then
            If eventSender.Text = "" Then
                eventSender.BackColor = System.Drawing.Color.Yellow
            Else
                eventSender.BackColor = System.Drawing.Color.White
                'ORGAN Med RO Event CCRST175
                'Check to see if form is loaded 
                If Me.FormLoad <> True Then
                    'See if Appropriate Organ has changed 
                    If Index = ORGAN Then
                        'If this is Med_RO for Organ set OrganMedROUpdateFlag
                        'to have an event created on referral save
                        If eventSender.SelectedItem.Value = APPROP_MED_RO Then
                            OrganMedROUpdateFlag = True
                        Else
                            'If this has changed and not a Med RO then do not create
                            'the event for next save.
                            OrganMedROUpdateFlag = False
                        End If
                    End If
                End If

            End If

            Dim senderID As Integer = -1
            Try
                senderID = modControl.GetID(eventSender)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            If senderID > 1 Then
                eventSender.ForeColor = System.Drawing.Color.Red
            Else
                eventSender.ForeColor = System.Drawing.SystemColors.WindowText
            End If
        End If

        If GetServiceLevel(APPROACHED, Index) Then
            If modControl.GetID(eventSender) = 1 Then
                Call modControl.Enable(CboApproach(Index))
            Else
                CboApproach(Index).Text = ""
                modControl.SelectID(CboApproach(Index), -1) '-1 is the disable or unanswered value
                Call modControl.Disable(CboApproach(Index))
            End If
        End If

        If GetServiceLevel(CONSENT, Index) Then
            Dim approachId As Integer = -1
            Try
                Call modStatValidate.ReferralTypeDefault(Me)
                approachId = modControl.GetID(CboApproach(Index))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '10/18/01 drh Added check for APRCH_YESDMV and APRCH_YESREG
            If approachId <> APRCH_YES And approachId <> APRCH_YESDMV And approachId <> APRCH_YESREG Then
                CboConsent(Index).Text = ""
                Call modControl.Disable(CboConsent(Index))
            End If
        End If

        If GetServiceLevel(CONVERT, Index) Then
            Dim consentId As Integer = -1
            Try
                consentId = modControl.GetID(CboConsent(Index))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '10/18/01 drh Added check for CONSENT_YESDMV and CONSENT_YESREG
            If consentId <> CONSENT_YES And consentId <> CONSENT_YESDMV And consentId <> CONSENT_YESREG Then
                CboRecovery(Index).Text = ""
                Call modControl.Disable(CboRecovery(Index))
            End If
        End If

        If Not IsNothing(Me.ActiveControl) Then
            If Me.ActiveControl.Text = eventSender.Text Then
                Call modStatValidate.ReferralTypeDefault(Me)
                'Check for pending contacts
                Call modStatValidate.ValidateReferralContacts(Me, False)
            End If
        End If
        '10/2/01 drh
        'Call ValidateForDonorIntent
        Return
    End Sub


    Private Sub CboAppropriate_DblClick(ByRef Index As Short)
        frmList = New FrmList()
        Try
            Call modStatRefQuery.ListRefQueryAppropriate((frmList.LstSelect))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        Call modControl.SelectID(CboAppropriate(Index), frmList.Display)

        '10/2/01 drh
        'Call ValidateForDonorIntent

    End Sub


    Private Sub CboDispositionItems_KeyDown(ByVal eventSender As ComboBox, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles _
        _CboAppropriate_1.KeyDown, _CboAppropriate_2.KeyDown, _CboAppropriate_3.KeyDown, _CboAppropriate_4.KeyDown, _CboAppropriate_5.KeyDown, _CboAppropriate_6.KeyDown, _CboAppropriate_7.KeyDown,
        _CboApproach_1.KeyDown, _CboApproach_2.KeyDown, _CboApproach_3.KeyDown, _CboApproach_4.KeyDown, _CboApproach_5.KeyDown, _CboApproach_6.KeyDown, _CboApproach_7.KeyDown,
        _CboConsent_1.KeyDown, _CboConsent_2.KeyDown, _CboConsent_3.KeyDown, _CboConsent_4.KeyDown, _CboConsent_5.KeyDown, _CboConsent_6.KeyDown, _CboConsent_7.KeyDown,
        _CboRecovery_1.KeyDown, _CboRecovery_2.KeyDown, _CboRecovery_3.KeyDown, _CboRecovery_4.KeyDown, _CboRecovery_5.KeyDown, _CboRecovery_6.KeyDown, _CboRecovery_7.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        Dim Index As Short
        Select Case DecodeComboArrayName(eventSender.Name)
            Case "CboAppropriate"
                Index = modControl.GetHasTableKey(CboAppropriate, eventSender)
            Case "CboApproach"
                Index = modControl.GetHasTableKey(CboApproach, eventSender)
            Case "CboConsent"
                Index = modControl.GetHasTableKey(CboConsent, eventSender)
            Case "CboRecovery"
                Index = modControl.GetHasTableKey(CboRecovery, eventSender)
        End Select


        Dim vAnyBlank As Boolean

        If Shift = 2 Then
            Dim result As Boolean = Integer.TryParse(ControlChars.Tab, KeyCode)
        End If

        Dim I As Short

        I = 0

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Select Case DecodeComboArrayName(eventSender.Name)
                Case "CboAppropriate"
                    Call CboAppropriate_KeyPress(eventSender, New System.Windows.Forms.KeyPressEventArgs(Chr(0)))
                Case "CboApproach"
                    Call CboApproach_KeyPress(eventSender, New System.Windows.Forms.KeyPressEventArgs(Chr(0)))
                Case "CboConsent"
                    Call CboConsent_KeyPress(eventSender, New System.Windows.Forms.KeyPressEventArgs(Chr(0)))
                Case "CboRecovery"
                    Call CboRecovery_KeyPress(eventSender, New System.Windows.Forms.KeyPressEventArgs(Chr(0)))
            End Select


        End If

        Select Case KeyCode

            Case System.Windows.Forms.Keys.Return
                frmList = New FrmList()
                Select Case DecodeComboArrayName(eventSender.Name)
                    Case "CboAppropriate"
                        Try
                            Call modStatRefQuery.ListRefQueryAppropriate((frmList.LstSelect))
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    Case "CboApproach"
                        Try
                            Call modStatRefQuery.ListRefQueryApproach((frmList.LstSelect))
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    Case "CboConsent"
                        Try
                            Call modStatRefQuery.ListRefQueryConsent((frmList.LstSelect))
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    Case "CboRecovery"
                        Try
                            Call modStatRefQuery.ListRefQueryConversion((frmList.LstSelect))
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                End Select

                Call modControl.SelectID(eventSender, frmList.Display)
                eventSender.Focus()
            Case System.Windows.Forms.Keys.Right
                If TabDisposition.SelectedIndex = 4 Then
                    If CboApproachType.Enabled = True Then
                        CboApproachType.Focus()
                    End If
                ElseIf TabDisposition.SelectedIndex = 0 Then
                    Select Case DecodeComboArrayName(eventSender.Name)
                        Case "CboAppropriate"
                            CboApproach(Index).Focus()
                        Case "CboApproach"
                            CboConsent(Index).Focus()
                        Case "CboConsent"
                            CboRecovery(Index).Focus()
                        Case "CboRecovery"
                            'Do nothing
                    End Select
                    KeyCode = 0
                ElseIf TabDisposition.SelectedIndex = 1 Then
                    LstViewVerify.Focus()
                End If
            Case System.Windows.Forms.Keys.Left
                Select Case DecodeComboArrayName(eventSender.Name)
                    Case "CboAppropriate"
                        'Do nothing
                    Case "CboApproach"
                        CboAppropriate(Index).Focus()
                    Case "CboConsent"
                        CboApproach(Index).Focus()
                    Case "CboRecovery"
                        CboConsent(Index).Focus()
                End Select
                KeyCode = 0
            Case System.Windows.Forms.Keys.Up
                Select Case DecodeComboArrayName(eventSender.Name)
                    Case "CboAppropriate"
                        I = Index

                        Do
                            If I = FIRSTGRIDROW Then
                                CboAppropriate(Index).Focus()
                                Exit Do
                            Else
                                I -= 1
                                CboAppropriate(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboAppropriate(I).Enabled

                    Case "CboApproach"
                        I = Index

                        Do
                            If I = FIRSTGRIDROW Then
                                If (CboAppropriate(LASTGRIDROW).ENABLED) Then
                                    CboAppropriate(LASTGRIDROW).Focus()
                                Else
                                    CboApproach(Index).Focus()

                                End If
                                Exit Do
                            Else
                                I -= 1
                                CboApproach(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboApproach(I).Enabled


                    Case "CboConsent"

                        I = Index

                        Do
                            If I = FIRSTGRIDROW Then
                                If (CboApproach(LASTGRIDROW).ENABLED) Then
                                    CboApproach(LASTGRIDROW).Focus()
                                Else
                                    CboConsent(Index).Focus()
                                End If
                                Exit Do
                            Else
                                I -= 1
                                CboConsent(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboConsent(I).Enabled

                    Case "CboRecovery"
                        I = Index

                        Do
                            If I = FIRSTGRIDROW Then
                                If (CboConsent(LASTGRIDROW).ENABLED) Then
                                    CboConsent(LASTGRIDROW).Focus()
                                Else
                                    CboRecovery(Index).Focus()

                                End If
                                Exit Do
                            Else
                                I -= 1
                                CboRecovery(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboRecovery(I).Enabled

                End Select
                KeyCode = 0
            Case System.Windows.Forms.Keys.Down
                Select Case DecodeComboArrayName(eventSender.Name)
                    Case "CboAppropriate"
                        I = Index
                        Do
                            If I = LASTGRIDROW Then
                                If (CboApproach(FIRSTGRIDROW).Enabled) Then
                                    CboApproach(FIRSTGRIDROW).Focus()
                                Else
                                    CboAppropriate(Index).Focus()

                                End If

                                Exit Do
                            Else

                                I += 1
                                CboAppropriate(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboAppropriate(I).Enabled

                    Case "CboApproach"
                        I = Index
                        Do
                            If I = LASTGRIDROW Then
                                If (CboConsent(FIRSTGRIDROW).Enabled) Then
                                    CboConsent(FIRSTGRIDROW).Focus()
                                Else
                                    CboApproach(Index).Focus()

                                End If

                                Exit Do
                            Else

                                I += 1
                                CboApproach(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboApproach(I).Enabled
                    Case "CboConsent"
                        I = Index
                        Do
                            If I = LASTGRIDROW Then
                                If (CboRecovery(FIRSTGRIDROW).Enabled) Then
                                    CboRecovery(FIRSTGRIDROW).Focus()
                                Else
                                    CboConsent(Index).Focus()

                                End If

                                Exit Do
                            Else

                                I += 1
                                CboConsent(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboConsent(I).Enabled
                    Case "CboRecovery"
                        I = Index
                        Do
                            If I = LASTGRIDROW Then
                                CboRecovery(Index).Focus()
                                Exit Do
                            Else

                                I += 1
                                CboRecovery(I).Focus()
                            End If
                        Loop Until Err.Number <> 51 And CboRecovery(I).Enabled

                End Select
                KeyCode = 0
            Case System.Windows.Forms.Keys.Tab
                If Shift = 0 Then
                    CmdCustomData.Focus()
                Else
                    vAnyBlank = False
                    For I = ORGAN To RESEARCH
                        If CboAppropriate(I).Enabled Then
                            If CboAppropriate(I).Text = "" Then
                                vAnyBlank = True
                            End If
                        End If
                    Next I
                    If vAnyBlank Then
                        TabDisposition.SelectedIndex = RESULTS_TAB
                        LstViewVerify.Focus()
                    Else
                        If TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                            TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB))
                        Else
                            CmdOK.Focus()
                        End If
                    End If
                End If
                KeyCode = 0

        End Select
        eventArgs.Handled = True

    End Sub

    Private Function DecodeComboArrayName(ByVal name As String) As String
        Dim tempString As String
        tempString = System.Text.RegularExpressions.Regex.Replace(name, "[_0-9]", "")
        Return tempString
    End Function

    Private Sub CboAppropriate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _CboAppropriate_1.KeyPress, _CboAppropriate_2.KeyPress, _CboAppropriate_3.KeyPress, _CboAppropriate_4.KeyPress, _CboAppropriate_5.KeyPress, _CboAppropriate_6.KeyPress, _CboAppropriate_7.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = modControl.GetHasTableKey(CboAppropriate, eventSender)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboAppropriate(Index), KeyAscii)
        Call modControl.ComboSearch(CboAppropriate(Index), KeyAscii, True)
        Me.CboAppropriate(Index).BackColor = System.Drawing.Color.White 'T.T 10/06/2004 added to remove yellow color

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboAppropriate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles _CboAppropriate_1.Validating, _CboAppropriate_2.Validating, _CboAppropriate_3.Validating, _CboAppropriate_4.Validating, _CboAppropriate_5.Validating, _CboAppropriate_6.Validating, _CboAppropriate_7.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        Dim Index As Short = modControl.GetHasTableKey(CboAppropriate, eventSender)

        Dim vAnyBlank As Boolean
        Dim I As Short

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub CboCauseOfDeath_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCauseOfDeath.SelectedIndexChanged

        Dim vCoronerCase As Boolean


        'Check for coroner's case
        Try
            If modControl.GetID(CboCauseOfDeath) <> -1 Then
                Call modStatQuery.QueryCauseOfDeathCoronerCase(modControl.GetID(CboCauseOfDeath), vCoronerCase)
            End If
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If vCoronerCase = True Then
            ChkCoronerCase.ForeColor = System.Drawing.Color.Red
            LblCoronerMsg.Visible = True
            If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB))
            End If
        ElseIf Not String.IsNullOrEmpty(TxtAdmitDate.Text) AndAlso Not (DateValue(TxtAdmitDate.Text) = Today Or DateValue(TxtAdmitDate.Text) = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today)) Then
            ChkCoronerCase.ForeColor = System.Drawing.Color.Black
            LblCoronerMsg.Visible = False
        End If
        'ccarroll 06/08/2010 added set focus to mimic old StatTrac
        If Me.FormLoad = False Then
            Me.CboCauseOfDeath.Focus()
        End If

    End Sub


    Private Sub CboCauseOfDeath_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCauseOfDeath.Enter
        Me.CODStateFocus = True
    End Sub


    Private Sub CboCauseOfDeath_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboCauseOfDeath.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboCauseOfDeath_KeyPress(CboCauseOfDeath, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Async Sub CboCauseOfDeath_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCauseOfDeath.Leave
        '************************************************************************************
        'Name: ValidateForDonorIntent
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Checks for existence of patient in registry
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 3/1/05                           Changed by: Scott Plummer
        'Release #: 7.7.31                              Task: 378
        'Description:  Check for changes in donor name and DOB before performing checks.
        '====================================================================================
        'Date Changed: 06/10/2007                          Changed by: Thien Ta
        'Release #: 8.4                             Task: 2.4
        'Description:  search registry if it has not already been searched
        '====================================================================================
        'Date Changed: 06/10/2007                   Changed by: Bret Knoll
        'Release #: 8.4                             Task: StatTrac Release: 8.0 Iter 4 Empirix 6780
        'Description:  removed functionality to call VerifyReferral
        '====================================================================================
        '************************************************************************************

        PreviousField = "CauseOfDeath"
        '04/11/03 bjk - moved from click
        '10/1/01 drh
        'If Donor Intent "ON" and an organization has been chosen, see if Registry has been checked
        If CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent And
           LblOrganization.Text <> "" And
           Me.FormLoad <> True Then

            'If Registry has not been checked, LblRegistry.Text defaults to "Registered".  If
            'that is the case, check the Registry
            If LblRegistry.Text = "Registered" Then
                ' Check to make sure Donor first name, last name, or DOB has changed before
                ' running validation.  3/10/05 - SAP
                If (Trim(UCase(Me.TxtDonorFirstName.Text)) <> Trim(UCase(Me.DonorFirstName))) Or
                    (Trim(UCase(Me.TxtDonorLastName.Text)) <> Trim(UCase(Me.DonorLastName))) Or
                    (Me.TxtDOB.Text <> Me.DonorDOB) Then
                    ' One of these fields has changed, do the registry check
                    Await TrySearchDonor()
                End If

            End If

            If DonorSearchState.HasDonor AndAlso
               VerifyAppropriateForDonorIntent() Then 'Check if it's appropriate
                'If a donor and appropriate, disable Save and NOK components; enable Donor Intent button
                SetNOKComponents("Disable")
            Else
                'If they are not appropriate or not a donor, enable Save 
                'and NOK components; disable Donor Intent button
                SetNOKComponents("Enable")
            End If

            'T.T 04/25/2007 Determines if referral is a ruleout and shows donorData
            If sCurrentRefTypeDesc <> "Ruleout" And
               Not RegMatchClicked And
               CmdRegMatch.Visible And
               CboCauseOfDeath.Text <> "" Then

                Await TrySearchDonor()

            End If
        End If
    End Sub


    Private Sub CboConsent_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CboConsent_1.SelectedIndexChanged, _CboConsent_2.SelectedIndexChanged, _CboConsent_3.SelectedIndexChanged, _CboConsent_4.SelectedIndexChanged, _CboConsent_5.SelectedIndexChanged, _CboConsent_6.SelectedIndexChanged, _CboConsent_7.SelectedIndexChanged
        Dim Index As Short = modControl.GetHasTableKey(CboConsent, eventSender)

        'Determine ConsentId
        Dim ConsentId As Integer
        Try
            ConsentId = modControl.GetID(CboConsent(Index))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ConsentId = -1
        End Try

        Call modStatValidate.ReferralTypeDefault(Me)
        If GetServiceLevel(CONSENT, Index) Then
            '10/18/01 drh Added checks for CONSENT_YESDMV and CONSENT_YESREG and -1; changed CONSENT_YES to <> instead of >
            If ConsentId <> CONSENT_YES And ConsentId <> CONSENT_YESDMV And ConsentId <> CONSENT_YESREG And ConsentId <> -1 Then
                CboConsent(Index).ForeColor = System.Drawing.Color.Red
            Else
                CboConsent(Index).ForeColor = System.Drawing.SystemColors.WindowText
            End If
        End If

        If GetServiceLevel(CONVERT, Index) Then

            '10/18/01 drh Added checks for CONSENT_YESDMV and CONSENT_YESREG
            If (ConsentId = CONSENT_YES Or ConsentId = CONSENT_YESDMV Or ConsentId = CONSENT_YESREG) And Me.FormState <> NEW_RECORD Then
                Call modControl.Enable(CboRecovery(Index))
            Else
                CboRecovery(Index).Text = ""
                Call modControl.Disable(CboRecovery(Index))
            End If
        End If
        Exit Sub
    End Sub

    Private Sub CboConsent_DblClick(ByRef Index As Short)
        frmList = New FrmList()
        Try
            Call modStatRefQuery.ListRefQueryConsent((frmList.LstSelect))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        Call modControl.SelectID(CboConsent(Index), frmList.Display)

    End Sub



    Private Sub CboConsent_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _CboConsent_1.KeyPress, _CboConsent_2.KeyPress, _CboConsent_3.KeyPress, _CboConsent_4.KeyPress, _CboConsent_5.KeyPress, _CboConsent_6.KeyPress, _CboConsent_7.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = modControl.GetHasTableKey(CboConsent, eventSender)
        'Carroll 10/11/2006 - Removed for selection of list items
        'Allow the delete key to clear the combo box
        '    If KeyAscii = 100 Or KeyAscii = 114 Then        'T.T 10/05/2004 added to remove dmv and registry options
        '        KeyAscii = 121
        '    End If



        Call modControl.AllowDelete(CboConsent(Index), KeyAscii)
        Call modControl.ComboSearch(CboConsent(Index), KeyAscii, True)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboCauseOfDeath_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboCauseOfDeath.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboCauseOfDeath, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboCoronerName_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboCoronerName.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboCoronerName, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboCoronerOrg_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCoronerOrg.SelectedIndexChanged

        Dim vReturn As New Object

        If Me.FormLoad = False Then
            Dim QueryCoroner As Short
            Try
                QueryCoroner = modStatQuery.QueryCoroner(modControl.GetID(CboCoronerOrg), vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                QueryCoroner = SQL_ERROR
            End Try
            If QueryCoroner = SUCCESS AndAlso ObjectIsValidArray(vReturn, 2, 0, 4) Then
                CoronerOrgID = vReturn(0, 4)
                Call modControl.SetTextID(CboCoronerName, vReturn, True)
                Call modControl.GetID(CboCoronerName)
                CboCoronerName.Items.Add(New ValueDescriptionPair(-1, "Not Available"))

                TxtCoronerPhone.Text = vReturn(0, 3)

                Call modControl.SelectID(CboCoronerName, -1)

            Else

                CboCoronerName.Items.Add(New ValueDescriptionPair(-1, "Not Available"))
                Call modControl.SelectFirst(CboCoronerName)

                TxtCoronerNote.Text = ""
                TxtCoronerPhone.Text = ""
            End If
        End If


    End Sub


    Private Sub CboCoronerOrg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboCoronerOrg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboCoronerOrg, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboGender_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboGender.Enter

        OldValue = CboGender.Text

    End Sub


    Private Sub CboGender_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboGender.Leave
        '====================================================================================
        'Date Changed: 6/07/2007                          Changed by: Thien Ta
        'Release #: 8.4                               Requirement:3.4.1,3.4.11, 3.4.1.1.1, 3.4.1.1.2, 3.4.1.2, 3.4.1.3
        'Description:  Added VerifyWeight and Verify Gender
        '====================================================================================
        'Verify
        Dim activeControl As Control = Me.ActiveControl
        If CboGender.Text <> OldValue And CboGender.Text <> "" Then
            Me.vVerifySex = False

            'Run VerifyReferral in a try/catch block to try to get clues on why it occasionally fails.
            Try
                Select Case CallerOrg.ServiceLevel.TriageLevel

                    Case VENT_ONLY
                        Call modStatValidate.VerifyReferral(Me, True, False, False, True)

                    Case AGE_ONLY
                        Call modStatValidate.VerifyReferral(Me, False, True, False, True)

                    Case VENT_AGE_ONLY
                        Call modStatValidate.VerifyReferral(Me, True, True, False, True)

                    Case VENT_AGE_MRO
                        Call modStatValidate.VerifyReferral(Me, True, True, True, True)

                End Select

            Catch ex As Exception

                'Gather details for this exception
                Dim exMessage As String = "Try/Catch Error Caught from CboGender_Leave when calling modStatValidate.VerifyReferral "
                exMessage = exMessage + " with TriageLevel: " + CallerOrg.ServiceLevel.TriageLevel.ToString()
                exMessage = exMessage + ", exceptionMessage: " + ex.Message
                exMessage = exMessage + ", exceptionStackTrace: " + ex.StackTrace

                'Log the exception
                Dim newException As New Exception(exMessage)
                StatTracLogger.CreateInstance().Write(newException)

            End Try

        End If

        OldValue = ""

        '10/2/01 drh
        ' Commented out for V. 7.7.31.  3/2/05 - SAP
        'Call ValidateForDonorIntent
        If Me.CallerOrg.ServiceLevel.VerifySex = -1 Then
            Call VerifySex()
        End If
        'Me.TxtWeight.Focus()
        activeControl.Select()

    End Sub
    Public Sub VerifySex()
        '************************************************************************************
        'Name: VerifySex
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: req 3.4.1.2
        'Description: verify sex when a referral is ruled out
        'Returns:
        'Params:
        'Stored Procedures: None
        '====================================================================================


        'MsgBox Me.sPrelimRefTypeDesc
        'If TxtWeight.Text <> OldValue Then
        'ccarroll 09/17/2007  removed: If Me.sPrelimRefTypeDesc = "Ruleout" And Me.vVerifySex = False Then
        If Me.vVerifySex = False Then
            If CheckCboAppropriate() = True Then
                frmVerifySex = New FrmVerifySex()
                frmVerifySex.modalParent = Me
                Dim dialogResult As DialogResult = frmVerifySex.ShowDialog() 'Show modal

                Call VerifySexValidate()
                frmVerifySex = Nothing
            End If
        End If
        'End If
    End Sub
    Public Function CheckCboAppropriate() As Boolean
        Dim I As Short
        For I = ORGAN To RESEARCH
            If CboAppropriate(I).Text = "Age" Then
                CheckCboAppropriate = True
            End If
        Next I
    End Function
    Public Sub VerifySexValidate()
        '************************************************************************************
        'Name: VerifySexValidate
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: None
        'Description: verify sex when a referral is ruled out
        'Returns:
        'Params:
        'Stored Procedures: None
        '=============================================================================
        'Verify
        If CboGender.Text <> OldValue And CboGender.Text <> "" Then
            Select Case CallerOrg.ServiceLevel.TriageLevel

                Case VENT_ONLY
                    Call modStatValidate.VerifyReferral(Me, True, False, False, True)

                Case AGE_ONLY
                    Call modStatValidate.VerifyReferral(Me, False, True, False, True)

                Case VENT_AGE_ONLY
                    Call modStatValidate.VerifyReferral(Me, True, True, False, True)

                Case VENT_AGE_MRO
                    Call modStatValidate.VerifyReferral(Me, True, True, True, True)

            End Select
        End If
    End Sub


    Private Sub CboGeneralConsent_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboGeneralConsent.SelectedIndexChanged
        Dim vReturn As New Object 'T.T 09/22/04 return dim

        If modControl.GetID(CboGeneralConsent) = 3 Then
            CboGeneralConsent.ForeColor = System.Drawing.Color.Red
        Else
            CboGeneralConsent.ForeColor = System.Drawing.Color.Black
        End If

        'vReturn = NOKServiceLevel
    End Sub

    Private Sub CboGeneralConsent_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboGeneralConsent.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboGeneralConsent_KeyPress(CboGeneralConsent, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Sub CboGeneralConsent_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboGeneralConsent.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboGeneralConsent, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboHeartBeat_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboHeartBeat.SelectedIndexChanged

        '*****************************************************************************
        '*** 01/06/04 mds
        '*** Added this entire Sub from Bret's original Heartbeat changes made in
        '*** April 2003.  Changed the dates and initials for searching purposes.
        '*****************************************************************************

        'ExecuteClick flag ensures this event doesn't execute when the form first loads for
        'existing referrals (it's set to FALSE in the Form_Load event for existing referrals)
        If ExecuteClick = True Then
            '01/06/04 mds add CboHeartBeat
            If modControl.GetID(CboHeartBeat) = HEART_BEAT_YES Then
                'If HeartBeat field value is Yes set On Vent field to Currently
                '1/13/04 mds:  but only if the vent has not already been set using the mouse by the user
                If CboHeartBeat.Enabled = True Then
                    If CboVentChanged = False Then
                        Call modControl.SelectID((Me.CboVent), 2)
                    End If
                End If

                'Clear CTOD when Heartbeat is set to Yes
                TxtDeathDate.Text = ""
                TxtDeathTime.Text = ""

            Else
                'Populate CTOD when Heartbeat is set to No
                PopulateCtod()
            End If

            '1/12/04 mds Call SetHeartBeatColor to set background and status
            Call SetHeartBeatColor()

            'check the heart beat and vent status values
            Call ConfirmHeartBeatVent()
        Else
            ExecuteClick = True
        End If

    End Sub

    Private Sub CboHeartBeat_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboHeartBeat.Enter
        '01/06/04 mds added for Heart Beat. Copied from cboVent
        OldValue = CboHeartBeat.Text 'T.T 10/11/2004 changed to cboheartbeat.text is was cboVent. Wrong!
    End Sub

    Private Sub CboHeartBeat_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboHeartBeat.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        '01/06/04 mds this prevents changes through key board
        KeyCode = -1
        eventArgs.Handled = True
    End Sub

    Private Sub CboHeartBeat_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboHeartBeat.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        '01/06/04 mds this prevents changes through key board
        KeyAscii = -1
        'eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = -1 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboHeartBeat_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboHeartBeat.Leave
        '01/06/04 mds adding for Heart Beat. Code Copied from cboVent
        'Before verifying, kick off the referraltype validation
        Call CboReferralType_SelectedIndexChanged(CboReferralType, New System.EventArgs())

        'Call ValidateForDonorIntent

    End Sub

    Private Sub CboHeartBeat_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboHeartBeat.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        '01/06/04 mds adding for Heart Beat. Code copied from cboVent

        'Verify
        If CboHeartBeat.Text <> OldValue Then
            If CboHeartBeat.Text <> "" And TxtAge.Text <> "" Then

                Select Case CallerOrg.ServiceLevel.TriageLevel

                    Case VENT_ONLY
                        Call modStatValidate.VerifyReferral(Me, True, False, False, True)

                    Case AGE_ONLY
                        Call modStatValidate.VerifyReferral(Me, False, True, False, True)

                    Case VENT_AGE_ONLY
                        Call modStatValidate.VerifyReferral(Me, True, True, False, True)

                    Case VENT_AGE_MRO
                        Call modStatValidate.VerifyReferral(Me, True, True, True, True)

                End Select
                'Set physician

                Try
                    Call InitializePhysician(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        End If



        OldValue = ""
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub CboPhysician_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CboPhysician_0.SelectedIndexChanged, _CboPhysician_1.SelectedIndexChanged
        Dim Index As Short = Array.IndexOf(CboPhysician, eventSender)
        If Index = 0 Then
            vOriginalAMD = Me.AttendingMDID
        Else
            vOriginalPMD = Me.PronouncingMDID
        End If
    End Sub

    Private Sub CboPhysician_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles _CboPhysician_0.KeyDown, _CboPhysician_1.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        Dim Index As Short = Array.IndexOf(CboPhysician, eventSender)

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboPhysician_KeyPress(CboPhysician(Index), New System.Windows.Forms.KeyPressEventArgs(Chr(0)))
        End If

    End Sub

    Private Sub CboPhysician_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _CboPhysician_0.KeyPress, _CboPhysician_1.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = Array.IndexOf(CboPhysician, eventSender)

        'Allow the delete key to clear the combo box
        If Index = 0 Then
            Call modControl.AllowDelete(CboPhysician(0), KeyAscii)
            Me.CmdPhysicianPhone(0).Enabled = False
            Me.TxtAttendingPhone.Text = ""
            Me.AttendingMDPhone = ""
        Else
            Call modControl.AllowDelete(CboPhysician(1), KeyAscii)
            Me.CmdPhysicianPhone(1).Enabled = False
            Me.TxtPronouncingPhone.Text = ""
            Me.PronouncingMDPhone = ""
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboPhysician_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CboPhysician_0.Leave, _CboPhysician_1.Leave
        Dim Index As Short = Array.IndexOf(CboPhysician, eventSender)

        'Get the ID of the selected person
        If Index = 0 Then
            Me.AttendingMDID = modControl.GetID(CboPhysician(0))
            If Me.AttendingMDID > 0 Then
                If vOriginalAMD <> Me.AttendingMDID Then
                    Me.TxtAttendingPhone.Text = ""
                End If
                If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(Me.CmdPhysicianPhone(0)) Else Call modControl.Disable(Me.CmdPhysicianPhone(0))
                'Me.CmdPhysicianPhone(0).Enabled = True
            End If
        Else
            Me.PronouncingMDID = modControl.GetID(CboPhysician(1))
            If Me.PronouncingMDID > 0 Then
                If vOriginalPMD <> Me.PronouncingMDID Then
                    Me.TxtPronouncingPhone.Text = ""
                End If
                If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(Me.CmdPhysicianPhone(1)) Else Call modControl.Disable(Me.CmdPhysicianPhone(1))
                'Me.CmdPhysicianPhone(1).Enabled = True
            End If
        End If

        Me.CboPhysician(Index).Tag = 1 'T.T 09/22/04 set tag to 1 to not hold cbobox
        Call modControl.HoldControl(CboPhysician(Index)) 'T.T 09/22/04 added to track data erasing
    End Sub

    Private Sub CboRace_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboRace.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboRace_KeyPress(CboRace, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Sub CboRecovery_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CboRecovery_1.SelectedIndexChanged, _CboRecovery_2.SelectedIndexChanged, _CboRecovery_3.SelectedIndexChanged, _CboRecovery_4.SelectedIndexChanged, _CboRecovery_5.SelectedIndexChanged, _CboRecovery_6.SelectedIndexChanged, _CboRecovery_7.SelectedIndexChanged
        Dim Index As Short = modControl.GetHasTableKey(CboRecovery, eventSender)

        If GetServiceLevel(CONVERT, Index) Then
            If modControl.GetID(CboRecovery(Index)) > 1 Then
                CboRecovery(Index).ForeColor = System.Drawing.Color.Red
            Else
                '       CboRecovery(Index).BackColor = vbWhite
                CboRecovery(Index).ForeColor = System.Drawing.SystemColors.WindowText
            End If
        End If

    End Sub

    Private Sub CboRecovery_DblClick(ByRef Index As Short)

        frmList = New FrmList()
        Try
            Call modStatRefQuery.ListRefQueryConversion((frmList.LstSelect))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        Call modControl.SelectID(CboRecovery(Index), frmList.Display)

    End Sub


    Private Sub CboRecovery_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _CboRecovery_1.KeyPress, _CboRecovery_2.KeyPress, _CboRecovery_3.KeyPress, _CboRecovery_4.KeyPress, _CboRecovery_5.KeyPress, _CboRecovery_6.KeyPress, _CboRecovery_7.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = modControl.GetHasTableKey(CboRecovery, eventSender)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboRecovery(Index), KeyAscii)
        Call modControl.ComboSearch(CboRecovery(Index), KeyAscii, True)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboReferralType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboReferralType.SelectedIndexChanged
        '************************************************************************************
        'Name: CboReferralType_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Changes variables and other control values based on ReferralType
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/17/05                          Changed by: Scott Plummer (on his last day)
        'Release #: 8.0                               Task: 416
        'Description:  Update the current referral type, which could have changed
        '************************************************************************************
        Dim TempValue As Short
        Dim vAnyBlank As Boolean
        Dim I As Short

        Select Case modControl.GetID(CboReferralType)

            Case ORGAN_TISSUE_EYE

                If Me.FormState = NEW_RECORD And Me.CallerOrg.ServiceLevel.ApproachMethod Then

                    'Assume options are complete
                    vAnyBlank = False

                    'Check for blank values
                    For I = ORGAN To RESEARCH
                        If Me.GetServiceLevel(GIVEN, I) And modControl.GetID(CboAppropriate(I)) = -1 Then
                            vAnyBlank = True
                        End If
                    Next I

                    'If all options are complete, then set approach type
                    If vAnyBlank Then

                        'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                        'for release 7.7.36
                        LblPromptApproach.Visible = False
                        LblPromptApproach.Text = "Complete Options"
                        'Call modControl.SelectNone(CboApproachType)
                        'Call CboApproachType_Click
                        'Call modControl.Disable(CboApproachType)
                        'Char Chaput 06/14/06 if this is called from notes change do not yellow
                        If vtxtnoteschng = False Then
                            CboApproachType.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboGeneralConsent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboApproachedBy.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                        End If

                    Else

                        Call modControl.Enable(CboApproachType)

                        'Get the current value
                        TempValue = modControl.GetID(CboApproachType)

                        Try
                            Call modStatRefQuery.ListRefQueryApproachType(CboApproachType, Me.CallerOrg.ServiceLevel.ApproachOTEPrompt)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'Reset the previous value
                        If TempValue = -1 And Me.CallerOrg.ServiceLevel.ApproachOTEPrompt = NO_PROMPT Then
                            Call modControl.SelectID(CboApproachType, UNKNOWN)
                        Else
                            Call modControl.SelectID(CboApproachType, TempValue)
                        End If

                        If Me.CallerOrg.ServiceLevel.ApproachOTEPrompt = PROMPT Then
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Ask"
                        Else
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Don't Ask"
                        End If

                    End If

                End If

                'Check if previous vent is being treated as an OTE referral type.
                'If so, select MRO screening based on eligible options, not referral type
                If CallerOrg.ServiceLevel.PrevVentClass = PREVVENT_OTE And modControl.GetID(CboAppropriate(ORGAN)) = APPROP_PREVIOUS_VENT Then

                    'Assuem ruleout
                    LblHistory.Text = "No"
                    LblHistory.ForeColor = System.Drawing.Color.Red

                    'Check for E Only referral type
                    If modControl.GetID(CboAppropriate(EYES)) = APPROP_YES Then
                        'Set the medical history alert label
                        Select Case CallerOrg.ServiceLevel.E_MROLevel
                            Case ADVANCED_MRO
                                LblHistory.Text = "Advanced"
                                LblHistory.ForeColor = System.Drawing.ColorTranslator.FromOle(COLOR_GREEN)
                                Me.TxtNotesCase.Enabled = True
                            Case STANDARD_MRO
                                LblHistory.Text = "Standard"
                                LblHistory.ForeColor = System.Drawing.Color.Blue
                                Me.TxtNotesCase.Enabled = True
                            Case NO_MRO
                                LblHistory.Text = "No"
                                LblHistory.ForeColor = System.Drawing.Color.Red
                        End Select
                    End If

                    'Check for tissue/eye referral type
                    If modControl.GetID(CboAppropriate(VALVES)) = APPROP_YES Or modControl.GetID(CboAppropriate(SKIN)) = APPROP_YES Or modControl.GetID(CboAppropriate(TISSUE)) = APPROP_YES Or modControl.GetID(CboAppropriate(BONE)) = APPROP_YES Then
                        'Set the medical history alert label
                        Select Case CallerOrg.ServiceLevel.TE_MROLevel
                            Case ADVANCED_MRO
                                LblHistory.Text = "Advanced"
                                LblHistory.ForeColor = System.Drawing.ColorTranslator.FromOle(COLOR_GREEN)
                                Me.TxtNotesCase.Enabled = True
                            Case STANDARD_MRO
                                LblHistory.Text = "Standard"
                                LblHistory.ForeColor = System.Drawing.Color.Blue
                                Me.TxtNotesCase.Enabled = True
                            Case NO_MRO
                                LblHistory.Text = "No"
                                LblHistory.ForeColor = System.Drawing.Color.Red
                        End Select
                    End If

                Else

                    'Set the medical history alert label
                    Select Case CallerOrg.ServiceLevel.OTE_MROLevel
                        Case ADVANCED_MRO
                            LblHistory.Text = "Advanced"
                            LblHistory.ForeColor = System.Drawing.ColorTranslator.FromOle(COLOR_GREEN)
                        Case STANDARD_MRO
                            LblHistory.Text = "Standard"
                            LblHistory.ForeColor = System.Drawing.Color.Blue
                        Case NO_MRO
                            LblHistory.Text = "No"
                            LblHistory.ForeColor = System.Drawing.Color.Red
                    End Select

                End If

            Case TISSUE_EYE

                If Me.FormState = NEW_RECORD And Me.CallerOrg.ServiceLevel.ApproachMethod Then

                    'Assume options are complete
                    vAnyBlank = False

                    'Check for blank values
                    For I = ORGAN To RESEARCH
                        If Me.GetServiceLevel(GIVEN, I) And modControl.GetID(CboAppropriate(I)) = -1 Then
                            vAnyBlank = True
                        End If
                    Next I

                    'If all options are complete, then set approach type
                    If vAnyBlank Then
                        'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                        'for release 7.7.36
                        LblPromptApproach.Visible = False
                        LblPromptApproach.Text = "Complete Options"
                        'Call modControl.SelectNone(CboApproachType)
                        'Call CboApproachType_Click
                        'Call modControl.Disable(CboApproachType)
                        'Char Chaput 06/14/06 if this is called from notes change do not yellow
                        If vtxtnoteschng = False Then
                            CboApproachType.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboGeneralConsent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboApproachedBy.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                        End If

                    Else

                        Call modControl.Enable(CboApproachType)

                        'Get the current value
                        TempValue = modControl.GetID(CboApproachType)

                        Try
                            Call modStatRefQuery.ListRefQueryApproachType(CboApproachType, Me.CallerOrg.ServiceLevel.ApproachTEPrompt)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'Reset the previous value
                        If TempValue = -1 And Me.CallerOrg.ServiceLevel.ApproachTEPrompt = NO_PROMPT Then
                            Call modControl.SelectID(CboApproachType, UNKNOWN)
                        Else
                            Call modControl.SelectID(CboApproachType, TempValue)
                        End If

                        If Me.CallerOrg.ServiceLevel.ApproachTEPrompt = PROMPT Then
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Ask"
                        Else
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Don't Ask"
                        End If

                    End If

                End If

                'Set the medical history alert label
                Select Case CallerOrg.ServiceLevel.TE_MROLevel
                    Case ADVANCED_MRO
                        LblHistory.Text = "Advanced"
                        LblHistory.ForeColor = System.Drawing.ColorTranslator.FromOle(COLOR_GREEN)
                    Case STANDARD_MRO
                        LblHistory.Text = "Standard"
                        LblHistory.ForeColor = System.Drawing.Color.Blue
                    Case NO_MRO
                        LblHistory.Text = "No"
                        LblHistory.ForeColor = System.Drawing.Color.Red
                End Select

            Case EYE_ONLY

                If Me.FormState = NEW_RECORD And Me.CallerOrg.ServiceLevel.ApproachMethod Then

                    'Assume options are complete
                    vAnyBlank = False

                    'Check for blank values
                    For I = ORGAN To RESEARCH
                        If Me.GetServiceLevel(GIVEN, I) And modControl.GetID(CboAppropriate(I)) = -1 Then
                            vAnyBlank = True
                        End If
                    Next I

                    'If all options are complete, then set approach type
                    If vAnyBlank Then
                        'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                        'for release 7.7.36
                        LblPromptApproach.Visible = False
                        LblPromptApproach.Text = "Complete Options"
                        'Call modControl.SelectNone(CboApproachType)
                        'Call CboApproachType_Click
                        'Call modControl.Disable(CboApproachType)
                        'Char Chaput 06/14/06 if this is called from notes change do not yellow
                        If vtxtnoteschng = False Then
                            CboApproachType.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboGeneralConsent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboApproachedBy.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                        End If

                    Else

                        Call modControl.Enable(CboApproachType)

                        'Get the current value
                        TempValue = modControl.GetID(CboApproachType)

                        Try
                            Call modStatRefQuery.ListRefQueryApproachType(CboApproachType, Me.CallerOrg.ServiceLevel.ApproachEPrompt)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'Reset the previous value
                        If TempValue = -1 And Me.CallerOrg.ServiceLevel.ApproachEPrompt = NO_PROMPT Then
                            Call modControl.SelectID(CboApproachType, UNKNOWN)
                        Else
                            Call modControl.SelectID(CboApproachType, TempValue)
                        End If

                        If Me.CallerOrg.ServiceLevel.ApproachEPrompt = PROMPT Then
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Ask"
                        Else
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Don't Ask"
                        End If

                    End If

                End If

                'Set the medical history alert label
                Select Case CallerOrg.ServiceLevel.E_MROLevel
                    Case ADVANCED_MRO
                        LblHistory.Text = "Advanced"
                        LblHistory.ForeColor = System.Drawing.ColorTranslator.FromOle(COLOR_GREEN)
                    Case STANDARD_MRO
                        LblHistory.Text = "Standard"
                        LblHistory.ForeColor = System.Drawing.Color.Blue
                    Case NO_MRO
                        LblHistory.Text = "No"
                        LblHistory.ForeColor = System.Drawing.Color.Red
                End Select

            Case RULEOUT

                If Me.FormState = NEW_RECORD And Me.CallerOrg.ServiceLevel.ApproachMethod Then

                    'Assume options are complete
                    vAnyBlank = False

                    'Check for blank values
                    For I = ORGAN To RESEARCH
                        If Me.GetServiceLevel(GIVEN, I) And modControl.GetID(CboAppropriate(I)) = -1 Then
                            vAnyBlank = True
                        End If
                    Next I

                    'If all options are complete, then set approach type
                    If vAnyBlank Then
                        'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                        'for release 7.7.36
                        LblPromptApproach.Visible = False
                        LblPromptApproach.Text = "Complete Options"
                        'Call modControl.SelectNone(CboApproachType)
                        'Call CboApproachType_Click
                        'Call modControl.Disable(CboApproachType)
                        'Char Chaput 06/14/06 if this is called from notes change do not yellow
                        If vtxtnoteschng = False Then
                            CboApproachType.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboGeneralConsent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                            CboApproachedBy.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                        End If

                    Else

                        Call modControl.Enable(CboApproachType)

                        'Get the current value
                        TempValue = modControl.GetID(CboApproachType)

                        Try
                            Call modStatRefQuery.ListRefQueryApproachType(CboApproachType, Me.CallerOrg.ServiceLevel.ApproachROPrompt)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'Reset the previous value
                        If TempValue = -1 And Me.CallerOrg.ServiceLevel.ApproachROPrompt = NO_PROMPT Then
                            Call modControl.SelectID(CboApproachType, UNKNOWN)
                        Else
                            Call modControl.SelectID(CboApproachType, TempValue)
                        End If

                        If Me.CallerOrg.ServiceLevel.ApproachROPrompt = PROMPT Then
                            'Char Chaput 12/22/05 removed the display of this label which is the prompt red text
                            'for release 7.7.36
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Ask"
                        Else
                            LblPromptApproach.Visible = False
                            LblPromptApproach.Text = "Don't Ask"
                        End If

                    End If

                End If

                LblHistory.Text = "No"
                LblHistory.ForeColor = System.Drawing.Color.Red

        End Select

        'Update the current referral type, which could have changed.  v.8.0 6/17/05 - SAP
        If pvPrelimReferralType = -1 Or pvPrelimReferralType = 0 Then
            pvPrelimReferralType = modControl.GetID(CboReferralType)
        End If
        pvCurrentReferralType = modControl.GetID(CboReferralType)
        UpdateFormCaption()

    End Sub

    Private Sub CboReferralType_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboReferralType.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboReferralType_KeyPress(CboReferralType, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Sub CboReferralType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboReferralType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboReferralType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub cboRegistryStatus_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboRegistryStatus.SelectedIndexChanged

        'T.T 10/11/2004 added to maintain registrystatus
        If cboRegistryStatus.Text = "Manually Found" _
            Or cboRegistryStatus.Text = "WebRegistry" _
            Or cboRegistryStatus.Text = "StateRegistry" _
            Or cboRegistryStatus.Text = "DLA Registry" Then
            EnableDonorIntent()
        ElseIf cboRegistryStatus.Text = "Not on Registry" Then
            cmdDonorIntent.Enabled = False
            'ccarroll 06/21/2010 The RegistryStatus has changed
            ' reset method of approach to Not Approached
            If FormLoad = False And MethodOfApproachReset = True Then
                'bret 08/30/2010 check to see if Not Approached exists. If it does set it else do nothing
                If Me.CboApproachType.FindString("Not Approached") > 0 Then
                    Me.CboApproachType.SelectedIndex = Me.CboApproachType.FindString("Not Approached") 'Not Approached
                End If
            End If
        ElseIf cboRegistryStatus.Text = "Not Checked" Then
            cmdDonorIntent.Enabled = False
            If FormLoad = False And MethodOfApproachReset = True Then
                'bret 08/30/2010 check to see if Not Approached exists. If it does set it else do nothing
                If Me.CboApproachType.FindString("Not Approached") > 0 Then
                    Me.CboApproachType.SelectedIndex = Me.CboApproachType.FindString("Not Approached") 'Not Approached
                End If
            End If
        End If

    End Sub

    Private Sub CboState_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboState.SelectedIndexChanged

        Dim vReturn As New Object

        'Set defaults
        TxtCoronerNote.Text = ""
        TxtCoronerPhone.Text = ""
        CboCoronerOrg.Items.Clear()
        CboCoronerName.Items.Clear()

        'Fill the list with coroners from the state of the hospital org
        If CboCoronerOrg.Items.Count = 0 Then
            Try
                If modStatQuery.QueryStateCoroners(modControl.GetID(CboState), vReturn) = SUCCESS Then
                    Call modControl.SetTextID(CboCoronerOrg, vReturn)
                End If
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If



    End Sub
    Private Sub CboRace_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboRace.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboRace, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboVent_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboVent.SelectedIndexChanged

        '01/06/04 mds Added vent constant of VENT_PREV (used to be 1)
        If modControl.GetID(CboVent) = VENT_PREV Then
            TxtExtubated.Text = VB6.Format(Now, "mm/dd/yy  ")
            Call modControl.Enable(TxtExtubated)
        Else
            Call modControl.Disable(TxtExtubated)
            TxtExtubated.Text = ""
            TxtExtubated.Enabled = False
        End If

        '02/18/02 bjk: set CboVentChanged  to true when coordinator changes value
        CboVentChanged = True
        CboVent.BackColor = System.Drawing.Color.White ' change background color back to white

        '01/06/04 mds check the heart beat and vent status values
        Call ConfirmHeartBeatVent()

    End Sub

    Private Sub CboVent_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboVent.Enter
        '************************************************************************************
        'Name: CboVent_GotFocus
        'Date Created: 08/13/07                         Created by: Bret Knoll
        'Release: Unknown                               Task: StatTrac Release: 8.0 Iter 4 Empirix 6780
        'Description: Sets OldValue when control receives focus
        '
        '====================================================================================
        OldValue = CboVent.Text
    End Sub

    '12/18/02 BJK: Disable ability for person to delete current selection FrmReferral.CboVent_KeyPress
    Private Sub CboVent_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboVent.KeyDown

        eventArgs.Handled = True
    End Sub
    Private Sub CboVent_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboVent.KeyPress
        eventArgs.Handled = True

    End Sub
    Private Sub CboVent_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboVent.Leave

        'Before verifying, kick off the referraltype validateion
        Call CboReferralType_SelectedIndexChanged(CboReferralType, New System.EventArgs())

        '10/2/01 drh
        'Call ValidateForDonorIntent

    End Sub

    Private Sub CboVent_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboVent.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        '************************************************************************************
        'Name: CboVent_Validate
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: validates CboVent data
        '
        '====================================================================================
        '====================================================================================
        'Date Changed: 08/13/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: StatTrac Release: 8.0 Iter 4 Empirix 6780
        'Description:   Sets OldValue when control receives focus
        '
        '====================================================================================
        'Verify
        If CboVent.Text <> OldValue Then
            If CboVent.Text <> "" And TxtAge.Text <> "" Then

                Select Case CallerOrg.ServiceLevel.TriageLevel

                    Case VENT_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, False, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, False, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_MRO
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, True, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                End Select

            End If
            'Set physician only if is not all ready set
            'If (Me.AttendingMDID = 0 Or Me.AttendingMDID = -1) Or Me.CboVent.Text = "Never" Then
            'If ((modControl.GetID(CboPhysician(0)) = 0 Or modControl.GetID(CboPhysician(0)) = -1)) And CboPhysician(0).Enabled = True Then
            'If (Me.CboVent.Text = "Currently" Or Me.CboVent.Text = "Previously") And Me.CboVent.Enabled = False Then
            Call InitializePhysician(Me)
            'End If
            'End If
            'If ((modControl.GetID(CboPhysician(1)) = 0 Or modControl.GetID(CboPhysician(1)) = -1)) And CboPhysician(1).Enabled = True Then
            'Call InitializePhysician(Me)
            'End If
        End If

        OldValue = ""




        eventArgs.Cancel = Cancel
    End Sub
    Private Sub chkApproached_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkApproached.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If MsgBox("Are you sure you want to change the Status? This action cannot be reversed.", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
            Call SetFSStage(CShort(Me.chkApproached.Tag))
        Else
            chkApproached.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If

    End Sub


    Private Sub chkCaseOpen_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkCaseOpen.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If MsgBox("Are you sure you want to change the Status? This action cannot be reversed.", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
            Call SetFSStage(CShort(Me.chkCaseOpen.Tag))
        Else
            chkCaseOpen.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If


    End Sub


    Private Sub ChkCoronerCase_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkCoronerCase.CheckStateChanged

        Dim vReturn As New Object


        If ChkCoronerCase.CheckState = 1 Then

            'Fill and set state list
            Try
                Call modStatRefQuery.RefQueryState(CboState)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.SelectID(CboState, OrganizationStateID)

            'Fill the list with coroners from the state of the hospital org
            If CboCoronerOrg.Items.Count = 0 Then
                Try
                    If modStatQuery.QueryStateCoroners(OrganizationStateID, vReturn) = SUCCESS Then
                        Call modControl.SetTextID(CboCoronerOrg, vReturn)
                    End If
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

            'Set defaults
            If Me.FormLoad = False Then
                Try
                    If modStatQuery.QueryCountyCoroner(OrganizationCountyID, vReturn) = SUCCESS _
                        AndAlso ObjectIsValidArray(vReturn, 2, 0, 4) Then
                        Call modControl.SelectID(CboCoronerOrg, vReturn(0, 4))
                        CoronerOrgID = vReturn(0, 4)
                    Else
                        TxtCoronerNote.Text = ""
                        TxtCoronerPhone.Text = ""
                        Call modControl.SelectNone(CboCoronerOrg)
                    End If
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

        Else

            TxtCoronerNote.Text = ""
            CboCoronerOrg.Items.Clear()
            CboCoronerName.Items.Clear()
            TxtCoronerPhone.Text = ""

        End If

        If ChkCoronerCase.CheckState = 1 Then
            CmdContactCoroner.Enabled = True
            CboState.Enabled = True
            CboCoronerOrg.Enabled = True
            CboCoronerName.Enabled = True
            TxtCoronerPhone.Enabled = True
            CmdCoronerDetail.Enabled = True
            CmdCoronerName.Enabled = True
        Else
            CmdContactCoroner.Enabled = False
            CboState.Enabled = False
            CboCoronerOrg.Enabled = False
            CboCoronerName.Enabled = False
            TxtCoronerPhone.Enabled = False
            CmdCoronerDetail.Enabled = False
            CmdCoronerName.Enabled = False
        End If

    End Sub
    Private Sub ChkDOB_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkDOB.CheckStateChanged

        If ChkDOB.CheckState = 0 Then
            Me.TxtDOB.Visible = True
            Me.LblDOB_ILB.Visible = False
        Else
            Me.TxtDOB.Visible = False
            Me.LblDOB_ILB.Visible = True
            Me.TxtDOB.Text = ""
        End If

    End Sub

    Private Sub chkFinal_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkFinal.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If AppMain.ParentForm.PersonTypeID = FAMILY_SERVICES_COORDINATOR Then
            Call MsgBox("Sorry, you do not have permission to mark Secondary Final.", MsgBoxStyle.OkOnly)
            chkFinal.CheckState = System.Windows.Forms.CheckState.Unchecked
            Exit Sub
        Else
            If MsgBox("Are you sure you want to change the Status? This action cannot be reversed.", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
                'Check to see if the current user is trying to disable the final check box. If the length of the lable is greater
                'than zero call the function to remove final information.
                If Len(lblFinalPersonDateTime.Text) > 0 Then
                    Call ReverseSetFSStage(CShort(Me.chkFinal.Tag))
                Else 'save person new data
                    Call SetFSStage(CShort(Me.chkFinal.Tag))
                End If
            Else
                chkFinal.CheckState = System.Windows.Forms.CheckState.Unchecked
            End If
        End If

    End Sub


    Private Sub chkSecondaryComplete_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryComplete.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If MsgBox("Are you sure you want to change the Status? This action cannot be reversed.", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
            Call SetFSStage(CShort(Me.chkSecondaryComplete.Tag))
        Else
            chkSecondaryComplete.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If

    End Sub


    Private Sub chkSecondaryTBINotNeeded_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryTBINotNeeded.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        'ccarroll 06/06/2007 StatTrac 8.4 release requirement 3.6 - TBI Number

        If Me.chkSecondaryTBINotNeeded.CheckState = 1 Then
            'Enable TBI comment area
            Me.txtSecondaryTBIComment.Enabled = True
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.Color.White
            Me.txtSecondaryTBIComment.Focus()

            'Assign TBI note content
            Me.TBINoteText = "The assignment of CTDN # " & Me.txtSecondaryTBINumber.Text & " was not needed. This action was executed by " & AppMain.ParentForm.StatEmployeeName

            'Set TBIUpdateflag to save data when secondary data is commited
            Me.TBIUpdateFlag = True

        Else
            'TBI NotNeeded checkbox was un-checked so disable comment area
            Me.txtSecondaryTBIComment.Text = ""
            Me.txtSecondaryTBIComment.Enabled = False
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)

            'Assign TBI note content
            Me.TBINoteText = "The CTDN # " & Me.txtSecondaryTBINumber.Text & " has been reassigned by " & AppMain.ParentForm.StatEmployeeName

            'Set TBIUpdateflag to save changes when secondary data is commited
            Me.TBIUpdateFlag = True


        End If
    End Sub

    Private Sub chkSystemEvents_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSystemEvents.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If MsgBox("Are you sure you want to change the Status? This action cannot be reversed.", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
            Call SetFSStage(CShort(Me.chkSystemEvents.Tag))
        Else
            chkSystemEvents.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If

    End Sub

    Private Sub ChkTemp_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkTemp.CheckStateChanged

        If ChkTemp.CheckState = System.Windows.Forms.CheckState.Checked Then
            ChkExclusive.Visible = True
            ChkExclusive.CheckState = System.Windows.Forms.CheckState.Checked
        Else
            ChkExclusive.Visible = False
            ChkExclusive.CheckState = System.Windows.Forms.CheckState.Unchecked
            CallComplete = True
        End If

    End Sub

    Private Sub chkViewLogEventDeleted_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkViewLogEventDeleted.CheckStateChanged
        '************************************************************************************
        'Name: chkViewLogEventDeleted_Click
        'Date Created: 06/11/07                         Created by: Bret Knoll
        'Release: 8.4                                   Task: 8.4.3.9 logevent deleted
        'Description: refereshes logevent with or w/o deleted logevents
        'Returns: na
        'Params: na
        '
        '
        'Stored Procedures: na
        '====================================================================================
        'Clear the grid
        LstViewLogEvent.Items.Clear()
        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        'Me.chkViewLogEventDeleted

    End Sub

    Private Sub CmdApproachedByDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdApproachedByDetail.Click

        Dim vPersonID As Integer
        Dim vReturn As New Object

        If uIMap Is Nothing Then
            Try
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        'Determine the form state which to open the
        'Person form.
        If modControl.GetID(CboApproachedBy) = -1 Then
            vPersonID = 0
            GeneralConstant.CreateInstance().OrganizationId = Me.OrganizationId
        Else
            vPersonID = modControl.GetID(CboApproachedBy)
        End If



        'Get the Person id from the Person form
        'after the user is done.
        Try
            Me.ApproachedByID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Me.ApproachedByID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)information
            Try
                Call modStatQuery.QueryLocationApproachPerson(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.SelectID(CboApproachedBy, Me.ApproachedByID)
        End If

    End Sub

    Private Sub CmdAttendingPhone_Click(ByRef Index As Short)
        Dim vPhoneID As Integer

        'Determine the state which to open the
        'form.
        If uIMap Is Nothing Then
            Try
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        'Get the Phone id from the Phone form
        'after the user is done.

        Try
            vPhoneID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup, Me.PersonID)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub
    Private Sub FakeSave()

        If ChkTemp.CheckState = System.Windows.Forms.CheckState.Unchecked Then
            If Not modStatValidate.ValidateReferralContacts(Me, True) Then
                Exit Sub
            End If
        End If


        Me.Close()

    End Sub
    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Dim error_Renamed As Object
        'ccarroll 09/20/2011 Get PNE Warning instructions on Cancel. CCRST151
        Dim isDisplayContactRequiredWarning As Boolean

        If Me.WSCount >= 1 Then
            Try
                error_Renamed = modStatSave.InsertNote(CStr(Me.CallId), "The Registry search could not be completed because it has been manually stopped" & Chr(13) & " The registry has not been searched.", VB.Right(Me.CallNumber, 3), (Me.OrganizationId))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
        If ChkTemp.CheckState = System.Windows.Forms.CheckState.Unchecked Then

            'Determine if Contact Required needs to be addressed
            isDisplayContactRequiredWarning = Me.GetPNEWarningOnSave()
            Try
                If Not modStatValidate.ValidateReferralContacts(Me, isDisplayContactRequiredWarning) Then
                    Exit Sub
                End If
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        Me.Close()

        Exit Sub

    End Sub

    Private Sub CmdColorKey_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdColorKey.Click
        frmColorKey = New FrmColorKey()
        Dim dialogResult As DialogResult = frmColorKey.ShowDialog()
        frmColorKey = Nothing
    End Sub

    Private Sub CmdContactCoroner_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdContactCoroner.Click

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object

        If modControl.GetID(CboCoronerOrg) = -1 Then
            Call MsgBox("Please select a coroner before establishing a contact.", , "Select Coroner")
            CboCoronerOrg.Focus()
            Exit Sub
        End If

        frmLogEvent = New FrmLogEvent()

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        frmLogEvent.DefaultContactName = CboCoronerName.Text
        frmLogEvent.DefaultContactPhone = TxtCoronerPhone.Text
        frmLogEvent.DefaultOrganization = CboCoronerOrg.Text
        frmLogEvent.DefaultContactType = CORONER_CASE

        'Set event types
        vEventTypeList(0) = CORONER_CASE
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        If TabDonor.TabPages.IndexOf(tabDonorTable(3)) > -1 Then

            TabDonor.TabPages.IndexOf(tabDonorTable(2))


        End If

    End Sub

    Private Sub CmdCoronerDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCoronerDetail.Click

        Dim vReturn As New Object
        Dim vResultArray As New Object
        Dim OrganizationId As Integer

        'FrmOrganization.SourceCode = Me.SourceCode
        OrganizationId = modControl.GetID(CboCoronerOrg)

        'Determine the form state which to open the
        'Organization form.
        If OrganizationId = -1 Then
            OrganizationId = 0
        Else
            OrganizationId = OrganizationId
        End If

        If uIMap Is Nothing Then
            Try
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        'Get the organization id from the organization form
        'after the user is done.
        Try
            OrganizationId = uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, OrganizationId)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If OrganizationId = 0 Then
            'The user cancelled adding a new organization
            'so do nothing
        Else
            'Refill the location combo box with the new (or updated)
            'organization id and name
            CboCoronerOrg.Items.Clear()

            Try
                If modStatQuery.QueryStateCoroners(modControl.GetID(CboState), vReturn) = SUCCESS Then
                    Call modControl.SetTextID(CboCoronerOrg, vReturn)
                End If
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            Call modControl.SelectID(CboCoronerOrg, OrganizationId)

        End If

    End Sub

    Private Sub CmdCoronerName_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCoronerName.Click

        Dim vPersonID As Integer
        Dim vReturn As New Object

        If CboCoronerOrg.Text = "" Then
            'Do nothing
            Exit Sub
        End If
        If uIMap Is Nothing Then
            Try
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
        'Determine the form state which to open the
        'Person form.
        If modControl.GetID(CboCoronerName) = -1 Then
            vPersonID = 0
            'Set the default organization to the selected location
            GeneralConstant.CreateInstance().OrganizationId = modControl.GetID(CboCoronerOrg)
        Else
            vPersonID = modControl.GetID(CboCoronerName)
        End If


        'Get the Person id from the Person form
        'after the user is done.
        Try
            vPersonID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vPersonID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)information
            Try
                If modStatQuery.QueryCoroner(modControl.GetID(CboCoronerOrg), vReturn) = SUCCESS Then

                    Call modControl.SetTextID(CboCoronerName, vReturn, True)

                    CboCoronerName.Items.Add(New ValueDescriptionPair(-1, "Not Available"))

                    Call modControl.SelectID(CboCoronerName, vPersonID)

                End If
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Sub


    Private Sub CmdCustomData_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCustomData.Click

        frmCustom1 = New FrmCustom1()
        frmCustom1.modalParent = Me
        frmCustom1.ServiceLevel = CallerOrg.ServiceLevel
        frmCustom1.CurrentCall = Me.ReferralCall
        frmCustom1.CallingForm = "FrmReferral"

        Call frmCustom1.Display()
        frmCustom1 = Nothing
    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        '************************************************************************************
        'Name: CmdDelete_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: checks if the event can be deleted and calls the delete method
        'Returns: n/a
        'Params: n/a
        '
        '
        'Stored Procedures: n/a
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/13/07                       Changed by: Bret Knoll
        'Release #: 8.4.3.9                            Task: LogEvent Delete
        'Description:
        '   Prevent Deleted from being deleted
        '   fix index numbers for existing code
        '====================================================================================
        Dim vLogEventID As Integer
        Dim I As Short
        Dim vRow As Short
        Dim vReturn As Short
        Dim vLogEventDesc As String = ""

        'if LstViewLogEvent.SelectedItem.SubItems(2) = "Note" then

        'Make sure we have a selected event
        If LstViewLogEvent.FocusedItem Is Nothing Then
            Call MsgBox("Please select an event before clicking the 'Delete Event' button.")
            Exit Sub
        End If

        'Get the ID of the selected LogEvent
        vLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

        Try
            Call modStatQuery.QueryLogEventDesc(vLogEventID, vLogEventDesc)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'T.T 05/20/2006 do not allow the deletion of web events
        If VB.Left(vLogEventDesc, 19) = "The Registry search" Then
            Call MsgBox("You may not delete a WebService Event.")
            Exit Sub
        End If

        'ccarroll 07/06/2007 do not allow deletion of QA_Note
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "QA Note" Then
            Call MsgBox("You may not delete the QA Note event.")
            Exit Sub
        End If

        'T.T 05/20/2006 do not allow recycle notes to delete
        ' subItem 1 is Event Type
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "Recycled Call" Then
            Call MsgBox("You may not delete the Recycle Note Event.")
            Exit Sub
        End If

        'Do not allow the deletion of the original incoming call event
        ' subItem 1 is Event Type
        'bret 06/11/2007 if the list is sorted this statement does not work.
        'subItem 6 is LogEvent Order Number
        If CDbl(LstViewLogEvent.FocusedItem.SubItems(6).Text) = 1 And LstViewLogEvent.FocusedItem.SubItems(1).Text = "Incoming Call" Then
            Call MsgBox("You may not delete the original incoming call event.")
            Exit Sub
        End If

        'ccarroll 06/13/2007 StatTrac 8.4 release requirement 3.6 - TBI Number
        'Do not allow the deletion of a TBI event
        '.SubItems(2) = from/To column
        If LstViewLogEvent.FocusedItem.SubItems(2).Text = "CTDN Number" Then
            Call MsgBox("You may not delete a CTDN event.")
            Exit Sub
        End If

        'bret 06/11/2007 8.4.3.9 edit deleted event
        'SubItems(1) = Event Type
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "DELETED EVENT" Then
            Call MsgBox("You may not delete a Deleted Event.")
            Exit Sub
        End If



        vReturn = MsgBox("Are you sure you want to delete this event?", MsgBoxStyle.OkCancel + MsgBoxStyle.DefaultButton2, "Delete Event")

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Get the ID of the LogEvent to open
        Me.CurrentLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

        'Delete the event
        Try
            Call modStatSave.DeleteLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Check for pending contacts
        Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Sub

    Private Sub CmdDirectionsNote_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDirectionsNote.Click


        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object

        frmLogEvent = New FrmLogEvent()

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        frmLogEvent.DefaultContactType = GENERAL

        'Set the call number of the Details form
        frmLogEvent.CallNumber = Me.CallNumber

        'Set event types
        vEventTypeList(0) = GENERAL
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

    End Sub

    Private Sub cmdDonorIntent_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDonorIntent.Click

        frmDonorIntent = New FrmDonorIntent()
        frmDonorIntent.modalParent = Me
        If (Len(CboRace.Text) < 1) Then
            If CboRace.Enabled = True Then
                MsgBox("Please enter Race!", MsgBoxStyle.Exclamation, "Instruction")
                CboRace.Focus()
                Exit Sub
            End If

        End If

        If Len(Me.CboGender.Text) = 0 Then
            If Me.CboGender.Enabled = True Then
                MsgBox("Please enter Gender!", MsgBoxStyle.Exclamation, "Instruction")
                Me.CboGender.Focus()
                Exit Sub
            End If
        End If

        '10/2/01 drh
        'Check if any options are appropriate
        If VerifyAppropriateForDonorIntent() Then
            '10/3/01 drh Check if Organs are appropriate
            If CboAppropriate(ORGAN).Text = "Yes" And (CboApproach(ORGAN).SelectedIndex <> -1 Or CboApproach(ORGAN).Text <> "Yes") Then
                'Display Organs Appropriate dialog; If OK is selected, set Approach and Disposition fields
                If MsgBox("Please tell the caller that the organ coordinator will be calling them back.  DO NOT tell the caller that the patient is a registered donor.", MsgBoxStyle.OkCancel, "Organs Appropriate") = MsgBoxResult.Ok Then

                    '10/16/01 drh Approach and Disposition field processing
                    Call SetDispositionForDonorIntent()

                    'Set Donor Intent Done flag
                    Me.DonorIntentDone = -1

                    'Enable NOK
                    Call SetNOKComponents("Enable")

                    EnableDonorIntent()

                    'Fill in default NOK info
                    'bjk 07/25/03 - Fix Problem: NOK is overwritten
                    'If Me.TxtNOK = "" Then
                    'Me.TxtNOK = "Not Available"
                    'End If

                    'Select Log Event tab
                    If TabDonor.TabPages.IndexOf(tabDonorTable(2)) > -1 Then
                        TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(2))
                    End If

                End If
            Else
                'Determine the form state which to open the
                'Organization form.
                Me.NOKData = False
                If NOKID <> 0 Or NOK > "" Then
                    frmDonorIntent.FormState = EXISTING_RECORD
                    frmDonorIntent.vNOKID = Me.NOKID
                Else
                    frmDonorIntent.FormState = NEW_RECORD
                    frmDonorIntent.vNOKID = 0
                End If
                'If other options are appropriate, display Nurse script dialog
                If NOKID <> 0 Or IsDBNull(NOKID) Or NOK = "" Then
                    frmDonorIntent.txtNurseScript.Text = CallerOrg.ServiceLevel.NurseScript
                    If Me.DonorSearchState.HasWebRegistryDonor Then
                        frmDonorIntent.lblRegType.Text = "Patient registered as donor in Donor Registry"
                        EnableDonorIntent()
                    ElseIf Me.DonorSearchState.HasStateRegistryDonor Then
                        frmDonorIntent.lblRegType.Text = "Patient registered as donor in DMV Registry"
                        EnableDonorIntent(Color.Blue)
                    Else
                        frmDonorIntent.lblRegType.Text = ""
                    End If
                Else
                    frmDonorIntent.txtoldNurseScript.Text = CallerOrg.ServiceLevel.NurseScript
                    If Me.DonorSearchState.HasWebRegistryDonor Then
                        frmDonorIntent.lbloldRegType.Text = "Patient registered as donor in Donor Registry"
                        EnableDonorIntent()
                    ElseIf Me.DonorSearchState.HasStateRegistryDonor Then
                        frmDonorIntent.lbloldRegType.Text = "Patient registered as donor in DMV Registry"
                        EnableDonorIntent()

                    Else
                        frmDonorIntent.lbloldRegType.Text = ""
                    End If

                End If

                'Get the Person id from the Person form
                'after the user is done
                Me.NOKData = False

                Me.NOKID = frmDonorIntent.Display

                If Me.DonorIntentDone = -1 Then
                    '10/16/01 drh Approach and Disposition field processing
                    Call SetDispositionForDonorIntent()

                    'Enable NOK
                    Call SetNOKComponents("Enable")

                    EnableDonorIntent(Color.Blue)
                    'Select Log Event tab
                    If TabDonor.TabPages.IndexOf(tabDonorTable(2)) > -1 Then
                        TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(2))
                    End If
                End If
            End If

        Else
            'If nothing is appropriate, enable Save and NOK components; disable Donor Intent button
            Call SetNOKComponents("Enable")
        End If

    End Sub

    Private Sub cmdEventRecieved_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)



    End Sub

    Private Sub cmdeventrecievedFound_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)


    End Sub
    Public Sub WebserviceErrorTimer()
        Me.WebServiceTimer1.Enabled = True
    End Sub
    Private Sub CmdFamilyContact_Click()

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(1) As Object
        Dim vSubItemsList As New Object

        frmLogEvent = New FrmLogEvent()
        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Set event types
        vEventTypeList(0) = OUTGOING
        vEventTypeList(1) = CALLBACK_PENDING
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        If TabDonor.TabPages.IndexOf(tabDonorTable(3)) > -1 Then
            TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(3))
        End If


    End Sub

    Private Sub cmdGenerateTBI_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdGenerateTBI.Click
        'ccarroll 06/06/2007 StatTrac 8.4 release, requirement 3.6 - TBI Number

        Dim TBINoteText As String = ""

        If Me.txtSecondaryTBINumber.Text = "" And Me.TBIAccess = True Then
            'get TBIPrefix and TBIdate
            Try
                Call modStatQuery.QuerySecondaryTBIPrefix(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Me.TBIPrefix <> "" Then 'If TBI prefix is missing disallow TBI number generation.

                'Check if valid Cardiac Death date
                If IsDate(Me.TxtDeathDate.Text) = True Then
                    'Use Cardiac Death date for TBI number
                    Me.TBIDate = VB6.Format(CDate(Me.TxtDeathDate.Text), "yyyy") & VB6.Format(CDate(Me.TxtDeathDate.Text), "mm")
                    Me.txtSecondaryTBINumber.Text = modStatSave.SaveSecondaryTBINumber(Me)
                    Me.cmdGenerateTBI.Enabled = False

                    'Enable the (TBI Not Needed) checkbox and comment area
                    Me.chkSecondaryTBINotNeeded.Enabled = True
                    Me.txtSecondaryTBIComment.Enabled = False

                    'Generate note for TBI button press
                    TBINoteText = "A CTDN number has been generated by " & AppMain.ParentForm.StatEmployeeName & ". The CTDN # is " & Me.txtSecondaryTBINumber.Text

                    Call modStatSave.SaveLogEvent(Me, GENERAL, TBINoteText)
                Else
                    MsgBox("CTDN number can not be generated without a valid" & Environment.NewLine & "Cardiac Death date. Please enter the Cardiac Death" & Environment.NewLine & "date before assigning the CTDN number.", MsgBoxStyle.Exclamation, "System Message")
                End If

            Else
                'TBI prefix is missing. Notify user.
                MsgBox("CTDN number can not be generated when CTDN prefix is missing." & Environment.NewLine & "Please have a Service Consultant check ServiceLevel setup options for this organization.", MsgBoxStyle.Exclamation, "System Message")
            End If

        End If


    End Sub

    Private Sub cmdKSFound_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)
    End Sub

    Private Sub CmdModify_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdModify.Click

        Dim vReturn As New Object
        Dim vResultArray As New Object


        If (AppMain.frmNew Is Nothing) Then
            AppMain.frmNew = New FrmNew()
        End If

        'Determine the form state which to open the
        'New form to modify source code and contact info.
        'Store the OrgId before the change
        vOriginalSC = Me.SourceCode.ID
        vOriginalOrgId = Me.OrganizationId

        If Me.CboHeartBeat.Enabled Then
            vOriginalHB = True
        Else
            vOriginalHB = False
            TxtDonorLastName.Focus()
        End If

        If Me.CboVent.Enabled Then
            vOriginalVent = True
        Else
            vOriginalVent = False
            TxtDonorLastName.Focus()
        End If

        If Me.OrganizationId = -1 Then
            ' FrmNew.FormState = NEW_RECORD
            AppMain.frmNew.OrganizationId = 0
        Else
            'AppMain.frmNew.FormState = EXISTING_RECORD
            AppMain.frmNew.OrganizationId = Me.OrganizationId
            vOldTextLblOrganization = Me.OrganizationName
            'Get the organization name
            Try
                Call modStatRefQuery.RefQueryOrganization(vResultArray, Me.OrganizationId)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            Call modControl.SelectText(AppMain.frmNew.CboCallType, "Referral")

            AppMain.frmNew.SourceCode.Name = Me.SourceCode.Name
            AppMain.frmNew.SourceCode.ID = Me.SourceCode.ID
            AppMain.frmNew.CallId = Me.CallId

            AppMain.frmNew.TxtPhone.Text = Me.LblPhone.Text
            AppMain.frmNew.TxtExtension.Text = Me.LblExtension.Text

            AppMain.frmNew.SubLocationID = Me.SubLocationID

            AppMain.frmNew.SubLocationLevel = Me.SubLocationLevel
            AppMain.frmNew.TxtLevel.Text = Me.SubLocationLevel

            'set the person type combo box
            AppMain.frmNew.PersonID = Me.PersonID

        End If

        'Get the Organization id from the NewCall form
        'after the user is done.
        AppMain.frmNew.vParentForm = Me

        'ccarroll 07/14/2011 - wi:13011
        AppMain.frmNew.vOriginalCallType = REFERRAL
        AppMain.frmNew.Display()



    End Sub

    Private Sub CmdNewEvent_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNewEvent.Click

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vSubItemsList As New Object

        frmLogEvent = New FrmLogEvent()
        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        If Me.ShiftKey Then

            If IsNothing(LstViewLogEvent.FocusedItem) Then
                Call MsgBox("Please select an event before shift-clicking the 'New Event' button.")
                Exit Sub
            End If
            Me.CurrentLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

            'Get the selected event
            Try
                Call modStatQuery.QueryLogEvent(Me, frmLogEvent)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Me.ShiftKey = False
        Else
            'Default fields
            frmLogEvent.DefaultContactName = LblName.Text
            frmLogEvent.DefaultContactPhone = LblPhone.Text
            frmLogEvent.DefaultOrganization = LblOrganization.Text
            frmLogEvent.DefaultOrganizationID = Me.OrganizationId
            'BJK 03/27/02: adding code to set OrganizationID in frmLogEvent Defaul OrganizationID
            'is not used but this is not guaranteed.  OrganizationID is save with the logEvent when saved.
            frmLogEvent.OrganizationId = Me.OrganizationId
            frmLogEvent.DefaultContactType = -1
        End If

        'Set the call number of the Details form
        frmLogEvent.CallNumber = Me.CallNumber

        'Set event types
        'Items past ALL_TYPES are to exclude.
        Dim vEventTypeList = New Object() {ALL_TYPES, OUTGOING_FAX, INCOMING_EREFERRAL, PENDING_EREFERRAL_REVIEW}
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/8/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Check for pending contacts
        Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '7/3/01 drh Get the FS stage
        Call GetFSStage()

    End Sub




    Private Sub CmdNOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNOK.Click

        frmDonorIntent = New FrmDonorIntent()
        frmDonorIntent.modalParent = Me

        'Determine the form state which to open the
        'frmDonorIntent/NOK form.
        If NOKID <> 0 Or NOK > "" Then
            frmDonorIntent.FormState = EXISTING_RECORD
            frmDonorIntent.vNOKID = Me.NOKID
        Else
            frmDonorIntent.FormState = NEW_RECORD
            frmDonorIntent.vNOKID = 0
        End If


        'Get the organization id from the organization form
        'after the user is done.
        Me.NOKData = True
        Me.NOKID = frmDonorIntent.Display


    End Sub

    Private Async Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short
        Dim I As Short
        Dim j As Short
        Dim vReferralID As Integer
        Dim vRegistration As Boolean 'T.T 8/16/2004 call to registration function
        Dim NoteText As String = ""
        Dim error_Renamed As Object
        Dim vQuery As New Object
        Dim Res As New Object
        Dim vResult As New Object


        'bret 6/10/07 8.4.3.8 moved call to work to top of method
        Call modUtility.Work()

        'Confirm we have a valid COD selection
        Dim cancelEventArgs As ComponentModel.CancelEventArgs = New System.ComponentModel.CancelEventArgs()
        CboCauseOfDeath_Validating(eventSender, cancelEventArgs)
        If cancelEventArgs.Cancel Then
            Exit Sub
        End If

        If Me.CmdRegMatch.Visible = True And
            Me.cboRegistryStatus.Text = "Not Checked" And
            Me.pvCurrentReferralType <> 4 Then
            Call CmdRegMatch_Click(CmdRegMatch, New System.EventArgs())
            Exit Sub

            'Show warning dialogue to registry clients who save with RegStatus set to NotChecked
        ElseIf Me.cboRegistryStatus.Text = "Not Checked" _
            And Me.CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent Then

            'We're about to save with RegStatus set to NotChecked
            'Prepare a CustomMessageBox form so we can prompt the user
            Dim prompt As String = "Registry couldn't be searched at this time. You can select 'Search Again' to search again or select  'Save' to save the referral without searching the registry."
            Dim customMsgBox = New FrmCustomMessageBox(prompt, "Search Again", "Save")

            'Prompt the user to either search again or proceed with saving
            If customMsgBox.ShowDialog() = DialogResult.Yes Then
                Await TrySearchDonor(forceNewSearch:=True)
                Exit Sub
            End If

        End If

        'ccarroll 06/06/2007 StatTrac release 8.4 requirement 3.6 - TBI Number
        If Me.TBIUpdateFlag = True Then
            'Information has changed. Update TBI Comment
            Try
                Call modStatSave.UpdateSecondaryTBI(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try

            'Create(LogEvent)
            Try
                Call modStatSave.SaveLogEvent(Me, GENERAL, Me.TBINoteText)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try

            Me.TBIUpdateFlag = False
        End If

        'ccarroll 09/12/2011 - CCRST151
        If Me.FormState = EXISTING_RECORD And DeclaredCTODUpdateFlag Then
            'Create Log event
            Try
                Call modStatSave.SaveLogEvent(Me, DECLARED_CTOD_PENDING, String.Empty)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try
            ' reset CTOD update flag 
            DeclaredCTODUpdateFlag = False
        End If

        'ccarroll 07/18/2014 - CCRST175
        ' Only create event on the initial referral
        If Me.FormState <> EXISTING_RECORD And OrganMedROUpdateFlag Then
            ' Create Log event
            Try
                Call modStatSave.SaveLogEvent(Me, ORGAN_MED_RO_PENDING, String.Empty)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try
            ' Reset Organ Med RO update flag 
            OrganMedROUpdateFlag = False
        End If

        If AppMain.ParentForm.LeaseOrganization = 0 Then 'T.T 11/13/2006 fake save only for statline not asp clients
            If Me.CallerOrg.ServiceLevel.DisableASPSave = -1 Then 'T.T 11/13/2006 fake save must be enabled in service level

                'If QA review checkbox is checked then update referral flag for QA review complete
                'ccarroll 10/17/2007 moved QA review to fakeSave area
                If Me.ChkQAReview.Visible = True And Me.ChkQAReview.CheckState = 1 Then
                    vQAResetSwitch = 0 'initialize QA reset switch this will prohibit referral from showing under Update Tab
                    Try
                        Call modStatSave.UpdateReferralQAComplete(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                        Throw New BaseException("Failed to Save Data", True)
                    End Try
                    'Enter QA Note for completed review
                    NoteText = "Triage QA Review Completed by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                    Try
                        Call modStatSave.SaveLogEvent(Me, 25, NoteText)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                        Throw New BaseException("Failed to Save Data", True)
                    End Try
                End If


                If Me.FormState = EXISTING_RECORD Then 'T.T 11/13/2006 fake save can only work on existing referral not new one
                    Try
                        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowASPSave") = False Then 'T.T 11/13/2006 some people are given  ability to save for asp clients
                            Call FakeSave()
                            'bret 6/10/07 8.4.3.8 moved call to work to top of method
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                        Throw New BaseException("Failed to Save Data", True)
                    End Try
                End If
            End If
        End If

        If Interrupt = 1 And Me.cmdDonorIntent.Enabled = False And DrdsnCount = 2 And WSCount = 1 Then

            vReturn = CShort(modControl.cbofill((Me.cboRegistryStatus), "State", True, True))

        End If

        For j = ORGAN To RESEARCH
            If System.Drawing.ColorTranslator.ToOle(Me.CboAppropriate(j).BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
                MsgBox("Please fill out the Appropriate Fields", MsgBoxStyle.Exclamation, "System Message")
                'bret 6/10/07 8.4.3.8 moved call to work to top of method
                Call modUtility.Done()
                Exit Sub
            End If
        Next j
        If System.Drawing.ColorTranslator.ToOle(Me.CboPhysician(0).BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
            MsgBox("Please fill out the Physician fields", MsgBoxStyle.Exclamation, "System Message")
            'bret 6/10/07 8.4.3.8 moved call to work to top of method
            Call modUtility.Done()
            Exit Sub
        End If
        If System.Drawing.ColorTranslator.ToOle(Me.CboPhysician(1).BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
            MsgBox("Please fill out the Physician fields", MsgBoxStyle.Information, "System Message")
            'bret 6/10/07 8.4.3.8 moved call to work to top of method
            Call modUtility.Done()
            Exit Sub
        End If

        If System.Drawing.ColorTranslator.ToOle(Me.CboApproachedBy.BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
            MsgBox("Please fill out the Approacher field", MsgBoxStyle.Information, "System Message")
            'bret 6/10/07 8.4.3.8 moved call to work to top of method
            Call modUtility.Done()
            Exit Sub
        End If
        If System.Drawing.ColorTranslator.ToOle(Me.CboApproachType.BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
            MsgBox("Please fill out the Method of Approach fields", MsgBoxStyle.Information, "System Message")
            'bret 6/10/07 8.4.3.8 moved call to work to top of method
            Call modUtility.Done()
            Exit Sub
        End If


        'Validate gender if it's enabled
        If CallerOrg.ServiceLevel.Gender = True Then
            If (CboGender.SelectedIndex = -1) Then
                vReturn = modMsgForm.FormValidate("Gender")
                Call modUtility.Done()
                Exit Sub
            End If
        End If

        '02/013/03 drh - Added date validation
        If DateValidate() Then

            'Make sure the user wants to save
            vReturn = modMsgForm.FormSave

            If vReturn = MsgBoxResult.Cancel Then
                Call modUtility.Done()
                Exit Sub
            End If

            '01/07/04 mds: confirm CboHeartBeatChanged was changed.
            '1/12/04 mds: changed to "Heart" from "Heart Beat" to match the label name

            If CallerOrg.ServiceLevel.HeartBeat = True Then
                If CboHeartBeatChanged = False Then
                    vReturn = modMsgForm.FormValidate("Heart")
                    Call modUtility.Done()
                    Exit Sub
                End If
            End If

            '01/08/04 mds:
            'do not allow the referral to be saved if heartbeat=NO and vent=CURRENTLY
            If (modControl.GetID(CboHeartBeat) = HEART_BEAT_NO And modControl.GetID(CboVent) = VENT_CURRENT) Then
                vReturn = modMsgForm.InvalidHeartBeatVentCombo
                Call modUtility.Done()
                Exit Sub
            End If


            '02/18/2002 bjk: confirm CboVentChanged was changed.
            '01/14/04 mds: changed from "On Vent" to "Vent" since the label name changed
            If CboVent.Enabled Then
                If CboVentChanged = False Then
                    vReturn = modMsgForm.FormValidate("Vent")
                    Call modUtility.Done()
                    Exit Sub
                End If
            End If

            'Validate the data
            'FSProj 7/25/02 drh - Added Me.chkCaseOpen = vbUnchecked so it only validates if not a Secondary (See Issue #91 - FS Bug List)
            If ChkTemp.CheckState = System.Windows.Forms.CheckState.Unchecked And Me.chkCaseOpen.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                If Not modStatValidate.ValidateReferral(Me) Then
                    Call modUtility.Done()
                    Exit Sub
                End If
            Else

                If Me.LblOrganization.Text = "" Then
                    Call modMsgForm.FormValidate("Location", Me.LblOrganization)
                    Call modUtility.Done()
                    Exit Sub
                End If
            End If

            'Do referral type save
            Call modStatValidate.ReferralTypeDefault(Me)

            'THE SAVED VALUES MUST BE SET BEFORE CALL IS SAVED
            Me.Saved = True

            '06/09/07 bret 8.4.3.8 set CallOpenbyID
            Me.CallOpenByID = -1
            Try
                Call modStatSave.SaveCall(Me, Me.CallId)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try
            If vReturnSC = -1 Then 'clicked no on savecall msgbox
                Me.Saved = False
                Me.Close()
                Exit Sub
            ElseIf vReturnSC = 2 Then  'clicked cancel on savecall msgbox
                Call modUtility.Done()
                Exit Sub
            End If


            If Me.RecycledNC = True Then
                Me.RecycledNC = False
                Me.Cancel = False
            End If

            'Save the referral
            'Save NOK information if NOKID then new NOK functionality
            If ModNOK = True Or AddNOK = True Then
                Try
                    Call modStatSave.SaveNOK(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                    Throw New BaseException("Failed to Save Data", True)
                End Try
            End If


            'ccarroll 10/19/07 - event has hit QA, reset the switch
            If Me.ChkQAReview.CheckState = 1 And vQAResetSwitch > 0 Then
                vQAResetSwitch = 0
            End If

            Try
                vReferralID = modStatSave.SaveReferral(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try


            If vReferralID = SQL_ERROR Then
                'Log a detailed message when an attempt to save a referral fails
                Err.Description = "No referralid on callid lookup"
                LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err, "(saving a referral) - callid: " & Me.CallId)
            End If

            'FSProj drh 5/01/02 - Save Triage Criteria and Service Level ID's
            Try
                Call modStatSave.SaveReferralTriageCriteria(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try

            Try
                Call ReferralCall.SaveCustom()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw New BaseException("Failed to Save Data", True)
            End Try

            If CallerOrg.ServiceLevel.SecondaryOn = True Then
                If vReferralID > 0 Then
                    ReferralSecondary.ID = vReferralID
                End If
                ReferralSecondary.SecondaryNote = TxtSecondaryNote.Text
                ReferralSecondary.SaveData()
            End If


            'bret 6/14/07 8.4.3.9 logevent order
            'Default the incoming call event
            'Call modStatSave.SaveLogEvent(Me)

            vRegistration = Me.RegistryLogEvent()

            'Save the Lease Org Call
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                Call modStatSave.SaveLOCall(Me)
            End If

            Call modUtility.Done()

            Me.Close()

        Else
            Call modUtility.Done()
        End If

        Exit Sub
    End Sub
    Private Sub CmdOption_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CmdOption_1.Click, _CmdOption_2.Click, _CmdOption_3.Click, _CmdOption_4.Click, _CmdOption_5.Click, _CmdOption_6.Click, _CmdOption_7.Click

        Dim Index As Short = modControl.GetHasTableKey(CmdOption, eventSender)
        frmCriteria = New FrmCriteria()
        frmCriteria.SourceCode = Me.SourceCode

        'Set the referral organization id
        frmCriteria.ReferralOrganizationID = Me.OrganizationId

        'Set the donor category id
        Select Case Index

            Case ORGAN
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Organ"

            Case BONE
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Bone"

            Case TISSUE
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Soft Tissue"

            Case SKIN
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Skin"

            Case VALVES
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Valves"

            Case EYES
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Eyes"

            Case RESEARCH
                frmCriteria.DonorCategoryID = Index
                frmCriteria.DonorCategoryName = "Other"

        End Select

        'FSProj drh 4/29/02 - Set CriteriaStatus so we can get the correct Historical Criteria Type (CriteriaStatus)
        '*************************************************************************************
        Dim vCriteriaStatus As Short
        If Me.HistoricalReferral Then
            vCriteriaStatus = ORIGINAL_CRITERIA
        Else
            vCriteriaStatus = CURRENT_CRITERIA

            'If we have a valid Criteria set, use the Criteria Id
            If Me.FormState = EXISTING_RECORD And Me.CriteriaValid Then
                frmCriteria.CriteriaGroupID = Me.ReferralTriageCriteria.Item(CStr(Index))
            End If
        End If

        frmCriteria.CriteriaStatusID = vCriteriaStatus
        '*************************************************************************************

        frmCriteria.CmdOK.Visible = False
        frmCriteria.Saved = True
        frmCriteria.CmdCancel.Text = "&Close"
        frmCriteria.TabCriteria.TabPages.RemoveAt(4)
        frmCriteria.TabCriteria.TabPages.RemoveAt(2)
        frmCriteria.TabCriteria.TabPages.RemoveAt(1)
        Me.SendToBack()
        frmCriteria.Display()

    End Sub

    Private Sub cmdPhysicianDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CmdPhysicianDetail_0.Click, _CmdPhysicianDetail_1.Click
        Dim Index As Short = Array.IndexOf(CmdPhysicianDetail, eventSender)

        Dim vReturn As New Object
        Dim vPersonID As Integer

        If uIMap Is Nothing Then
            Try
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        If Index = 0 Then
            'Determine the form state which to open the
            'Person form.
            If modControl.GetID(CboPhysician(0)) = -1 Then
                vPersonID = 0
                'Set the default organization to the selected location
                GeneralConstant.CreateInstance().OrganizationId = Me.OrganizationId
            Else
                vPersonID = modControl.GetID(CboPhysician(0))
            End If
        Else
            'Determine the form state which to open the
            'Person form.
            If modControl.GetID(CboPhysician(1)) = -1 Then
                vPersonID = 0
                'Set the default organization to the selected location
                GeneralConstant.CreateInstance().OrganizationId = Me.OrganizationId
            Else
                vPersonID = modControl.GetID(CboPhysician(1))
            End If
        End If


        If Index = 0 Then
            'Get the Person id from the Person form
            'after the user is done.
            Try
                Me.AttendingMDID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Me.AttendingMDID = 0 Then
                'The user cancelled adding a new Person
                'so do nothing
            Else
                'Refill the combo boxes with the new (or updated) names
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.SelectID(CboPhysician(0), Me.AttendingMDID)
                Call modControl.SelectID(CboPhysician(1), Me.PronouncingMDID)
            End If
        Else
            'Get the Person id from the Person form
            'after the user is done.
            Try
                Me.PronouncingMDID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Me.PronouncingMDID = 0 Then
                'The user cancelled adding a new Person
                'so do nothing
            Else
                'Refill the combo boxes with the new (or updated) names
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.SelectID(CboPhysician(0), Me.AttendingMDID)
                Call modControl.SelectID(CboPhysician(1), Me.PronouncingMDID)
            End If
        End If

    End Sub

    Private Sub CmdPhysicianPhone_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles _CmdPhysicianPhone_0.Click, _CmdPhysicianPhone_1.Click
        Dim Index As Short = Array.IndexOf(CmdPhysicianPhone, eventSender)
        Dim vResult() As String
        Dim vPersonID As Integer
        Dim vReturn As New Object

        'The form state should always be existing since you will have MD ID.

        If Index = 0 Then
            vPersonID = AttendingMDID
        Else
            vPersonID = PronouncingMDID
        End If

        'Get the organization id from the organization form
        'after the user is done.
        Me.MDPhone = True

        'Set the default organization to the selected location
        If (vPersonID = 0) Then
            GeneralConstant.CreateInstance().OrganizationId = Me.OrganizationId
        End If

        'Get the Person id from the Person form
        'after the user is done.

        If Index = 0 Then
            Try
                Me.AttendingMDID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            Try
                Me.PronouncingMDID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        'Reset flag
        Me.MDPhone = False


    End Sub

    Private Sub CmdReferral_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReferral.Click
        '************************************************************************************
        'Name: CmdReferral_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmOnCallEvent, along with associated variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 11/30/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added filling of variables to store email text and subject
        '====================================================================================
        '************************************************************************************
        Dim vEventTypeList(13) As Object

        frmOnCallEvent = New FrmOnCallEvent()
        'Set the call id & number of the form
        frmOnCallEvent.CallId = Me.CallId
        frmOnCallEvent.CallNumber = Me.CallNumber
        frmOnCallEvent.CurrentDate = Today
        frmOnCallEvent.DefaultContactType = PAGE_PENDING
        frmOnCallEvent.ReferralOrganizationID = Me.OrganizationId


        'Set event types
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = GENERAL
        vEventTypeList(3) = CONSENT_PENDING
        vEventTypeList(4) = RECOVERY_PENDING
        vEventTypeList(5) = PAGE_PENDING
        vEventTypeList(6) = CONSENT_RESPONSE
        vEventTypeList(7) = RECOVERY_RESPONSE
        vEventTypeList(8) = CALLBACK_PENDING
        'Added: 05/23/01 tw
        vEventTypeList(9) = SECONDARY_PENDING
        'Added for ver. 7.7.2.  12/13/2004 - SAP
        vEventTypeList(10) = EMAIL_PENDING

        vEventTypeList(11) = CASE_HAND_OFF
        vEventTypeList(12) = EMAIL_SENT
        vEventTypeList(13) = PAGE_SENT

        frmOnCallEvent.SourceCode = Me.SourceCode
        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        frmOnCallEvent.OnCallType = REFERRAL
        'Char Chaput 04/28/06 modify .Text to TextRTF so that rich text will display
        modControl.SetRTFText(frmOnCallEvent.TxtAlert, Me.ScheduleAlert)
        frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)
        frmOnCallEvent.AutoResponseMsg = modStatValidate.SetRefAutoResponse(Me) 'mjd 05/28/2002 Page-AutoResponse
        frmOnCallEvent.AutoResponseSbj = modStatValidate.SetRefAutoResponseSbj(Me) 'mjd 05/28/2002 Page-AutoResponse

        'Added ability to send Referral info in email.  11/30/04 - SAP
        frmOnCallEvent.EmailMsg = modStatValidate.SetRefEmail(Me)
        frmOnCallEvent.EmailSbj = modStatValidate.SetRefEmailSbj(Me)

        '10/8/01 drh
        frmOnCallEvent.vParentForm = Me

        'Show the referral form
        Me.SendToBack()
        Call frmOnCallEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Check for pending contacts
        Try
            Call modStatValidate.ValidateReferralContacts(Me, False)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub


    Public Sub Cmdregkill_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Cmdregkill.Click
        'MsgBox "TimerRegKill"
        'Me.CmdRegMatch_Click
        Me.TimerReg.Enabled = False
    End Sub

    Private Sub CmdVerify_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdVerify.Click

        Select Case CallerOrg.ServiceLevel.TriageLevel

            Case VENT_ONLY
                Call modStatValidate.VerifyReferral(Me, True, False, False, True)

            Case AGE_ONLY
                Call modStatValidate.VerifyReferral(Me, False, True, False, True)

            Case VENT_AGE_ONLY
                Call modStatValidate.VerifyReferral(Me, True, True, False, True)

            Case VENT_AGE_MRO
                Call modStatValidate.VerifyReferral(Me, True, True, True, True)

        End Select

        '10/2/01 drh
        'Call ValidateForDonorIntent

    End Sub

    Private Sub Command2_Click()
        Me.Interrupt = 1
    End Sub

    Private Sub FrmReferral_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        Dim I As Short
        Dim vAge As Single
        Dim vCheckRegistry As CheckRegistryMode

        'ccarroll 04/22/2010 Set text button color to red on load
        Me.CmdRegMatch.ForeColor = Color.Red

        If Me.FormLoad = True Then



            'FSProj drh 5/3/02 - Get Criteria and ServiceLevelId's
            Try
                Call modStatQuery.QueryReferralTriageCriteria(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            'Get the referral record
            If Me.RecycledNC = True Then
                Me.ChkTemp.CheckState = System.Windows.Forms.CheckState.Checked
                Me.ChkExclusive.CheckState = System.Windows.Forms.CheckState.Checked
                'Call modStatSave.SaveCall(Me, Me.CallId)
            End If

            If Me.RecycledNC = True Then
                If Me.RecycledNCType = 1 Then
                    Try
                        Call modStatQuery.QueryRecycledNC(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                Else
                    Try
                        Call modStatQuery.QueryReferral(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            Else
                If Me.RecycledNCType = 3 Then
                    Try
                        Call modStatQuery.QueryRecycledNC(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                Else
                    Try
                        Call modStatQuery.QueryReferral(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If

            'Get the time zone of the organization
            Try
                Call modStatQuery.QueryOrganizationTimeZone(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Me.CboHeartBeat.Text = "" Then

                'Set default value of Yes for CboHeartBeat
                Call modControl.SelectID((Me.CboHeartBeat), 1)
                If CallerOrg.ServiceLevel.HeartBeat = True Then
                    CboHeartBeat.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                End If

                'Set default value CBOVent
                If Me.CboVent.Text = "" Then
                    Me.CboVent.Text = "Currently"
                    'Set CboVentChanged to false for new referrals
                    CboVentChanged = False
                    If CallerOrg.ServiceLevel.Vent = True Then
                        CboVent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                    End If
                End If
                'Me.TabDisposition.TabVisible(DISPOSITION_TAB) = False
                Me.cboRegistryStatus.Visible = True
                Me.RegStatus.Visible = True

            End If


            'Get NOK information if NOKID > 0
            If NOKID <> 0 Then
                Try
                    Call modStatQuery.QueryNOK(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

            'Using the organizationID selected update the Donor Categories
            Try
                Call ChangeDonorCategory((Me.OrganizationId), (Me.SourceCode.Name))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


            '02/19/2002 bjk: add patients name to top of Referral Form
            If Me.TxtDonorLastName.Text <> "" And Me.TxtDonorFirstName.Text <> "" Then
                UpdateFormCaption()
            End If

            '10/12/01 drh Moved this below "For i = ORGAN To RESEARCH" line; will leave it until regression testing complete
            'Me.FormLoad = False

            Try
                Call modStatQuery.QueryOrganizationAlert(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


            For I = ORGAN To RESEARCH
                Call CboAppropriate_SelectedIndexChanged(CboAppropriate(I), New System.EventArgs())
                Call CboApproach_SelectedIndexChanged(CboApproach(I), New System.EventArgs())
                Call CboConsent_SelectedIndexChanged(CboConsent(I), New System.EventArgs())
            Next I

            'Initialize DCD Potential Field & DDL
            bolDCDPotentialSelected = False
            'Set default value only if we didn't get a valid one from the db
            If String.IsNullOrEmpty(cboDCDPotential.Text) Then
                Dim organApproachRecoveryValues() As String = {"never brain dead", "did not die"}
                If (CboHeartBeat.Text.ToLower().Equals("yes") _
                    And CboVent.Text.ToLower().Equals("currently") _
                    And _CboAppropriate_1.Text.ToLower().Equals("yes") _
                    And (organApproachRecoveryValues.Contains(_CboApproach_1.Text.ToLower()) _
                        Or (_CboApproach_1.Text.ToLower().Equals("yes") _
                            And organApproachRecoveryValues.Contains(_CboRecovery_1.Text.ToLower())))) Then
                    cboDCDPotential.Text = "Yes"
                Else
                    cboDCDPotential.Text = "No"
                End If
            End If

            'Show PossibleDCDCase Warning If Needed
            If CallerOrg.ServiceLevel.DCDPotentialMessageEnabled And cboDCDPotential.Text.Equals("Yes") And frmPossibleDCDCase Is Nothing Then
                frmPossibleDCDCase = New FrmPossibleDCDCase()
                frmPossibleDCDCase.modalParent = Me
                Dim dialogResult As DialogResult = frmPossibleDCDCase.ShowDialog() 'Show modal
            End If

            '10/12/01 drh Moved this from above so we can do Registry checks only after form is loaded
            Me.FormLoad = False

            If Me.CallerOrg.ServiceLevel.ApproachMethod Then
                TabDisposition.SelectedIndex = 0
                Call CboApproachType_SelectedIndexChanged(CboApproachType, New System.EventArgs())
            End If

            'Kick off the pending contacts routine
            Call modStatValidate.ValidateReferralContacts(Me, False)

            'Validate the age/weight activation
            Call Check_ServiceLevel_Weight()
            '9/28/01 drh
            vCheckRegistry = CallerOrg.ServiceLevel.CheckRegistryMode

            Me.CmdCancel.Focus()

            '9/28/01 drh
        Else
            '9/28/01 drh CheckRegistry is NoRegistry by default
            vCheckRegistry = CheckRegistryMode.NoRegistry
        End If

        '9/28/01 drh
        If vCheckRegistry = CheckRegistryMode.DonorIntent Then
            'Check if it's a new Referral
            If Me.FormState = NEW_RECORD Then
                'If Donor Intent is "ON", disable NOK and Save
                Call SetNOKComponents("Disable")
                'By default, Donor Intent is "OFF"
                cmdDonorIntent.Enabled = False
            ElseIf (Me.DonorSearchState.HasDonor) And
                    Me.VerifyAppropriateForDonorIntent Then
                If Me.DonorIntentDone = -1 Then
                    EnableDonorIntent(Color.Blue)
                Else
                    EnableDonorIntent()
                End If
                'ccarroll 06/17/2010 - this is already being fired when form loads
                'Call cboRegistryStatus_SelectedIndexChanged(cboRegistryStatus, New System.EventArgs())
            End If
        End If

        ChkDOA.BackColor = System.Drawing.SystemColors.Control

        '10/15/01 drh
        If Me.VerifyAppropriateForDonorIntent Then
            Me.DonorAppropriate = True
        Else
            Me.DonorAppropriate = False
        End If

        Me.AttendingMDID = modControl.GetID(CboPhysician(0))
        If Me.AttendingMDID = -1 Or Me.AttendingMDID = 0 Then
            Me.CmdPhysicianPhone(0).Enabled = False
        End If

        Me.PronouncingMDID = modControl.GetID(CboPhysician(1))
        If Me.PronouncingMDID = -1 Or Me.PronouncingMDID = 0 Then
            Me.CmdPhysicianPhone(1).Enabled = False
        End If


        'ccarroll 06/08/2007 StatTrac 8.4 release requirement 3.6
        'ccarroll 07/06/2007 added check for two users in case
        If Me.CmdOK.Enabled = True Then
            'Get Secondary TBI ServiceLevel and set TBIAccess
            Try
                Call modStatQuery.QuerySecondaryTBIAccess(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            TBIAccess = False
        End If


        'ccarroll 09/08/2011 - PNE - CCRST151
        GetPNEWarningOnSave()

        'ccarroll 11/1/2011 - HS 29072, 29553
        'vOpenEventLog is set opening referral from OpenStatTracVBForms OpenEventLog
        'Moved event log tab open to end of form activate
        If vOpenEventLog Then
            Me.TabDonor.SelectedIndex = AppMain.frmReferral.TabDonor.TabPages.Count - 1

            'reset flag
            vOpenEventLog = False
        End If

        'Char Chaput 5/03/06 so that the screen caption would display patient name properly
        'See updateformcaption function
        UpdateFormCaption()

        DisableAgeFieldsAsNeeded()

    End Sub
    Private Sub FrmReferral_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        'BJK 1/15/01 add bitwise check. Code was a simple if Shift = 1 (1 is the value for vbShiftMask, which is the shift key)
        ' The code checks to see if vbShiftMask (1) exists in Shift
        If (Shift And VB6.ShiftConstants.ShiftMask) = VB6.ShiftConstants.ShiftMask Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

        Select Case KeyCode

            Case System.Windows.Forms.Keys.F1
                If TabDonor.TabPages.IndexOf(tabDonorTable(0)) > -1 Then
                    TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(0))
                End If
                TabDisposition.Focus()
            Case System.Windows.Forms.Keys.F2
                If TabDonor.TabPages.IndexOf(tabDonorTable(1)) > -1 Then
                    TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(1))
                End If
                LstViewPending.Focus()
            Case System.Windows.Forms.Keys.F3
                If TabDonor.TabPages.IndexOf(tabDonorTable(2)) > -1 Then
                    TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(2))
                End If
                TxtSecondaryNote.Focus()

        End Select

    End Sub


    Private Sub FrmReferral_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift > 0 Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

    End Sub



    Private Sub FrmReferral_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmReferral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/10/2005                        Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Set top of form to load in a visible area
        '====================================================================================
        '************************************************************************************
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time along with
        'set callopenbyid equal to person in this instance of stattrac when the form is loaded
        '====================================================================================
        'Date Changed: 4/25/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Mods for release 8.0 and added code in multiple places for autosave from New Call
        'screen to Referral screen and in Referral screen
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/13/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9 Deleted logevent, Logevent number
        'Description:  Change size and order of logevent columns
        '
        '====================================================================================
        '************************************************************************************

        CheckWorkstationMemory()

        Me.AlertType = REFERRAL

        Dim I As Short
        Dim ResultsArray As New Object
        Dim AppropriateList As New Object
        Dim ApproachList As New Object
        Dim ConsentList As New Object
        Dim RecoveryList As New Object
        Dim vPersonID As New Object

        'bret 02/17/2010 add for control array fix
        Initialize_DisopositionControls()
        Initialize_CboPhysician()
        Initialize_StaticLists()
        Initialize_ControlArrays()
        Initialize_DispositionTabTable()
        Initialize_TabDonorTable()
        'Me.FormBorderStyle = 1
        Me.CboHeartBeat.Focus()

        Dim vReturn3 As Object

        Dim AllowQA As New Object

        AppMain.frmOpenAll.TypeEvent = 1 'T.T 11/01/2004 added to know what event referral or message

        'Set the call type
        Me.CallType = REFERRAL
        Me.Saved = False
        Me.FormLoad = False

        'ccarroll 11/14/2006 - moved Initialize the combo boxes to end of Form Load

        Try
            Call modStatRefQuery.ListRefQueryCauseOfDeath(CboCauseOfDeath)
            Call modStatRefQuery.ListRefQueryRace(CboRace)
            Call modStatRefQuery.ListRefQueryReferralType(CboReferralType)
            Call modStatRefQuery.ListRefQueryApproachType(CboApproachType)
            Call modStatRefQuery.ListRefQueryStatEmployee(CboCallByEmployee)
            Call modStatRefQuery.ListRefQueryStatEmployeeActiveOnly(CboPendingCaseCoordinator)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If Me.FormState = NEW_RECORD Then

            'Initialize the call date
            '12/19/01 bjk added DateAdd, adjusts the callDate
            '04/12/02 bjk do not need to adjust time
            'Me.CallDate = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
            Me.CallDate = VB6.Format(Now, "mm/dd/yy  hh:mm")
            TxtCallDate.Text = Me.CallDate
            vOriginalSC = Me.SourceCode.ID

            'Initialize the call by and pending case coordinator
            Call modControl.SelectID(CboCallByEmployee, AppMain.ParentForm.StatEmployeeID)
            Call modControl.SelectID(CboPendingCaseCoordinator, AppMain.ParentForm.StatEmployeeID)

            'Initialize the total call time
            'Me.CallTotalTime = Format(0, "hh:mm:ss")
            Me.TimeSnapshot = Now  'change this to Now to represnt date and time instead of just time TimeOfDay
            'Me.CallNumber = Me.CallId
            'For a new record set the callopenby id to person in statrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID
            Try
                Call modStatSave.SaveCall(Me, Me.CallId)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'bret 06/08/07 remove second call to save 8.4.3.8 AuditTrail
            'Call modStatSave.SaveCallOpenBy(Me)

            Me.ReferralCall.ID = Me.CallId

            'Set the contact information
            Me.LblOrganization.Text = Me.OrganizationName
            Me.LblSubLocation.Text = Me.SubLocation
            Me.LblLevel.Text = Me.SubLocationLevel
            Me.LblName.Text = Me.Person
            Me.LblPersonType.Text = Me.PersonType
            Me.LblPhone.Text = Me.CallPhoneNumber
            Me.LblExtension.Text = Me.CallPhoneExtension

            '01/06/04 mds set default value of Yes for CboHeartBeat
            Call modControl.SelectID((Me.CboHeartBeat), 1)
            '1/12/04 mds Call function to set status and backcolor
            Call SetHeartBeatColor()

            '02/18/2002 bjk: Set default value CBOVent
            'If CboVent.Enabled = True Then
            Me.CboVent.Text = "Currently"

            '02/18/2002 bjk: set CboVentChanged to false for new referrals
            CboVentChanged = False

            If CboVent.Enabled = True Then
                CboVent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
            End If

            'Char Chaput 05/27/05 Moved original ogranizationclick functionality
            'into the following function
            CallerOrg.ID = Me.OrganizationId

            'First set the service level
            Call Me.SetServiceLevel(Me)
            'Now Set Organization
            Call Me.SetOrganization()


            'BRET 4/2010 Removed code that was reduntantly removed  and set the dispositiontab index

            'ccarroll 060706
            Me.ChkQAReview.Enabled = False
            Me.ChkQAReview.Visible = False
            Me.ChkQAReview.CheckState = System.Windows.Forms.CheckState.Unchecked

            'bret 6/14/07 8.4.3.9 create incoming logevent before user can
            'Default the incoming call event
            'Call modStatSave.SaveLogEvent(Me)

        ElseIf Me.FormState = EXISTING_RECORD Then
            'T.T 04/25/2007 added to enable CmdRegMatch
            'Me.CmdRegMatch.Visible = True

            'T.T 10/11/2004 added to set holdstate for data erasing
            HoldCount = HoldCount + 2

            '11/16/05 C.Chaput set callopenbyid equal to person in this instance of stattrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID

            'ccarroll 02/25/2011 - Permanently hide the QA Review Complete checkbox (10615)
            Me.ChkQAReview.Enabled = False
            Me.ChkQAReview.Visible = False

            '01/05/05 check to see if is exclusive, fscase or pending
            Try
                Call modStatQuery.QueryCallAccess(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Get the call record
            'the querycall function also calls savecallopenby to set person in stattrac
            Try
                Call modStatQuery.QueryCall(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Get LO Call Information
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                Try
                    Call modStatQuery.QueryLOCall(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

            ReferralCall.ID = Me.CallId
            'Get the current call custom field data
            Try
                Call ReferralCall.GetCustom()
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Set the call date
            TxtCallDate.Text = Me.CallDate

            'FSProj drh 5/1/02 - Check whether this is a historical referral
            If CDate(Me.CallDate) < CDate(HISTORICAL_CUTOFF) Then
                Me.HistoricalReferral = True
            End If

            'Get the referral record in form activate
            Me.FormLoad = True

            'Enable the referral command button
            Me.VerifiedOptions = True

            '02/18/2002 bjk: set CboVentChange to true for existing referrals
            CboVentChanged = True

            '01/12/04 mds: set CboHeartBeatChange to true for existing referrals
            CboHeartBeatChanged = True

            '09/16/03 drh - Set timer to 30 seconds for existing Referral
            'VP_Timer.Interval = 30000

            '01/08/04 mds - Flag to avoid executing CboHeartBeat_Click on Load of existing referrals
            ExecuteClick = False
            Me.TabDonor.TabIndex = vTabIndex
            Me.TabDonor_SelectedIndexChanged(eventSender, eventArgs)


        End If

        Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name

        'Initialize the combo boxes
        Try
            Call modStatRefQuery.RefQueryAppropriate(AppropriateList)
            Call modStatRefQuery.RefQueryApproach(ApproachList)
            Call modStatRefQuery.RefQueryConsent(ConsentList)
            Call modStatRefQuery.RefQueryConversion(RecoveryList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        For I = ORGAN To RESEARCH
            Call modControl.SetTextID(CboAppropriate(I), AppropriateList)
            Call modControl.SetTextID(CboApproach(I), ApproachList)
            Call modControl.SetTextID(CboConsent(I), ConsentList)
            Call modControl.SetTextID(CboRecovery(I), RecoveryList)
        Next I


        If Me.CboPhysician(0).Text = "" Then
            Me.CmdPhysicianPhone(0).Enabled = False
        End If

        If Me.CboPhysician(1).Text = "" Then
            Me.CmdPhysicianPhone(1).Enabled = False
        End If

        'Log Event Info
        'Initialize the grid
        Call modControl.HighlightListViewRow(LstViewLogEvent)
        Call LstViewLogEvent.Columns.Insert(0, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1400)))
        Call LstViewLogEvent.Columns.Insert(1, "", "Event Type", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewLogEvent.Columns.Insert(2, "", "From/To", CInt(VB6.TwipsToPixelsX(1600)))
        Call LstViewLogEvent.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(3000)))
        Call LstViewLogEvent.Columns.Insert(4, "", "By", CInt(VB6.TwipsToPixelsX(1800)))
        Call LstViewLogEvent.Columns.Insert(5, "", "Description", CInt(VB6.TwipsToPixelsX(4500)))
        Call LstViewLogEvent.Columns.Insert(6, "", "#", CInt(VB6.TwipsToPixelsX(500)))


        'Pending Event Info
        'Initialize the grid
        Call modControl.HighlightListViewRow(LstViewPending)
        Call LstViewPending.Columns.Insert(0, "", "Type", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewPending.Columns.Insert(1, "", "Organization", CInt(VB6.TwipsToPixelsX(6500)))


        'Initialize the verify grid
        Call modControl.HighlightListViewRow(LstViewVerify)
        Call LstViewVerify.Columns.Insert(0, "", "Option", 70)
        Call LstViewVerify.Columns.Insert(1, "", "Criteria", 120)
        Call LstViewVerify.Columns.Insert(2, "", "Note", 0)
        LstViewVerify.CheckBoxes = False

        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowDeleteLogEvent") Then
            Me.CmdDelete.Visible = True
        Else
            Me.CmdDelete.Visible = False
        End If

        'bret 6/11/07 8.4.3.9 LogEventDeleted
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowViewDeletedLogEvents") Then
            Me.chkViewLogEventDeleted.Visible = True
        Else
            Me.chkViewLogEventDeleted.Visible = False
        End If

        If CmdOK.Enabled = False Then
            TimerTotalTime.Enabled = False
        End If

        'Me.TabDisposition.TabPages.RemoveAt(WEBSERVICE_TAB) 'T.T 09/22/2005  Webservice tab
        ChkDOA.BackColor = System.Drawing.SystemColors.Control

        'deactivate option for referraltype
        CboReferralType.Enabled = False

        PopulateCtod()

        If CallerOrg.ServiceLevel.ApproachLevel = 0 Then
            If Not TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                Me.TabDisposition.TabPages.Add(tabDispositionTable(DISPOSITION_TAB))
            End If

        ElseIf CallerOrg.ServiceLevel.ApproachLevel = 2 And Me.DispositionFieldEnabled = True Then
            If Not TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                Me.TabDisposition.TabPages.Add(tabDispositionTable(DISPOSITION_TAB))
            End If
        Else
            If TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                Me.TabDisposition.TabPages.RemoveAt(TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)))
            End If
        End If
        'bret 4/2010 set the disposition Results tab active
        If TabDisposition.TabPages.IndexOf(tabDispositionTable(RESULTS_TAB)) > -1 Then
            Me.TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(RESULTS_TAB))
        End If

    End Sub

    Private Sub PopulateCtod()
        'Check the current time (using server time in MT) to make sure we're between 02:00 and 22:00 -
        ' when ctod date determination is considered safe
        Dim isDateDeterminationSafe As Boolean = DateTime.Now.Hour >= 2 And DateTime.Now.Hour < 22
        If isDateDeterminationSafe And TxtDeathDate.Text = "" Then
            'Load TxtDeathDate (ctod) with the current date adjusted for time zone of the selected referral facility
            TxtDeathDate.Text = VB6.Format(CDate(modConv.DateToOrganizationDate((Me.OrganizationTimeZone))), "mm/dd/yy")
        End If
    End Sub

    Private Sub CheckWorkstationMemory()

        'Determine memory parameters
        Dim minimumAvailableMemoryInKb As Single = Single.Parse(ConfigurationSettings.AppSettings("MinimumAvailableMemoryInKb"))
        Dim actualAvailableMemoryInKb As Single 'defaults to a value of 0     
        If GeneralConstant.CreateInstance().IsPerformanceCounterCounterAvailable Then
            actualAvailableMemoryInKb = New PerformanceCounter("Memory", "Available MBytes").NextValue() * 1000
        End If

        'Log memory info
        Dim infoMessage As String = "StatTrac Workstation Memory Information: Computer " + Environment.MachineName +
                                    " had " + actualAvailableMemoryInKb.ToString("#,##0") +
                                    " kb of available memory - seen when user: " + UserID +
                                    " opened the referral screen on " + Now.ToShortDateString() +
                                    " @ " + Now.ToShortTimeString() + "."
        Try
            StatTracLogger.CreateInstance().Write(New Exception(infoMessage), TraceEventType.Information)
        Catch ex As Exception
            'Swallow error
        End Try

        'Check to see if we have enough available memory
        If actualAvailableMemoryInKb < minimumAvailableMemoryInKb Then

            'We have a problem, log a low memory warning
            Dim exMessage As String = "StatTrac Low Memory Warning: Minimum available memory requirements were not met " +
                                      "on computer: " + Environment.MachineName + " for user: " + UserID + ".  " +
                                      "StatTrac requires " + minimumAvailableMemoryInKb.ToString("#,##0") + " kb " +
                                      "where this user's computer only had " + actualAvailableMemoryInKb.ToString("#,##0") + " kb available " +
                                      "on " + Now.ToShortDateString() + " @ " + Now.ToShortTimeString() + "."
            Try
                StatTracLogger.CreateInstance().Write(New Exception(exMessage), TraceEventType.Warning)
            Catch ex As Exception
                'Swallow error
            End Try

            'Show low memory warning
            Me.LowMemoryWarning.Visible = True

        Else
            'Hide low memory warning if we don't have a problem
            Me.LowMemoryWarning.Visible = False
        End If

    End Sub

    Public Sub FrmReferral_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '************************************************************************************
        'Name: Form_Unload
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Unloads frmReferral
        'Returns: Nothing
        'Params: Cancel as integer
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/16/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added save of unsaved referrals if cancelled, then place directly
        '              in holding tank
        '************************************************************************************
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time and
        'set callopenbyid = -1 when the form is unloaded if the person have save ability only
        '====================================================================================


        Dim vReturn As Short
        Dim I As Short
        Dim vReferralID As Integer
        Dim vCallOpenByID As Short
        Dim vRegistration As Boolean
        Dim NoteText As String = ""
        Dim vReturns As New Object


        'Save cumulative call time
        'If TimerTotalTime.Enabled = True Then
        '    Call modStatSave.SaveTotalTime(Me)
        'End If

        'if the ok button was clicked and the referral was saved in that routine then the me.Saved = True
        If Me.Saved = True Then

            '************* THIS IS NO LONGER NEEDED
            'Char Chaput 12/28/05
            'Update call open by only if have save ability
            If Me.CmdOK.Enabled Then
                '    If Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                '        Me.CallOpenByID = -1
                '        Call modStatSave.SaveCallOpenBy(Me)
                'End If

                'ccarroll 06/06/2006 Added QA Note event
                'ccarroll 09/28/2006 Added Triage to QA note to avoid confusion, StatTrac 8.2 Iter 2
                If Me.ChkQAReview.CheckState = 1 And Me.ChkQAReview.Enabled = True Then
                    NoteText = "Triage QA Review Completed by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                    Call modStatSave.SaveLogEvent(Me, 25, NoteText)
                End If

            End If

            'The message was saved so just unload
            eventArgs.Cancel = False

        Else 'Me.Saved is not equal to true / user hit cancel
            'The message was cancelled or closed so confirm cancellation
            If vReturnSC <> -1 Then

                'T.T 11/13/2006 fake save skip over cancel question
                If AppMain.ParentForm.LeaseOrganization = 0 Then
                    If Me.CallerOrg.ServiceLevel.DisableASPSave = -1 Then
                        If Me.FormState = EXISTING_RECORD Then
                            'user canceled out set the callopenby to -1 if they are the primary
                            'if the user is not the primary set it to null
                            'NOTE if callOpenByID = 0 SaveCall is only called if OK is enabled
                            If Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                                Me.CallOpenByID = -1
                                'bret 06/08/07 use new save routine
                                Call modStatSave.SaveCallCancel(Me)
                            ElseIf Me.CallOpenByID = 0 Then
                                'if callopend by = 0 then some has opened the referral int he update report
                                'if the OK button is enabled reset the callopenby
                                If Me.CmdOK.Enabled Then
                                    Me.CallOpenByID = -1
                                    'bret 06/08/07 use new save routine
                                    Call modStatSave.SaveCallCancel(Me)
                                End If
                                'if the OK button is not enable do not save call
                            Else
                                'save the call but do not change callopen by
                                Me.CallOpenByID = 0
                                'bret 06/08/07 use new save routine
                                Call modStatSave.SaveCallCancel(Me)

                            End If
                            'bret 08/15/07 8.4
                            'we need to log the user is reading referral the orignialgoal was to only log this to referral
                            'but because of pending referrals we cannot do this
                            Call modStatSave.SaveReferralCancel(Me)
                            vReturn = MsgBoxResult.Yes
                        End If
                    End If

                End If

                If vReturn = MsgBoxResult.Yes Then
                    vReturn = MsgBoxResult.Yes
                Else
                    vReturn = modMsgForm.FormCancel
                End If

                If vReturn = MsgBoxResult.Yes Then
                    Me.Visible = False

                    Dim RefQueryCall As Short
                    Try
                        RefQueryCall = modStatRefQuery.RefQueryCall(vReturns, Me.CallId)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                        RefQueryCall = SQL_ERROR
                    End Try

                    'Char Chaput 08/24/2006 if callopenbyid on DB is not equal to person in this
                    'instance of StatTrac then do not set callopenby id to -1
                    If RefQueryCall = SUCCESS AndAlso ObjectIsValidArray(vReturns, 2, 0, 5) Then
                        vCallOpenByID = CShort(vReturns(0, 5))

                        If vCallOpenByID > 0 And vCallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                            'Char Chaput 12/27/05
                            'Update call open by only if have save ability and callopenbyid = AppMain.ParentForm.StatEmployeeID
                            If Me.CmdOK.Enabled Then
                                Me.CallOpenByID = -1
                                If Me.RecycledNC = True Then
                                    eventArgs.Cancel = False
                                End If
                                'bret 06/08/07 use new save routine
                                Call modStatSave.SaveCallCancel(Me)
                            End If
                        Else
                            'if callopend by = 0 then some has opened the referral int he update report
                            'if the OK button is enabled reset the callopenby
                            If Me.CmdOK.Enabled Then
                                Me.CallOpenByID = -1
                                'bret 06/08/07 use new save routine
                                Call modStatSave.SaveCallCancel(Me)
                            End If

                        End If
                        'bret 08/15/07 8.4
                        'we need to log the user is reading referral the orignialgoal was to only log this to referral
                        'but because of pending referrals we cannot do this
                        Call modStatSave.SaveReferralCancel(Me)
                    End If

                    If Me.FormState = NEW_RECORD Then

                        'A new call was created but not saved.
                        'Remove the call record and log event items

                        'Save the referral first, using same logic as cmdOk
                        'Delete places it in holding tank. v. 8.0 - 6/15/05 - SAP
                        Call modStatSave.SaveCall(Me, Me.CallId)

                        'Save NOK information if NOKID then new NOK functionality
                        If ModNOK = True Or AddNOK = True Then
                            Call modStatSave.SaveNOK(Me)
                        End If

                        vReferralID = modStatSave.SaveReferral(Me)
                        If vReferralID = SQL_ERROR Then
                            Dim ex As New Exception("SQL Error: No referralid on callid lookup, callid: " & Me.CallId.ToString())
                            StatTracLogger.CreateInstance().Write(ex)
                        End If


                        'Save the Lease Org Call
                        If AppMain.ParentForm.LeaseOrganization <> 0 Then
                            Call modStatSave.SaveLOCall(Me)
                        End If


                        'Save Triage Criteria and Service Level ID's
                        Call modStatSave.SaveReferralTriageCriteria(Me)

                        Call ReferralCall.SaveCustom()

                        If CallerOrg.ServiceLevel.SecondaryOn = True Then
                            ReferralSecondary.ID = vReferralID
                            ReferralSecondary.SecondaryNote = TxtSecondaryNote.Text
                            ReferralSecondary.SaveData() 'Default the incoming call event
                            'Call modStatSave.SaveLogEvent(Me) 'T.T commented out saved below

                        End If



                        'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                        NoteText = "Referral deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                        Call modStatSave.SaveLogEvent(Me, NOTE, NoteText)
                        vRegistration = Me.RegistryLogEvent()

                        ' Now place it in the holding tank.  6/15/05 - SAP
                        'Log a detailed message when a call record gets deleted after a referral was cancelled (before saving)
                        Err.Description = "Call was deleted when a referral was cancelled (before saving) by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
                        Call modStatSave.DeleteCall(Me.CallId)
                        ' Commented out - leave LogEvents intact since referral is going into the holding tank. 6/15/05 - SA
                        '''Call modStatSave.DeleteLogEvent(Me, , 1) '10/07/02 drh - Switched DeleteLogEvent and DeleteCall order so we can Audit the LogEvents before they're deleted

                        'And unload
                        eventArgs.Cancel = False

                    End If

                Else
                    'Closing form was cancelled on open referral
                    eventArgs.Cancel = True
                    isDuplicate = False
                    Exit Sub

                End If
            Else
                eventArgs.Cancel = False

            End If
            modUtility.Done()

            'Close related windows
            '10/24/01 drh Added code to unload FrmDonorIntent and FrmDonorIntentFax
            I = Application.OpenForms.Count - 1
            While I >= 0
                If (I > Application.OpenForms.Count - 1) Then
                    Exit While
                End If
                If Application.OpenForms.Item(I).Name = "FrmOpenLogEvent" Or Application.OpenForms.Item(I).Name = "FrmLogEvent" Or Application.OpenForms.Item(I).Name = "FrmOnCallEvent" Or Application.OpenForms.Item(I).Name = "FrmDonorIntent" Or Application.OpenForms.Item(I).Name = "FrmDonorIntentFax" Or Application.OpenForms.Item(I).Name = "FrmRefDups" Or Application.OpenForms.Item(I).Name = "FrmCustom1" Then
                    Application.OpenForms(I).Close()
                End If
                I -= 1
            End While

        End If

        '08/18/2010 bret check for all instances of references forms, call close
        If (Not IsNothing(frmColorKey)) Then
            frmColorKey.Close()
            frmColorKey = Nothing
        End If
        If (Not IsNothing(frmCriteria)) Then
            frmCriteria.Close()
            frmCriteria = Nothing
        End If
        If (Not IsNothing(frmCustom1)) Then
            frmCustom1.Close()
            frmCustom1 = Nothing
        End If
        If (Not IsNothing(frmDonorIntent)) Then
            frmDonorIntent.Close()
            frmDonorIntent = Nothing
        End If
        If (Not IsNothing(frmEventLogDescription)) Then
            frmEventLogDescription.Close()
            frmEventLogDescription = Nothing
        End If
        If (Not IsNothing(frmList)) Then
            frmList.Close()
            frmList = Nothing
        End If
        If (Not IsNothing(frmLogEvent)) Then
            frmLogEvent.Close()
            frmLogEvent = Nothing
        End If
        If (Not IsNothing(frmOnCallEvent)) Then
            frmOnCallEvent.Close()
            frmOnCallEvent = Nothing
        End If
        If (Not IsNothing(frmVerifySex)) Then
            frmVerifySex.Close()
            frmVerifySex = Nothing
        End If
        If (Not IsNothing(frmVerifyWeight)) Then
            frmVerifyWeight.Close()
            frmVerifyWeight = Nothing
        End If

        If (Not IsNothing(AppMain.frmRefDups)) Then
            'AppMain.frmRefDups.Activate()
            AppMain.frmRefDups.Closeform()
            AppMain.frmRefDups = Nothing
        End If

        AppMain.frmReferral = Nothing
        Me.Dispose()
    End Sub

    Private Sub Lable_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)
        Dim Index As Short = Lable.GetIndex(eventSender)
        'If TxtNotesCase.Text = "cookietest" Then
        '    Frmcookietest.Show()
        'End If
    End Sub

    Private Sub LstViewLogEvent_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewLogEvent.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewLogEvent.Columns(eventArgs.Column)


        Dim sort As String
        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
            sort = "DESC"
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
            sort = "ASC"
        End If

        LstViewLogEvent.Items.Clear()

        Try
            Call modStatQuery.QueryOpenLogEvent(Me, ColumnHeader.Text, sort)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub


    Private Sub LstViewLogEvent_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewLogEvent.DoubleClick
        '************************************************************************************
        'Name: LstViewLogEvent_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: checks if the event can be edited anc calls the edit form
        'Returns: n/a
        'Params: n/a
        '
        '
        'Stored Procedures: n/a
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/13/07                       Changed by: Bret Knoll
        'Release #: 8.4.3.9                            Task: LogEvent Delete
        'Description:
        '   Prevent Deleted from being edited
        '
        '====================================================================================

        Dim vLogEventID As Integer
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vReturn As New Object

        'bret 06/11/2007 8.4.3.9 edit deleted event
        'SubItems(1) = Event Type
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "DELETED EVENT" Then
            Call MsgBox("You may not edit a Deleted Event.")
            Exit Sub
        ElseIf String.IsNullOrWhiteSpace(LstViewLogEvent.FocusedItem.Text) Then
            Exit Sub
        End If

        frmLogEvent = New FrmLogEvent()
        'Get the call ID and set the values to be passed
        frmLogEvent.FormState = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber
        frmLogEvent.OrganizationTimeZone = Me.OrganizationTimeZone

        'Get the ID of the LogEvent to open
        frmLogEvent.LogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)
        Try
            If modStatRefQuery.RefQueryLogEventType(vReturn, frmLogEvent.LogEventID) = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                frmLogEvent.LogEventTypeID = vReturn(0, 0)
            End If
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/8/01 drh
        frmLogEvent.vParentForm = Me

        'Get the LogEvent id from the LogEvent form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Check for pending contacts
        Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Me.Activate()

    End Sub


    Private Sub LstViewLogEvent_ItemClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)


    End Sub

    Private Sub LstViewPending_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPending.DoubleClick
        '************************************************************************************
        'Name: LstViewPending_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmOnCallEvent, along with associated variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/16/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added filling of variables to store email text and subject
        '====================================================================================
        '************************************************************************************

        Dim vEventTypeList As New Object
        Dim vLogEventTypeID As Integer
        Dim vOrganizationId As Integer
        Dim vScheduleGroupID As Integer
        Dim vPosition As Short

        '***********************
        'Then open the log event
        '***********************

        If IsNothing(LstViewPending.FocusedItem) Then
            BaseMessageBox.Show("nothing focused")
        End If
        If InStr(1, LstViewPending.FocusedItem.Tag, "|") <> 0 Then
            'The pending event is a pending contact so open the oncall event form
            frmOnCallEvent = New FrmOnCallEvent()
            ReDim vEventTypeList(6)

            'Get the position of the second pipe
            vPosition = InStr(2, LstViewPending.FocusedItem.Tag, "|")

            'Get the organization ID from the selected item
            vOrganizationId = CInt(Mid(LstViewPending.FocusedItem.Tag, 2, vPosition - 2))

            'Get the schedulegroupid from the selected item
            vScheduleGroupID = CInt(Mid(LstViewPending.FocusedItem.Tag, vPosition + 1, Len(LstViewPending.FocusedItem.Tag)))

            'Set the call id & number of the form
            frmOnCallEvent.CallId = Me.CallId
            frmOnCallEvent.CallNumber = Me.CallNumber
            frmOnCallEvent.CurrentDate = Today
            frmOnCallEvent.DefaultContactType = PAGE_PENDING
            frmOnCallEvent.ReferralOrganizationID = Me.OrganizationId
            frmOnCallEvent.OrganizationId = vOrganizationId
            frmOnCallEvent.ScheduleGroupID = vScheduleGroupID


            'Set event types
            vEventTypeList(0) = INCOMING
            vEventTypeList(1) = OUTGOING
            vEventTypeList(2) = PAGE_PENDING
            vEventTypeList(3) = EMAIL_PENDING
            vEventTypeList(4) = EMAIL_SENT
            vEventTypeList(5) = PAGE_SENT
            vEventTypeList(6) = SECONDARY_PENDING

            frmOnCallEvent.SourceCode = Me.SourceCode
            frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

            frmOnCallEvent.OnCallType = REFERRAL
            'Char Chaput 04/28/06 modify .Text to TextRTF so that rich text will display
            modControl.SetRTFText(frmOnCallEvent.TxtAlert, Me.ScheduleAlert)
            frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)

            '10/8/01 drh
            frmOnCallEvent.vParentForm = Me

            'Added ability to send Referral info in email, alpha and autoresponse.  12/16/04 - SAP
            frmOnCallEvent.EmailMsg = modStatValidate.SetRefEmail(Me)
            frmOnCallEvent.EmailSbj = modStatValidate.SetRefEmailSbj(Me)
            frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)
            frmOnCallEvent.AutoResponseMsg = modStatValidate.SetRefAutoResponse(Me) 'mjd 05/28/2002 Page-AutoResponse
            frmOnCallEvent.AutoResponseSbj = modStatValidate.SetRefAutoResponseSbj(Me) 'mjd 05/28/2002 Page-AutoResponse


            Me.SendToBack()
            Call frmOnCallEvent.Display()

        Else
            'The pending event is a log event
            frmLogEvent = New FrmLogEvent()

            'Get the call ID and set the values to be passed
            frmLogEvent.FormState = EXISTING_RECORD

            'Set the call id & number of the LogEvent form to
            '0 to indicate table maintenence
            frmLogEvent.CallId = Me.CallId
            frmLogEvent.CallNumber = Me.CallNumber

            ReDim vEventTypeList(1)

            'Get the ID of the LogEvent to open
            frmLogEvent.LogEventID = modConv.TextToLng(LstViewPending.FocusedItem.Tag)

            'Find the event type
            Try
                Call modStatQuery.QueryLogEventTypeID((frmLogEvent.LogEventID), vLogEventTypeID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            Select Case vLogEventTypeID

                Case CONSENT_PENDING
                    vEventTypeList(0) = CONSENT_RESPONSE
                    vEventTypeList(1) = NO_CONSENT_RESPONSE
                    frmLogEvent.DefaultContactType = CONSENT_RESPONSE
                Case PAGE_PENDING
                    vEventTypeList(0) = PAGE_RESPONSE
                    vEventTypeList(1) = NO_PAGE_RESPONSE
                    frmLogEvent.DefaultContactType = PAGE_RESPONSE
                Case ONLINE_REVIEW_PENDING
                    'ccarroll 06/09/2011 - wi:9325
                    vEventTypeList(0) = ONLINE_REVIEW_RESPONSE
                    vEventTypeList(1) = ONLINE_REVIEW_RESPONSE
                    frmLogEvent.DefaultContactType = ONLINE_REVIEW_RESPONSE
                Case DECLARED_CTOD_PENDING
                    'ccarroll 09/11/2011 - CCRST151
                    vEventTypeList(0) = DECLARED_CTOD_CONFIRMED
                    vEventTypeList(1) = DECLARED_CTOD_CONFIRMED
                    frmLogEvent.DefaultContactType = DECLARED_CTOD_CONFIRMED
                Case ORGAN_MED_RO_PENDING
                    'ccarroll 07/16/2014 - CCRST175
                    vEventTypeList(0) = ORGAN_MED_RO_CONFIRMED
                    vEventTypeList(1) = ORGAN_MED_RO_CONFIRMED
                    frmLogEvent.DefaultContactType = ORGAN_MED_RO_CONFIRMED
                Case RECOVERY_PENDING
                    vEventTypeList(0) = RECOVERY_RESPONSE
                    vEventTypeList(1) = NO_RECOVERY_RESPONSE
                    frmLogEvent.DefaultContactType = RECOVERY_RESPONSE
                Case CALLBACK_PENDING
                    vEventTypeList(0) = OUTGOING
                    vEventTypeList(1) = INCOMING
                    frmLogEvent.DefaultContactType = OUTGOING
                Case SECONDARY_PENDING
                    ReDim vEventTypeList(0)
                    vEventTypeList(0) = SECONDARY_RESPONSE
                    frmLogEvent.DefaultContactType = SECONDARY_RESPONSE
                    frmLogEvent.PersonID = AppMain.ParentForm.StatEmployeeID
                    '10/8/01 drh
                Case FAX_PENDING
                    ReDim vEventTypeList(0)
                    vEventTypeList(0) = OUTGOING_FAX
                    frmLogEvent.DefaultContactType = OUTGOING_FAX
                    'Added for email capability, ver. 7.7.2.  12/17/04 - SAP
                Case EMAIL_PENDING
                    vEventTypeList(0) = EMAIL_RESPONSE
                    vEventTypeList(1) = NO_PAGE_RESPONSE
                    frmLogEvent.DefaultContactType = EMAIL_RESPONSE
                    'bret 3/13/09 StatTrac8.4.8
                Case Labs_Pending
                    vEventTypeList(0) = Labs_Received
                    vEventTypeList(1) = No_Labs_Received
                    frmLogEvent.DefaultContactType = Labs_Received
                Case Acknowledge_to_Evaluate
                    vEventTypeList(0) = DonorNet_Acceptance
                    vEventTypeList(1) = DonorNet_Decline
                    frmLogEvent.DefaultContactType = DonorNet_Acceptance
                Case PENDING_EREFERRAL_REVIEW
                    vEventTypeList(0) = EREFERRAL_RESPONSE
                    vEventTypeList(1) = EREFERRAL_RESPONSE
                    frmLogEvent.DefaultContactType = EREFERRAL_RESPONSE
            End Select

            frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)
            frmLogEvent.UpdatePendingEvent = True

            'set default settings
            frmLogEvent.DefaultContactName = LblName.Text
            frmLogEvent.DefaultContactPhone = LblPhone.Text
            frmLogEvent.DefaultOrganization = LblOrganization.Text
            frmLogEvent.DefaultOrganizationID = Me.OrganizationId

            '10/8/01 drh
            frmLogEvent.vParentForm = Me

            'Get the LogEvent id from the LogEvent form
            'after the user is done.
            Me.SendToBack()
            Call frmLogEvent.Display()

        End If


        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Check for pending contacts
        Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vLogEventTypeID = CONSENT_PENDING Then
            If TabDonor.TabPages.IndexOf(tabDonorTable(0)) > -1 Then
                TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(0))
            End If
            TabDisposition.SelectedIndex = 3
        End If

        If vLogEventTypeID = RECOVERY_PENDING Then
            If TabDonor.TabPages.IndexOf(tabDonorTable(0)) > -1 Then
                TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(0))
            End If
            TabDisposition.SelectedIndex = 0
        End If

        Me.Activate()

    End Sub






    Private Sub LstViewVerify_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles LstViewVerify.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        Dim vItemsList As New Object

        Me.ActiveControl.Name = "LstViewVerify"
        Me.LstViewVerify.Focus()

        Select Case KeyCode

            Case System.Windows.Forms.Keys.Left

                Call modControl.GetSelListViewItems(LstViewVerify, vItemsList)

                If ObjectIsValidArray(vItemsList, 2, 0, 0) Then
                    Select Case vItemsList(0, 0)

                        Case "Organ"
                            CboAppropriate(ORGAN).Focus()
                        Case "Bone"
                            CboAppropriate(BONE).Focus()
                        Case "Tissue"
                            CboAppropriate(TISSUE).Focus()
                        Case "Skin"
                            CboAppropriate(SKIN).Focus()
                        Case "Valves"
                            CboAppropriate(VALVES).Focus()
                        Case "Eyes"
                            CboAppropriate(EYES).Focus()
                        Case "Rsch"
                            CboAppropriate(RESEARCH).Focus()
                    End Select
                End If
            Case System.Windows.Forms.Keys.Tab
                If Shift = 0 Then
                    TabDisposition.Focus()
                Else
                    TabDisposition.Focus()
                End If
                KeyCode = 0

        End Select

        'Call LstViewVerify_Click(Me.LstViewVerify, eventArgs)

    End Sub

    Private Sub TabDisposition_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabDisposition.SelectedIndexChanged
        Static PreviousTab As Short = TabDisposition.SelectedIndex()
        'ccarroll 09/27/2011 - CCRST151 Removed TabStop = false for CORONER_TAB per bug wi:13561,13562
        'If TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) Or TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(RESULTS_TAB)) Then
        If TabDisposition.SelectedIndex = TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(RESULTS_TAB)) Then
            Me.ChkCoronerCase.TabStop = False
            Me.CboCoronerName.TabStop = False
            Me.TxtCoronerPhone.TabStop = False
            Me.CboCoronerOrg.TabStop = False
            Me.TxtCoronerNote.TabStop = False
        End If

        PreviousTab = TabDisposition.SelectedIndex()
    End Sub

    Private Sub TabDisposition_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TabDisposition.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        Select Case KeyCode

            Case System.Windows.Forms.Keys.Down

                If TabDisposition.SelectedIndex = 0 Then
                    CboApproachType.Focus()
                ElseIf TabDisposition.SelectedIndex = 1 Then
                    CboAppropriate(ORGAN).Focus()

                End If

        End Select


    End Sub

    Private Sub TabDonor_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabDonor.SelectedIndexChanged
        Static PreviousTab As Short = TabDonor.SelectedIndex()

        Call modUtility.Work()
        If TabDonor.TabPages.IndexOf(tabDonorTable(1)) > -1 And TabDisposition.TabPages.IndexOf(tabDonorTable(1)) > -1 Then
            Me.TabDonor.TabPages.RemoveAt(TabDisposition.TabPages.IndexOf(tabDonorTable(1)))
        End If
        If TabDonor.TabPages.IndexOf(tabDonorTable(1)) > -1 And TabDisposition.TabPages.IndexOf(tabDonorTable(1)) > -1 Then
            Me.TabDonor.TabPages.RemoveAt(TabDisposition.TabPages.IndexOf(tabDonorTable(1)))
        End If
        Select Case TabDonor.TabPages.Item(TabDonor.SelectedIndex).Name
            Case tabDonorTable(0).Name
                LstViewPending.TabStop = False
                CmdReferral.TabStop = False
                CmdNewEvent.TabStop = False
                LstViewLogEvent.TabStop = False
                TabDisposition.TabStop = True
            Case tabDonorTable(1).Name

                TxtNotesCaseReadOnly.Text = TxtNotesCase.Text
                TxtSecondaryNote.Focus()

                'ccarroll 06/12/2007 StaTrac 8.4 release requirement 3.6 - TBI Number
                'set default for TBI
                Me.txtSecondaryTBINumber.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
                Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)

                'ccarroll 06/06/2007 StatTrac 8.4 release requirement 3.6 - TBI Number
                'Initialize TBI controls
                If TBIAccess = True Then
                    Me.FrameTBINumber.Enabled = True
                    'ccarroll 07/06/2007 changed to Locked
                    Me.txtSecondaryTBINumber.ReadOnly = True
                    Me.cmdGenerateTBI.Enabled = True
                    Me.chkSecondaryTBINotNeeded.Enabled = False
                    Me.txtSecondaryTBIComment.Enabled = True
                    Me.lblTBINumber.Enabled = True
                    Me.lblTBIComment.Enabled = True
                End If

                Try
                    Call modStatQuery.QuerySecondaryTBI(Me) 'Get TBI data if exists
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                'Set NotNeeded controls depending on existing TBI data
                If Me.chkSecondaryTBINotNeeded.CheckState = 1 And Me.TBIAccess = True Then
                    Me.txtSecondaryTBIComment.BackColor = System.Drawing.Color.White
                Else
                    Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
                End If


                'If Person Type is Triage Coordinator or another person has the Referral open, disable TBI
                If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Or (Me.CallOpenByID <> 0 And Me.CallOpenByID <> AppMain.ParentForm.StatEmployeeID) Then
                    'ccarroll 06/06/2007 StatTrac 8.4 release requirement 3.6 - TBI Number
                    'Disallow Triage Corrdinator access to TBI
                    Me.TBIAccess = False
                    Me.FrameTBINumber.Enabled = False
                    Me.cmdGenerateTBI.Enabled = False
                    Me.chkSecondaryTBINotNeeded.Enabled = False
                    Me.txtSecondaryTBIComment.Enabled = False
                    Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
                    Me.lblTBIComment.Enabled = False
                    Me.lblTBINumber.Enabled = False
                End If
            Case tabDonorTable(2).Name
                '10/15/01 drh Set flag to indicate whether donor is appropriate
                If Me.VerifyAppropriateForDonorIntent Then
                    Me.DonorAppropriate = True
                Else
                    Me.DonorAppropriate = False
                End If

                LstViewPending.TabStop = True
                CmdReferral.TabStop = True
                CmdNewEvent.TabStop = True
                LstViewLogEvent.TabStop = True
                TabDisposition.TabStop = False
                'Clear the grid
                LstViewLogEvent.Items.Clear()
                LstViewLogEvent.View = View.Details

                'Clear the grid
                LstViewPending.Items.Clear()

                Try
                    Call modStatQuery.QueryPendingEvents(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                'Check for pending contacts
                Call modStatValidate.ValidateReferralContacts(Me, False)

                'Fill Grid
                Try
                    Call modStatQuery.QueryOpenLogEvent(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                'Reversed the order of two ListView columns to avoid a potentially breaking
                'change to the order of items returned by StoredProcedure: GetLogEventList
                LstViewLogEvent.Columns(5).DisplayIndex = 4
                LstViewLogEvent.Columns(4).DisplayIndex = 5

                If Not IsNothing(Me.ScheduleAlert) Then
                    modControl.SetRTFText(rtbScheduleAlert, Me.ScheduleAlert)
                End If
        End Select

        '7/9/01 drh Determine if FS Stages should be visible and enabled
        Call GetFSStage()

        Call modUtility.Done()

        PreviousTab = TabDonor.SelectedIndex()
    End Sub




    Private Sub TimerReg_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)
        Call Cmdregkill_Click(Cmdregkill, New System.EventArgs())
    End Sub

    Private Sub TxtAdmitDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAdmitDate.Enter

        Call modControl.HighlightText(TxtAdmitDate)

    End Sub

    Private Sub TxtAdmitDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtAdmitDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateMask_LY(KeyAscii, TxtAdmitDate)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtAdmitDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAdmitDate.Leave
        '02/05/03 drh - Added because Validate event is not fired when TabDonor tabs are selected
        Dim vCancel As Boolean
        vCancel = False
    End Sub

    Private Sub TxtAdmitDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtAdmitDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        Dim vCoronerCase As Boolean
        Dim currentActiveControl As Control
        currentActiveControl = ActiveControl

        'dont valid date if cancel is clicked jth 6/10
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtAdmitDate" Then
            '02/05/03 drh - Moved up from bottom and modified to check for 8 characters
            If TxtAdmitDate.Text <> "" And (Len(TxtAdmitDate.Text) < 8 Or Not IsDate(TxtAdmitDate.Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

            If Len(TxtAdmitDate.Text) = 8 Then

                'Check for coroner's case
                If modControl.GetID(CboCauseOfDeath) <> -1 Then
                    Try
                        Call modStatQuery.QueryCauseOfDeathCoronerCase(modControl.GetID(CboCauseOfDeath), vCoronerCase)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If

                If TxtAdmitTime.Text = "" And TxtAdmitDate.Text <> "" Then

                    'Test date
                    If DateValue(TxtAdmitDate.Text) = Today Or DateValue(TxtAdmitDate.Text) = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today) Then

                        ChkCoronerCase.ForeColor = System.Drawing.Color.Red
                        LblCoronerMsg.Visible = True
                        If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                            TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB))
                        End If
                        'currentActiveControl.Focus()
                    End If

                ElseIf (DateValue(TxtAdmitDate.Text) = Today Or DateValue(TxtAdmitDate.Text) = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today)) Then

                    ChkCoronerCase.ForeColor = System.Drawing.Color.Red
                    LblCoronerMsg.Visible = True
                    If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                        TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB))
                    End If
                    'TxtAdmitDateNextControlFocus()
                ElseIf vCoronerCase = False Then

                    ChkCoronerCase.ForeColor = System.Drawing.Color.Black
                    LblCoronerMsg.Visible = False

                End If

            End If
            currentActiveControl.Focus()
EventExitSub:
            eventArgs.Cancel = Cancel
        End If

        Exit Sub
    End Sub

    Private Sub TxtAdmitTime_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAdmitTime.Enter

        Call modControl.HighlightText(TxtAdmitTime)

    End Sub


    Private Sub TxtAdmitTime_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtAdmitTime.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, TxtAdmitTime, Me.OrganizationTimeZone)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtAdmitTime_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAdmitTime.Leave

        Dim vCoronerCase As Boolean

        If Len(TxtAdmitDate.Text) = 8 Then

            'Check for coroner's case
            If modControl.GetID(CboCauseOfDeath) <> -1 Then
                Try
                    Call modStatQuery.QueryCauseOfDeathCoronerCase(modControl.GetID(CboCauseOfDeath), vCoronerCase)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

            If TxtAdmitTime.Text = "" And TxtAdmitDate.Text <> "" Then

                'Test date
                If DateValue(TxtAdmitDate.Text) = Today Or DateValue(TxtAdmitDate.Text) = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today) Then

                    ChkCoronerCase.ForeColor = System.Drawing.Color.Red
                    LblCoronerMsg.Visible = True
                    If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                        TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB))
                    End If
                End If

            ElseIf (DateValue(TxtAdmitDate.Text) = Today Or DateValue(TxtAdmitDate.Text) = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today)) Then

                ChkCoronerCase.ForeColor = System.Drawing.Color.Red
                LblCoronerMsg.Visible = True
                If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                    TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB))
                End If

            ElseIf vCoronerCase = False Then

                ChkCoronerCase.ForeColor = System.Drawing.Color.Black
                LblCoronerMsg.Visible = False

            End If
            If Me.ShiftKey = True Then
                TxtAdmitDate.Focus()
            Else
                CboApproachType.Focus()
            End If

        ElseIf Not IsDate(TxtAdmitDate.Text) And TxtAdmitDate.Text <> "" Then
            Call MsgBox("Date is incomplete.", MsgBoxStyle.Exclamation, "Validation Error")
            TxtAdmitDate.Focus()
        End If

    End Sub


    Private Sub TxtAge_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAge.Enter

        Call modControl.HighlightText(ActiveControl)

        OldValue = TxtAge.Text

    End Sub


    Private Sub TxtAge_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtAge.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtAge_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAge.Leave

        'Call TxtAge_Validate(False)

    End Sub

    Private Sub TxtAge_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtAge.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        Dim vAge As Single
        Dim vDays As Single

        If TxtAge.Text = "0" Then
            MsgBox("The age cannot be 0!")
            Cancel = True
            GoTo EventExitSub
        End If

        If TxtAge.Text <> "" Then
            If CShort(TxtAge.Text) > 120 Then
                MsgBox("Invalid Age. Please Check Age.")
                Cancel = True
                GoTo EventExitSub
            End If
        End If

        'Check age against DOB
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtAge" Then
            If TxtAge.Text <> "" And CboAgeUnit.Text <> "" And TxtDOB.Text <> "" Then

                'Convert date into age
                'Get the number of days between today and birth date
                If TxtDeathDate.Text <> "" Then
                    vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtDeathDate.Text, "mm/dd/yyyy")))
                Else
                    vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtCallDate.Text, "mm/dd/yyyy")))
                End If

                If vDays = 0 Then
                    vDays = vDays + 1
                End If

                'If less than 31 days, set the age and age unit to days
                If vDays <= 31 Then
                    If CDbl(TxtAge.Text) <> vDays Or CboAgeUnit.Text <> "Days" Then
                        Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                        Cancel = True
                        GoTo EventExitSub
                    End If
                End If

                'If greater than 31 days but less than 730 days (24 months),
                'then convert to months
                If vDays > 31 And vDays < 730 Then
                    If CDbl(TxtAge.Text) <> (modConv.AgeMonths(TxtDOB.Text)) Or CboAgeUnit.Text <> "Months" Then
                        Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                        Cancel = True
                        GoTo EventExitSub
                    End If
                End If

                'If greater than 730 days, set the age and age unit to years
                If vDays >= 730 Then
                    If CDbl(TxtAge.Text) <> (modConv.Age((TxtDOB.Text))) Or CboAgeUnit.Text <> "Years" Then
                        Call MsgBox("The DOB and Age do not match. Please clear or enter the correct age.", MsgBoxStyle.OkOnly, "Date Error")
                        Cancel = True
                        GoTo EventExitSub
                    End If
                End If

            End If

            Call Check_ServiceLevel_Weight()

            'Verify
            If TxtAge.Text <> OldValue Then
                If TxtAge.Text <> "" And CboAgeUnit.Text <> "" And CboGender.Text <> "" Then
                    Select Case CallerOrg.ServiceLevel.TriageLevel

                        Case VENT_ONLY
                            Try
                                Call modStatValidate.VerifyReferral(Me, True, False, False, True)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try

                        Case AGE_ONLY
                            Try
                                Call modStatValidate.VerifyReferral(Me, False, True, False, True)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try

                        Case VENT_AGE_ONLY
                            Try
                                Call modStatValidate.VerifyReferral(Me, True, True, False, True)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try

                        Case VENT_AGE_MRO
                            Try
                                Call modStatValidate.VerifyReferral(Me, True, True, True, True)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try

                    End Select
                End If
            End If
        End If


        OldValue = ""

        '10/2/01 drh
        'Call ValidateForDonorIntent

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtBrainDeathDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtBrainDeathDate.Enter
        Call modControl.HighlightText(ActiveControl)
        Me.vOldBrainDeathDate = Me.TxtDeathDate.Text
    End Sub

    Private Sub TxtBrainDeathDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtBrainDeathDate.Leave
        '02/05/03 drh - Added because Validate event is not fired when TabDonor tabs are selected
        Dim vCancel As Boolean
        vCancel = False
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtBrainDeathDate" Then
            'Call TxtBrainDeathDate_Validate(vCancel)
            If vCancel = True Then
                If TabDonor.TabPages.IndexOf(tabDonorTable(0)) > -1 Then
                    TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(0))
                End If
                TxtBrainDeathDate.Focus()
            End If
        End If
    End Sub
    Private Sub TxtBrainDeathTime_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtBrainDeathTime.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtBrainDeathTime_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtBrainDeathTime.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl, Me.OrganizationTimeZone)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtCallDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCallDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallDate.Leave

        'Make sure we have a valid date
        If IsDate(TxtCallDate.Text) Then
            Me.CallDate = TxtCallDate.Text
        Else
            Call MsgBox("Date is invalid.", MsgBoxStyle.Exclamation, "Validation Error")
        End If

    End Sub


    Private Sub TxtCoronerName_GotFocus()

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtBrainDeathDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtBrainDeathDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtBrainDeathDate.SelectedText <> "" Then
            TxtBrainDeathDate.Text = ""
        End If
        KeyAscii = modMask.DateMask_LY(KeyAscii, ActiveControl)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtBrainDeathDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtBrainDeathDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'if me.TxtBrainDeathDate.text
        '02/05/03 drh - Modified to check for 8 characters
        'dont valid date if cancel is clicked jth 6/10
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtBrainDeathDate" Then
            If TxtBrainDeathDate.Text <> "" And (Len(TxtBrainDeathDate.Text) < 8 Or Not IsDate(TxtBrainDeathDate.Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
            ElseIf TxtBrainDeathDate.Text <> "" Then

                If CDate(VB6.Format(TxtBrainDeathDate.Text, "mm/dd/yy")) > CDate(modConv.DateToOrganizationDate((Me.OrganizationTimeZone))) Then
                    Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                    Cancel = True
                End If
            End If
            If Me.vOldDeathDate <> Me.TxtBrainDeathDate.Text Then
                If TxtBrainDeathDate.Text <> "" And TxtDOB.Text <> "" And TxtAge.Text <> "" Then
                    Call TxtDOB_Validating(TxtDOB, New System.ComponentModel.CancelEventArgs(False))
                End If
            End If
            eventArgs.Cancel = Cancel
        End If

    End Sub
    Private Sub TxtCoronerPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCoronerPhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCoronerPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCoronerPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtDeathDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDeathDate.Enter
        Call modControl.HighlightText(ActiveControl)
        Me.vOldDeathDate = Me.TxtDeathDate.Text
    End Sub

    Private Sub TxtDeathDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDeathDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtDeathDate.SelectedText <> "" Then
            TxtDeathDate.Text = ""
        End If
        KeyAscii = modMask.DateMask_LY(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtDeathDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDeathDate.Leave
        '02/05/03 drh - Added because Validate event is not fired when TabDonor tabs are selected
        Dim vCancel As Boolean
        vCancel = False
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtDeathDate" Then
            'Call TxtDeathDate_Validating(vCancel)
            If vCancel = True Then
                If TabDonor.TabPages.IndexOf(tabDonorTable(0)) > -1 Then
                    TabDonor.SelectedIndex = TabDonor.TabPages.IndexOf(tabDonorTable(0))
                End If

                TxtDeathDate.Focus()
            End If
        End If

    End Sub

    'Added: 05/25/01 - ttw
    Private Sub TxtDeathDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtDeathDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        'dont valid date if cancel is clicked jth 6/10
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtDeathDate" Then
            'if me.TxtDeathDate.text
            '02/05/03 drh - Modified to check for 8 characters
            If TxtDeathDate.Text <> "" And (Len(TxtDeathDate.Text) < 8 Or Not IsDate(TxtDeathDate.Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
            ElseIf TxtDeathDate.Text <> "" Then

                'Check for a mismatch between the selected date and the current date in the referral facility's time zone
                If CDate(VB6.Format(TxtDeathDate.Text, "mm/dd/yy")).Date <> CDate(modConv.DateToOrganizationDate(Me.OrganizationTimeZone)).Date Then
                    Call MsgBox("Date is not valid because it doesn't match the date of the referral facility in their time zone.", MsgBoxStyle.Exclamation, "Validation Error")
                    Cancel = False
                End If
            End If
            If IsDate(Me.vOldDeathDate) _
                And IsDate(TxtDeathDate.Text) _
                AndAlso Me.vOldDeathDate <> Me.TxtDeathDate.Text Then
                If TxtDeathDate.Text <> "" And TxtDOB.Text <> "" And TxtAge.Text <> "" Then
                    Call TxtDOB_Validating(TxtDOB, New System.ComponentModel.CancelEventArgs(False))
                End If
            End If

            eventArgs.Cancel = Cancel
        End If

    End Sub
    Private Sub TxtDeathTime_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDeathTime.Enter

        Call modControl.HighlightText(ActiveControl)
        Me.vOldDeathTime = Me.TxtDeathTime.Text

    End Sub


    Private Sub TxtDeathTime_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDeathTime.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl, Me.OrganizationTimeZone)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub



    Private Sub TxtDOB_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDOB.Enter

        Call modControl.HighlightText(ActiveControl)

        OldValue = TxtDOB.Text

    End Sub


    Private Sub TxtDOB_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDOB.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        KeyAscii = modMask.DateMask2000(KeyAscii, TxtDOB)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Async Sub TxtDOB_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDOB.Leave
        Dim vReturn As String = ""

        '05/02/2011 ccarroll bug 11549
        If Not IsDate(Me.TxtDOB.Text) Then
            Me.TxtDOB.Select(0, Me.TxtDOB.Text.Length - 1)
            'Reset RegStatus & RegMatch if date was removed
            If String.IsNullOrEmpty(Me.TxtDOB.Text) Then
                modControl.cbofill((Me.cboRegistryStatus), "Not Checked", True, True)
                CmdRegMatch.Visible = False
            End If
            Exit Sub
        End If
    End Sub

    Private Async Sub TxtDOB_Validated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDOB.Validated

        If Me.TxtDOB.Text = Me.DonorDOB Then 'T.T 8/16/2004 added to exit sub when old value equals new value
            Exit Sub
        End If

        vNoteChange = "DOB" 'T.T this is a note to indicate why to research the registry

        strRegistryMessage = "" 'T.T 8/16/2004 added to recreate note

        '10/15/01 drh Reset lblRegistry.Text if dob changed; This is so Registry will be checked again
        If Me.TxtDOB.Text <> Me.DonorDOB Then
            LblRegistry.Text = "Registered"
            Await TrySearchDonor()
        End If

        Call Check_ServiceLevel_Weight()

        'ccarroll 09/27/2007 - Empirix 6973 added if statement
        If Me.TxtAge.Enabled Then
            Me.TxtAge.Focus()
        End If

    End Sub

    Private Sub TxtDOB_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtDOB.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        Dim vDays As Single
        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtDOB" Then

            If TxtDOB.Text <> "" Then

                If (Not IsDate(TxtDOB.Text)) OrElse ((CDate(TxtDOB.Text) > CDate(VB6.Format(Now, "mm/dd/yyyy"))) Or (CDate(TxtDOB.Text) < CDate("01/01/1890")) Or Len(TxtDOB.Text) < 10) Then '02/05/03 drh - Added check for date length
                    Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                    Cancel = True
                    GoTo EventExitSub
                End If

                'Convert date into age

                'Get the number of days between today and birth date
                If TxtDeathDate.Text <> "" Then
                    vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtDeathDate.Text, "mm/dd/yyyy")))
                Else
                    vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(TxtDOB.Text, "mm/dd/yyyy")), CDate(VB6.Format(TxtCallDate.Text, "mm/dd/yyyy")))
                End If

                'If less than 31 days, set the age and age unit to days
                If vDays = 0 Then
                    TxtAge.Text = CStr(vDays + 1)
                    CboAgeUnit.Text = "Days"
                End If

                If vDays > 0 And vDays <= 31 Then
                    TxtAge.Text = CStr(vDays)
                    CboAgeUnit.Text = "Days"
                End If

                'If greater than 31 days but less than 730 days (24 months),
                'then convert to months
                If vDays > 31 And vDays < 730 Then
                    TxtAge.Text = CStr(modConv.AgeMonths(TxtDOB.Text))
                    CboAgeUnit.Text = "Months"
                End If

                'If greater than 730 days, set the age and age unit to years
                If vDays >= 730 Then
                    TxtAge.Text = CStr(modConv.Age((TxtDOB.Text)))
                    CboAgeUnit.Text = "Years"
                End If

            End If

            'Verify
            'Only if not PNE case HS 30099 wi14184
            'ccarroll 12/09/2011 CCRST165
            If TxtDOB.Text <> OldValue And IsPNEActive = False Then
                If TxtAge.Text <> "" And CboAgeUnit.Text <> "" And CboGender.Text <> "" Then
                    Select Case CallerOrg.ServiceLevel.TriageLevel

                        Case VENT_ONLY
                            Call modStatValidate.VerifyReferral(Me, True, False, False, True)

                        Case AGE_ONLY
                            Call modStatValidate.VerifyReferral(Me, False, True, False, True)

                        Case VENT_AGE_ONLY
                            Call modStatValidate.VerifyReferral(Me, True, True, False, True)

                        Case VENT_AGE_MRO
                            Call modStatValidate.VerifyReferral(Me, True, True, True, True)

                    End Select
                End If
            End If
        End If

        DisableAgeFieldsAsNeeded()

        Call Check_ServiceLevel_Weight()

        OldValue = ""

        '10/2/01 drh
        'Call ValidateForDonorIntent

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub



    Private Async Sub TxtDonorFirstName_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDonorFirstName.Leave


        If Me.TxtDonorFirstName.Text = Me.DonorFirstName Then 'T.T 8/16/2004 added to exit sub when old value equals new value
            UpdateFormCaption()
            Exit Sub
        End If

        vNoteChange = "FirstName"

        '10/15/01 drh Reset lblRegistry.Text if name changed; This is so Registry will be checked again
        If Me.TxtDonorFirstName.Text <> Me.DonorFirstName Then
            LblRegistry.Text = "Registered"
            strRegistryMessage = "" 'T.T 8/16/2004 added to recreate note

            Await TrySearchDonor()

        End If

        'Char Chaput 5/03/06 added equal to so that the screen caption would display patient name properly
        'See updateformcaption function
        If Me.TxtDonorFirstName.Text >= "" Then
            UpdateFormCaption()
        End If

    End Sub

    Private Sub TxtDonorLastName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDonorLastName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
    Private Sub TxtDonorFirstName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDonorFirstName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtDonorLastName_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtDonorLastName.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        vTxtLNameChng = True
    End Sub

    Private Sub TxtDonorLastName_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDonorLastName.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Default 'Not Given' if first character is an 'n'
        If (KeyAscii = 110 Or KeyAscii = 78) And Len(ActiveControl.Text) = 0 Then
            ActiveControl.Text = "Not Given"
            'FIXIT: Whenever possible replace ActiveForm or ActiveControl with an early-bound variable     FixIT90210ae-R1614-RCFE85
            TxtDonorLastName.SelectionStart = 1
            KeyAscii = 0
        ElseIf ActiveControl.Text = "Not Given" Then
            ActiveControl.Text = "N"
            'FIXIT: Whenever possible replace ActiveForm or ActiveControl with an early-bound variable     FixIT90210ae-R1614-RCFE85
            TxtDonorLastName.SelectionStart = 1
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Async Sub TxtDonorLastName_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDonorLastName.Leave

        If isDuplicate Then
            Exit Sub
        End If

        modUtility.Work()

        If vTxtLNameChng = False Then
            'If Me.TxtDonorLastName = Me.DonorLastName Then              'T.T 8/16/2004 added to exit sub when old value equals new value
            'UpdateFormCaption
            Exit Sub
        End If

        vNoteChange = "LastName" 'T.T this is a note for the reason to research the registry
        strRegistryMessage = "" 'T.T 8/16/2004 added to recreate note
        '10/15/01 drh Reset lblRegistry.Text if name changed; This is so Registry will be checked again
        If Me.TxtDonorLastName.Text <> Me.DonorLastName Then
            Dim vServiceLevelStatus As Integer
            'vServiceLevelStatus = CURRENT_SERVICELEVEL

            'ccarroll 11/18/2010 Only re-check registry if servicelevel is turned on
            'TODO: What exactly does this check do?
            If Not GetCheckRegistryValue(vServiceLevelStatus, Me.ServiceLevelId) Then
                LblRegistry.Text = "Registered"
                Await TrySearchDonor()
            End If

            'ccarroll 06/21/2010 method of approach requires reset because name changed
            Me.MethodOfApproachReset = True


            'ccarroll 11/09/2010 Moved location of duplicate name check (wi8325)
            'Check only if the donor name is other than 'Not Given'
            Dim vMsg As String = ""
            If TxtDonorLastName.Text <> "Not Given" Then

                'Char Chaput 5/03/06 added equal to so that the screen caption would display patient name properly
                'See updateformcaption function
                If TxtDonorLastName.Text >= "" Then
                    UpdateFormCaption()
                End If

                Dim vResults As New Object

                'Look up QueryDonorName
                Dim QueryDonorName As Short
                Try
                    QueryDonorName = modStatQuery.QueryDonorName(Me, vResults)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                    QueryDonorName = SQL_ERROR
                End Try

                If QueryDonorName = SUCCESS Then

                    Dim I As Short

                    '08/25/01 drh Log the duplicate match
                    'ccarroll 11/22/2010 added check for finding same referral running search.
                    If Me.CallId <> CStr(vResults(I, 0)) Then

                        vMsg = "Duplicate Referral Found for " & CStr(Me.CallId) & " - '" & Me.TxtDonorLastName.Text & "': "
                        For I = 0 To UBound(vResults, 1)
                            vMsg = vMsg & CStr(vResults(I, 0)) & ", " & vResults(I, 2) & ", " & vResults(I, 3) & ", " & vResults(I, 4) & " | "
                        Next I

                        'check if there is already a donor name
                        'in the referral database that is the same as the one just
                        'entered.

                        AppMain.frmRefDups = New FrmRefDups()

                        Dim newCallId As Object = AppMain.frmRefDups.Display(vResults)
                        AppMain.frmRefDups.Dispose()
                        AppMain.frmRefDups = Nothing
                        If newCallId > 0 Then

                            isDuplicate = True


                            Me.Close()
                            'ccarroll 07/18/2011 wi:13025
                            'Canceling out of a referral during a duplicate check now re-sets
                            'the isDuplicate value and new referral is not created.
                            'Changed Show to ShowDialog()
                            If (isDuplicate) Then

                                AppMain.frmReferral = New FrmReferral()

                                AppMain.frmReferral.FormState = EXISTING_RECORD
                                AppMain.frmReferral.CallId = newCallId
                                'Load(FrmReferral)
                                AppMain.frmReferral.ShowDialog()
                                If AppMain.frmReferral IsNot Nothing Then
                                    AppMain.frmReferral.TabDonor.SelectedIndex = 0
                                End If
                                isDuplicate = False

                            End If

                        End If

                    End If

                End If

            End If

        End If

        modUtility.Done()
        Exit Sub

    End Sub

    Private Sub TxtExtension_GotFocus()

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtExtension_KeyPress(ByRef KeyAscii As Short)

        KeyAscii = modMask.NumMask(KeyAscii, 5, ActiveControl)

    End Sub
    Private Sub TxtDonorMI_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDonorMI.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtExtubated_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtExtubated.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtExtubated_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtExtubated.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtExtubated_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtExtubated.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If Len(TxtExtubated.Text) > 0 Then
            If Not IsDate(TxtExtubated.Text) Then
                'changed 07/19/00 ttw (removed line below)
                'Or Len(TxtExtubated.Text) < 15 Or DateDiff("h", Now, CDate(TxtExtubated.Text)) > 2
                Call MsgBox("Date/Time is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
            End If
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtNotesCase_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNotesCase.Enter
        Me.CaseNotes = TxtNotesCase.Text
    End Sub

    Private Sub TxtNotesCase_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtNotesCase.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
        End If

        KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Return, 0, KeyCode)

    End Sub

    Private Sub TxtNotesCase_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtNotesCase.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Try
            Call modStatQuery.QueryKeyCodePhrase(ActiveControl, KeyAscii)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtNotesCase_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNotesCase.Leave
        '************************************************************************************
        'Name: TxtNotesCase_LostFocus
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: control application after TxtNotesCase looses focus
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: StatTrac Release: 8.0 Iter 4 Empirix 6780
        'Description: Referral is always reverified even if the user does not change.
        '             Spelling is still only checked if the user changes it.
        '====================================================================================
        'bjk 08272003 moved code from sub TxtNotesCase_validate
        Dim verifyReferral As Boolean
        Dim currentActiveControl As Control

        verifyReferral = False
        currentActiveControl = ActiveControl

        'ccarroll 06/21/2010 
        'If Me.ActiveControl.Name <> "TabDisposition" Then
        'vLastActiveControlName = Me.ActiveControl.Name.ToString()
        'End If


        'Char Chaput 06/14/06 if this is called from notes change do not yellow
        'vtxtnoteschng is used in cboreferraltype.click event
        vtxtnoteschng = True

        'checks if CaseNotes changed
        If Me.CaseNotes <> TxtNotesCase.Text Then
            'bjk 0827.2003 moved Call modStatValidate.ValidateSpelling(TxtNotesCase) to within if statment
            Call modStatValidate.ValidateSpelling(TxtNotesCase)
        End If

        Select Case CallerOrg.ServiceLevel.TriageLevel

            Case VENT_ONLY
                Try
                    verifyReferral = modStatValidate.VerifyReferral(Me, True, False, False, True)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Case AGE_ONLY
                Try
                    verifyReferral = modStatValidate.VerifyReferral(Me, False, True, False, True)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Case VENT_AGE_ONLY
                Try
                    verifyReferral = modStatValidate.VerifyReferral(Me, True, True, False, True)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Case VENT_AGE_MRO
                Try
                    verifyReferral = modStatValidate.VerifyReferral(Me, True, True, True, True)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

        End Select


        PreviousField = ""

        vtxtnoteschng = False

        currentActiveControl.Focus()
        Exit Sub

    End Sub

    Private Sub TxtNotesCase_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtNotesCase.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'bjk 08272003 moved code from sub to txNotesCase_LostFocus
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtPersonType_GotFocus()

        Call modControl.HighlightText(ActiveControl)

    End Sub
    Private Sub TxtRecNum_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtRecNum.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtRecNum_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles TxtRecNum.KeyDown
        Dim KeyCode As Short = e.KeyCode
        Dim Shift As Short = e.KeyData \ &H10000
        vTxtMedicalRecordChng = True

    End Sub

    Private Sub TxtRecNum_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtRecNum.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Default 'Not Given' if first character is an 'n'
        If Len(ActiveControl.Text) = 0 And (KeyAscii = 110 Or KeyAscii = 78) Then
            ActiveControl.Text = "Not Given"
            'FIXIT: Whenever possible replace ActiveForm or ActiveControl with an early-bound variable     FixIT90210ae-R1614-RCFE85
            TxtRecNum.SelectionStart = 1
            KeyAscii = 0
        ElseIf ActiveControl.Text = "Not Given" Then
            ActiveControl.Text = "N"
            'FIXIT: Whenever possible replace ActiveForm or ActiveControl with an early-bound variable     FixIT90210ae-R1614-RCFE85
            TxtRecNum.SelectionStart = 1
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub




    Private Sub TxtSecondaryNote_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtSecondaryNote.Enter

        OldValue = TxtSecondaryNote.Text

    End Sub

    Private Sub TxtSecondaryNote_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtSecondaryNote.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
        End If

        KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Return, 0, KeyCode)

    End Sub

    Private Sub TxtSecondaryNote_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtSecondaryNote.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Try
            Call modStatQuery.QueryKeyCodePhrase(TxtSecondaryNote, KeyAscii)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtSecondaryNote_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtSecondaryNote.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If TxtSecondaryNote.Text <> OldValue Then
            Try
                Call modStatValidate.ValidateSpelling(TxtNotesCase)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtSecondaryTBIComment_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtSecondaryTBIComment.Leave
        'ccarroll 06/12/2007 StatTrac 8.4 release requirement 3.6 - TBI number
        'Prevent user from leaving until either checkbox is un-checked or value is added
        'in comment area.
        If Me.txtSecondaryTBIComment.Text = "" And Me.chkSecondaryTBINotNeeded.CheckState = 1 Then
            Call MsgBox("Please comment why CTDN assignment was not needed.", MsgBoxStyle.OkOnly)
            Me.txtSecondaryTBIComment.Focus()
        End If
    End Sub

    Private Sub TxtSSN_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtSSN.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtSSN_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtSSN.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.SSNMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtSSN_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtSSN.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Call cmdRegistry_Click
        'removed all validation - use button instead
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtTotalTimeCounter_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtTotalTimeCounter.TextChanged

        Dim I As Integer

        I = I + 1

    End Sub

    Private Sub TxtTotalTimeCounter_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtTotalTimeCounter.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = 0
        'KeyAscii = modMask.TimerMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtWeight_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtWeight.Enter

        Call modControl.HighlightText(ActiveControl)

        OldValue = TxtWeight.Text

    End Sub


    Private Sub txtWeight_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtWeight.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 107 Or KeyAscii = 75) Then
            If LblWeight.Text = "lbs" Then
                'TxtWeight.Text = CInt(CInt(TxtWeight.Text) / 2.2)
                LblWeight.Text = "kg"
            End If
        ElseIf (KeyAscii = 108 Or KeyAscii = 76) Then
            If LblWeight.Text = "kg" Then
                'TxtWeight.Text = CInt(CInt(TxtWeight.Text) * 2.2)
                LblWeight.Text = "lbs"
            End If
        End If

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 1, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub



    Public Function Display() As Object

        'Me.Show

    End Function

    Public Function SetServiceLevel(ByRef pvForm As FrmReferral) As Object

        Dim I As Short
        Dim j As Short
        Dim HeartBeat As New Object 'T.T 09/30/2004 added for heartbeat consistency

        '====================================================================================
        'Date Changed: 6/20/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Referral Screen Redesign - Added new referral screen fields. MD Phone,
        '              Brain Death Date/time, Specific COD, Patient MI
        '====================================================================================


        'FSProj drh 5/2/02 - Before we start, get the correct ServiceLevelStatus for historical purposes
        '*************************************************************************************
        Dim vServiceLevelStatus As Short
        If Me.HistoricalReferral Then
            vServiceLevelStatus = ORIGINAL_SERVICELEVEL
        Else
            vServiceLevelStatus = CURRENT_SERVICELEVEL
        End If
        '*************************************************************************************

        'First, determine the service level
        'FSProj drh 5/2/02 - Need to get the Service Level for the correct Status type (ServiceLevelStatus) or ServiceLevelId

        'Determine ServiceLevel
        Dim ServiceLevel As Integer
        Try
            ServiceLevel = CallerOrg.GetServiceLevel(Me.SourceCode.ID, vServiceLevelStatus, Me.ServiceLevelId)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ServiceLevel = -1
        End Try

        'ccarroll 04/07/2011 Notification for OrganizationNotAssignedToServiceLevel moved to Shown event (wi:11418)
        If ServiceLevel <> SUCCESS Then
            pvForm.OrganizationNotAssignedToServiceLevel = True
            Exit Function
        Else
            'FSProj drh 5/3/02 - If CallerOrg.GetServiceLevel succeeded, set the Referral's ServiceLevelId
            Me.ServiceLevelId = Me.CallerOrg.ServiceLevel.ID

            If CallerOrg.ServiceLevel.TriageLevel = VENT_AGE_MRO Then
                Call modControl.Enable(TxtNotesCase)
            Else
                Call modControl.Disable(TxtNotesCase)
            End If

            '01/07/04 mds Added for HeartBeat field -
            'Copied code from Vent functionality below & removed CboVentChanged flag
            'Added logic to repopulate the list box in case it's been cleared
            'Call modControl.Enable(CboHeartBeat)
            If CallerOrg.ServiceLevel.HeartBeat = True Then
                Call modControl.Enable(CboHeartBeat)
                If Me.CboHeartBeat.Items.Count = 0 Then 'Organization changed and list was cleared out reset list
                    HeartBeat = Me.CboHeartBeat.SelectedIndex
                    'Set default value of Yes for CboHeartBeat
                    Call modControl.SelectID((Me.CboHeartBeat), HeartBeat)
                    'Call function to set status and backcolor
                    Call SetHeartBeatColor()
                End If
                'change to CboHeartBeat back ground color to yellow
                If Me.FormState = NEW_RECORD Then
                    If CboHeartBeat.Items.Count = 0 Then
                        CboHeartBeat.Items.Add(New ValueDescriptionPair(1, "Yes"))
                        CboHeartBeat.Items.Add(New ValueDescriptionPair(0, "No"))
                    End If
                    HeartBeat = Me.CboHeartBeat.SelectedIndex 'T.T 09/30/2004 old value for heartbeat
                    'Call modControl.SelectID(Me.CboHeartBeat, 1)

                    Call modControl.SelectID((Me.CboHeartBeat), HeartBeat) 'T.T 09/30/2004 added for data erasing errors

                    '1/12/04 mds Call SetHeartBeatColor to set backcolor and status
                    Call SetHeartBeatColor()
                End If
            Else
                Me.CboHeartBeat.Items.Clear()
                Call modControl.Disable(CboHeartBeat)
            End If

            If CallerOrg.ServiceLevel.LastName = True Then Call modControl.Enable(TxtDonorLastName) Else Call modControl.Disable(TxtDonorLastName)
            If CallerOrg.ServiceLevel.FirstName = True Then Call modControl.Enable(TxtDonorFirstName) Else Call modControl.Disable(TxtDonorFirstName)
            If CallerOrg.ServiceLevel.NameMI = True Then Call modControl.Enable(TxtDonorMI) Else Call modControl.Disable(TxtDonorMI)
            If CallerOrg.ServiceLevel.RecordNum = True Then Call modControl.Enable(TxtRecNum) Else Call modControl.Disable(TxtRecNum)
            If CallerOrg.ServiceLevel.SSN = True Then Call modControl.Enable(TxtSSN) Else Call modControl.Disable(TxtSSN)

            If CallerOrg.ServiceLevel.CheckRegistryMode <> CheckRegistryMode.DonorIntent And Me.cmdDonorIntent.ForeColor.Name <> "Red" Then
                Me.cmdDonorIntent.Visible = False
            End If
            If CallerOrg.ServiceLevel.Gender = True Then Call modControl.Enable(CboGender) Else Call modControl.Disable(CboGender)
            If CallerOrg.ServiceLevel.Age = True Then Call modControl.Enable(TxtAge) Else Call modControl.Disable(TxtAge)
            If CallerOrg.ServiceLevel.Age = True Then Call modControl.Enable(CboAgeUnit) Else Call modControl.Disable(CboAgeUnit)
            If CallerOrg.ServiceLevel.Weight = True Then Call modControl.Enable(TxtWeight) Else Call modControl.Disable(TxtWeight)
            If CallerOrg.ServiceLevel.Race = True Then Call modControl.Enable(CboRace) Else Call modControl.Disable(CboRace)
            '02/25/2002 bjk: add a line to the vent field code to control the field colors
            If CallerOrg.ServiceLevel.Vent = True Then
                Call modControl.Enable(CboVent)
                If Me.CboVent.Items.Count = 0 Then 'Organization changed and list was cleared out reset list
                    CboVent.BackColor = System.Drawing.Color.Yellow
                    'Set default value CBOVent
                    Me.CboVent.Text = "Currently"
                    'Set CboVentChanged to false for new referrals
                    CboVentChanged = False
                    'CboVent.BackColor = vbYellow '&HFFFF&
                End If
                'change to CboVent back ground color to yellow and confirm the CboVentChanged is set to false for new records
                If Me.FormState = NEW_RECORD And CboVentChanged = False Then
                    CboVent.BackColor = System.Drawing.Color.Yellow
                    CboVentChanged = False
                End If
            Else
                Me.CboVent.Items.Clear()
                Call modControl.Disable(CboVent)
                CboVentChanged = True
                TxtDonorLastName.Focus()
            End If

            If CallerOrg.ServiceLevel.ExcludePrevVent = True And Me.CboVent.Items.Count = 0 Then
                'Clear the vent list
                Me.CboVent.Items.Clear()

                'Repopulate list with only "Never" and "Current"
                CboVent.Items.Add(New ValueDescriptionPair(2, "Currently"))
                CboVent.Items.Add(New ValueDescriptionPair(0, "Never"))

                'Set currently vented
                Me.CboVent.Text = "Currently"
                Me.CboVent.BackColor = System.Drawing.Color.Yellow
                CboVentChanged = False

            End If

            If CallerOrg.ServiceLevel.DOB = True Then Call modControl.Enable(TxtDOB) Else Call modControl.Disable(TxtDOB)
            If CallerOrg.ServiceLevel.DOBILB = True Then Call modControl.Enable(ChkDOB) Else Call modControl.Disable(ChkDOB)
            If CallerOrg.ServiceLevel.DOA = True Then Call modControl.Enable(ChkDOA) Else Call modControl.Disable(ChkDOA)
            If CallerOrg.ServiceLevel.DeathDate = True Then Call modControl.Enable(TxtDeathDate) Else Call modControl.Disable(TxtDeathDate)
            If CallerOrg.ServiceLevel.DeathTime = True Then Call modControl.Enable(TxtDeathTime) Else Call modControl.Disable(TxtDeathTime)

            'LSA is linked to CTOD Service Level - CCRST151 - ccarroll 09/06/2011
            If CallerOrg.ServiceLevel.DeathDate = True Then Call modControl.Enable(TxtLSADate) Else Call modControl.Disable(TxtLSADate)
            If CallerOrg.ServiceLevel.DeathTime = True Then Call modControl.Enable(TxtLSATime) Else Call modControl.Disable(TxtLSATime)

            If CallerOrg.ServiceLevel.BrainDeathDate = True Then Call modControl.Enable(TxtBrainDeathDate) Else Call modControl.Disable(TxtBrainDeathDate)
            If CallerOrg.ServiceLevel.BrainDeathTime = True Then Call modControl.Enable(TxtBrainDeathTime) Else Call modControl.Disable(TxtBrainDeathTime)
            If CallerOrg.ServiceLevel.AdmitDate = True Then Call modControl.Enable(TxtAdmitDate) Else Call modControl.Disable(TxtAdmitDate)
            If CallerOrg.ServiceLevel.AdmitTime = True Then Call modControl.Enable(TxtAdmitTime) Else Call modControl.Disable(TxtAdmitTime)
            If CallerOrg.ServiceLevel.CauseOfDeath = True Then Call modControl.Enable(CboCauseOfDeath) Else Call modControl.Disable(CboCauseOfDeath)
            If CallerOrg.ServiceLevel.SpecificCauseofDeath = True Then Call modControl.Enable(TxtSpecificCOD) Else Call modControl.Disable(TxtSpecificCOD)
            If CallerOrg.ServiceLevel.OTE_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            If CallerOrg.ServiceLevel.TE_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            If CallerOrg.ServiceLevel.E_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)

            If CallerOrg.ServiceLevel.ApproachMethod = True Then Call modControl.Enable(CboApproachType) Else Call modControl.Disable(CboApproachType)

            'T.T 09/22/04 commented out to add new service levels for NOK
            If CallerOrg.ServiceLevel.ApproachBy = True Then Call modControl.Enable(CboApproachedBy) Else Call modControl.Disable(CboApproachedBy)
            If CallerOrg.ServiceLevel.ApproachBy = True Then CmdApproachedByDetail.Enabled = True Else CmdApproachedByDetail.Enabled = False
            If CallerOrg.ServiceLevel.ApproachBy = True Then Call modControl.Enable(CboGeneralConsent) Else Call modControl.Disable(CboGeneralConsent)
            'If CallerOrg.ServiceLevel.NOKName = True Then Call modControl.Enable(TxtNOK) Else Call modControl.Disable(TxtNOK)
            'If CallerOrg.ServiceLevel.NOKRelation = True Then Call modControl.Enable(CboRelation) Else Call modControl.Disable(CboRelation)
            'If CallerOrg.ServiceLevel.NOKPhone = True Then Call modControl.Enable(TxtNOKPhone) Else Call modControl.Disable(TxtNOKPhone)
            'If CallerOrg.ServiceLevel.NOKAddress = True Then Call modControl.Enable(TxtNOKAddress) Else Call modControl.Disable(TxtNOKAddress)

            If Not CallerOrg.ServiceLevel.CoronerInfo = True Then
                If TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)) > -1 Then
                    Me.TabDisposition.TabPages.RemoveAt(TabDisposition.TabPages.IndexOf(tabDispositionTable(CORONER_TAB)))
                End If

            End If
            'Set physician
            If CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
                Call modControl.Disable(CboPhysician(0))
                Call modControl.Disable(CboPhysician(1))
                Call modControl.Disable(CmdPhysicianDetail(0))
                Call modControl.Disable(CmdPhysicianDetail(1))
                Call modControl.Disable(CmdPhysicianPhone(0))
                Call modControl.Disable(CmdPhysicianPhone(1))
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Disable(CboPhysician(0))
                Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                Call modControl.Disable(CmdPhysicianDetail(0))
                Call modControl.Enable(CmdPhysicianDetail(1))
                Call modControl.Disable(CmdPhysicianPhone(0))
                If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                Call modControl.Disable(CboPhysician(1))
                Call modControl.Enable(CmdPhysicianDetail(0))
                Call modControl.Disable(CmdPhysicianDetail(1))
                If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                Call modControl.Disable(CmdPhysicianPhone(1))
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                Call modControl.Enable(CmdPhysicianDetail(0))
                Call modControl.Enable(CmdPhysicianDetail(1))
                If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_NEVER And CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
                If CboVent.Text = "Previously" Or CboVent.Text = "Currently" Then
                    Try
                        Call modStatQuery.QueryLocationPhysicians(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Call modControl.Disable(CboPhysician(0))
                    Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Disable(CmdPhysicianDetail(0))
                    Call modControl.Enable(CmdPhysicianDetail(1))
                    Call modControl.Disable(CmdPhysicianPhone(0))
                    If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
                Else
                    Call modControl.Disable(CboPhysician(0))
                    Call modControl.Disable(CboPhysician(1))
                    Call modControl.Disable(CmdPhysicianDetail(0))
                    Call modControl.Disable(CmdPhysicianDetail(1))
                    Call modControl.Disable(CmdPhysicianPhone(0))
                    Call modControl.Disable(CmdPhysicianPhone(1))
                End If
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_ALWAYS And CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                If CboVent.Text = "Previously" Or CboVent.Text = "Currently" Then
                    Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CmdPhysicianDetail(0))
                    Call modControl.Enable(CmdPhysicianDetail(1))
                    If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                    If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
                Else
                    Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Disable(CboPhysician(1))
                    Call modControl.Enable(CmdPhysicianDetail(0))
                    Call modControl.Disable(CmdPhysicianDetail(1))
                    If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                    Call modControl.Disable(CmdPhysicianPhone(1))
                End If
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_VENT And CallerOrg.ServiceLevel.PronouncingMD = MD_ALWAYS Then
                Try
                    Call modStatQuery.QueryLocationPhysicians(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                If CboVent.Text = "Previously" Or CboVent.Text = "Currently" Then
                    Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CmdPhysicianDetail(0))
                    Call modControl.Enable(CmdPhysicianDetail(1))
                    If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                    If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
                Else
                    Call modControl.Disable(CboPhysician(0))
                    Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Disable(CmdPhysicianDetail(0))
                    Call modControl.Enable(CmdPhysicianDetail(1))
                    Call modControl.Disable(CmdPhysicianPhone(0))
                    If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
                End If
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_VENT And CallerOrg.ServiceLevel.PronouncingMD = MD_NEVER Then
                If CboVent.Text = "Previously" Or CboVent.Text = "Currently" Then
                    Try
                        Call modStatQuery.QueryLocationPhysicians(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Disable(CboPhysician(1))
                    Call modControl.Enable(CmdPhysicianDetail(0))
                    Call modControl.Disable(CmdPhysicianDetail(1))
                    If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                    Call modControl.Disable(CmdPhysicianPhone(1))
                Else
                    Call modControl.Disable(CboPhysician(0))
                    Call modControl.Disable(CboPhysician(1))
                    Call modControl.Disable(CmdPhysicianDetail(0))
                    Call modControl.Disable(CmdPhysicianDetail(1))
                    Call modControl.Disable(CmdPhysicianPhone(0))
                    Call modControl.Disable(CmdPhysicianPhone(1))
                End If
            ElseIf CallerOrg.ServiceLevel.AttendingMD = MD_VENT And CallerOrg.ServiceLevel.PronouncingMD = MD_VENT Then
                If CboVent.Text = "Previously" Or CboVent.Text = "Currently" Then
                    Try
                        Call modStatQuery.QueryLocationPhysicians(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Call modControl.Enable(CboPhysician(0), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CboPhysician(1), True) 'T.T 10/03/2004 added skip for enable
                    Call modControl.Enable(CmdPhysicianDetail(0))
                    Call modControl.Enable(CmdPhysicianDetail(1))
                    If CallerOrg.ServiceLevel.AttendingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(0)) Else Call modControl.Disable(CmdPhysicianPhone(0))
                    If CallerOrg.ServiceLevel.PronouncingMDPhone = True Then Call modControl.Enable(CmdPhysicianPhone(1)) Else Call modControl.Disable(CmdPhysicianPhone(1))
                Else
                    Call modControl.Disable(CboPhysician(0))
                    Call modControl.Disable(CboPhysician(1))
                    Call modControl.Disable(CmdPhysicianDetail(0))
                    Call modControl.Disable(CmdPhysicianDetail(1))
                    Call modControl.Disable(CmdPhysicianPhone(0))
                    Call modControl.Disable(CmdPhysicianPhone(1))
                End If
            End If

            'T.T 08/31/2006 check to see if anything is enabled on the disposition tab
            '**************************************************************************

            If CallerOrg.ServiceLevel.ApproachLevel = 0 Or CallerOrg.ServiceLevel.ApproachLevel = 2 Then
                If CallerOrg.ServiceLevel.ApproachOrgan = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(ORGAN))
                If CallerOrg.ServiceLevel.ApproachBone = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(BONE))
                If CallerOrg.ServiceLevel.ApproachTissue = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(TISSUE))
                If CallerOrg.ServiceLevel.ApproachSkin = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(SKIN))
                If CallerOrg.ServiceLevel.ApproachValves = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(VALVES))
                If CallerOrg.ServiceLevel.ApproachEyes = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(EYES))
                If CallerOrg.ServiceLevel.ApproachResearch = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboApproach(RESEARCH))

                If CallerOrg.ServiceLevel.ConsentOrgan = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(ORGAN))
                If CallerOrg.ServiceLevel.ConsentBone = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(BONE))
                If CallerOrg.ServiceLevel.ConsentTissue = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(TISSUE))
                If CallerOrg.ServiceLevel.ConsentSkin = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(SKIN))
                If CallerOrg.ServiceLevel.ConsentValves = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(VALVES))
                If CallerOrg.ServiceLevel.ConsentEyes = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(EYES))
                If CallerOrg.ServiceLevel.ConsentResearch = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboConsent(RESEARCH))

                If CallerOrg.ServiceLevel.RecoveryOrgan = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(ORGAN))
                If CallerOrg.ServiceLevel.RecoveryBone = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(BONE))
                If CallerOrg.ServiceLevel.RecoveryTissue = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(TISSUE))
                If CallerOrg.ServiceLevel.RecoverySkin = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(SKIN))
                If CallerOrg.ServiceLevel.RecoveryValves = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(VALVES))
                If CallerOrg.ServiceLevel.RecoveryEyes = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(EYES))
                If CallerOrg.ServiceLevel.RecoveryResearch = True Then Me.DispositionFieldEnabled = True Else Call modControl.Disable(CboRecovery(RESEARCH))
            End If
            '****************************************************************************

            If CallerOrg.ServiceLevel.AppropriateOrgan = True Then Call modControl.Enable(CboAppropriate(ORGAN)) Else Call modControl.Disable(CboAppropriate(ORGAN))
            If CallerOrg.ServiceLevel.AppropriateOrgan = True Then CmdOption(ORGAN).Enabled = True Else CmdOption(ORGAN).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateBone = True Then Call modControl.Enable(CboAppropriate(BONE)) Else Call modControl.Disable(CboAppropriate(BONE))
            If CallerOrg.ServiceLevel.AppropriateBone = True Then CmdOption(BONE).Enabled = True Else CmdOption(BONE).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateTissue = True Then Call modControl.Enable(CboAppropriate(TISSUE)) Else Call modControl.Disable(CboAppropriate(TISSUE))
            If CallerOrg.ServiceLevel.AppropriateTissue = True Then CmdOption(TISSUE).Enabled = True Else CmdOption(TISSUE).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateSkin = True Then Call modControl.Enable(CboAppropriate(SKIN)) Else Call modControl.Disable(CboAppropriate(SKIN))
            If CallerOrg.ServiceLevel.AppropriateSkin = True Then CmdOption(SKIN).Enabled = True Else CmdOption(SKIN).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateValves = True Then Call modControl.Enable(CboAppropriate(VALVES)) Else Call modControl.Disable(CboAppropriate(VALVES))
            If CallerOrg.ServiceLevel.AppropriateValves = True Then CmdOption(VALVES).Enabled = True Else CmdOption(VALVES).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateEyes = True Then Call modControl.Enable(CboAppropriate(EYES)) Else Call modControl.Disable(CboAppropriate(EYES))
            If CallerOrg.ServiceLevel.AppropriateEyes = True Then CmdOption(EYES).Enabled = True Else CmdOption(EYES).Enabled = False
            If CallerOrg.ServiceLevel.AppropriateResearch = True Then Call modControl.Enable(CboAppropriate(RESEARCH)) Else Call modControl.Disable(CboAppropriate(RESEARCH))
            If CallerOrg.ServiceLevel.AppropriateResearch = True Then CmdOption(RESEARCH).Enabled = True Else CmdOption(RESEARCH).Enabled = False

            If CallerOrg.ServiceLevel.ApproachLevel = 0 Then
                If Me.DispositionFieldEnabled = True Then

                    If CallerOrg.ServiceLevel.ApproachOrgan = True Then Call modControl.Enable(CboApproach(ORGAN)) Else Call modControl.Disable(CboApproach(ORGAN))
                    If CallerOrg.ServiceLevel.ApproachBone = True Then Call modControl.Enable(CboApproach(BONE)) Else Call modControl.Disable(CboApproach(BONE))
                    If CallerOrg.ServiceLevel.ApproachTissue = True Then Call modControl.Enable(CboApproach(TISSUE)) Else Call modControl.Disable(CboApproach(TISSUE))
                    If CallerOrg.ServiceLevel.ApproachSkin = True Then Call modControl.Enable(CboApproach(SKIN)) Else Call modControl.Disable(CboApproach(SKIN))
                    If CallerOrg.ServiceLevel.ApproachValves = True Then Call modControl.Enable(CboApproach(VALVES)) Else Call modControl.Disable(CboApproach(VALVES))
                    If CallerOrg.ServiceLevel.ApproachEyes = True Then Call modControl.Enable(CboApproach(EYES)) Else Call modControl.Disable(CboApproach(EYES))
                    If CallerOrg.ServiceLevel.ApproachResearch = True Then Call modControl.Enable(CboApproach(RESEARCH)) Else Call modControl.Disable(CboApproach(RESEARCH))

                    If CallerOrg.ServiceLevel.ConsentOrgan = True Then Call modControl.Enable(CboConsent(ORGAN)) Else Call modControl.Disable(CboConsent(ORGAN))
                    If CallerOrg.ServiceLevel.ConsentBone = True Then Call modControl.Enable(CboConsent(BONE)) Else Call modControl.Disable(CboConsent(BONE))
                    If CallerOrg.ServiceLevel.ConsentTissue = True Then Call modControl.Enable(CboConsent(TISSUE)) Else Call modControl.Disable(CboConsent(TISSUE))
                    If CallerOrg.ServiceLevel.ConsentSkin = True Then Call modControl.Enable(CboConsent(SKIN)) Else Call modControl.Disable(CboConsent(SKIN))
                    If CallerOrg.ServiceLevel.ConsentValves = True Then Call modControl.Enable(CboConsent(VALVES)) Else Call modControl.Disable(CboConsent(VALVES))
                    If CallerOrg.ServiceLevel.ConsentEyes = True Then Call modControl.Enable(CboConsent(EYES)) Else Call modControl.Disable(CboConsent(EYES))
                    If CallerOrg.ServiceLevel.ConsentResearch = True Then Call modControl.Enable(CboConsent(RESEARCH)) Else Call modControl.Disable(CboConsent(RESEARCH))

                    If CallerOrg.ServiceLevel.RecoveryOrgan = True Then Call modControl.Enable(CboRecovery(ORGAN)) Else Call modControl.Disable(CboRecovery(ORGAN))
                    If CallerOrg.ServiceLevel.RecoveryBone = True Then Call modControl.Enable(CboRecovery(BONE)) Else Call modControl.Disable(CboRecovery(BONE))
                    If CallerOrg.ServiceLevel.RecoveryTissue = True Then Call modControl.Enable(CboRecovery(TISSUE)) Else Call modControl.Disable(CboRecovery(TISSUE))
                    If CallerOrg.ServiceLevel.RecoverySkin = True Then Call modControl.Enable(CboRecovery(SKIN)) Else Call modControl.Disable(CboRecovery(SKIN))
                    If CallerOrg.ServiceLevel.RecoveryValves = True Then Call modControl.Enable(CboRecovery(VALVES)) Else Call modControl.Disable(CboRecovery(VALVES))
                    If CallerOrg.ServiceLevel.RecoveryEyes = True Then Call modControl.Enable(CboRecovery(EYES)) Else Call modControl.Disable(CboRecovery(EYES))
                    If CallerOrg.ServiceLevel.RecoveryResearch = True Then Call modControl.Enable(CboRecovery(RESEARCH)) Else Call modControl.Disable(CboRecovery(RESEARCH))
                Else
                    'T.T 08/31/2006 enable all the disposition fields
                    CallerOrg.ServiceLevel.ApproachOrgan = True
                    CallerOrg.ServiceLevel.ApproachBone = True
                    CallerOrg.ServiceLevel.ApproachTissue = True
                    CallerOrg.ServiceLevel.ApproachSkin = True
                    CallerOrg.ServiceLevel.ApproachValves = True
                    CallerOrg.ServiceLevel.ApproachEyes = True
                    CallerOrg.ServiceLevel.ApproachResearch = True

                    CallerOrg.ServiceLevel.ConsentOrgan = True
                    CallerOrg.ServiceLevel.ConsentBone = True
                    CallerOrg.ServiceLevel.ConsentTissue = True
                    CallerOrg.ServiceLevel.ConsentSkin = True
                    CallerOrg.ServiceLevel.ConsentValves = True
                    CallerOrg.ServiceLevel.ConsentEyes = True
                    CallerOrg.ServiceLevel.ConsentResearch = True

                    CallerOrg.ServiceLevel.RecoveryOrgan = True
                    CallerOrg.ServiceLevel.RecoveryBone = True
                    CallerOrg.ServiceLevel.RecoveryTissue = True
                    CallerOrg.ServiceLevel.RecoverySkin = True
                    CallerOrg.ServiceLevel.RecoveryValves = True
                    CallerOrg.ServiceLevel.RecoveryEyes = True
                    CallerOrg.ServiceLevel.RecoveryResearch = True
                    Call modControl.Enable(CboApproach(ORGAN))
                    Call modControl.Enable(CboApproach(BONE))
                    Call modControl.Enable(CboApproach(TISSUE))
                    Call modControl.Enable(CboApproach(SKIN))
                    Call modControl.Enable(CboApproach(VALVES))
                    Call modControl.Enable(CboApproach(EYES))
                    Call modControl.Enable(CboApproach(RESEARCH))

                    Call modControl.Enable(CboConsent(ORGAN))
                    Call modControl.Enable(CboConsent(BONE))
                    Call modControl.Enable(CboConsent(TISSUE))
                    Call modControl.Enable(CboConsent(SKIN))
                    Call modControl.Enable(CboConsent(VALVES))
                    Call modControl.Enable(CboConsent(EYES))
                    Call modControl.Enable(CboConsent(RESEARCH))

                    Call modControl.Enable(CboRecovery(ORGAN))
                    Call modControl.Enable(CboRecovery(BONE))
                    Call modControl.Enable(CboRecovery(TISSUE))
                    Call modControl.Enable(CboRecovery(SKIN))
                    Call modControl.Enable(CboRecovery(VALVES))
                    Call modControl.Enable(CboRecovery(EYES))
                    Call modControl.Enable(CboRecovery(RESEARCH))
                End If
            End If

            'T.T 08/31/2006 added for approach level
            If CallerOrg.ServiceLevel.ApproachLevel = 2 And Me.DispositionFieldEnabled = True Then
                If Not TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                    Me.TabDisposition.TabPages.Add(tabDispositionTable(DISPOSITION_TAB))
                End If
                If TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                    TabDisposition.SelectedIndex = TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB))
                End If

            End If

            'T.T 08/31/2006 SeviceLevel Only Display disposition based on fields
            If CallerOrg.ServiceLevel.ApproachLevel = 2 Then
                If CallerOrg.ServiceLevel.ApproachOrgan = True Then Call modControl.Enable(CboApproach(ORGAN)) Else Call modControl.Disable(CboApproach(ORGAN))
                If CallerOrg.ServiceLevel.ApproachBone = True Then Call modControl.Enable(CboApproach(BONE)) Else Call modControl.Disable(CboApproach(BONE))
                If CallerOrg.ServiceLevel.ApproachTissue = True Then Call modControl.Enable(CboApproach(TISSUE)) Else Call modControl.Disable(CboApproach(TISSUE))
                If CallerOrg.ServiceLevel.ApproachSkin = True Then Call modControl.Enable(CboApproach(SKIN)) Else Call modControl.Disable(CboApproach(SKIN))
                If CallerOrg.ServiceLevel.ApproachValves = True Then Call modControl.Enable(CboApproach(VALVES)) Else Call modControl.Disable(CboApproach(VALVES))
                If CallerOrg.ServiceLevel.ApproachEyes = True Then Call modControl.Enable(CboApproach(EYES)) Else Call modControl.Disable(CboApproach(EYES))
                If CallerOrg.ServiceLevel.ApproachResearch = True Then Call modControl.Enable(CboApproach(RESEARCH)) Else Call modControl.Disable(CboApproach(RESEARCH))

                If CallerOrg.ServiceLevel.ConsentOrgan = True Then Call modControl.Enable(CboConsent(ORGAN)) Else Call modControl.Disable(CboConsent(ORGAN))
                If CallerOrg.ServiceLevel.ConsentBone = True Then Call modControl.Enable(CboConsent(BONE)) Else Call modControl.Disable(CboConsent(BONE))
                If CallerOrg.ServiceLevel.ConsentTissue = True Then Call modControl.Enable(CboConsent(TISSUE)) Else Call modControl.Disable(CboConsent(TISSUE))
                If CallerOrg.ServiceLevel.ConsentSkin = True Then Call modControl.Enable(CboConsent(SKIN)) Else Call modControl.Disable(CboConsent(SKIN))
                If CallerOrg.ServiceLevel.ConsentValves = True Then Call modControl.Enable(CboConsent(VALVES)) Else Call modControl.Disable(CboConsent(VALVES))
                If CallerOrg.ServiceLevel.ConsentEyes = True Then Call modControl.Enable(CboConsent(EYES)) Else Call modControl.Disable(CboConsent(EYES))
                If CallerOrg.ServiceLevel.ConsentResearch = True Then Call modControl.Enable(CboConsent(RESEARCH)) Else Call modControl.Disable(CboConsent(RESEARCH))

                If CallerOrg.ServiceLevel.RecoveryOrgan = True Then Call modControl.Enable(CboRecovery(ORGAN)) Else Call modControl.Disable(CboRecovery(ORGAN))
                If CallerOrg.ServiceLevel.RecoveryBone = True Then Call modControl.Enable(CboRecovery(BONE)) Else Call modControl.Disable(CboRecovery(BONE))
                If CallerOrg.ServiceLevel.RecoveryTissue = True Then Call modControl.Enable(CboRecovery(TISSUE)) Else Call modControl.Disable(CboRecovery(TISSUE))
                If CallerOrg.ServiceLevel.RecoverySkin = True Then Call modControl.Enable(CboRecovery(SKIN)) Else Call modControl.Disable(CboRecovery(SKIN))
                If CallerOrg.ServiceLevel.RecoveryValves = True Then Call modControl.Enable(CboRecovery(VALVES)) Else Call modControl.Disable(CboRecovery(VALVES))
                If CallerOrg.ServiceLevel.RecoveryEyes = True Then Call modControl.Enable(CboRecovery(EYES)) Else Call modControl.Disable(CboRecovery(EYES))
                If CallerOrg.ServiceLevel.RecoveryResearch = True Then Call modControl.Enable(CboRecovery(RESEARCH)) Else Call modControl.Disable(CboRecovery(RESEARCH))
            End If

            'T.T 11/20/2006 set servicelevel disposition tab
            If Not CallerOrg.ServiceLevel.ApproachLevel = 0 And (Not CallerOrg.ServiceLevel.ApproachLevel = 2 And Not Me.DispositionFieldEnabled = True) Then
                If TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)) > -1 Then
                    Me.TabDisposition.TabPages.RemoveAt(TabDisposition.TabPages.IndexOf(tabDispositionTable(DISPOSITION_TAB)))
                End If
            End If

            'Determine if custom data is available
            If CallerOrg.ServiceLevel.CustomPromptOn = True Then Call modControl.Enable(CmdCustomData) Else CmdCustomData.Visible = False

            'Determine if secondary tab should be displayed
            If CallerOrg.ServiceLevel.SecondaryOn = True Then
                If CallerOrg.ServiceLevel.SecondaryHistory = True Then Call modControl.Enable(TxtSecondaryNote) Else Call modControl.Disable(TxtSecondaryNote)
                TxtSecondaryAlert.Text = CallerOrg.ServiceLevel.SecondaryAlert
                CmdContactCoroner.Visible = True
            Else
                If TabDonor.TabPages.IndexOf(tabDonorTable(1)) > -1 Then
                    Me.TabDonor.TabPages.RemoveAt(TabDonor.TabPages.IndexOf(tabDonorTable(1)))
                End If

            End If

        End If

        If Me.CallerOrg.ServiceLevel.DCDPotentialMessageEnabled IsNot Nothing Then
            CmdDcdPotential.Visible = IIf(Me.CallerOrg.ServiceLevel.DCDPotentialMessageEnabled = -1, True, False)
        End If

        GbPendingCase.Visible = Me.CallerOrg.ServiceLevel.PendingCase.ToString().Equals("-1")

        '7/3/01 drh Determine if FS Stages should be visible and enabled
        Try
            Call GetFSStage()
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Try
            Call CboApproachType_SelectedIndexChanged(CboApproachType, New System.EventArgs())
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Sub txtWeight_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtWeight.Leave
        '====================================================================================
        'Date Changed: 6/07/2007                          Changed by: Thien Ta
        'Release #: 8.4                               Requirement:8.4.3.4.1,8.4.3.4.11, 8.4.3.4.1.1.1, 8.4.3.4.1.1.2, 8.4.3.4.1.2, 8.4.3.4.1.3
        'Description:  Added VerifyWeight and Verify Gender
        '====================================================================================
        If LblWeight.Text = "lbs" And IsNumeric(TxtWeight.Text) Then
            TxtWeight.Text = FormatNumber(System.Math.Round(CDbl(TxtWeight.Text) / 2.2, 1), 1)
            LblWeight.Text = "kg"
        End If

        'Verify
        If TxtWeight.Text <> OldValue Then
            Me.vVerifyWeight = False 'T.T 06/10/2007 flag set to verify weight
            If TxtAge.Text <> "" And CboAgeUnit.Text <> "" Then
                Select Case CallerOrg.ServiceLevel.TriageLevel

                    Case VENT_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, False, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, False, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_ONLY
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, False, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    Case VENT_AGE_MRO
                        Try
                            Call modStatValidate.VerifyReferral(Me, True, True, True, True)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                End Select
            End If
        End If

        OldValue = ""

        '10/2/01 drh
        ' Commented out for V. 7.7.31.  3/2/05 - SAP
        'Call ValidateForDonorIntent
        If Me.CallerOrg.ServiceLevel.VerifyWeight = -1 Then
            Call VerifyWeight()
        End If
    End Sub
    Public Sub VerifyWeight()
        '************************************************************************************
        'Name: VerifyWeight
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: req 3.4.1.2
        'Description: verify Weight when a referral is ruled out
        'Returns:
        'Params:
        'Stored Procedures: None
        '====================================================================================


        'MsgBox Me.sPrelimRefTypeDesc
        'If TxtWeight.Text <> OldValue Then
        If TxtWeight.Text <> "" Then
            Me.WeightRuleOut = False
            If Me.vVerifyWeight = False Then
                VerifyWeightRuleout()
                If Me.WeightRuleOut = True Then
                    frmVerifyWeight = New FrmVerifyWeight()
                    frmVerifyWeight.modalParent = Me
                    Dim dialogResult As DialogResult = frmVerifyWeight.ShowDialog() 'Show modal
                    frmVerifyWeight = Nothing
                End If
            End If
        End If
        'End If



    End Sub
    Public Sub VerifyWeightValidate()

        Select Case CallerOrg.ServiceLevel.TriageLevel

            Case VENT_ONLY
                Call modStatValidate.VerifyReferral(Me, True, False, False, True)

            Case AGE_ONLY
                Call modStatValidate.VerifyReferral(Me, False, True, False, True)

            Case VENT_AGE_ONLY
                Call modStatValidate.VerifyReferral(Me, True, True, False, True)

            Case VENT_AGE_MRO
                Call modStatValidate.VerifyReferral(Me, True, True, True, True)

        End Select



    End Sub
    Public Sub VerifyWeightRuleout()
        '************************************************************************************
        'Name: VerifyWeightRuleout
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: 3.4
        'Description: verify Weight when a referral is ruled out get criteria for organization
        'Returns:
        'Params:
        'Stored Procedures: None
        '================================================================================
        'Date Changed: 6/19/2008                          Changed by: ccarroll
        'Release #: 8.4.6                               Requirement:
        'Description:  moved SQL to sproc, rewrote function
        '************************************************************************************

        Dim vReturn As New Object
        Dim vResultArray As New Object
        Dim vQuery As New Object
        Dim I As New Object
        Dim MinWeight As Double
        Dim MaxWeight As Double
        Dim DonorWeight As Double

        DonorWeight = modConv.TextToDbl(Me.TxtWeight.Text)

        vQuery = "sps_VerifyWeightRuleout " & Me.OrganizationId & ", " & Me.SourceCode.ID & " "
        Try
            vReturn = modODBC.Exec(vQuery, vResultArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        For I = 0 To UBound(vResultArray)

            'Get weight limits from array
            MinWeight = modConv.TextToDbl(vResultArray(I, 2))
            MaxWeight = modConv.TextToDbl(vResultArray(I, 3))

            'Evaluate minimum weight limit
            If vResultArray(I, 2) <> "" Then
                If DonorWeight < MinWeight Then 'And CboAppropriate(I).Enabled = True Then
                    Me.WeightRuleOut = True
                End If
            End If

            'Evaluate maximum weight limit
            If vResultArray(I, 3) <> "" Then
                If DonorWeight > MaxWeight Then 'And CboAppropriate(I).Enabled = True Then
                    Me.WeightRuleOut = True
                End If
            End If

        Next I




    End Sub


    Public Sub SetDisposition()

    End Sub



    Public Function GetServiceLevel(ByVal DispositionType As Short, ByVal Index As Short) As Boolean

        Select Case DispositionType

            Case GIVEN

                Select Case Index
                    Case ORGAN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateOrgan
                    Case BONE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateBone
                    Case TISSUE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateTissue
                    Case SKIN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateSkin
                    Case VALVES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateValves
                    Case EYES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateEyes
                    Case RESEARCH
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.AppropriateResearch
                End Select

            Case APPROACHED

                Select Case Index
                    Case ORGAN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachOrgan
                    Case BONE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachBone
                    Case TISSUE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachTissue
                    Case SKIN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachSkin
                    Case VALVES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachValves
                    Case EYES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachEyes
                    Case RESEARCH
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ApproachResearch
                End Select

            Case CONSENT

                Select Case Index
                    Case ORGAN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentOrgan
                    Case BONE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentBone
                    Case TISSUE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentTissue
                    Case SKIN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentSkin
                    Case VALVES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentValves
                    Case EYES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentEyes
                    Case RESEARCH
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.ConsentResearch
                End Select

            Case CONVERT

                Select Case Index
                    Case ORGAN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryOrgan
                    Case BONE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryBone
                    Case TISSUE
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryTissue
                    Case SKIN
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoverySkin
                    Case VALVES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryValves
                    Case EYES
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryEyes
                    Case RESEARCH
                        GetServiceLevel = Me.CallerOrg.ServiceLevel.RecoveryResearch
                End Select

        End Select

    End Function


    Private Sub ChangeDonorCategory(ByRef vOrganizationId As Integer, ByRef vSourceCodeName As String)

        Dim vStatus As Short
        Dim vOption As New Object
        Dim LoopCount As Short
        'Query DonorCategories
        Try
            vStatus = modStatQuery.QueryDynamicDonorCategory(vOption, vOrganizationId, vSourceCodeName)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        'setDonorCategories
        'check for each value before assigning
        If vStatus = 0 Then
            For LoopCount = 0 To UBound(vOption, 1)
                CmdOption(CShort(vOption(LoopCount, 0))).Text = vOption(LoopCount, 1)

            Next

        End If

    End Sub
    Private Sub VP_Timer_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)

    End Sub

    Private Function SetHeartBeatColor() As Object

        '**********************************************************************************
        '**** 1/12/04 mds
        '**** This funtion handles the back color and status of the heartbeat field. Err 91
        '**** occurs when the form is loaded, so the status and back color are set
        '**** appropriately when that error occurs.
        '**** The function determines if it should changed the color based on the current
        '**** control - they can only change if CboHeartBeat is the currently control.
        '**********************************************************************************

        If Me.ActiveControl Is Nothing Then
            CboHeartBeatChanged = False
            If CboHeartBeat.Enabled = True Then
                CboHeartBeat.BackColor = System.Drawing.Color.Yellow
            End If
            Exit Function
        End If

        If Me.ActiveControl.Name = "CboHeartBeat" Then
            CboHeartBeatChanged = True
            CboHeartBeat.BackColor = System.Drawing.Color.White
        Else
            '1/12/04 mds: added check to only change the color and status if the user
            'hasn't already set the heartbeat value
            If CboHeartBeatChanged = True Then
                'do nothing
            Else
                CboHeartBeatChanged = False
                CboHeartBeat.BackColor = System.Drawing.Color.Yellow
            End If
        End If

    End Function

    Private Function ConfirmHeartBeatVent() As Boolean

        Dim vReturn As Short

        '*****************************************************************************
        '*** 01/06/04 mds
        '*** Added this entire Sub from Bret's original Heartbeat changes made in
        '*** April and May 2003.  Changed the dates and initials for searching purposes.
        '*****************************************************************************

        '01/06/04 mds confirm both the heart beat and vent have been answered
        If CboVentChanged = True And CboHeartBeatChanged = True Then
            '01/06/04 mds This function notifies the coordinator that the Vent and Heart Beat values are in
            ' conflict and asks them to confirm the values
            If (modControl.GetID(CboHeartBeat) = HEART_BEAT_NO And modControl.GetID(CboVent) = VENT_PREV) Or (modControl.GetID(CboHeartBeat) = HEART_BEAT_YES And ((modControl.GetID(CboVent) = VENT_PREV) Or (modControl.GetID(CboVent) = VENT_NEVER))) Then
                'Heart Beat is No and vent is Previously
                ' OR
                ' Heart Beat is Yes and vent is either Previously or Never
                Call MsgBox("Double check Heartbeat and Vent status before proceeding.", MsgBoxStyle.Exclamation, "Confirm Values")
            Else
                '01/06/04 mds Heartbeat cannot be NO if vent is CURRENTLY
                If (modControl.GetID(CboHeartBeat) = HEART_BEAT_NO And modControl.GetID(CboVent) = VENT_CURRENT) Then
                    vReturn = modMsgForm.InvalidHeartBeatVentCombo
                End If
            End If
        End If
    End Function

    Function RegistryLogEvent() As Boolean
        '************************************************************************************
        'Name: RegistryLogEvent()
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: req 3.4.1.2
        'Description: Registry log event saving
        'Returns:
        'Params:
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 06/25/2007                      Changed by: Thien Ta
        'Release #: 8.4                              Task:
        'Description:   columns have shifted in the event log changing subitems to new feature
        '====================================================================================
        'Date Changed: 09/20/2007                    Changed by: Bret Knoll
        'Release #: 8.4                              Task: Project: StatTrac 8.0
        '                                                  Issue: 6753  Donor Registry Note Should Say
        'Description:   Modify Events displayed when registrants are found
        '====================================================================================

        Dim strNotChecked As String = ""
        Dim vLogEventID As Integer
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        Dim vMessageExtension As String = ""
        Dim vEventID As New Object
        Dim ChangeMessage As String = ""
        Dim x As New Object
        Dim OldMessage As String = ""

        'bret 09/19/07 check for rule out. change event message if ruleout
        'if the case is a ruleout create a message
        'treate the message different depending on number of registrancs found

        'ccarroll 10/29/2007 changed logic of If statement for printing rule-out note
        If Me.FormState = NEW_RECORD And
           pvCurrentReferralType = RULEOUT And
           Me.CmdRegMatch.Visible = True And
           (Me.cboRegistryStatus.Text = "Not Checked" Or
            (Me.cmdDonorIntent.Enabled = False And Me.cboRegistryStatus.Text <> "Not on Registry")) Then

            If lastDonorSearchResults.Length > 1 Then
                strRegistryMessage = "Multiple"
            Else
                strRegistryMessage = lastDonorSearchResults.Length.ToString()
            End If

            strRegistryMessage = strRegistryMessage & " Instance(s) of " & Me.TxtDonorFirstName.Text & " " & Me.TxtDonorLastName.Text & " found in registry. This referral has been ruled out."

            'Save the event
            Try
                Call modStatSave.SaveLogEvent(Me, GENERAL, strRegistryMessage)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Exit Function
        End If

        'ccarroll 10/15/2007 - Empirix 7011 - moved location, added check for donor intent
        If Me.cboRegistryStatus.Text = "Not Checked" Or (Me.cmdDonorIntent.Enabled = False And Me.cboRegistryStatus.Text <> "Not on Registry") Then
            Exit Function
        End If

        Call Me.SetServiceLevel(Me)
        If Me.CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent Then

            If Not DonorSearchState.WasSearched Then
                If vNoteChange <> "" Then

                    'TODO: Condense the loop and if statement so we only iterate through relevant items in LstViewLogEvents
                    For x = 0 To LstViewLogEvent.Items.Count - 1
                        'T.T 06/25/2007 columns have shifted over changed subitems
                        If LstViewLogEvent.Items.Item(x).SubItems(1).Text = "Note" And LstViewLogEvent.Items.Item(x).SubItems(2).Text = "Donor Registry" Then
                            vLogEventID = LstViewLogEvent.Items.Item(x).Tag

                            'T.T 10/06/2004 This section of code will modify the Registry note when the registry has been searched again.
                            '**********************************************************
                            vEventID = vLogEventID
                            Try
                                OldMessage = modStatQuery.ChangeQueryLogEvent(vEventID)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try
                            If VB.Left(OldMessage, 7) <> "INVALID" Then
                                ChangeMessage = "INVALID NOTE: "
                                If Me.vNoteChange = "FirstName" Then
                                    ChangeMessage = ChangeMessage & " The FirstName has been changed ." '& OldMessage
                                ElseIf Me.vNoteChange = "LastName" Then
                                    ChangeMessage = ChangeMessage & " The LastName has been changed ." '& OldMessage
                                ElseIf Me.vNoteChange = "DOB" Then
                                    ChangeMessage = ChangeMessage & " The DOB has been changed . " '&' OldMessage
                                ElseIf Me.TxtDonorFirstName.Text = "" Then
                                    ChangeMessage = ChangeMessage & " The Registry has not been Checked because Missing First Name"
                                ElseIf Me.TxtDonorLastName.Text = "" Then
                                    ChangeMessage = ChangeMessage & " The Registry has not been Checked because Missing Last Name"
                                ElseIf Me.TxtDOB.Text = "" Then
                                    ChangeMessage = ChangeMessage & " The Registry has not been Checked because Missing DOB"
                                ElseIf Me.vNoteChange = "Multiple" Then
                                    ChangeMessage = ChangeMessage & " The Registry has been searched Again"
                                ElseIf Me.vNoteChange = "Canceled" Then
                                    ChangeMessage = "Registry information changed due to change in Registry Status"
                                Else
                                    ChangeMessage = ChangeMessage & "The Registry has Changed"
                                End If

                                '& Environment.NewLine & ChangeMessage
                                Try
                                    Call modStatSave.DeleteLogEventID(vLogEventID, (Me.CallId))
                                    Call modStatSave.SaveLogEvent(Me, GENERAL, ChangeMessage)
                                Catch ex As Exception
                                    StatTracLogger.CreateInstance().Write(ex)
                                End Try
                            End If

                            If Me.TxtDonorFirstName.Text = "" Then
                                strNotChecked = "has not been Checked because Missing First Name"
                            ElseIf Me.TxtDonorLastName.Text = "" Then
                                strNotChecked = "has not been Checked because Missing Last Name"
                            ElseIf Me.TxtDOB.Text = "" Then
                                strNotChecked = "has not been Checked because Missing DOB"
                            End If

                            strRegistryMessage = strRegistryMessage & Chr(13) & Chr(10) & vMessageExtension
                            '                                End If

                            Try
                                Call modStatSave.SaveLogEvent(Me, GENERAL, "The Registry has Changed" & strNotChecked)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try

                        End If


                    Next x

                End If 'vNote



            End If 'DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.Unknown
        End If 'ServiceLevel
        If DonorSearchState.WasSearched Then
            If strRegistryMessage <> "" Then
                '*********log the event********


                For x = 0 To LstViewLogEvent.Items.Count - 1
                    'T.T 06/25/2007 columns have shifted over changed subitems
                    If LstViewLogEvent.Items.Item(x).SubItems(1).Text = "Note" And LstViewLogEvent.Items.Item(x).SubItems(2).Text = "Donor Registry" Then
                        vLogEventID = LstViewLogEvent.Items.Item(x).Tag

                        'T.T 10/06/2004 This section of code will modify the Registry note when the registry has been searched again. *CodeReview
                        '**********************************************************
                        vEventID = vLogEventID
                        Try
                            OldMessage = modStatQuery.ChangeQueryLogEvent(vEventID)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                        If VB.Left(OldMessage, 7) <> "INVALID" Then
                            ChangeMessage = "INVALID NOTE: "

                            If Me.vNoteChange = "FirstName" Then
                                ChangeMessage = ChangeMessage & " The FirstName has been changed ." '& OldMessage
                            ElseIf Me.vNoteChange = "LastName" Then
                                ChangeMessage = ChangeMessage & " The LastName has been changed ." '& OldMessage
                            ElseIf Me.vNoteChange = "DOB" Then
                                ChangeMessage = ChangeMessage & " The DOB has been changed . " '&' OldMessage
                            ElseIf Me.vNoteChange = "Multiple" Then
                                ChangeMessage = ChangeMessage & " The Registry has been searched Again"
                            ElseIf Me.vNoteChange = "Canceled" Then
                                ChangeMessage = "Registry information changed due to change in Registry Status"

                            Else
                                ChangeMessage = ChangeMessage & "The Registry has Changed"
                            End If

                            '& Environment.NewLine & ChangeMessage
                            Try
                                Call modStatSave.DeleteLogEventID(vLogEventID, (Me.CallId))
                                Call modStatSave.SaveLogEvent(Me, GENERAL, ChangeMessage)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try
                        End If

                    End If

                    If vLogEventID > 0 Then
                        'Call modStatSave.DeleteLogEventID(vLogEventID, Me.CallId)
                        'Call modStatSave.SaveLogEvent(me,General)
                    End If
                Next x
                If Me.DonorSearchState.HasDonor Then
                    Dim donorService As DonorService = New DonorServiceFactory(CallerOrg.ServiceLevel.ID).Create()
                    Try
                        vMessageExtension = donorService.GetFormattedDonorDetailsAsync(Me).GetAwaiter().GetResult()
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                Else
                    vMessageExtension = ""
                End If

                strRegistryMessage = strRegistryMessage & Chr(13) & Chr(10) & vMessageExtension

                'Save the event
                Try
                    Call modStatSave.SaveLogEvent(Me, GENERAL, strRegistryMessage)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        End If

    End Function

    Public Function SetOrganization() As Object
        '************************************************************************************
        'Date Changed: 6/03/05                          Changed by: Char Chaput
        'Release #: 8.0                               Task: 400
        'Description:  Added this function due to Referral screen redesign and no
        '              longer having organization changes on referral screen.
        '              All functionality for referral screen fields that was
        '              previously done on org click, lost focus etc. is now done in here
        '              and called from CmdModify after changes in NewCall screen.
        '====================================================================================
        'Date Changed: 08/31/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: Empirix 6805
        'Description:   Reset CriteriatGroupID and ReferralTriageCriteria
        '
        '====================================================================================
        '************************************************************************************


        'JH 07/30/10 this was declared as an object and s/b int...which was causing the donor intent button to show incorrectly
        Dim vServiceLevelStatus As Integer 'New Object


        '08/31/2007 8.4 Empirix 6805
        Call Me.ClearCriteria()
        Me.CriteriaGroupID = 0


        'Get the time zone of the organization
        Try
            Call modStatQuery.QueryOrganizationTimeZone(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Instead of default alert above now get the general alert
        'default alerts show with source code on New call screen
        Try
            Call modStatQuery.QueryOrganizationAlert(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Me.FormLoad = False Then


            'Find the names that match the selected location
            Try
                Call modStatQuery.QueryLocationPerson(Me)
                Call modStatQuery.QueryLocationApproachPerson(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


            'Clear ServiceLevelId and Criteria collection if this is a different org
            'If SC is different, reset the ServiceLevel and Criteria
            If Me.SourceCode.ID <> vOriginalSC Then
                Me.ServiceLevelId = 0
                Call Me.ZeroCriteria()
            End If
            '******************************************************************************************

            'Determine CheckRegistryValue
            Dim CheckRegistryValue As Integer
            Try
                CheckRegistryValue = GetCheckRegistryValue(vServiceLevelStatus, Me.ServiceLevelId)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                CheckRegistryValue = -1
            End Try

            '9/28/01 drh
            'Set NOK Components
            'If organization changed, we need to get the organization's Check Registry Value
            'FSProj drh 5/3/02 - Added vServiceLevelStatus parameter to GetCheckRegistryValue call
            If Not CheckRegistryValue Then
                'Determine whether DonorIntent button was not red (before calling SetNOKComponents)
                Dim DonorIntentWasNotRed As Boolean = Not cmdDonorIntent.ForeColor.Name.Equals("Red")
                'Determine whether donor was not found
                Dim DonorNotFound As Boolean = False
                If cboRegistryStatus.SelectedIndex > -1 Then
                    DonorNotFound = cboRegistryStatus.Items(cboRegistryStatus.SelectedIndex).Equals("Not on Registry")
                End If

                'If Donor Intent is "ON", disable NOK and Save
                Call SetNOKComponents("Disable")
                'By default Donor Intent button is "OFF"
                cmdDonorIntent.Visible = True
                'Disable DonorIntent button if it was anything but red or if donor wasn't found
                If DonorIntentWasNotRed Or DonorNotFound Then
                    cmdDonorIntent.Enabled = False
                End If

                'drh 11/21/01 Hide Registry button when it's Donor Intent (related to #49)

                'drh 11/21/01 Added else to enable OK button; See Issue #49
            Else
                CmdOK.Enabled = True
                'cmdRegistry.Enabled = True
                'cmdRegistry.Visible = True
            End If

        End If

        Try
            'Check the properties of the location
            Call modStatQuery.QueryOrganizationProperties(Me)

            'Get the county and state ids
            Call modStatQuery.QueryOrganizationCountyID(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        'Using the organizationID selected update the Donor Categories
        Call ChangeDonorCategory((Me.OrganizationId), (Me.SourceCode.Name))

        'ccarroll 08/22/2011 wi:13183 
        If Me.OrganizationId <> vOriginalOrgId Then
            're-load criteria for new organization
            Call Me.PopulateCriteria()
        End If

        Call ConfirmHeartBeatVent()

        'Set physician
        Try
            Call InitializePhysician(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Function

    Public Sub UpdateFormCaption()
        '************************************************************************************
        'Name: UpdateFormCaption
        'Date Created: 6/13/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Updates caption of frmReferral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '************************************************************************************

        ' Set the display description string for the preliminary referral type
        Select Case pvPrelimReferralType
            Case ORGAN_TISSUE_EYE
                sPrelimRefTypeDesc = ORGAN_TISSUE_EYE_DESC ' "Organ/Tissue/Eye"
                If CallerOrg.ServiceLevel.OTE_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            Case TISSUE_EYE
                sPrelimRefTypeDesc = TISSUE_EYE_DESC ' "Tissue/Eye"
                If CallerOrg.ServiceLevel.TE_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            Case EYE_ONLY
                sPrelimRefTypeDesc = EYE_ONLY_DESC ' "Eyes Only"
                If CallerOrg.ServiceLevel.E_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            Case RULEOUT
                sPrelimRefTypeDesc = RULEOUT_DESC ' "Ruleout"
            Case Else
                sPrelimRefTypeDesc = ""
        End Select

        ' Set the display description string for the current referral type
        Select Case Me.pvCurrentReferralType
            Case ORGAN_TISSUE_EYE
                sCurrentRefTypeDesc = ORGAN_TISSUE_EYE_DESC ' "Organ/Tissue/Eye"
                If CallerOrg.ServiceLevel.OTE_MROLevel = 2 Then
                    If CallerOrg.ServiceLevel.PrevVentClass = PREVVENT_OTE And modControl.GetID(CboAppropriate(ORGAN)) = APPROP_PREVIOUS_VENT Then
                        Call modControl.Enable(TxtNotesCase)
                    Else
                        Call modControl.Disable(TxtNotesCase)
                    End If
                End If
            Case TISSUE_EYE
                sCurrentRefTypeDesc = TISSUE_EYE_DESC ' "Tissue/Eye"
                If CallerOrg.ServiceLevel.TE_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            Case EYE_ONLY
                sCurrentRefTypeDesc = EYE_ONLY_DESC ' "Eyes Only"
                If CallerOrg.ServiceLevel.E_MROLevel <> 2 Then Call modControl.Enable(TxtNotesCase) Else Call modControl.Disable(TxtNotesCase)
            Case RULEOUT
                sCurrentRefTypeDesc = RULEOUT_DESC ' "Ruleout"
                'Call modControl.Disable(TxtNotesCase)
            Case TISSUE_EYE
                sCurrentRefTypeDesc = TISSUE_EYE_DESC ' "Tissue/Eye"
            Case ORGAN_TISSUE
                sCurrentRefTypeDesc = ORGAN_TISSUE_DESC ' "Organ/Tissue"
            Case ORGAN_EYE
                sCurrentRefTypeDesc = ORGAN_EYE_DESC ' "Organ/Eye"
            Case ORGAN_
                sCurrentRefTypeDesc = ORGAN_DESC ' "Organ"
            Case TISSUE_
                sCurrentRefTypeDesc = TISSUE_DESC ' "Tissue"
            Case Else
                sCurrentRefTypeDesc = ""
        End Select

        If Me.TxtDonorLastName.Text <> "" And Me.TxtDonorFirstName.Text = "" Then
            Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name & "     Patient: " & Me.TxtDonorLastName.Text & ", " & Me.TxtDonorFirstName.Text & "     Preliminary Ref. Type: " & sPrelimRefTypeDesc & "      Current Ref. Type:" & sCurrentRefTypeDesc
        ElseIf Me.TxtDonorLastName.Text = "" And Me.TxtDonorFirstName.Text <> "" Then
            Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name & "     Patient: " & Me.TxtDonorFirstName.Text & ", " & Me.TxtDonorFirstName.Text & "     Preliminary Ref. Type: " & sPrelimRefTypeDesc & "      Current Ref. Type:" & sCurrentRefTypeDesc
        ElseIf Me.TxtDonorLastName.Text <> "" And Me.TxtDonorFirstName.Text <> "" Then
            Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name & "     Patient: " & Me.TxtDonorLastName.Text & ", " & Me.TxtDonorFirstName.Text & "     Preliminary Ref. Type: " & sPrelimRefTypeDesc & "      Current Ref. Type:" & sCurrentRefTypeDesc
        ElseIf Me.TxtDonorLastName.Text = "" And Me.TxtDonorFirstName.Text = "" Then
            Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name & "     Patient:               Preliminary Ref. Type: " & sPrelimRefTypeDesc & "      Current Ref. Type:" & sCurrentRefTypeDesc

        End If
    End Sub

    Private Function Check_ServiceLevel_Weight() As Object
        '************************************************************************************
        'Name: Check_ServiceLevel_Weight
        'Date Created: 10/9/07                         Created by: Bret Knoll
        'Release: 8.4                                  Task: Issue: 7015  Weight Service Level Displaying Field When Not Set
        'Description: Run Common Code
        'Returns: NA
        '====================================================================================
        Dim Age As Double

        If CallerOrg.ServiceLevel.Weight And TxtAge.Text <> "" And CboAgeUnit.Text <> "" Then
            'Convert age to years
            Select Case CboAgeUnit.Text
                Case "Years"
                    Age = CShort(TxtAge.Text)
                Case "Months"
                    Age = modConv.AgeMonthsToYears(modConv.AgeMonths(TxtDOB.Text))
                Case "Days"
                    Age = modConv.AgeDaysToYears(modConv.Age((TxtDOB.Text)))
            End Select


            If Age > CallerOrg.ServiceLevel.WeightAgeUpperLimit And CallerOrg.ServiceLevel.WeightAgeUpperLimit <> 0 Then
                TxtWeight.Text = String.Empty
                Call modControl.Disable(TxtWeight)
            Else
                Call modControl.Enable(TxtWeight)
            End If

        End If

    End Function
    Private Sub Initialize_DisopositionControls()
        CboAppropriate = New Hashtable()
        CboApproach = New Hashtable()
        CboRecovery = New Hashtable()
        CboConsent = New Hashtable()
        CboAppropriate.Add(ORGAN, _CboAppropriate_1)
        CboAppropriate.Add(BONE, _CboAppropriate_2)
        CboAppropriate.Add(TISSUE, _CboAppropriate_3)
        CboAppropriate.Add(SKIN, _CboAppropriate_4)
        CboAppropriate.Add(VALVES, _CboAppropriate_5)
        CboAppropriate.Add(EYES, _CboAppropriate_6)
        CboAppropriate.Add(RESEARCH, _CboAppropriate_7)
        CboApproach.Add(ORGAN, _CboApproach_1)
        CboApproach.Add(BONE, _CboApproach_2)
        CboApproach.Add(TISSUE, _CboApproach_3)
        CboApproach.Add(SKIN, _CboApproach_4)
        CboApproach.Add(VALVES, _CboApproach_5)
        CboApproach.Add(EYES, _CboApproach_6)
        CboApproach.Add(RESEARCH, _CboApproach_7)
        CboRecovery.Add(ORGAN, _CboRecovery_1)
        CboRecovery.Add(BONE, _CboRecovery_2)
        CboRecovery.Add(TISSUE, _CboRecovery_3)
        CboRecovery.Add(SKIN, _CboRecovery_4)
        CboRecovery.Add(VALVES, _CboRecovery_5)
        CboRecovery.Add(EYES, _CboRecovery_6)
        CboRecovery.Add(RESEARCH, _CboRecovery_7)
        CboConsent.Add(ORGAN, _CboConsent_1)
        CboConsent.Add(BONE, _CboConsent_2)
        CboConsent.Add(TISSUE, _CboConsent_3)
        CboConsent.Add(SKIN, _CboConsent_4)
        CboConsent.Add(VALVES, _CboConsent_5)
        CboConsent.Add(EYES, _CboConsent_6)
        CboConsent.Add(RESEARCH, _CboConsent_7)

        'set the default text
        Dim I As Short
        For I = ORGAN To RESEARCH
            CboAppropriate(I).Text = ""
            CboApproach(I).Text = ""
            CboConsent(I).Text = ""
            CboRecovery(I).Text = ""
        Next I

    End Sub
    Private Sub Initialize_CboPhysician()
        CboPhysician(0) = _CboPhysician_0
        CboPhysician(1) = _CboPhysician_1
        CmdPhysicianDetail(0) = _CmdPhysicianDetail_0
        CmdPhysicianDetail(1) = _CmdPhysicianDetail_1
        LblPhysician(0) = _LblPhysician_0
        LblPhysician(1) = _LblPhysician_1
        CmdPhysicianPhone(0) = _CmdPhysicianPhone_0
        CmdPhysicianPhone(1) = _CmdPhysicianPhone_1
    End Sub
    Private Sub Initialize_StaticLists()
        CboVent.Items.Add(New ValueDescriptionPair(VENT_NEVER, "Never"))
        CboVent.Items.Add(New ValueDescriptionPair(VENT_PREV, "Previously"))
        CboVent.Items.Add(New ValueDescriptionPair(VENT_CURRENT, "Currently"))

        CboHeartBeat.Items.Add(New ValueDescriptionPair(HEART_BEAT_NO, "No"))
        CboHeartBeat.Items.Add(New ValueDescriptionPair(HEART_BEAT_YES, "Yes"))

        CboGender.Items.Add(New ValueDescriptionPair(0, "M"))
        CboGender.Items.Add(New ValueDescriptionPair(1, "F"))
        '.AddRange(New Object() {"F", "M"})
        CboAgeUnit.Items.Add(New ValueDescriptionPair(0, "Days"))
        CboAgeUnit.Items.Add(New ValueDescriptionPair(1, "Months"))
        CboAgeUnit.Items.Add(New ValueDescriptionPair(2, "Years"))

        CboGeneralConsent.Items.Add(New ValueDescriptionPair(1, "Yes-Written"))
        CboGeneralConsent.Items.Add(New ValueDescriptionPair(2, "Yes-Verbal"))
        CboGeneralConsent.Items.Add(New ValueDescriptionPair(3, "No"))

        cboDCDPotential.Items.Add(New ValueDescriptionPair(-2, ""))
        cboDCDPotential.Items.Add(New ValueDescriptionPair(-1, "Yes"))
        cboDCDPotential.Items.Add(New ValueDescriptionPair(0, "No"))

        '.AddRange(New Object() {"Yes-Written", "Yes-Verbal", "No"})
    End Sub
    Private Sub Initialize_ControlArrays()
        TxtAlerts(0) = _TxtAlerts_0
        TxtAlerts(1) = _TxtAlerts_1

        CmdOption = New Hashtable()
        CmdOption.Add(ORGAN, _CmdOption_1)
        CmdOption.Add(BONE, _CmdOption_2)
        CmdOption.Add(TISSUE, _CmdOption_3)
        CmdOption.Add(SKIN, _CmdOption_4)
        CmdOption.Add(VALVES, _CmdOption_5)
        CmdOption.Add(EYES, _CmdOption_6)
        CmdOption.Add(RESEARCH, _CmdOption_7)



    End Sub



    Private Sub LstViewVerify_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewVerify.Click

        Dim vNote As String = ""
        Dim vSubItemsList As New Object

        Try
            Call modControl.GetSelListViewSubItems(LstViewVerify, vSubItemsList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vSubItemsList, 2, 0, 2) Then
            'Wrap this call in a try/catch block so we can try to identify why it occasionally fails
            Try
                vNote = vSubItemsList(0, 2)
            Catch ex As Exception

                'Gather details about this exception
                Dim exMessage As String = "Try/Catch Error Caught from LstViewVerify_Click when evaluating vSubItemsList(0, 2).  "
                exMessage = exMessage + "ArrayObject Type: " + vSubItemsList.GetType().ToString()
                If vSubItemsList.GetType().Name.Equals("Object[,]") Then
                    Dim arrString As String = ""
                    For Each item As String In vSubItemsList
                        If arrString.Length > 0 Then
                            arrString = arrString + ", "
                        End If
                        arrString = arrString + item.ToString()
                    Next
                    exMessage = exMessage + ", Array Contents: " + arrString
                End If

                'Log the exception
                Dim newException As New Exception(exMessage & ex.Message)
                StatTracLogger.CreateInstance().Write(newException)

            End Try
        End If

        TxtConditional.Text = vNote

        'Set all the words to red
        TxtConditional.SelectionStart = 0
        TxtConditional.SelectionLength = Len(TxtConditional.Text)

        'ccarroll 10/24/2007 changed to Blue text for General Items
        If InStr(TxtConditional.Text, "General") Then
            TxtConditional.SelectionColor = System.Drawing.Color.Blue
        Else
            TxtConditional.SelectionColor = System.Drawing.Color.Red
        End If

        TxtConditional.SelectionStart = 0


    End Sub

    Public Sub OpenOnCallEvent(ByVal criteriaScheduleGroupsOrganizationID As Integer, ByVal criteriaScheduleGroupsScheduleGroupID As Integer)
        frmOnCallEvent = New FrmOnCallEvent
        frmOnCallEvent.SourceCode = SourceCode
        'Set the call id & number of the form
        frmOnCallEvent.CallId = CallId
        frmOnCallEvent.CallNumber = CallNumber
        frmOnCallEvent.ReferralOrganizationID = OrganizationId
        frmOnCallEvent.CurrentDate = Today
        frmOnCallEvent.DefaultContactType = PAGE_PENDING
        frmOnCallEvent.OnCallType = REFERRAL
        frmOnCallEvent.AlphaMsg = SetRefAlpha(Me)
        frmOnCallEvent.AutoResponseMsg = modStatValidate.SetRefAutoResponse(Me)
        frmOnCallEvent.AutoResponseSbj = modStatValidate.SetRefAutoResponseSbj(Me)
        frmOnCallEvent.OrganizationId = criteriaScheduleGroupsOrganizationID
        frmOnCallEvent.ScheduleGroupID = criteriaScheduleGroupsScheduleGroupID
        frmOnCallEvent.EmailMsg = modStatValidate.SetRefEmail(Me)
        frmOnCallEvent.EmailSbj = modStatValidate.SetRefEmailSbj(Me)

        'Set event types
        Dim vEventTypeList(3) As Object
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = PAGE_PENDING
        vEventTypeList(3) = EMAIL_PENDING
        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/19/01 drh
        frmOnCallEvent.vParentForm = Me
        'Show the referral form
        Me.SendToBack()
        Call frmOnCallEvent.Display()

    End Sub
    Private Sub Initialize_DispositionTabTable()

        tabDispositionTable = New Hashtable
        tabDispositionTable.Add(DISPOSITION_TAB, TabDisposition.TabPages.Item(DISPOSITION_TAB))
        tabDispositionTable.Add(RESULTS_TAB, TabDisposition.TabPages.Item(RESULTS_TAB))
        tabDispositionTable.Add(CORONER_TAB, TabDisposition.TabPages.Item(CORONER_TAB))
    End Sub
    Private Sub Initialize_TabDonorTable()

        tabDonorTable = New Hashtable
        tabDonorTable.Add(0, TabDonor.TabPages.Item(0))
        tabDonorTable.Add(1, TabDonor.TabPages.Item(1))
        tabDonorTable.Add(2, TabDonor.TabPages.Item(2))
    End Sub

    Private Sub LstViewLogEvent_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewLogEvent.SelectedIndexChanged

        Dim vLogEventID As Integer
        Dim vLogEventDesc As String = ""

        'Get the ID of the selected LogEvent
        If IsNothing(LstViewLogEvent.FocusedItem) Then
            Exit Sub
        End If
        vLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

    End Sub

    Private Sub TimerTotalTime_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles TimerTotalTime.Disposed

    End Sub

    Private Sub TimerTotalTime_Tick1(ByVal sender As Object, ByVal e As System.EventArgs) Handles TimerTotalTime.Tick
    End Sub

    Private Sub LstViewVerify_KeyUp(ByVal sender As System.Object, ByVal EventArgs As System.Windows.Forms.KeyEventArgs) Handles LstViewVerify.KeyUp

        Call LstViewVerify_Click(Me.LstViewVerify, EventArgs)

    End Sub

    Private Sub _Frame_1_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles _Frame_1.Enter

    End Sub

    Private Sub TxtSSN_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtSSN.TextChanged

    End Sub
    Private Sub TabDonor_DrawItem(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DrawItemEventArgs) Handles TabDonor.DrawItem

    End Sub

    Private Sub LstViewPending_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewPending.SelectedIndexChanged

    End Sub

    Private Sub FrmReferral_Shown(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Shown

        'ccarroll 04/07/2011 OrganizationNotAssignedToServiceLevel is a flag rased during FrmReferral_Activate
        'and is set in function SetServiceLevel(). (wi:11418) 
        If Me.OrganizationNotAssignedToServiceLevel Then
            'Give notification to user that organization is not assigned to service level
            Call MsgBox("This organization is not assigned to a service level. " & "Contact a data maintenance manager to add this organization to a service level.", MsgBoxStyle.Exclamation, "Service Level")
            'Reset flag
            Me.OrganizationNotAssignedToServiceLevel = False
        End If

    End Sub

    Private Sub FrmReferral_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Click

    End Sub

    Private Sub TxtRecNum_Leave(ByVal sender As Object, ByVal e As System.EventArgs) Handles TxtRecNum.Leave
        Dim vResults As New Object
        Dim vMsgText As String = ""
        Dim I As Short
        Dim v As New Object
        Dim useMedicalRecordNumber As Boolean = True
        'ccarroll 06/03/2011 added event to check duplicate medical record #

        'If medical record number has not changed then exit sub
        If vTxtMedicalRecordChng = False Then
            Exit Sub
        End If

        'Check only if the medical record name is other than 'Not Given'
        Dim vMsg As String = ""
        If isDuplicate Then
            Exit Sub
        End If
        modUtility.Work()

        'Check only if the medical record name is other than 'Not Given'
        If TxtRecNum.Text <> "Not Given" And TxtRecNum.Text.Length > 0 Then

            Dim QueryDonorName As Boolean
            Try
                QueryDonorName = modStatQuery.QueryDonorName(Me, vResults, useMedicalRecordNumber)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                QueryDonorName = False
            End Try

            If QueryDonorName = SUCCESS Then

                'Log the duplicate match
                'Check for same referral running search.

                If Me.CallId <> CStr(vResults(I, 0)) Then

                    vMsg = "Duplicate Referral Found for " & CStr(Me.CallId) & " - Medical Record: '" & Me.TxtRecNum.Text & "': "
                    For I = 0 To UBound(vResults, 1)
                        vMsg = vMsg & CStr(vResults(I, 0)) & ", " & vResults(I, 2) & ", " & vResults(I, 3) & ", " & vResults(I, 4) & " | "
                    Next I

                    'Log the duplicate match
                    Dim ex As New Exception("Duplicate Referral Error: FrmReferral.TxtRecNum_LostFocus - " & vMsg)
                    StatTracLogger.CreateInstance().Write(ex, TraceEventType.Warning)

                    AppMain.frmRefDups = New FrmRefDups()

                    Dim newCallId As Object = AppMain.frmRefDups.Display(vResults)
                    AppMain.frmRefDups.Dispose()
                    AppMain.frmRefDups = Nothing
                    If newCallId > 0 Then

                        isDuplicate = True

                        Me.Close()

                        ' ccarroll 06/05/2012 HS(32120)
                        ' If user cancels after selecting duplicate referral, isDuplicate will be false
                        ' and existing referral will not be opened.
                        If (isDuplicate) Then
                            AppMain.frmReferral = New FrmReferral()
                            AppMain.frmReferral.FormState = EXISTING_RECORD
                            AppMain.frmReferral.CallId = newCallId
                            AppMain.frmReferral.Show()
                            AppMain.frmReferral.TabDonor.SelectedIndex = 0
                            isDuplicate = False
                        End If


                    End If

                End If

            End If

        End If
        modUtility.Done()
        Exit Sub

    End Sub

    Private Sub TxtLSATime_Leave(sender As System.Object, e As System.EventArgs) Handles TxtLSATime.Leave
        'ccarroll 09/14/2011 - CCRST151
        'Check to see if LSA is filled out
        If TxtLSADate.Text.Length > 0 And TxtLSATime.Text.Length > 0 Then

            If Me.TxtNotesCase.Enabled Then
                'Don't add note if it already exists
                If TxtNotesCase.Text.Contains("Last Seen Alive") = False Then
                    Dim medicalHistory As New System.Text.StringBuilder()
                    'Create LSA Medical history note
                    medicalHistory.Append(TxtNotesCase.Text)

                    'ccarroll 12/09/2011 CCRST165, HS-30100 Add space if appending to existing MH.
                    If medicalHistory.Length > 0 Then
                        medicalHistory.Append(" ")
                    End If

                    medicalHistory.Append(String.Format("Last Seen Alive {0} {1} ", TxtLSADate.Text, TxtLSATime.Text))

                    'Add Note to Medical history
                    TxtNotesCase.Text = medicalHistory.ToString()
                End If
            End If
        End If


        'Notify user if LSA Date Time was deleted and LSA was added to MH 
        If TxtLSADate.Text.Length < 1 And TxtLSATime.Text.Length < 1 Then
            FindLSANotesCase()
        End If

    End Sub

    Private Sub TxtDeathTime_Leave(sender As System.Object, e As System.EventArgs) Handles TxtDeathTime.Leave
        'ccarroll 09/12/2011 - CCRST151
        If Me.FormState = EXISTING_RECORD And Me.FormLoad <> True Then
            If Me.vOldDeathTime.Length < 1 And Me.TxtDeathTime.Text.Length > 0 Then
                'If this an existing referral and the CTOD was missing and is now added
                DeclaredCTODUpdateFlag = True
            End If
        End If
    End Sub

    Private Sub TxtLSADate_Leave(sender As System.Object, e As System.EventArgs) Handles TxtLSADate.Leave
        'ccarroll 09/14/2011 - CCRST151
        If TxtLSADate.Text.Length < 1 And TxtLSATime.Text.Length < 1 Then
            FindLSANotesCase()
        End If
    End Sub
    Private Function FindLSANotesCase()
        'ccarroll 09/14/2011 - CCRST151
        'Notify user if LSA Date Time was deleted and LSA was added to MH
        If Me.TxtNotesCase.Enabled Then
            'See if LSA was entered in medical History
            Dim lsa As String = "Last Seen Alive"
            If Me.TxtNotesCase.Text.Contains(lsa) Then
                Dim lsaStartLocation As Integer = Me.TxtNotesCase.Text.IndexOf(lsa)
                'Select LSA text
                Me.TxtNotesCase.Select(lsaStartLocation, lsa.Length)
                'Direct User to medical history where LSA is highlighted
                Me.TxtNotesCase.Focus()
            End If
        End If
    End Function

    Private Sub TxtLSADate_TextChanged(sender As System.Object, e As System.EventArgs) Handles TxtLSADate.TextChanged

    End Sub

    Private Sub TxtLSATime_TextChanged(sender As System.Object, e As System.EventArgs) Handles TxtLSATime.TextChanged

    End Sub

    Private Sub TxtLSADate_Enter(sender As System.Object, e As System.EventArgs) Handles TxtLSADate.Enter

        Call modControl.HighlightText(TxtLSADate)

    End Sub

    Private Sub TxtLSATime_Enter(sender As System.Object, e As System.EventArgs) Handles TxtLSATime.Enter

        Call modControl.HighlightText(TxtLSATime)

    End Sub

    Private Sub TxtLSADate_KeyPress(sender As System.Object, e As System.Windows.Forms.KeyPressEventArgs) Handles TxtLSADate.KeyPress
        'ccarroll 09/12/2011 - CCRST151
        Dim KeyAscii As Short = Asc(e.KeyChar)
        If TxtLSADate.SelectedText <> "" Then
            TxtLSADate.Text = ""
        End If
        KeyAscii = modMask.DateMask_LY(KeyAscii, ActiveControl)

        e.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            e.Handled = True
        End If

        If TxtLSADate.Text.Length < 1 And TxtLSATime.Text.Length < 1 Then
            FindLSANotesCase()
        End If

    End Sub

    Private Sub TxtLSATime_KeyPress(sender As System.Object, e As System.Windows.Forms.KeyPressEventArgs) Handles TxtLSATime.KeyPress
        'ccarroll 09/12/2011 - CCRST151
        Dim KeyAscii As Short = Asc(e.KeyChar)
        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl, Me.OrganizationTimeZone)
        e.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            e.Handled = True
        End If

        If TxtLSADate.Text.Length < 1 And TxtLSATime.Text.Length < 1 Then
            FindLSANotesCase()
        End If
    End Sub

    Private Sub DisableAgeFieldsAsNeeded()
        'Make sure DateOfBirth & Age Are Enabled
        If CallerOrg.ServiceLevel.DOB And CallerOrg.ServiceLevel.Age Then

            'Make sure DateOfBirth Is Valid
            Dim isDobEntered As Boolean
            Dim isDobValid As Boolean
            isDobEntered = TxtDOB.Enabled And Len(TxtDOB.Text) > 0
            isDobValid = TxtDOB.Enabled And Len(TxtDOB.Text) = 10 And IsDate(TxtDOB.Text)

            'Enable/Disable Age Controls
            If isDobEntered And isDobValid Then
                modControl.Disable(TxtAge)
                modControl.Disable(CboAgeUnit)
            Else
                modControl.Enable(TxtAge)
                modControl.Enable(CboAgeUnit)
            End If

        End If
    End Sub

    Private Sub CmdDcdPotential_Click(sender As Object, e As EventArgs) Handles CmdDcdPotential.Click
        frmDCDPotential = New FrmDCDPotential()
        frmDCDPotential.modalParent = Me
        Dim dialogResult As DialogResult = frmDCDPotential.ShowDialog() 'Show modal
    End Sub

    Private Sub TxtLSADate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtLSADate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If ActiveControl.Name <> "CmdCancel" And ActiveControl.Name <> "TxtLSADate" Then
            If TxtLSADate.Text <> "" And (Len(TxtLSADate.Text) < 8 Or Not IsDate(TxtLSADate.Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
            End If
            eventArgs.Cancel = Cancel
        End If
    End Sub

    Private Sub TxtDeathTime_Validating(sender As Object, e As System.ComponentModel.CancelEventArgs) Handles TxtDeathTime.Validating, TxtBrainDeathTime.Validating, TxtAdmitTime.Validating, TxtLSATime.Validating
        Dim timeTextBox As TextBox = sender

        If ((timeTextBox.TextLength > 0) AndAlso (timeTextBox.TextLength < 8)) Then
            Call MsgBox("Time is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            e.Cancel = True
        End If
    End Sub

    Private Sub CboCauseOfDeath_Validating(sender As Object, e As System.ComponentModel.CancelEventArgs) Handles CboCauseOfDeath.Validating
        If Not String.IsNullOrEmpty(CboCauseOfDeath.Text) And CboCauseOfDeath.SelectedItem Is Nothing Then
            BaseMessageBox.ShowWarning("Please select a valid C.O.D.")
            e.Cancel = True
        End If
    End Sub

    Private Sub EnableDonorIntent(Optional foreColor As Color = Nothing)
        cmdDonorIntent.Enabled = True
        If foreColor = Nothing Then
            cmdDonorIntent.ForeColor = Color.Red
        Else
            cmdDonorIntent.ForeColor = foreColor
        End If
    End Sub

#Region "Donor Search"

    Private lastDonorSearchRequest As DonorSearchRequest = DonorSearchRequest.Empty
    Private lastDonorSearchResults As DonorSearchResult() = Array.Empty(Of DonorSearchResult)()

    Private Async Sub CmdRegMatch_Click(
        eventSender As Object,
        eventArgs As EventArgs) Handles CmdRegMatch.Click

        RegMatchClicked = True

        Dim donorListForm = New FrmReferralDonorList(lastDonorSearchResults, lastDonorSearchRequest)

        CmdRegMatch.Visible = False

        If donorListForm.ShowDialog(Me) = DialogResult.OK Then
            ApplySearchResultToForm(donorListForm.SelectedDonor)
        Else
            ApplyNotOnRegistrySearchResultToForm()
        End If

    End Sub

    Private Async Function TrySearchDonor(Optional forceNewSearch As Boolean = False) As Task
        If CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.NoRegistry Then
            Return
        End If

        If (Not IsDate(TxtDOB.Text)) Then
            Return
        End If

        'TODO: Think how to remove these fields, we can rely on last search request instead.
        DonorFirstName = TxtDonorFirstName.Text
        DonorLastName = TxtDonorLastName.Text
        DonorDOB = TxtDOB.Text

        Dim searchRequest = New DonorSearchRequest(
            TxtDonorFirstName.Text.Trim(),
            TxtDonorLastName.Text.Trim(),
            Date.Parse(TxtDOB.Text))

        If (Not forceNewSearch And searchRequest = lastDonorSearchRequest) OrElse Not searchRequest.IsFull Then
            Return
        End If

        lastDonorSearchRequest = searchRequest

        PrepareForDonorSearch()

        Dim searchResults = Array.Empty(Of DonorSearchResult)()

        Try
            searchResults = Await SearchRegistryApiWithLoggingAsync(searchRequest)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            HandleDonorSearchError()
            RestoreAfterDonorSearch()
            Return
        End Try

        lastDonorSearchResults = searchResults

        RestoreAfterDonorSearch()

        Select Case searchResults.Length
            Case 0
                ApplyNotOnRegistrySearchResultToForm()
            Case 1
                If CallerOrg.ServiceLevel.AlwaysPopRegistry Then
                    ApplyNeedUserChoiceToForm()
                Else
                    ApplySearchResultToForm(searchResults.Single())
                End If
            Case Else
                ApplyNeedUserChoiceToForm()
        End Select

    End Function

    Private Sub HandleDonorSearchError()
        ShowRegApiSearchErrorMessage()
        ApplyErrorSearchResultToForm()
    End Sub

    Private Sub ApplyNeedUserChoiceToForm()
        CmdRegMatch.Visible = True
        DonorSearchState = DonorSearchFormState.FoundMultiple
        UpdateRegistryStatusCombo("Not Checked")
        'This is a way to reset donor intent until user makes a choice
        ValidateForDonorIntent()
    End Sub

    Private Sub ApplyNotOnRegistrySearchResultToForm()
        DonorSearchState = DonorSearchFormState.NotFound
        UpdateDonorNotOnRegistryMessage()
        UpdateRegistryStatusCombo("NotRegistered")
        ValidateForDonorIntent()
    End Sub

    Private Sub ApplyErrorSearchResultToForm()
        DonorSearchState = DonorSearchFormState.NotChecked
        UpdateRegistryStatusCombo("Not Checked")
        ValidateForDonorIntent()
    End Sub

    Private Sub ApplySearchResultToForm(searchResult As DonorSearchResult)
        If searchResult.OnRegistry Then
            DonorSearchState = searchResult.ToDonorSearchFormState(ServiceLevelId)

            Select Case searchResult.Registry.Type
                Case DonorRegistryType.Web
                    UpdateDonorFoundRegistryMessage("Donor")
                    UpdateRegistryStatusCombo("Web")
                Case DonorRegistryType.Dmv
                    UpdateDonorFoundRegistryMessage("DMV")
                    UpdateRegistryStatusCombo("State")
                Case DonorRegistryType.Dla
                    UpdateDonorFoundRegistryMessage("DLA")
                    UpdateRegistryStatusCombo("DLA")
            End Select

            DonorAppropriate = True
            ValidateForDonorIntent()
        Else
            ApplyNotOnRegistrySearchResultToForm()
        End If

    End Sub

    Private Sub UpdateDonorFoundRegistryMessage(registryName As String)
        strRegistryMessage =
            $"{lastDonorSearchResults.Length} instances of {lastDonorSearchRequest.DonorFirstName} " &
            $"{lastDonorSearchRequest.DonorLastName}  found. {Environment.NewLine}" &
            $"Patient registered as donor in {registryName} Registry"
    End Sub

    Private Sub UpdateDonorNotOnRegistryMessage()
        strRegistryMessage =
            $"{lastDonorSearchResults.Length} instances of {lastDonorSearchRequest.DonorFirstName} " &
            $"{lastDonorSearchRequest.DonorLastName}  found. {Environment.NewLine}" &
            $"Patient donor status Is UNKNOWN with Donor Registry And DMV |" &
            $"Search {lastDonorSearchRequest.DonorLastName} , " &
            $"{lastDonorSearchRequest.DonorFirstName}|DOB: {lastDonorSearchRequest.DateOfBirth}"
    End Sub

    Private Sub UpdateRegistryStatusCombo(selectedStatus As String)
        modControl.Enable(cboRegistryStatus)
        modControl.cbofill(cboRegistryStatus, vFound:=selectedStatus, setchoice:=True, NewReferral:=True)
    End Sub


    Private Sub PrepareForDonorSearch()
        'Search indicator
        rtbSearching.Visible = True

        'To prevent reentrance to search while it's in progress
        'Since user is not able to edit these fields during search,
        'search request will remain the same, and search won't repeat.
        TxtDonorFirstName.Enabled = False
        TxtDonorLastName.Enabled = False
        TxtDOB.Enabled = False

        CmdRegMatch.Visible = False
        RegMatchClicked = False
        'Reset donor intent done so Donor Intent button gets 
        'disabled during donor intent validation.
        DonorIntentDone = 0
        DonorAppropriate = False
    End Sub

    Private Sub RestoreAfterDonorSearch()
        rtbSearching.Visible = False

        TxtDonorFirstName.Enabled = True
        TxtDonorLastName.Enabled = True
        TxtDOB.Enabled = True
    End Sub

    Private Async Function SearchRegistryApiWithLoggingAsync(
            searchRequest As DonorSearchRequest) As Task(Of DonorSearchResult())

        Dim regApiSearchStartTime = DateTime.Now 'This is needed in-case there's an error/timeout and we get no response
        Dim regApiServiceTimeoutLimit As Integer = Integer.Parse(ConfigurationSettings.AppSettings("RegistryServiceTimeoutLimit"))

        Dim donorService = New DonorServiceFactory(ServiceLevelId).Create()

        'Allow UI updates to propagate
        'since search operation is not fully async
        'and blocks when calling sprocs.
        Await Task.Yield()

        Try
            Return Await donorService.SearchRegistryAsync(searchRequest).TimeoutAfter(regApiServiceTimeoutLimit)
        Catch ex As TimeoutException
            LogRegistryApiCallTimeOut(regApiSearchStartTime, regApiServiceTimeoutLimit)
            Throw
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            Throw
        End Try

    End Function

    Private Sub LogRegistryApiCallTimeOut(
        regApiSearchStartTime As DateTime,
        regApiServiceTimeoutLimit As Integer)
        'Prepare data to serialize and log with the error information.
        Dim errorInfo = New With
        {
            .ItemCount = 0,
            .ErrorCount = 1,
            .RequestDateTime = regApiSearchStartTime,
            .RequestFirstName = TxtDonorFirstName.Text,
            .RequestLastName = TxtDonorLastName.Text,
            .RequestDOB = Date.Parse(TxtDOB.Text)
        }

        'Prepare Error Description
        Err.Description = "Registry API Search Failure due to timeout waiting for response from the API.  " &
            "Response took longer than " + regApiServiceTimeoutLimit.ToString() & " milliseconds.  " &
            "API response info: " & JsonConvert.SerializeObject(errorInfo, Formatting.Indented)

        'Log DLA Search Timeout Error
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Sub

    Private Sub ShowRegApiSearchErrorMessage()
        'Initialize Error Message Box Parameters
        Dim regApiErrorMessage As String = ConfigurationSettings.AppSettings("RegistryServiceErrorMessage").ToString()
        Dim regApiErrorTitle As String = ConfigurationSettings.AppSettings("RegistryServiceErrorTitle").ToString()

        ShowError(regApiErrorMessage, regApiErrorTitle)
    End Sub


#End Region 'Donor Search

End Class