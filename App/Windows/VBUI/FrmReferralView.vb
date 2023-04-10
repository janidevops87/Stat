Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant
Imports Statline.Stattrac.Framework
Imports System.Collections.Generic
Imports Stattrac.Services.Donor

Public Class FrmReferralView
    Inherits BaseFormReferralData
    'Bret 1/06/10 add Option explicit for upgrade
    ' No more data is available.
    Const ERROR_NO_MORE_ITEMS As Short = 259

    ' The data area passed to a system call is too small.
    Const ERROR_INSUFFICIENT_BUFFER As Short = 122

    Private Declare Function InternetSetCookie Lib "wininet.dll" Alias "InternetSetCookieA" (ByVal lpszUrlName As String, ByVal lpszCookieName As String, ByVal lpszCookieData As String) As Boolean

    Private Declare Function InternetGetCookie Lib "wininet.dll" Alias "InternetGetCookieA" (ByVal lpszUrlName As String, ByVal lpszCookieName As String, ByVal lpszCookieData As String, ByRef lpdwSize As Integer) As Boolean


    Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Integer, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Integer) As Integer
    Dim mbMoving As Boolean
    Const sglSplitLimit As Short = 500
    Dim ie As New Object
    Public CaseOpen As Boolean
    Public CallId As Integer
    Public LOCallID As Integer
    Public OrganizationId As Integer
    Public CallPhoneNumberID As Integer
    Public SubLocationID As Integer
    Public PersonID As Integer
    Public FormLoad As Boolean
    Public SortOrder As Short
    Public OrganizationTimeZone As String
    Public FormState As Short
    Public CallType As Short
    Public CallNumber As String
    Private fvCallDate As Date
    Private fvCallTotalTime As Date
    Private fvLOCallTotalTime As Date
    Public TimeSnapshot As Date
    Public CallOpenByID As Integer
    Public CallOpenByName As String
    Public CallFSCase As Boolean
    Public CallExclusive As Boolean
    Public CallPending As Boolean
    Public CallOpenbyPersonID As Integer
    Public CallOpenbyWebPersonPassword As String
    Public DispositionNotFinished As Boolean 'T.T 06/10/2007 flag to determine if Dispo is finished.
    Public strRegistryMessage As String
    Public ExitDoLoop As Boolean
    Public RegistrySource As String 'T.T 07/25/2007 release 8.4 req 3.5.1
    'NOK addition for release 80
    Public NOKStateID As Integer
    Public NOKID As Integer
    Public vStateAbbr As String
    Public NOKFirstName As String
    Public NOKLastName As String
    Public NOKRefPhone As String
    Public NOKCity As String
    Public NOKZip As String
    Public NOKApproachRelation As String
    Public ModNOK As Boolean
    Public AddNOK As Boolean
    Public DonorTracClient As Short 'T.T 10/15/2007 added flag for donortrac clients
    Public RegMatchClicked As Boolean 'T.T 07/02/2007 added flag

    'T.T 6/10/2007 Disposition incomplete flag
    Public DispositionIncompleteFlag As Boolean
    'Old NOK before release 80
    Public NOK As String

    Public CurrentLogEventID As Integer
    Public ServiceLevelId As Integer

    Public ShiftKey As Boolean

    Public ReferralCall As New clsCall
    Public CallerOrg As New clsOrganization
    Public SourceCode As New clsSourceCode
    Public ReferralSecondary As New clsReferralSecondary

    Public HistoricalReferral As Boolean

    Public SecondaryAutoBill As Boolean
    Public SecondaryUpdated As Boolean

    '10/16/02 drh
    Public AuditLogId As Integer
    Public URL As String
    Public DonorTracSourceCode As Object
    Public OldTab As Short

    'T.T 04/26/2007
    Public DOB As Object

    'ccarroll 11/08/2010 changed types to TextBox
    'for compatibility with RegMatch(frmReferral)
    Public TxtDOB As TextBox
    Public TxtDonorLastName As TextBox
    Public TxtDonorFirstName As TextBox

    'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
    'Autobill - Event driven Autobill Family Approach
    Public BillSecondaryFlag As Boolean
    Public BillSecondaryComplete As Boolean

    'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
    'AutoBill - Used to enable/disable Event driven Autobill feature
    Public BillSecondaryManualEnable As Boolean
    Public BillFamilyApproachManualEnable As Boolean
    Public BillMedSocManualEnable As Boolean

    'ccarroll 06/17/2008 StatTrac 8.4.6, BillApproachOnly
    'Used for ME/Coroner case to disable BillSecondary checkbox
    Public BillApproachOnly As Boolean


    'ccarroll 06/04/2007 StatTrac 8.4 release, requirement 3.6
    'TBI Number - Used to generate TBI Number
    Public TBIUpdateFlag As Boolean
    Public TBIAccess As Boolean
    Public TBIDate As String
    Public TBIPrefix As String
    Public TBINoteText As String

    Public subCriteriaHash As New Hashtable()
    Public processorConditionalHash As New Hashtable()

    'ccarroll 01/28/2013 bug wi: 5484, HS 34684 StatTrac Import for DonorTrac
    Public CoronerOrgID As Integer

    Public CloseAfterSave As Boolean 'determines whether we need to close the window after saving

    'FSProj drh 5/30/02
    '*******************************************
    Private Structure tTree
        Dim TreeItemId As String
        Dim ParentId As String
        Dim DisplayText As String
        Dim Checked As Boolean
        Dim ControlName As String
    End Structure

    Private ThisNode As System.Windows.Forms.TreeNode
    Private IgnorePassedNode As Boolean
    '*******************************************

    'drh FSMod 06/04/03 - Variable for selecting best match in a dropdown list as the User types
    Private CapturedText As String
    Private SelectMatch As Boolean

    '7/2/07 bret 8.4.3.8 AudiTrail change how medications are deleted
    Dim DeletedSecondaryMedicationList() As Object

    'bret 02/17/2010 add references to forms
    Private frmColorKey As FrmColorKey
    Private frmCriteria As FrmCriteria
    Private frmDonorIntent As FrmDonorIntent
    Private frmEventLogDescription As FrmEventLogDescription
    Private frmList As FrmList
    Private frmLogEvent As FrmLogEvent
    Private frmNDRICallSheet As FrmNDRICallSheet

    Private frmOnCallEvent As FrmOnCallEvent
    'bret 02/01/11 
    Private uIMap As UIMap

    Private frmVerifySex As FrmVerifySex
    Private frmVerifyWeight As FrmVerifyWeight
    'bret 03/05/10 control Hashtables
    Public DataItemListArray As Hashtable
    Private tabPages(8) As TabPage
    'bret 06/16/10 add to search lstview
    Private txtlstViewAvailableMeds As String

    Public InstanceFound As Short

    Public Sub ActivateTriageReferral()

    End Sub

    Public Function CalculateBMI(ByRef pvWeight As Double, ByRef pvHeightFeet As Short, ByRef pvHeightInches As Short) As Object

        Dim vHeightMeters As Double

        vHeightMeters = (((pvHeightFeet * 12) + pvHeightInches) * 2.54) / 100

        CalculateBMI = pvWeight / (vHeightMeters * vHeightMeters)


    End Function

    Public Sub SetUserPermissions()
        '************************************************************************************
        'Name: SetUserPermissions
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Set user permissions to application objects
        'Returns: na
        'Params: na
        '
        'Stored Procedures: na
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/13/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9 LogEventDeleted
        'Description:   Check to see if current user has access to deleted events
        '
        '====================================================================================
        If GetBitPermission(AppMain.ParentForm.StatEmployeeID, "AllowAddMedication") Then
            Me.cmdCreateMedication.Enabled = True
        Else
            Me.cmdCreateMedication.Enabled = False
        End If


        'bret 6/11/07 8.4.3.9 LogEventDeleted
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowViewDeletedLogEvents") Then
            Me.chkViewLogEventDeleted.Visible = True
        Else
            Me.chkViewLogEventDeleted.Visible = False
        End If
    End Sub

    Public Sub TextMatch(ByRef vCtl As ComboBox)
        'drh FSMod 06/04/03 - New Sub: Select the best match based on the text entered

        Dim vMatch As Boolean
        Dim vCurrIndex As Short
        Dim I As Short

        If SelectMatch = True Then
            'Find a match and select the item
            vMatch = False
            For I = 0 To vCtl.Items.Count - 1
                If LCase(VB.Left(vCtl.Items(I).Description, Len(CapturedText))) = LCase(CapturedText) Then
                    vCtl.SelectedIndex = I
                    vMatch = True
                    Exit For
                End If
            Next I

            'If no match was found, re-select the current index
            vCurrIndex = vCtl.SelectedIndex
            If Not vMatch Then
                CapturedText = VB.Left(CapturedText, Len(CapturedText) - 1)
                vCtl.SelectedIndex = -1
                vCtl.SelectedIndex = vCurrIndex
            End If
        End If

        SelectMatch = False

    End Sub

    Public Sub TextCapture(ByRef vAscii As Short)
        'drh FSMod 06/04/03 - New Sub: Capture text as it's typed

        'MsgBox (vAscii)

        '"a-z", "A-Z", period, space, hyphen
        If (vAscii > 64 And vAscii < 91) Or (vAscii > 96 And vAscii < 123) Or vAscii = 46 Or vAscii = 32 Or vAscii = 45 Then
            CapturedText = CapturedText & Chr(vAscii)
        ElseIf vAscii = 8 Then
            If Len(CapturedText) > 0 Then
                CapturedText = VB.Left(CapturedText, Len(CapturedText) - 1)
            End If
        End If

        'MsgBox (LCase(CapturedText))

        SelectMatch = True

    End Sub



    Public Function DateValidate() As Boolean

        Dim I As Short
        DateValidate = True

        On Error GoTo ErrorNextI

        For I = 0 To DataTextArray.UBound
            '02/13/03 drh - Added code to validate Date for 8 characters and IsDate
            If DataTextArray(I).Tag = "SecondaryPatientDOD" Or DataTextArray(I).Tag = "SecondaryPatientDeathType1" Or DataTextArray(I).Tag = "SecondaryPatientDeathType2" Or DataTextArray(I).Tag = "SecondaryWBC1Date" Or DataTextArray(I).Tag = "SecondaryWBC2Date" Or DataTextArray(I).Tag = "SecondaryWBC3Date" Or DataTextArray(I).Tag = "SecondaryNOKNotifiedDate" Or DataTextArray(I).Tag = "SecondaryBodyRefrigerationDate" Or DataTextArray(I).Tag = "SecondaryPreTransfusionSampleDrawnDate" Or DataTextArray(I).Tag = "SecondaryPreTransfusionSampleHeldDate" Or DataTextArray(I).Tag = "SecondaryAdmissionDate" Or DataTextArray(I).Tag = "SecondaryIntubationDate" Or DataTextArray(I).Tag = "SecondaryExtubationDate" Or DataTextArray(I).Tag = "SecondaryBrainDeathDate" Or DataTextArray(I).Tag = "SecondaryDNRDate" Or DataTextArray(I).Tag = "SecondaryPostMordemSampleCollectionDate" Or DataTextArray(I).Tag = "SecondaryLabTemp1Date" Or DataTextArray(I).Tag = "SecondaryLabTemp2Date" Or DataTextArray(I).Tag = "SecondaryLabTemp3Date" Or DataTextArray(I).Tag = "SecondaryAutopsyDate" Or DataTextArray(I).Tag = "SecondaryEMSArrivalToPatientDate" Or DataTextArray(I).Tag = "SecondaryEMSArrivalToHospitalDate" Or DataTextArray(I).Tag = "SecondaryLSADate" Then
                If DataTextArray(I).Text <> "" AndAlso (Len(DataTextArray(I).Text) < 8 Or Not DateTimeTryParseExact(DataTextArray(I).Text)) Then
                    Call MsgBox(DataTextArray(I).Tag & " field contains an invalid date. Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
                    DateValidate = False
                    Exit Function
                End If

                '02/13/03 drh - Added code to validate Date for 8 characters and IsDate
                'Date Mask (Set 2)
            ElseIf DataTextArray(I).Tag = "SecondaryCulture1DrawnDate" Or DataTextArray(I).Tag = "SecondaryCulture2DrawnDate" Or DataTextArray(I).Tag = "SecondaryCulture3DrawnDate" Or DataTextArray(I).Tag = "SecondaryCXR1Date" Or DataTextArray(I).Tag = "SecondaryCXR2Date" Or DataTextArray(I).Tag = "SecondaryCXR3Date" Or DataTextArray(I).Tag = "SecondaryAntibiotic1StartDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic2StartDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic3StartDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic4StartDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic5StartDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic1EndDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic2EndDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic3EndDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic4EndDate" Or DataTextArray(I).Tag = "SecondaryAntibiotic5EndDate" Then
                If DataTextArray(I).Text <> "" AndAlso (Len(DataTextArray(I).Text) < 8 Or Not DateTimeTryParseExact(DataTextArray(I).Text)) Then
                    Call MsgBox(DataTextArray(I).Tag & " field contains an invalid date. Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
                    DateValidate = False
                    Exit Function
                End If

                '02/13/03 drh - Added code to validate Date for 10 characters and IsDate
            ElseIf DataTextArray(I).Tag = "SecondaryPatientDOB" Then
                If DataTextArray(I).Text <> "" AndAlso (Len(DataTextArray(I).Text) < 10 Or Not DateTimeTryParseExact(DataTextArray(I).Text)) Then
                    Call MsgBox(DataTextArray(I).Tag & " field contains an invalid date. Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
                    DateValidate = False
                    Exit Function
                End If

            End If
        Next I

        'TODO: Move to validation event on Start & End date fields for antibiotics and medications
        For Each thisItemList As ctlItemList In DataItemListArray.Values
            For Each thisItem As ListViewItem In thisItemList.lvwSelected.Items
                For I = 2 To 3
                    Dim thisSubItem As ListViewItem.ListViewSubItem = thisItem.SubItems.Item(I)
                    If thisSubItem.Text <> "" AndAlso (Len(thisSubItem.Text) < 8 Or Not DateTimeTryParseExact(thisSubItem.Text)) Then
                        Call MsgBox(thisItemList.Tag & " item #" & (thisItem.Index + 1) & " date field contains an invalid date. Please enter a valid date or delete the existing value.", MsgBoxStyle.Exclamation, "Validation Error")
                        DateValidate = False
                        Exit Function
                    End If
                Next
            Next
        Next

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If

    End Function

    Public Sub GetApproachConsent()

        'drh FSMod 06/03/03 - Add Blank item to lists before populating
        Call SetTextIDItem(cboApproachType, -1, "")
        Call SetTextIDItem(cboApproachedBy, -1, "")
        Call SetTextIDItem(cboConsentBy, -1, "")
        Call SetTextIDItem(cboHospitalApproachedBy, -1, "")
        Call SetTextIDItem(cboConsentMedSocObtainedBy, -1, "")
        Call SetTextIDItem(cboHospitalApproachType, -1, "")
        Call SetTextIDItem(cboApproachReason, -1, "")

        'Populate ApproachType/ApproachBy combo boxes
        Call modStatRefQuery.ListSecQueryApproachType(cboApproachType)
        Call modStatQuery.QueryLocationApproachPerson(Me)

        'drh FSMod 05/27/03
        Call modStatRefQuery.ListRefQueryApproachType(cboHospitalApproachType)

        'Populate Y/N combo boxes
        Dim YesNoList(2, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        YesNoList(0, 0) = -1 'drh FSMod 06/03/03 - Added blank value
        YesNoList(0, 1) = "" 'drh FSMod 06/03/03 - Added blank value
        YesNoList(1, 0) = 1
        YesNoList(1, 1) = "Yes"
        YesNoList(2, 0) = 2
        YesNoList(2, 1) = "No"
        Call modControl.SetTextID(cboApproached, YesNoList)
        Call modControl.SetTextID(cboConsent, YesNoList)

        'drh FSMod 05/28/03 - Fld no longer used
        'Call modControl.SetTextID(cboConsentOutcome, YesNoList)

        'drh FSMod 05/27/03
        Call modControl.SetTextID(cboConsentMedSocPaperwork, YesNoList)

        'Populate Y/N/NA combo box
        Dim YesNoList1(2, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        YesNoList1(0, 0) = 1
        YesNoList1(0, 1) = "Yes"
        YesNoList1(1, 0) = 2
        YesNoList1(1, 1) = "No"
        YesNoList1(2, 0) = 3
        YesNoList1(2, 1) = "N/A"
        Call modControl.SetTextID(cboConsentResearch, YesNoList1)

        'Populate Y/N/etc combo box
        Dim YesNoList2(4, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        YesNoList2(0, 0) = -1 'drh FSMod 06/03/03 - Added blank value
        YesNoList2(0, 1) = "" 'drh FSMod 06/03/03 - Added blank value
        YesNoList2(1, 0) = 1
        YesNoList2(1, 1) = "Yes-Verbal"
        YesNoList2(2, 0) = 2
        YesNoList2(2, 1) = "Yes-Written"
        YesNoList2(3, 0) = 3
        YesNoList2(3, 1) = "No"
        YesNoList2(4, 0) = 4
        YesNoList2(4, 1) = "Undecided"
        Call modControl.SetTextID(cboApproachOutcome, YesNoList2)

        'drh FSMod 05/27/03 - Populate Y/N/etc combo box
        Dim YesNoList3(5, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        YesNoList3(0, 0) = -1 'drh FSMod 06/03/03 - Added blank value
        YesNoList3(0, 1) = "" 'drh FSMod 06/03/03 - Added blank value
        YesNoList3(1, 0) = 1
        YesNoList3(1, 1) = "Yes-Written"
        YesNoList3(2, 0) = 2
        YesNoList3(2, 1) = "Yes-Verbal"
        YesNoList3(3, 0) = 3
        YesNoList3(3, 1) = "No"
        Call modControl.SetTextID(cboHospitalApproachOutcome, YesNoList3)

        'drh FSMod 05/29/03 - Added If stmt since value list changed
        Dim ReasonList(4, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        If Me.CallId > SEC_DISPO_CUTOFF_CALLID Then
            Call modStatRefQuery.ListSecApproachReason(cboApproachReason)
        Else
            'Populate Y/N/etc combo box
            ReasonList(0, 0) = -1 'drh FSMod 06/03/03 - Added blank value
            ReasonList(0, 1) = "" 'drh FSMod 06/03/03 - Added blank value
            ReasonList(1, 0) = 17 'drh FSMod 07/28/03 - Changed to match FSApproach table
            ReasonList(1, 1) = "Unsuitable"
            ReasonList(2, 0) = 3 'drh FSMod 07/28/03 - Changed to match FSApproach table
            ReasonList(2, 1) = "Family Unavailable"
            ReasonList(3, 0) = 15 'drh FSMod 07/28/03 - Changed to match FSApproach table
            ReasonList(3, 1) = "Time"
            ReasonList(4, 0) = 7 'drh FSMod 07/28/03 - Changed to match FSApproach table
            ReasonList(4, 1) = "Logistics"
            Call modControl.SetTextID(cboApproachReason, ReasonList)
        End If

        'drh FSMod 05/28/03 - Populate Y/N/NA/Unknown combo box
        Dim YesNoList4(3, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        YesNoList4(0, 0) = 1
        YesNoList4(0, 1) = "Yes"
        YesNoList4(1, 0) = 2
        YesNoList4(1, 1) = "No"
        YesNoList4(2, 0) = 0
        YesNoList4(2, 1) = "N/A"
        YesNoList4(3, 0) = 3
        YesNoList4(3, 1) = "Unknown"
        Call modControl.SetTextID(cboConsentLongSleeves, YesNoList4)

        'drh FSMod 05/28/03
        Call modStatRefQuery.ListSecFuneralPlan(cboConsentFuneralPlan)

        'Populate the fields
        Call modStatQuery.QuerySecondaryApproach(Me)

    End Sub

    Public Sub GetTriageReferralData()

        'Triage Data
        Dim TriageDataCtlList(2, 41) As Object 'Char Chaput FSMod 05/10/06 - Updated to 34
        TriageDataCtlList(1, 0) = "SecondaryPatientHospitalName" 'Control name
        TriageDataCtlList(2, 0) = "ReferralCallerOrganizationID" 'DB field name
        TriageDataCtlList(1, 1) = "SecondaryPatientPhone"
        TriageDataCtlList(2, 1) = "ReferralCallerPhoneID"
        TriageDataCtlList(1, 2) = "SecondaryPatientHospitalUnit"
        TriageDataCtlList(2, 2) = "ReferralCallerSubLocationID"
        TriageDataCtlList(1, 3) = "SecondaryPatientContactName"
        TriageDataCtlList(2, 3) = "ReferralCallerPersonID"
        TriageDataCtlList(1, 4) = "SecondaryPatientContactTitle"
        TriageDataCtlList(2, 4) = "SecondaryPatientContactTitle"
        TriageDataCtlList(1, 5) = "SecondaryPatientLastName"
        TriageDataCtlList(2, 5) = "ReferralDonorLastName"
        TriageDataCtlList(1, 6) = "SecondaryPatientFirstName"
        TriageDataCtlList(2, 6) = "ReferralDonorFirstName"
        TriageDataCtlList(1, 7) = "SecondaryPatientDOB"
        TriageDataCtlList(2, 7) = "ReferralDOB"
        TriageDataCtlList(1, 8) = "SecondaryPatientAge"
        TriageDataCtlList(2, 8) = "ReferralDonorAge"
        TriageDataCtlList(1, 9) = "SecondaryPatientGender"
        TriageDataCtlList(2, 9) = "ReferralDonorGender"
        TriageDataCtlList(1, 10) = "SecondaryPatientRace"
        TriageDataCtlList(2, 10) = "ReferralDonorRaceID"
        TriageDataCtlList(1, 11) = "SecondaryPatientWeight"
        TriageDataCtlList(2, 11) = "ReferralDonorWeight"
        TriageDataCtlList(1, 12) = "SecondaryPatientMedicalRecordNumber"
        TriageDataCtlList(2, 12) = "ReferralDonorRecNumber"
        TriageDataCtlList(1, 13) = "SecondaryPatientSSN"
        TriageDataCtlList(2, 13) = "ReferralDonorSSN"
        TriageDataCtlList(1, 14) = "SecondaryPatientDOD"
        TriageDataCtlList(2, 14) = "ReferralDonorDeathDate"
        TriageDataCtlList(1, 15) = "SecondaryPatientTOD"
        TriageDataCtlList(2, 15) = "ReferralDonorDeathTime"
        TriageDataCtlList(1, 16) = "SecondaryAdmissionDate"
        TriageDataCtlList(2, 16) = "ReferralDonorAdmitDate"
        TriageDataCtlList(1, 17) = "SecondaryAdmissionTime"
        TriageDataCtlList(2, 17) = "ReferralDonorAdmitTime"

        TriageDataCtlList(1, 18) = "SecondaryBrainDeathDate"
        TriageDataCtlList(2, 18) = "ReferralDonorBrainDeathDate" 'Char Chaput Added for 8.0
        TriageDataCtlList(1, 19) = "SecondaryBrainDeathTime"
        TriageDataCtlList(2, 19) = "ReferralDonorBrainDeathTime" 'Char Chaput Added for 8.0


        TriageDataCtlList(1, 20) = "SecondaryNOKName"
        TriageDataCtlList(2, 20) = "ReferralApproachNOK"
        TriageDataCtlList(1, 21) = "SecondaryNOKPhone"
        TriageDataCtlList(2, 21) = "ReferralNOKPhone"
        TriageDataCtlList(1, 22) = "SecondaryNOKRelation"
        TriageDataCtlList(2, 22) = "ReferralApproachRelation"
        TriageDataCtlList(1, 23) = "SecondaryNOKAddress"
        TriageDataCtlList(2, 23) = "ReferralNOKAddress"
        TriageDataCtlList(1, 24) = "SecondaryCoronerCase"
        TriageDataCtlList(2, 24) = "ReferralCoronersCase"
        TriageDataCtlList(1, 25) = "SecondaryCoronerState"
        TriageDataCtlList(2, 25) = "ReferralCoronerState"
        TriageDataCtlList(1, 26) = "SecondaryCoronerOrganization"
        TriageDataCtlList(2, 26) = "ReferralCoronerOrganization"
        TriageDataCtlList(1, 27) = "SecondaryCoronerInvestigatorName"
        TriageDataCtlList(2, 27) = "ReferralCoronerName"
        TriageDataCtlList(1, 28) = "SecondaryCoronerInvestigatorPhone"
        TriageDataCtlList(2, 28) = "ReferralCoronerPhone"
        TriageDataCtlList(1, 29) = "SecondaryTriageHX"
        TriageDataCtlList(2, 29) = "ReferralNotesCase"
        TriageDataCtlList(1, 30) = "SecondaryPatientAgeUnit"
        TriageDataCtlList(2, 30) = "ReferralDonorAgeUnit"
        TriageDataCtlList(1, 31) = "SecondaryPatientHospitalFloor" 'drh FSMod 06/13/03 - Add for Floor fld
        TriageDataCtlList(2, 31) = "ReferralCallerSubLocationLevel" 'drh FSMod 06/13/03 - Add for Floor fld
        TriageDataCtlList(1, 32) = "SecondaryPatientVentilated" 'drh FSMod 06/13/03 - Add for Pt. Ventilated fld
        TriageDataCtlList(2, 32) = "ReferralDonorOnVentilator" 'drh FSMod 06/13/03 - Add for Pt. Ventilated fld
        TriageDataCtlList(1, 33) = "SecondaryMDAttendingId" 'drh FSMod 07/16/03
        TriageDataCtlList(2, 33) = "ReferralAttendingMD" 'drh FSMod 07/16/03
        TriageDataCtlList(1, 34) = "SecondaryTriageSpecificCOD" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 34) = "ReferralDonorSpecificCOD" 'Char Chaput FSMod 05/09/06

        TriageDataCtlList(1, 35) = "SecondaryNOKFirstName" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 35) = "ReferralNOKFirstName" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 36) = "SecondaryNOKLastName" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 36) = "ReferralNOKLastName" 'Char Chaput FSMod 05/09/06

        TriageDataCtlList(1, 37) = "SecondaryNOKStreetAddress" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 37) = "ReferralNOKStreetAddress" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 38) = "SecondaryNOKCity" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 38) = "ReferralNOKCity" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 39) = "SecondaryNOKState" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 39) = "ReferralNOKState" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 40) = "SecondaryNOKZip" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 40) = "ReferralNOKZip" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 41) = "SecondaryPatientPhoneExt"
        TriageDataCtlList(2, 41) = "ReferralCallerExtension"

        Call GetDataFieldIndex(TriageDataCtlList, CTL_TEXT)
        Call GetDataFieldIndex(TriageDataCtlList, CTL_COMBOID)
        Call GetDataFieldIndex(TriageDataCtlList, CTL_RICHTEXT)

        Call modStatQuery.QuerySecondaryTriageData(Me, TriageDataCtlList)

    End Sub

    Public Sub ProcessPersonDetail(ByRef vCtl As ComboBox)
        'drh FSMod 06/03/03 - New function

        Dim vPersonID As Integer
        Dim vReturn As New Object
        Dim vHospitalApproachedByPersonId As Integer
        Dim vInformedApproachedByPersonId As Integer
        Dim vConsentPaperWorkObtainedByPersonId As Integer
        Dim vConsentMedSocObtainedByPersonId As Integer
        Dim vSecondaryPatientContactNameId As Integer
        Dim vSecondaryMDAttendingId As Integer

        '*******Get the data field controls - BEGIN***************
        'bret 01/12/2010 
        Dim vSecondaryPatientContactNameCtl As New ComboBox
        Dim vSecondaryMDAttendingCtl As New ComboBox

        On Error GoTo ErrorNextI

        Dim I As Integer
        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryPatientContactName" Then
                'Set the variable equal to this control
                vSecondaryPatientContactNameCtl = DataComboArray(I)
            End If
        Next I

        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryMDAttendingId" Then
                'Set the variable equal to this control
                vSecondaryMDAttendingCtl = DataComboArray(I)
            End If
        Next I
        '*******Get the data field controls - END***************

        On Error Resume Next

        'Get the Person ID's
        vHospitalApproachedByPersonId = modControl.GetID(cboHospitalApproachedBy)
        vInformedApproachedByPersonId = modControl.GetID(cboApproachedBy)
        vConsentPaperWorkObtainedByPersonId = modControl.GetID(cboConsentBy)
        vConsentMedSocObtainedByPersonId = modControl.GetID(cboConsentMedSocObtainedBy)
        vSecondaryPatientContactNameId = modControl.GetID(vSecondaryPatientContactNameCtl)
        vSecondaryMDAttendingId = modControl.GetID(vSecondaryMDAttendingCtl)

        'Determine the form state which to open the
        'Person form.
        If modControl.GetID(vCtl) = -1 Then
            vPersonID = 0
        Else
            vPersonID = modControl.GetID(vCtl)
        End If

        'Set the default organization to the selected location
        If (vPersonID = 0) Then
            GeneralConstant.CreateInstance().OrganizationId = Me.OrganizationId
        End If

        'Get the Person id from the Person form
        'after the user is done.
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If
        vPersonID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)

        If vPersonID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Re-initialize the controls
            cboHospitalApproachedBy.Items.Clear()
            Call SetTextIDItem(cboHospitalApproachedBy, -1, "")
            cboApproachedBy.Items.Clear()
            Call SetTextIDItem(cboApproachedBy, -1, "")
            cboConsentBy.Items.Clear()
            Call SetTextIDItem(cboConsentBy, -1, "")
            cboConsentMedSocObtainedBy.Items.Clear()
            Call SetTextIDItem(cboConsentMedSocObtainedBy, -1, "")
            vSecondaryPatientContactNameCtl.Items.Clear()
            Call SetTextIDItem(vSecondaryPatientContactNameCtl, -1, "")
            vSecondaryMDAttendingCtl.Items.Clear()
            Call SetTextIDItem(vSecondaryMDAttendingCtl, -1, "")

            'Re-populate ApproachPerson dropdowns
            Call modStatQuery.QueryLocationApproachPerson(Me)

            'Re-populate LocationPerson dropdowns
            Call modStatQuery.QueryLocationPerson(Me, , vSecondaryPatientContactNameCtl)

            'Re-populate PhysicianPerson dropdowns
            Call modStatQuery.QueryLocationPhysicians(Me, , vSecondaryMDAttendingCtl)

            'Set the controls to their original PersonId's
            Call modControl.SelectID(cboHospitalApproachedBy, vHospitalApproachedByPersonId)
            Call modControl.SelectID(cboApproachedBy, vInformedApproachedByPersonId)
            Call modControl.SelectID(cboConsentBy, vConsentPaperWorkObtainedByPersonId)
            Call modControl.SelectID(cboConsentMedSocObtainedBy, vConsentMedSocObtainedByPersonId)
            Call modControl.SelectID(vSecondaryPatientContactNameCtl, vSecondaryPatientContactNameId)
            Call modControl.SelectID(vSecondaryMDAttendingCtl, vSecondaryMDAttendingId)

            'Set the selected control to the PersonId from the Person form
            Call modControl.SelectID(vCtl, vPersonID)

        End If

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Public Sub SaveSecondaryCall()

        'Save the referral
        Call modStatSave.SaveSecondaryCall(Me, (Me.CallId))

        '    'Save the Lease Org Call
        '    If AppMain.ParentForm.LeaseOrganization <> 0 Then
        '        Call modStatSave.SaveLOCall(Me)
        '    End If

    End Sub

    Public Sub SaveTriageReferralData()

        'Triage Data
        Dim TriageDataCtlList(2, 32) As Object 'Char Chaput FSMod 05/09/07 - Updated to 29 for Rel 8.0

        'Textbox/Phone (special)
        TriageDataCtlList(1, 0) = "SecondaryPatientPhone"
        TriageDataCtlList(2, 0) = "ReferralCallerPhoneID"

        'Textbox/DB Varchar
        TriageDataCtlList(1, 1) = "SecondaryPatientLastName"
        TriageDataCtlList(2, 1) = "ReferralDonorLastName"
        TriageDataCtlList(1, 2) = "SecondaryPatientFirstName"
        TriageDataCtlList(2, 2) = "ReferralDonorFirstName"
        TriageDataCtlList(1, 3) = "SecondaryPatientDOB"
        TriageDataCtlList(2, 3) = "ReferralDOB"
        TriageDataCtlList(1, 4) = "SecondaryPatientAge"
        TriageDataCtlList(2, 4) = "ReferralDonorAge"
        TriageDataCtlList(1, 5) = "SecondaryPatientWeight"
        TriageDataCtlList(2, 5) = "ReferralDonorWeight"
        TriageDataCtlList(1, 6) = "SecondaryPatientMedicalRecordNumber"
        TriageDataCtlList(2, 6) = "ReferralDonorRecNumber"
        TriageDataCtlList(1, 7) = "SecondaryPatientSSN"
        TriageDataCtlList(2, 7) = "ReferralDonorSSN"
        TriageDataCtlList(1, 8) = "SecondaryPatientDOD"
        TriageDataCtlList(2, 8) = "ReferralDonorDeathDate"
        TriageDataCtlList(1, 9) = "SecondaryPatientTOD"
        TriageDataCtlList(2, 9) = "ReferralDonorDeathTime"
        TriageDataCtlList(1, 10) = "SecondaryAdmissionDate"
        TriageDataCtlList(2, 10) = "ReferralDonorAdmitDate"
        TriageDataCtlList(1, 11) = "SecondaryAdmissionTime"
        TriageDataCtlList(2, 11) = "ReferralDonorAdmitTime"
        TriageDataCtlList(1, 12) = "SecondaryBrainDeathDate"
        TriageDataCtlList(2, 12) = "ReferralDonorBrainDeathDate" 'Char Chaput Added for 8.0
        TriageDataCtlList(1, 13) = "SecondaryBrainDeathTime"
        TriageDataCtlList(2, 13) = "ReferralDonorBrainDeathTime" 'Char Chaput Added for 8.0
        TriageDataCtlList(1, 14) = "SecondaryTriageSpecificCOD" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(2, 14) = "ReferralDonorSpecificCOD" 'Char Chaput FSMod 05/09/06
        TriageDataCtlList(1, 15) = "SecondaryNOKName"
        TriageDataCtlList(2, 15) = "ReferralApproachNOK"
        TriageDataCtlList(1, 16) = "SecondaryNOKPhone"
        TriageDataCtlList(2, 16) = "ReferralNOKPhone"
        If Me.NOKID > 0 Or Me.NOK = "" Or IsDBNull(Me.NOKID) Then 'No new NOK and no old NOK
            TriageDataCtlList(1, 17) = "SecondaryNOKStreetAddress" 'Char Chaput FSMod 05/09/06
        Else
            TriageDataCtlList(1, 17) = "SecondaryNOKAddress"
        End If
        TriageDataCtlList(2, 17) = "ReferralNOKAddress"
        TriageDataCtlList(1, 18) = "SecondaryCoronerInvestigatorPhone"
        TriageDataCtlList(2, 18) = "ReferralCoronerPhone"
        TriageDataCtlList(1, 19) = "SecondaryPatientHospitalFloor" 'drh FSMod 06/13/03
        TriageDataCtlList(2, 19) = "ReferralCallerSubLocationLevel" 'drh FSMod 06/13/03

        'Combo boxes with integer value
        TriageDataCtlList(1, 20) = "SecondaryPatientHospitalUnit"
        TriageDataCtlList(2, 20) = "ReferralCallerSubLocationID"
        TriageDataCtlList(1, 21) = "SecondaryPatientRace"
        TriageDataCtlList(2, 21) = "ReferralDonorRaceID"
        TriageDataCtlList(1, 22) = "SecondaryPatientContactName"
        TriageDataCtlList(2, 22) = "ReferralCallerPersonID"
        TriageDataCtlList(1, 23) = "SecondaryMDAttendingId" 'drh FSMod 07/16/03
        TriageDataCtlList(2, 23) = "ReferralAttendingMD" 'drh FSMod 07/16/03

        'Checkbox
        TriageDataCtlList(1, 24) = "SecondaryCoronerCase"
        TriageDataCtlList(2, 24) = "ReferralCoronersCase"

        'Combobox/DB Text
        TriageDataCtlList(1, 25) = "SecondaryPatientGender"
        TriageDataCtlList(2, 25) = "ReferralDonorGender"
        TriageDataCtlList(1, 26) = "SecondaryNOKRelation"
        TriageDataCtlList(2, 26) = "ReferralApproachRelation"
        TriageDataCtlList(1, 27) = "SecondaryCoronerOrganization"
        TriageDataCtlList(2, 27) = "ReferralCoronerOrganization"
        TriageDataCtlList(1, 28) = "SecondaryCoronerInvestigatorName"
        TriageDataCtlList(2, 28) = "ReferralCoronerName"
        TriageDataCtlList(1, 29) = "SecondaryPatientAgeUnit"
        TriageDataCtlList(2, 29) = "ReferralDonorAgeUnit"


        TriageDataCtlList(1, 30) = "SecondaryLSADate" 'drh FSMod 06/13/03
        TriageDataCtlList(2, 30) = "ReferralDonorLSADate" 'drh FSMod 06/13/03

        TriageDataCtlList(1, 31) = "SecondaryLSATime" 'drh FSMod 06/13/03
        TriageDataCtlList(2, 31) = "ReferralDonorLSATime" 'drh FSMod 06/13/03

        TriageDataCtlList(1, 32) = "SecondaryPatientPhoneExt" 'drh FSMod 06/13/03
        TriageDataCtlList(2, 32) = "ReferralCallerExtension" 'drh FSMod 06/13/03

        Call GetDataFieldIndex(TriageDataCtlList, CTL_TEXT)
        Call GetDataFieldIndex(TriageDataCtlList, CTL_COMBOID)

        If Me.ModNOK = True Or Me.AddNOK = True Then
            If Me.NOKID = 0 Then
                Me.ModNOK = NEW_RECORD
            End If
            Call modStatSave.SaveNOK(Me)
        End If
        Call modStatSave.SaveSecondaryTriage(Me, TriageDataCtlList)


    End Sub
    Public Sub GetSecondaryReferralData()

        'Secondary Data (Secondary 1 table)
        Dim SecDataCtlList(2, 123) As Object 'drh FSMod 07/21/03 - Removed items, updated indexes
        SecDataCtlList(1, 0) = "SecondaryNOKNotifiedBy"
        SecDataCtlList(1, 1) = "SecondaryNOKNextDest"
        SecDataCtlList(1, 2) = "SecondaryPatientMiddleName"
        SecDataCtlList(1, 3) = "SecondaryPatientHeightFeet"
        SecDataCtlList(1, 4) = "SecondaryPatientHeightInches"
        SecDataCtlList(1, 5) = "SecondaryPatientBMICalc"
        SecDataCtlList(1, 6) = "SecondaryAdmissionDiagnosis"
        SecDataCtlList(1, 7) = "SecondaryCODSignatory"
        SecDataCtlList(1, 8) = "SecondaryCODTime"
        SecDataCtlList(1, 9) = "SecondaryCODSignedBy"
        SecDataCtlList(1, 10) = "SecondaryDeathWitnessedBy"
        SecDataCtlList(1, 11) = "SecondaryPCPName"
        SecDataCtlList(1, 12) = "SecondaryPCPPhone"
        SecDataCtlList(1, 13) = "SecondaryMDAttendingPhone"
        SecDataCtlList(1, 14) = "SecondaryInternalBloodLossCC"
        SecDataCtlList(1, 15) = "SecondaryExternalBloodLossCC"
        SecDataCtlList(1, 16) = "SecondaryPreTransfusionSampleQuantity"
        SecDataCtlList(1, 17) = "SecondaryPreTransfusionSampleHeldTechnician"
        SecDataCtlList(1, 18) = "SecondaryPostMordemSampleLocation"
        SecDataCtlList(1, 19) = "SecondaryPostMordemSampleContact"
        SecDataCtlList(1, 20) = "SecondarySputumCharacteristics"
        SecDataCtlList(1, 21) = "SecondaryNOKAltPhone"
        SecDataCtlList(1, 22) = "SecondaryNOKAltContact"
        SecDataCtlList(1, 23) = "SecondaryNOKAltContactPhone"
        SecDataCtlList(1, 24) = "SecondaryNOKPostMortemAuthorizationReminder"
        SecDataCtlList(1, 25) = "SecondaryCoronerCaseNumber"
        SecDataCtlList(1, 26) = "SecondaryCoronerCounty"
        SecDataCtlList(1, 27) = "SecondaryCoronerReleasedStipulations"
        SecDataCtlList(1, 28) = "SecondaryFuneralHomeName"
        SecDataCtlList(1, 29) = "SecondaryFuneralHomePhone"
        SecDataCtlList(1, 30) = "SecondaryFuneralHomeAddress"
        SecDataCtlList(1, 31) = "SecondaryFuneralHomeContact"
        SecDataCtlList(1, 32) = "SecondaryHoldOnBodyTag"
        SecDataCtlList(1, 33) = "SecondaryBodyLocation"
        SecDataCtlList(1, 34) = "SecondaryBodyMedicalChartLocation"
        SecDataCtlList(1, 35) = "SecondaryBodyIDTagLocation"
        SecDataCtlList(1, 36) = "SecondaryUNOSNumber"
        SecDataCtlList(1, 37) = "SecondaryClientNumber"
        SecDataCtlList(1, 38) = "SecondaryCryolifeNumber"
        SecDataCtlList(1, 39) = "SecondaryMTFNumber"
        SecDataCtlList(1, 40) = "SecondaryLifeNetNumber"
        SecDataCtlList(1, 41) = "SecondaryFreeText"
        SecDataCtlList(1, 42) = "SecondaryPatientSuffix" 'drh FSMod 06/13/03
        SecDataCtlList(1, 43) = "SecondaryBodyHoldPlacedWith" 'drh FSMod 06/19/03
        SecDataCtlList(1, 44) = "SecondaryBodyFutureContact" 'drh FSMod 06/19/03
        SecDataCtlList(1, 45) = "SecondaryBodyHoldPhone" 'drh FSMod 06/19/03

        SecDataCtlList(1, 46) = "SecondaryIntubationDate"
        SecDataCtlList(1, 47) = "SecondaryBrainDeathDate"
        SecDataCtlList(1, 48) = "SecondaryDNRDate"
        SecDataCtlList(1, 49) = "SecondaryLSADate"
        SecDataCtlList(1, 50) = "SecondaryPreTransfusionSampleDrawnDate"
        SecDataCtlList(1, 51) = "SecondaryPreTransfusionSampleHeldDate"
        SecDataCtlList(1, 52) = "SecondaryPostMordemSampleCollectionDate"
        SecDataCtlList(1, 53) = "SecondaryAutopsyDate"
        SecDataCtlList(1, 54) = "SecondaryBodyRefrigerationDate"
        SecDataCtlList(1, 55) = "SecondaryExtubationDate"
        SecDataCtlList(1, 56) = "SecondaryNOKNotifiedDate"
        SecDataCtlList(1, 57) = "SecondaryBodyHoldPlaced" 'drh FSMod 06/19/03

        SecDataCtlList(1, 58) = "SecondaryEstTimeSinceLeft"
        SecDataCtlList(1, 59) = "SecondaryTimeLeftInMT"
        SecDataCtlList(1, 60) = "SecondaryIntubationTime"
        SecDataCtlList(1, 61) = "SecondaryBrainDeathTime"
        SecDataCtlList(1, 62) = "SecondaryEMSArrivalToPatientTime"
        SecDataCtlList(1, 63) = "SecondaryEMSArrivalToHospitalTime"
        SecDataCtlList(1, 64) = "SecondaryLSATime"
        SecDataCtlList(1, 65) = "SecondaryPreTransfusionSampleDrawnTime"
        SecDataCtlList(1, 66) = "SecondaryPreTransfusionSampleHeldTime"
        SecDataCtlList(1, 67) = "SecondaryPostMordemSampleCollectionTime"
        SecDataCtlList(1, 68) = "SecondaryAutopsyTime"
        SecDataCtlList(1, 69) = "SecondaryBodyRefrigerationTime"
        SecDataCtlList(1, 70) = "SecondaryExtubationTime"
        SecDataCtlList(1, 71) = "SecondaryNOKNotifiedTime"
        SecDataCtlList(1, 72) = "SecondaryNOKETA"
        SecDataCtlList(1, 73) = "SecondaryBodyHoldPlacedTime" 'drh FSMod 06/24/03

        SecDataCtlList(1, 74) = "SecondaryPreTransfusionSampleRequired"
        SecDataCtlList(1, 75) = "SecondaryPreTransfusionSampleAvailable"
        SecDataCtlList(1, 76) = "SecondaryNOKaware"
        SecDataCtlList(1, 77) = "SecondaryFamilyConsent"
        SecDataCtlList(1, 78) = "SecondaryFamilyInterested"
        SecDataCtlList(1, 79) = "SecondaryNOKatHospital"
        SecDataCtlList(1, 80) = "SecondaryPatientVent"
        SecDataCtlList(1, 81) = "SecondaryDeathWitnessed"
        SecDataCtlList(1, 82) = "SecondaryFluidsGiven"
        SecDataCtlList(1, 83) = "SecondaryBloodLoss"
        SecDataCtlList(1, 84) = "SecondarySignOfInfection"
        SecDataCtlList(1, 85) = "SecondaryMedication"
        SecDataCtlList(1, 86) = "SecondaryAntibiotic"
        SecDataCtlList(1, 87) = "SecondaryBloodProducts"
        SecDataCtlList(1, 88) = "SecondaryColloidsInfused"
        SecDataCtlList(1, 89) = "SecondaryCrystalloids"
        SecDataCtlList(1, 90) = "SecondaryPostMordemSampleTestSuitable"
        SecDataCtlList(1, 91) = "SecondaryNOKLegal"
        SecDataCtlList(1, 92) = "SecondaryNOKPostMortemAuthorization"
        SecDataCtlList(1, 93) = "SecondaryAutopsy"
        SecDataCtlList(1, 94) = "SecondaryAutopsyBloodRequested"
        SecDataCtlList(1, 95) = "SecondaryAutopsyCopyRequested"
        SecDataCtlList(1, 96) = "SecondaryFuneralHomeSelected"
        SecDataCtlList(1, 97) = "SecondaryHoldOnBody"
        SecDataCtlList(1, 98) = "SecondaryHistorySubstanceAbuse"
        SecDataCtlList(1, 99) = "SecondaryAutopsyReminderYN"
        SecDataCtlList(1, 100) = "SecondaryFHReminderYN"
        SecDataCtlList(1, 101) = "SecondaryBodyCareReminderYN"
        SecDataCtlList(1, 102) = "SecondaryWrapUpReminderYN"
        SecDataCtlList(1, 103) = "SecondaryFuneralHomeNotified"
        SecDataCtlList(1, 104) = "SecondaryFuneralHomeMorgueCooled"
        SecDataCtlList(1, 105) = "SecondaryPatientABO" 'drh FSMod 06/13/03
        SecDataCtlList(1, 106) = "SecondaryRhythm" 'drh FSMod 06/17/03
        SecDataCtlList(1, 107) = "SecondarySteroid" 'drh FSMod 06/24/03

        SecDataCtlList(1, 108) = "SecondaryCoronerCase" '9/20/02 drh - Added Coroner Case

        SecDataCtlList(1, 109) = "SecondaryCOD"
        'Identify the corresponding "Other" field
        SecDataCtlList(2, 109) = "SecondaryCODOther"

        SecDataCtlList(1, 110) = "SecondaryAutopsyLocation"
        'Identify the corresponding "Other" field
        SecDataCtlList(2, 110) = "SecondaryAutopsyLocationOther"

        SecDataCtlList(1, 111) = "SecondaryNOKGender"
        SecDataCtlList(1, 112) = "SecondaryCoronerReleased"
        SecDataCtlList(1, 113) = "SecondaryPreTransfusionSampleHeldAt"
        SecDataCtlList(1, 114) = "SecondaryBodyCoolingMethod"

        SecDataCtlList(1, 115) = "SecondaryCircumstanceOfDeath"
        SecDataCtlList(1, 116) = "SecondaryMedicalHistory"
        SecDataCtlList(1, 117) = "SecondaryPhysicalAppearance"
        SecDataCtlList(1, 118) = "SecondarySubstanceAbuseDetail"
        SecDataCtlList(1, 119) = "SecondaryAdditionalComments" 'drh FSMod 06/17/03
        SecDataCtlList(1, 120) = "SecondaryAdditionalMedications" 'drh FSMod 06/17/03

        'drh FSMod 06/19/03 - New format: Checkbox
        SecDataCtlList(1, 121) = "SecondaryBodyHoldInstructionsGiven" 'drh FSMod 06/17/03

        'Add the "Other" fields to the query resultset
        SecDataCtlList(1, 122) = "SecondaryCODOther"
        SecDataCtlList(1, 123) = "SecondaryAutopsyLocationOther"


        Call GetDataFieldIndex(SecDataCtlList, CTL_TEXT)
        Call GetDataFieldIndex(SecDataCtlList, CTL_COMBOID)
        Call GetDataFieldIndex(SecDataCtlList, CTL_RICHTEXT)
        Call GetDataFieldIndex(SecDataCtlList, CTL_CHECKBOXCTL)



        'Secondary Data (Secondary 2 table)
        Dim SecDataCtlList2(2, 81) As Object
        SecDataCtlList2(1, 0) = "SecondaryBloodProductsReceived1Units"
        SecDataCtlList2(1, 1) = "SecondaryBloodProductsReceived2Units"
        SecDataCtlList2(1, 2) = "SecondaryBloodProductsReceived3Units"
        SecDataCtlList2(1, 3) = "SecondaryColloidsInfused1Units"
        SecDataCtlList2(1, 4) = "SecondaryColloidsInfused2Units"
        SecDataCtlList2(1, 5) = "SecondaryColloidsInfused3Units"
        SecDataCtlList2(1, 6) = "SecondaryCrystalloids1Units"
        SecDataCtlList2(1, 7) = "SecondaryCrystalloids2Units"
        SecDataCtlList2(1, 8) = "SecondaryCrystalloids3Units"
        SecDataCtlList2(1, 9) = "SecondaryWBC1"
        SecDataCtlList2(1, 10) = "SecondaryWBC1Bands"
        SecDataCtlList2(1, 11) = "SecondaryWBC2"
        SecDataCtlList2(1, 12) = "SecondaryWBC2Bands"
        SecDataCtlList2(1, 13) = "SecondaryWBC3"
        SecDataCtlList2(1, 14) = "SecondaryWBC3Bands"
        SecDataCtlList2(1, 15) = "SecondaryLabTemp1"
        SecDataCtlList2(1, 16) = "SecondaryLabTemp2"
        SecDataCtlList2(1, 17) = "SecondaryLabTemp3"
        SecDataCtlList2(1, 18) = "SecondaryCulture1Growth"
        SecDataCtlList2(1, 19) = "SecondaryCulture2Growth"
        SecDataCtlList2(1, 20) = "SecondaryCulture3Growth"
        SecDataCtlList2(1, 21) = "SecondaryCXR1Finding"
        SecDataCtlList2(1, 22) = "SecondaryCXR2Finding"
        SecDataCtlList2(1, 23) = "SecondaryCXR3Finding"

        SecDataCtlList2(1, 24) = "SecondaryWBC1Date"
        SecDataCtlList2(1, 25) = "SecondaryWBC2Date"
        SecDataCtlList2(1, 26) = "SecondaryWBC3Date"
        SecDataCtlList2(1, 27) = "SecondaryLabTemp1Date"
        SecDataCtlList2(1, 28) = "SecondaryLabTemp2Date"
        SecDataCtlList2(1, 29) = "SecondaryLabTemp3Date"
        SecDataCtlList2(1, 30) = "SecondaryCulture1DrawnDate"
        SecDataCtlList2(1, 31) = "SecondaryCulture2DrawnDate"
        SecDataCtlList2(1, 32) = "SecondaryCulture3DrawnDate"
        SecDataCtlList2(1, 33) = "SecondaryCXR1Date"
        SecDataCtlList2(1, 34) = "SecondaryCXR2Date"
        SecDataCtlList2(1, 35) = "SecondaryCXR3Date"

        SecDataCtlList2(1, 36) = "SecondaryLabTemp1Time"
        SecDataCtlList2(1, 37) = "SecondaryLabTemp2Time"
        SecDataCtlList2(1, 38) = "SecondaryLabTemp3Time"

        SecDataCtlList2(1, 39) = "SecondaryCXRAvailable"

        SecDataCtlList2(1, 40) = "SecondaryBloodProductsReceived1Type"
        SecDataCtlList2(2, 40) = "SecondaryBloodProductsReceived1TypeOther"
        SecDataCtlList2(1, 41) = "SecondaryBloodProductsReceived2Type"
        SecDataCtlList2(2, 41) = "SecondaryBloodProductsReceived2TypeOther"
        SecDataCtlList2(1, 42) = "SecondaryBloodProductsReceived3Type"
        SecDataCtlList2(2, 42) = "SecondaryBloodProductsReceived3TypeOther"
        SecDataCtlList2(1, 43) = "SecondaryColloidsInfused1Type"
        SecDataCtlList2(2, 43) = "SecondaryColloidsInfused1TypeOther"
        SecDataCtlList2(1, 44) = "SecondaryColloidsInfused2Type"
        SecDataCtlList2(2, 44) = "SecondaryColloidsInfused2TypeOther"
        SecDataCtlList2(1, 45) = "SecondaryColloidsInfused3Type"
        SecDataCtlList2(2, 45) = "SecondaryColloidsInfused3TypeOther"
        SecDataCtlList2(1, 46) = "SecondaryCrystalloids1Type"
        SecDataCtlList2(2, 46) = "SecondaryCrystalloids1TypeOther"
        SecDataCtlList2(1, 47) = "SecondaryCrystalloids2Type"
        SecDataCtlList2(2, 47) = "SecondaryCrystalloids2TypeOther"
        SecDataCtlList2(1, 48) = "SecondaryCrystalloids3Type"
        SecDataCtlList2(2, 48) = "SecondaryCrystalloids3TypeOther"
        SecDataCtlList2(1, 49) = "SecondaryCulture1Type"
        SecDataCtlList2(2, 49) = "SecondaryCulture1Other"
        SecDataCtlList2(1, 50) = "SecondaryCulture2Type"
        SecDataCtlList2(2, 50) = "SecondaryCulture2Other"
        SecDataCtlList2(1, 51) = "SecondaryCulture3Type"
        SecDataCtlList2(2, 51) = "SecondaryCulture3Other"

        SecDataCtlList2(1, 52) = "SecondaryBloodProductsReceived1TypeCC"
        SecDataCtlList2(1, 53) = "SecondaryBloodProductsReceived1TypeUnitGiven"
        SecDataCtlList2(1, 54) = "SecondaryBloodProductsReceived2TypeCC"
        SecDataCtlList2(1, 55) = "SecondaryBloodProductsReceived2TypeUnitGiven"
        SecDataCtlList2(1, 56) = "SecondaryBloodProductsReceived3TypeCC"
        SecDataCtlList2(1, 57) = "SecondaryBloodProductsReceived3TypeUnitGiven"
        SecDataCtlList2(1, 58) = "SecondaryColloidsInfused1CC"
        SecDataCtlList2(1, 59) = "SecondaryColloidsInfused1UnitGiven"
        SecDataCtlList2(1, 60) = "SecondaryColloidsInfused2CC"
        SecDataCtlList2(1, 61) = "SecondaryColloidsInfused2UnitGiven"
        SecDataCtlList2(1, 62) = "SecondaryColloidsInfused3CC"
        SecDataCtlList2(1, 63) = "SecondaryColloidsInfused3UnitGiven"
        SecDataCtlList2(1, 64) = "SecondaryCrystalloids1CC"
        SecDataCtlList2(1, 65) = "SecondaryCrystalloids1UnitGiven"
        SecDataCtlList2(1, 66) = "SecondaryCrystalloids2CC"
        SecDataCtlList2(1, 67) = "SecondaryCrystalloids2UnitGiven"
        SecDataCtlList2(1, 68) = "SecondaryCrystalloids3CC"
        SecDataCtlList2(1, 69) = "SecondaryCrystalloids3UnitGiven"

        '"Others"
        SecDataCtlList2(1, 70) = "SecondaryBloodProductsReceived1TypeOther"
        SecDataCtlList2(1, 71) = "SecondaryBloodProductsReceived2TypeOther"
        SecDataCtlList2(1, 72) = "SecondaryBloodProductsReceived3TypeOther"
        SecDataCtlList2(1, 73) = "SecondaryColloidsInfused1TypeOther"
        SecDataCtlList2(1, 74) = "SecondaryColloidsInfused2TypeOther"
        SecDataCtlList2(1, 75) = "SecondaryColloidsInfused3TypeOther"
        SecDataCtlList2(1, 76) = "SecondaryCrystalloids1TypeOther"
        SecDataCtlList2(1, 77) = "SecondaryCrystalloids2TypeOther"
        SecDataCtlList2(1, 78) = "SecondaryCrystalloids3TypeOther"
        SecDataCtlList2(1, 79) = "SecondaryCulture1Other"
        SecDataCtlList2(1, 80) = "SecondaryCulture2Other"
        SecDataCtlList2(1, 81) = "SecondaryCulture3Other"

        Call GetDataFieldIndex(SecDataCtlList2, CTL_TEXT)
        Call GetDataFieldIndex(SecDataCtlList2, CTL_COMBOID)

        Call modStatQuery.QuerySecondarySecData(Me, SecDataCtlList, SecDataCtlList2)

        'ccarroll 06/01/2007 StatTrac 8.4 release, requirement 3.6
        'ccarroll 06/20/2007 added initialize for TBI
        Me.DataTextArray(36).BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
        Me.chkSecondaryTBINotNeeded.Enabled = False
        Me.txtSecondaryTBIComment.Enabled = False

        'Me.cmdGenerateTBI.Enabled = False

        Call modStatQuery.QuerySecondaryTBI(Me)

    End Sub

    Public Sub SaveSecondaryReferralData()

        'Secondary Data (Secondary 1 table)
        Dim SecDataCtlList(2, 122) As Object 'drh FSMod 07/20/03 - Removed items and updated indexes
        SecDataCtlList(1, 0) = "SecondaryNOKNotifiedBy"
        SecDataCtlList(1, 1) = "SecondaryNOKNextDest"
        SecDataCtlList(1, 2) = "SecondaryPatientMiddleName"
        SecDataCtlList(1, 3) = "SecondaryPatientHeightFeet"
        SecDataCtlList(1, 4) = "SecondaryPatientHeightInches"
        SecDataCtlList(1, 5) = "SecondaryPatientBMICalc"
        SecDataCtlList(1, 6) = "SecondaryAdmissionDiagnosis"
        SecDataCtlList(1, 7) = "SecondaryCODSignatory"
        SecDataCtlList(1, 8) = "SecondaryCODTime"
        SecDataCtlList(1, 9) = "SecondaryCODSignedBy"
        SecDataCtlList(1, 10) = "SecondaryDeathWitnessedBy"
        SecDataCtlList(1, 11) = "SecondaryPCPName"
        SecDataCtlList(1, 12) = "SecondaryPCPPhone"
        SecDataCtlList(1, 13) = "SecondaryMDAttendingPhone"
        SecDataCtlList(1, 14) = "SecondaryInternalBloodLossCC"
        SecDataCtlList(1, 15) = "SecondaryExternalBloodLossCC"
        SecDataCtlList(1, 16) = "SecondaryPreTransfusionSampleQuantity"
        SecDataCtlList(1, 17) = "SecondaryPreTransfusionSampleHeldTechnician"
        SecDataCtlList(1, 18) = "SecondaryPostMordemSampleLocation"
        SecDataCtlList(1, 19) = "SecondaryPostMordemSampleContact"
        SecDataCtlList(1, 20) = "SecondarySputumCharacteristics"
        SecDataCtlList(1, 21) = "SecondaryNOKAltPhone"
        SecDataCtlList(1, 22) = "SecondaryNOKAltContact"
        SecDataCtlList(1, 23) = "SecondaryNOKAltContactPhone"
        SecDataCtlList(1, 24) = "SecondaryNOKPostMortemAuthorizationReminder"
        SecDataCtlList(1, 25) = "SecondaryCoronerCaseNumber"
        SecDataCtlList(1, 26) = "SecondaryCoronerCounty"
        SecDataCtlList(1, 27) = "SecondaryCoronerReleasedStipulations"
        SecDataCtlList(1, 28) = "SecondaryFuneralHomeName"
        SecDataCtlList(1, 29) = "SecondaryFuneralHomePhone"
        SecDataCtlList(1, 30) = "SecondaryFuneralHomeAddress"
        SecDataCtlList(1, 31) = "SecondaryFuneralHomeContact"
        SecDataCtlList(1, 32) = "SecondaryHoldOnBodyTag"
        SecDataCtlList(1, 33) = "SecondaryBodyLocation"
        SecDataCtlList(1, 34) = "SecondaryBodyMedicalChartLocation"
        SecDataCtlList(1, 35) = "SecondaryBodyIDTagLocation"
        SecDataCtlList(1, 36) = "SecondaryUNOSNumber"
        SecDataCtlList(1, 37) = "SecondaryClientNumber"
        SecDataCtlList(1, 38) = "SecondaryCryolifeNumber"
        SecDataCtlList(1, 39) = "SecondaryMTFNumber"
        SecDataCtlList(1, 40) = "SecondaryLifeNetNumber"
        SecDataCtlList(1, 41) = "SecondaryFreeText"
        SecDataCtlList(1, 42) = "SecondaryPatientSuffix" 'drh FSMod 06/13/03
        SecDataCtlList(1, 43) = "SecondaryBodyHoldPlacedWith" 'drh FSMod 06/19/03
        SecDataCtlList(1, 44) = "SecondaryBodyFutureContact" 'drh FSMod 06/19/03
        SecDataCtlList(1, 45) = "SecondaryBodyHoldPhone" 'drh FSMod 06/19/03

        SecDataCtlList(1, 46) = "SecondaryIntubationDate"
        SecDataCtlList(1, 47) = "SecondaryBrainDeathDate"
        SecDataCtlList(1, 48) = "SecondaryDNRDate"
        SecDataCtlList(1, 49) = "SecondaryLSADate"
        SecDataCtlList(1, 50) = "SecondaryPreTransfusionSampleDrawnDate"
        SecDataCtlList(1, 51) = "SecondaryPreTransfusionSampleHeldDate"
        SecDataCtlList(1, 52) = "SecondaryPostMordemSampleCollectionDate"
        SecDataCtlList(1, 53) = "SecondaryAutopsyDate"
        SecDataCtlList(1, 54) = "SecondaryBodyRefrigerationDate"
        SecDataCtlList(1, 55) = "SecondaryExtubationDate"
        SecDataCtlList(1, 56) = "SecondaryNOKNotifiedDate"
        SecDataCtlList(1, 57) = "SecondaryBodyHoldPlaced" 'drh FSMod 06/19/03

        SecDataCtlList(1, 58) = "SecondaryEstTimeSinceLeft"
        SecDataCtlList(1, 59) = "SecondaryTimeLeftInMT"
        SecDataCtlList(1, 60) = "SecondaryIntubationTime"
        SecDataCtlList(1, 61) = "SecondaryBrainDeathTime"
        SecDataCtlList(1, 62) = "SecondaryEMSArrivalToPatientTime"
        SecDataCtlList(1, 63) = "SecondaryEMSArrivalToHospitalTime"
        SecDataCtlList(1, 64) = "SecondaryLSATime"
        SecDataCtlList(1, 65) = "SecondaryPreTransfusionSampleDrawnTime"
        SecDataCtlList(1, 66) = "SecondaryPreTransfusionSampleHeldTime"
        SecDataCtlList(1, 67) = "SecondaryPostMordemSampleCollectionTime"
        SecDataCtlList(1, 68) = "SecondaryAutopsyTime"
        SecDataCtlList(1, 69) = "SecondaryBodyRefrigerationTime"
        SecDataCtlList(1, 70) = "SecondaryExtubationTime"
        SecDataCtlList(1, 71) = "SecondaryNOKNotifiedTime"
        SecDataCtlList(1, 72) = "SecondaryNOKETA"
        SecDataCtlList(1, 73) = "SecondaryBodyHoldPlacedTime" 'drh FSMod 06/24/03

        SecDataCtlList(1, 74) = "SecondaryPreTransfusionSampleRequired"
        SecDataCtlList(1, 75) = "SecondaryPreTransfusionSampleAvailable"
        SecDataCtlList(1, 76) = "SecondaryNOKaware"
        SecDataCtlList(1, 77) = "SecondaryFamilyConsent"
        SecDataCtlList(1, 78) = "SecondaryFamilyInterested"
        SecDataCtlList(1, 79) = "SecondaryNOKatHospital"
        SecDataCtlList(1, 80) = "SecondaryPatientVent"
        SecDataCtlList(1, 81) = "SecondaryDeathWitnessed"
        SecDataCtlList(1, 82) = "SecondaryFluidsGiven"
        SecDataCtlList(1, 83) = "SecondaryBloodLoss"
        SecDataCtlList(1, 84) = "SecondarySignOfInfection"
        SecDataCtlList(1, 85) = "SecondaryMedication"
        SecDataCtlList(1, 86) = "SecondaryAntibiotic"
        SecDataCtlList(1, 87) = "SecondaryBloodProducts"
        SecDataCtlList(1, 88) = "SecondaryColloidsInfused"
        SecDataCtlList(1, 89) = "SecondaryCrystalloids"
        SecDataCtlList(1, 90) = "SecondaryPostMordemSampleTestSuitable"
        SecDataCtlList(1, 91) = "SecondaryNOKLegal"
        SecDataCtlList(1, 92) = "SecondaryNOKPostMortemAuthorization"
        SecDataCtlList(1, 93) = "SecondaryAutopsy"
        SecDataCtlList(1, 94) = "SecondaryAutopsyBloodRequested"
        SecDataCtlList(1, 95) = "SecondaryAutopsyCopyRequested"
        SecDataCtlList(1, 96) = "SecondaryFuneralHomeSelected"
        SecDataCtlList(1, 97) = "SecondaryHoldOnBody"
        SecDataCtlList(1, 98) = "SecondaryHistorySubstanceAbuse"
        SecDataCtlList(1, 99) = "SecondaryAutopsyReminderYN"
        SecDataCtlList(1, 100) = "SecondaryFHReminderYN"
        SecDataCtlList(1, 101) = "SecondaryBodyCareReminderYN"
        SecDataCtlList(1, 102) = "SecondaryWrapUpReminderYN"
        SecDataCtlList(1, 103) = "SecondaryFuneralHomeNotified"
        SecDataCtlList(1, 104) = "SecondaryFuneralHomeMorgueCooled"
        SecDataCtlList(1, 105) = "SecondaryPatientABO" 'drh FSMod 06/13/03
        SecDataCtlList(1, 106) = "SecondaryCoronerCase" '9/20/02 drh - Added Coroner Case
        SecDataCtlList(1, 107) = "SecondaryRhythm" 'drh FSMod 06/17/03
        SecDataCtlList(1, 108) = "SecondarySteroid" 'drh FSMod 06/24/03

        SecDataCtlList(1, 109) = "SecondaryBirthCBO"
        SecDataCtlList(1, 110) = "SecondaryNOKGender"
        SecDataCtlList(1, 111) = "SecondaryCoronerReleased"
        SecDataCtlList(1, 112) = "SecondaryPreTransfusionSampleHeldAt"
        SecDataCtlList(1, 113) = "SecondaryBodyCoolingMethod"

        SecDataCtlList(1, 114) = "SecondaryCircumstanceOfDeath"
        SecDataCtlList(1, 115) = "SecondaryMedicalHistory"
        SecDataCtlList(1, 116) = "SecondaryPhysicalAppearance"
        SecDataCtlList(1, 117) = "SecondarySubstanceAbuseDetail"
        SecDataCtlList(1, 118) = "SecondaryAdditionalComments" 'drh FSMod 06/16/03
        SecDataCtlList(1, 119) = "SecondaryAdditionalMedications" 'drh FSMod 06/17/03

        'drh FSMod 06/19/03 - New format: Checkbox
        SecDataCtlList(1, 120) = "SecondaryBodyHoldInstructionsGiven" 'drh FSMod 06/17/03

        SecDataCtlList(1, 121) = "SecondaryCOD"
        SecDataCtlList(2, 121) = "SecondaryCODOther"
        SecDataCtlList(1, 122) = "SecondaryAutopsyLocation"
        SecDataCtlList(2, 122) = "SecondaryAutopsyLocationOther"


        Call GetDataFieldIndex(SecDataCtlList, CTL_TEXT)
        Call GetDataFieldIndex(SecDataCtlList, CTL_COMBOID)
        Call GetDataFieldIndex(SecDataCtlList, CTL_RICHTEXT)
        Call GetDataFieldIndex(SecDataCtlList, CTL_CHECKBOXCTL)



        'Secondary Data (Secondary 2 table)
        Dim SecDataCtlList2(2, 69) As Object '07/20/03 drh FSMod - Removed antibiotic items and updated all indexes
        SecDataCtlList2(1, 0) = "SecondaryBloodProductsReceived1Units"
        SecDataCtlList2(1, 1) = "SecondaryBloodProductsReceived2Units"
        SecDataCtlList2(1, 2) = "SecondaryBloodProductsReceived3Units"
        SecDataCtlList2(1, 3) = "SecondaryColloidsInfused1Units"
        SecDataCtlList2(1, 4) = "SecondaryColloidsInfused2Units"
        SecDataCtlList2(1, 5) = "SecondaryColloidsInfused3Units"
        SecDataCtlList2(1, 6) = "SecondaryCrystalloids1Units"
        SecDataCtlList2(1, 7) = "SecondaryCrystalloids2Units"
        SecDataCtlList2(1, 8) = "SecondaryCrystalloids3Units"
        SecDataCtlList2(1, 9) = "SecondaryWBC1"
        SecDataCtlList2(1, 10) = "SecondaryWBC1Bands"
        SecDataCtlList2(1, 11) = "SecondaryWBC2"
        SecDataCtlList2(1, 12) = "SecondaryWBC2Bands"
        SecDataCtlList2(1, 13) = "SecondaryWBC3"
        SecDataCtlList2(1, 14) = "SecondaryWBC3Bands"
        SecDataCtlList2(1, 15) = "SecondaryLabTemp1"
        SecDataCtlList2(1, 16) = "SecondaryLabTemp2"
        SecDataCtlList2(1, 17) = "SecondaryLabTemp3"
        SecDataCtlList2(1, 18) = "SecondaryCulture1Growth"
        SecDataCtlList2(1, 19) = "SecondaryCulture2Growth"
        SecDataCtlList2(1, 20) = "SecondaryCulture3Growth"
        SecDataCtlList2(1, 21) = "SecondaryCXR1Finding"
        SecDataCtlList2(1, 22) = "SecondaryCXR2Finding"
        SecDataCtlList2(1, 23) = "SecondaryCXR3Finding"

        SecDataCtlList2(1, 24) = "SecondaryWBC1Date"
        SecDataCtlList2(1, 25) = "SecondaryWBC2Date"
        SecDataCtlList2(1, 26) = "SecondaryWBC3Date"
        SecDataCtlList2(1, 27) = "SecondaryLabTemp1Date"
        SecDataCtlList2(1, 28) = "SecondaryLabTemp2Date"
        SecDataCtlList2(1, 29) = "SecondaryLabTemp3Date"
        SecDataCtlList2(1, 30) = "SecondaryCulture1DrawnDate"
        SecDataCtlList2(1, 31) = "SecondaryCulture2DrawnDate"
        SecDataCtlList2(1, 32) = "SecondaryCulture3DrawnDate"
        SecDataCtlList2(1, 33) = "SecondaryCXR1Date"
        SecDataCtlList2(1, 34) = "SecondaryCXR2Date"
        SecDataCtlList2(1, 35) = "SecondaryCXR3Date"

        SecDataCtlList2(1, 36) = "SecondaryLabTemp1Time"
        SecDataCtlList2(1, 37) = "SecondaryLabTemp2Time"
        SecDataCtlList2(1, 38) = "SecondaryLabTemp3Time"

        SecDataCtlList2(1, 39) = "SecondaryCXRAvailable"

        SecDataCtlList2(1, 40) = "SecondaryBloodProductsReceived1TypeCC"
        SecDataCtlList2(1, 41) = "SecondaryBloodProductsReceived1TypeUnitGiven"
        SecDataCtlList2(1, 42) = "SecondaryBloodProductsReceived2TypeCC"
        SecDataCtlList2(1, 43) = "SecondaryBloodProductsReceived2TypeUnitGiven"
        SecDataCtlList2(1, 44) = "SecondaryBloodProductsReceived3TypeCC"
        SecDataCtlList2(1, 45) = "SecondaryBloodProductsReceived3TypeUnitGiven"
        SecDataCtlList2(1, 46) = "SecondaryColloidsInfused1CC"
        SecDataCtlList2(1, 47) = "SecondaryColloidsInfused1UnitGiven"
        SecDataCtlList2(1, 48) = "SecondaryColloidsInfused2CC"
        SecDataCtlList2(1, 49) = "SecondaryColloidsInfused2UnitGiven"
        SecDataCtlList2(1, 50) = "SecondaryColloidsInfused3CC"
        SecDataCtlList2(1, 51) = "SecondaryColloidsInfused3UnitGiven"
        SecDataCtlList2(1, 52) = "SecondaryCrystalloids1CC"
        SecDataCtlList2(1, 53) = "SecondaryCrystalloids1UnitGiven"
        SecDataCtlList2(1, 54) = "SecondaryCrystalloids2CC"
        SecDataCtlList2(1, 55) = "SecondaryCrystalloids2UnitGiven"
        SecDataCtlList2(1, 56) = "SecondaryCrystalloids3CC"
        SecDataCtlList2(1, 57) = "SecondaryCrystalloids3UnitGiven"

        SecDataCtlList2(1, 58) = "SecondaryBloodProductsReceived1Type"
        SecDataCtlList2(2, 58) = "SecondaryBloodProductsReceived1TypeOther"
        SecDataCtlList2(1, 59) = "SecondaryBloodProductsReceived2Type"
        SecDataCtlList2(2, 59) = "SecondaryBloodProductsReceived2TypeOther"
        SecDataCtlList2(1, 60) = "SecondaryBloodProductsReceived3Type"
        SecDataCtlList2(2, 60) = "SecondaryBloodProductsReceived3TypeOther"
        SecDataCtlList2(1, 61) = "SecondaryColloidsInfused1Type"
        SecDataCtlList2(2, 61) = "SecondaryColloidsInfused1TypeOther"
        SecDataCtlList2(1, 62) = "SecondaryColloidsInfused2Type"
        SecDataCtlList2(2, 62) = "SecondaryColloidsInfused2TypeOther"
        SecDataCtlList2(1, 63) = "SecondaryColloidsInfused3Type"
        SecDataCtlList2(2, 63) = "SecondaryColloidsInfused3TypeOther"
        SecDataCtlList2(1, 64) = "SecondaryCrystalloids1Type"
        SecDataCtlList2(2, 64) = "SecondaryCrystalloids1TypeOther"
        SecDataCtlList2(1, 65) = "SecondaryCrystalloids2Type"
        SecDataCtlList2(2, 65) = "SecondaryCrystalloids2TypeOther"
        SecDataCtlList2(1, 66) = "SecondaryCrystalloids3Type"
        SecDataCtlList2(2, 66) = "SecondaryCrystalloids3TypeOther"
        SecDataCtlList2(1, 67) = "SecondaryCulture1Type"
        SecDataCtlList2(2, 67) = "SecondaryCulture1Other"
        SecDataCtlList2(1, 68) = "SecondaryCulture2Type"
        SecDataCtlList2(2, 68) = "SecondaryCulture2Other"
        SecDataCtlList2(1, 69) = "SecondaryCulture3Type"
        SecDataCtlList2(2, 69) = "SecondaryCulture3Other"


        Call GetDataFieldIndex(SecDataCtlList2, CTL_TEXT)
        Call GetDataFieldIndex(SecDataCtlList2, CTL_COMBOID)

        Call modStatSave.SaveSecondary(Me, SecDataCtlList, SecDataCtlList2)

        'ccarroll 06/06/2007 StatTrac release 8.4 requirement 3.6 - TBI Number
        If Me.TBIUpdateFlag = True Then
            'Information has changed. Update TBI Comment
            Call modStatSave.UpdateSecondaryTBI(Me)

            'create TBI LogEvent
            Call modStatSave.SaveLogEvent(Me, GENERAL, Me.TBINoteText)

            Me.TBIUpdateFlag = False
        End If

    End Sub

    Public Sub InitializeTabFrames()

        'drh FSMod 06/05/03 - Added ErrorNextI
        On Error GoTo ErrorNextI

        Dim I As Integer
        'Initialize Frames
        'drh FSMod 06/05/03 - Changed to Me.fmDataFrame.UBound from Me.fmDataFrame.Count - 1
        For Each frameTemp As GroupBox In fmDataFrame
            frameTemp.Location = New System.Drawing.Point(4, 4)
            frameTemp.Visible = False
            frameTemp.Text = ""
        Next

        'Initialize Tabs
        Me.tbReferralData.TabPages.Clear()


        'drh FSMod 06/05/03
        Exit Sub

        'drh FSMod 06/05/03 - Added ErrorNextI
ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Private Sub LoadTriageReferral()
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmReferral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time along with
        'set callopenbyid equal to person in this instance of stattrac when the form is loaded
        '====================================================================================
        'Date Changed: 6/13/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9 Deleted logevent, Logevent number
        'Description:  Change size and order of logevent columns
        '
        '====================================================================================
        '************************************************************************************
        'FSProj drh 6/15/02 - Stole code from FrmReferral

        On Error Resume Next

        '    Me.AlertType = REFERRAL

        '    Dim vParams$()
        '    Dim i%
        '    Dim ResultsArray
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        Call modUtility.CenterForm(ParentForm)

        '    'Set the call type
        '    Me.CallType = REFERRAL

        Call modStatRefQuery.ListRefQueryStatEmployee(CboCallByEmployee)

        If Me.FormState = NEW_RECORD Then
        ElseIf Me.FormState = EXISTING_RECORD Then

            '11/16/05 C.Chaput set callopenbyid for this for equal to person in this instance of stattrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID

            '01/05/05 check to see if is exclusive, fscase or pending
            Call modStatQuery.QueryCallAccess(Me)

            'Get the call record
            Call modStatQuery.QueryCall(Me)

            '        'Get LO Call Information
            '        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            '            Call modStatQuery.QueryLOCall(Me)
            '        End If

            'Set the call date
            TxtCallDate.Text = Me.CallDate

            '        'FSProj drh 5/1/02 - Check whether this is a historical referral
            '        If CDate(Me.CallDate) < CDate(HISTORICAL_CUTOFF) Then
            '            Me.HistoricalReferral = True
            '        End If

            'Get the referral record in form activate
            Me.FormLoad = True

        End If


        Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name


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

        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowDeleteLogEvent") Then
            Me.CmdDelete.Visible = True
        Else
            Me.CmdDelete.Visible = False
        End If

        If btnSaveAndClose.Enabled = False Then
            TimerTotalTime.Enabled = False
        End If

    End Sub


    Public Sub SetDataFocus(ByRef vSelectedFrame As System.Windows.Forms.GroupBox)

        Dim vLowTabIdx As Integer
        Dim I As Short
        vLowTabIdx = 100000

        'If array element doesn't exist, go to handler
        On Error GoTo ErrorNextI

        For Each dataTextArrayItem As TextBox In DataTextArray

            If dataTextArrayItem.Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If dataTextArrayItem.TabIndex < vLowTabIdx Then
                    If dataTextArrayItem.Enabled Then
                        dataTextArrayItem.Focus()
                        vLowTabIdx = dataTextArrayItem.TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If dataTextArrayItem.Tag = tvTreeView.SelectedNode.Tag Then
                    dataTextArrayItem.Focus()
                    Exit Sub
                End If
            End If
        Next

        For Each dataComboArrayItem As ComboBox In DataComboArray
            If dataComboArrayItem.Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If dataComboArrayItem.TabIndex < vLowTabIdx Then
                    If dataComboArrayItem.Enabled Then
                        dataComboArrayItem.Focus()
                        vLowTabIdx = dataComboArrayItem.TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If dataComboArrayItem.Tag = tvTreeView.SelectedNode.Tag Then
                    dataComboArrayItem.Focus()
                    Exit Sub
                End If
            End If
        Next

        For Each dataRTFArrayItem As RichTextBox In DataRTFArray
            If dataRTFArrayItem.Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If dataRTFArrayItem.TabIndex < vLowTabIdx Then
                    If dataRTFArrayItem.Enabled Then
                        dataRTFArrayItem.Focus()
                        vLowTabIdx = dataRTFArrayItem.TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If dataRTFArrayItem.Tag = tvTreeView.SelectedNode.Tag Then
                    dataRTFArrayItem.Focus()
                    Exit Sub
                End If
            End If
        Next

        For Each dataFrameArrayItem As GroupBox In DataFrameArray
            If dataFrameArrayItem.Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If dataFrameArrayItem.TabIndex < vLowTabIdx Then
                    If dataFrameArrayItem.Enabled Then

                        'Hard-coded for now since there's only one of these
                        If I = 0 Then
                            Me.lstAvailableMeds.Focus()
                        End If

                        vLowTabIdx = dataFrameArrayItem.TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If dataFrameArrayItem.Tag = tvTreeView.SelectedNode.Tag Then
                    If I = 0 Then
                        Me.lstAvailableMeds.Focus()
                    End If

                    Exit Sub
                End If
            End If
        Next

        'drh FSMod 06/06/03 - Added for new User Control type
        For I = 0 To DataItemListArray.Count - 1 'bret 03/05/10 replace control array DataItemListArray.UBound
            If DataItemListArray(I).Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If DataItemListArray(I).TabIndex < vLowTabIdx Then
                    If DataItemListArray(I).Enabled Then
                        DataItemListArray(I).Focus()
                        vLowTabIdx = DataItemListArray(I).TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If DataItemListArray(I).Tag = tvTreeView.SelectedNode.Tag Then
                    DataItemListArray(I).Focus()
                    Exit Sub
                End If
            End If
        Next I

        'drh FSMod 06/19/03 - Added for checkbox type
        For Each dataCheckboxArrayItem As CheckBox In DataCheckboxArray
            If dataCheckboxArrayItem.Parent.ToString() = vSelectedFrame.Text Then
                'Find the lowest tab index in the frame (ie. If a group node is selected)
                If dataCheckboxArrayItem.TabIndex < vLowTabIdx Then
                    If dataCheckboxArrayItem.Enabled Then
                        dataCheckboxArrayItem.Focus()
                        vLowTabIdx = dataCheckboxArrayItem.TabIndex
                    End If
                End If

                'If this child node is selected in the tree, then exit the loop (ie. If a field node is selected)
                If dataCheckboxArrayItem.Tag = tvTreeView.SelectedNode.Tag Then
                    dataCheckboxArrayItem.Focus()
                    Exit Sub
                End If
            End If
        Next

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Sub SizeControls(ByRef y As Single)
        On Error Resume Next

        'set the height
        If y < 500 Then y = 500
        If y > (VB6.PixelsToTwipsY(Me.Height) - 500) Then y = VB6.PixelsToTwipsY(Me.Height) - 500
        Me.ctlSecondaryDisposition1.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - y)
        ''imgSplitter.Top = VB6.TwipsToPixelsY(y)
        Me.ctlSecondaryDisposition1.Top = VB6.TwipsToPixelsY(y + 40)
        'tvTreeView.Height = Me.Height - ((lvListView.Height + 140) + Picture1.Height)
        TabDonor.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - ((VB6.PixelsToTwipsY(ctlSecondaryDisposition1.Height) + 140) + VB6.PixelsToTwipsY(Picture1.Height)))
        CmdCancel.Top = VB6.TwipsToPixelsY(y - 800)
        cmdVerify.Top = VB6.TwipsToPixelsY(y - 400)
        'lblTitle(0).Width = tvTreeView.Width
        'lblTitle(1).Left = lvListView.Left + 20
        'lblTitle(1).Width = lvListView.Width - 40

        tvTreeView.Height = TabDonor.Height
        SubForm1.Height = TabDonor.Height


    End Sub

    Public Function SetFSStage(ByRef vStage As Short) As Boolean
        '************************************************************************************
        'Name: SetFSStage
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Update FSCase Status
        'Returns: boolean
        'Params: vStage
        '
        'Stored Procedures: UpdateFSCase and UpdateCall
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""
        Dim Org As Short

        Select Case vStage
            Case 1
                vField1 = "@FSCaseOpenUserId"
                vField2 = "@FSCaseOpenDateTime"
            Case 2
                vField1 = "@FSCaseSysEventsUserId"
                vField2 = "@FSCaseSysEventsDateTime"
            Case 3
                vField1 = "@FSCaseSecCompUserId"
                vField2 = "@FSCaseSecCompDateTime"
            Case 4
                vField1 = "@FSCaseApproachUserId"
                vField2 = "@FSCaseApproachDateTime"
            Case 5
                vField1 = "@FSCaseFinalUserId"
                vField2 = "@FSCaseFinalDateTime"
        End Select


        vQuery = "EXEC UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'"

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        '*CodeReview
        ' T.T 7/7/2004 Change StatemployeeID to a Lease Organization employee to enable Statline to switch on and off the view.
        ' The scenario is when a Family Services LO is passed a case from Statline. The employee ID must change to a LO ID.
        ' So the system will recognize the case as a LO case and not a Statline Case
        '*********************************************************************************************************************
        If vStage = 1 Then
            Org = 0
            Org = InStr(AppMain.ParentForm.LeaseOrganizationType, "FamilyServices")
            If Org > 0 Then
                vQuery = "Exec UpdateCall " & "@StatEmployeeID  = " & AppMain.ParentForm.StatEmployeeID & ", @CallId = " & Me.CallId & ", @CallSaveLastByID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                Try
                    Call modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        End If
        '*********************************************************************************************************************


        Call GetFSStage()

    End Function

    Public Sub UpdateSecondaryAutoBillStatus()
        '************************************************************************************
        'Name: UpdateSecondaryAutoBillStatus
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Determines Billing settngs for FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        'Date Changed: 12/11/2018                   Changed by: Mike Berenson
        'Release #: 9.4.18                          Bug: 63538
        'Description: Optimized code to run faster with 'for each' instead of for loops, 
        '               no try/catch blocks, and a separate MarkBillable method (to get rid
        '               of the GoTo command)
        '====================================================================================

        'Get data state (if any Secondary fields have been filled out, mark case Secondary Billable
        If SecondaryAutoBill And Not SecondaryUpdated Then

            For Each textBoxTemp As TextBox In DataTextArray
                If textBoxTemp.Tag <> "SecondaryPatientHospitalName" _
                    And textBoxTemp.Tag <> "SecondaryPatientPhone" _
                    And textBoxTemp.Tag <> "SecondaryPatientContactTitle" _
                    And textBoxTemp.Tag <> "SecondaryPatientLastName" _
                    And textBoxTemp.Tag <> "SecondaryPatientFirstName" _
                    And textBoxTemp.Tag <> "SecondaryPatientDOB" _
                    And textBoxTemp.Tag <> "SecondaryPatientAge" _
                    And textBoxTemp.Tag <> "SecondaryPatientWeight" _
                    And textBoxTemp.Tag <> "SecondaryPatientMedicalRecordNumber" _
                    And textBoxTemp.Tag <> "SecondaryPatientSSN" _
                    And textBoxTemp.Tag <> "SecondaryPatientDOD" _
                    And textBoxTemp.Tag <> "SecondaryPatientTOD" _
                    And textBoxTemp.Tag <> "SecondaryAdmissionDate" _
                    And textBoxTemp.Tag <> "SecondaryAdmissionTime" _
                    And textBoxTemp.Tag <> "SecondaryNOKName" _
                    And textBoxTemp.Tag <> "SecondaryNOKPhone" _
                    And textBoxTemp.Tag <> "SecondaryNOKAddress" _
                    And textBoxTemp.Tag <> "SecondaryCoronerInvestigatorPhone" _
                    And textBoxTemp.Text.Trim() <> "" Then
                    SecondaryUpdated = True
                    MarkBillable()
                    Exit Sub
                End If
            Next

            For Each comboBoxTemp As ComboBox In DataComboArray
                If comboBoxTemp.Tag <> "SecondaryCoronerCase" _
                    And comboBoxTemp.Tag <> "SecondaryCoronerState" _
                    And comboBoxTemp.Tag <> "SecondaryCoronerOrganization" _
                    And comboBoxTemp.Tag <> "SecondaryCoronerInvestigatorName" _
                    And comboBoxTemp.Tag <> "SecondaryPatientAgeUnit" _
                    And comboBoxTemp.Tag <> "SecondaryPatientHospitalUnit" _
                    And comboBoxTemp.Tag <> "SecondaryPatientContactName" _
                    And comboBoxTemp.Tag <> "SecondaryPatientGender" _
                    And comboBoxTemp.Tag <> "SecondaryPatientRace" _
                    And comboBoxTemp.Tag <> "SecondaryNOKRelation" _
                    And comboBoxTemp.Text.Trim() <> "" _
                    And comboBoxTemp.Text.Trim() <> "NA" _
                    And comboBoxTemp.Text.Trim() <> "DataComboArray" Then
                    SecondaryUpdated = True
                    MarkBillable()
                    Exit Sub
                End If
            Next

            For Each rtfBoxTemp As RichTextBox In DataRTFArray
                If rtfBoxTemp.Tag <> "SecondaryTriageHX" _
                    And rtfBoxTemp.Text.Trim() <> "" Then
                    SecondaryUpdated = True
                    MarkBillable()
                    Exit Sub
                End If
            Next

        End If

    End Sub

    Private Sub MarkBillable()
        '************************************************************************************
        'Name: MarkBillable
        'Date Created: 12/11/2018                       Created by: Mike Berenson
        'Release: 9.4.18                                Bug: 63538
        'Description: Handles saving of FSCase record with SecondaryUpdatedFlag = 1
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        vField1 = "@FSCaseBillSecondaryUserId"
        vField2 = "@FSCaseBillDateTime"

        vQuery = "EXEC UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", @SecondaryUpdatedFlag = 1 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & "; "

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub

    Private Sub cboApproached_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboApproached.SelectedIndexChanged

        'Check if Informed Approach Done is "Yes"
        If modControl.GetID(cboApproached) = 1 Then
            'Informed Approach Type field
            cboApproachType.Enabled = True
            cboApproachType.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

            'Informed Approach By Person field
            cboApproachedBy.Enabled = True
            cboApproachedBy.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
            cboApproachedBy.SelectedIndex = 0

            'Informed Approach Outcome field
            cboApproachOutcome.Enabled = True
            cboApproachOutcome.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
            cboApproachOutcome.SelectedIndex = 0

            'Informed Approach Reason Not Approached field
            cboApproachReason.Enabled = False
            cboApproachReason.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            cboApproachReason.SelectedIndex = 0

            'Informed Approached By Person Detail Button
            cmdInformedApproachPersonDetail.Enabled = True

        Else
            'Informed Approach Type field
            cboApproachType.Enabled = False
            cboApproachType.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            cboApproachType.SelectedIndex = 0

            'Informed Approach By Person field
            cboApproachedBy.Enabled = False
            cboApproachedBy.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            cboApproachedBy.SelectedIndex = 0

            'Informed Approach Outcome field
            cboApproachOutcome.Enabled = False
            cboApproachOutcome.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            cboApproachOutcome.SelectedIndex = 0

            'Informed Approach Reason Not Approached field
            cboApproachReason.Enabled = True
            cboApproachReason.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

            'Informed Approached By Person Detail Button
            cmdInformedApproachPersonDetail.Enabled = False

        End If

    End Sub

    Private Sub cboApproached_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboApproached.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboApproached.SelectedIndex = 0
        End If
    End Sub

    Private Sub cboApproachedBy_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboApproachedBy.SelectedIndexChanged

        'drh FSMod 06/04/03 - Select the best match based on the captured text
        Call TextMatch(cboApproachedBy)

    End Sub

    Private Sub cboApproachedBy_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboApproachedBy.Enter

        'drh FSMod 06/04/03 - Clear the text match variable
        CapturedText = ""

    End Sub


    Private Sub cboApproachedBy_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles cboApproachedBy.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'drh FSMod 06/04/03 - Select the best match for the text that was typed
        Call TextCapture(KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cboApproachedBy_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboApproachedBy.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboApproachedBy.SelectedIndex = 0
        End If
    End Sub

    Private Sub cboApproachOutcome_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboApproachOutcome.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboApproachOutcome.SelectedIndex = 0
        End If
    End Sub


    Private Sub cboApproachType_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboApproachType.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboApproachType.SelectedIndex = 0
        End If
    End Sub


    Private Sub cboConsent_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboConsent.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/23/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboConsent.SelectedIndex = 0
        End If
    End Sub


    Private Sub cboConsentBy_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboConsentBy.SelectedIndexChanged

        'drh FSMod 06/04/03 - Select the best match based on the captured text
        Call TextMatch(cboConsentBy)

    End Sub


    Private Sub cboConsentBy_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboConsentBy.Enter

        'drh FSMod 06/04/03 - Clear the text match variable
        CapturedText = ""

    End Sub

    Private Sub cboConsentBy_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles cboConsentBy.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'drh FSMod 06/04/03 - Select the best match for the text that was typed
        Call TextCapture(KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cboConsentBy_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboConsentBy.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            'Clear the text match variable
            CapturedText = ""

            cboConsentBy.SelectedIndex = 0
        End If
    End Sub

    Private Sub cboConsentFuneralPlan_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboConsentFuneralPlan.TextChanged
        'drh FSMod 07/17/03 - New Sub

        If cboConsentFuneralPlan.Text = "" Then
            'drh FSMod 07/16/03 - Default to N/A if blank
            Call modControl.SelectID(cboConsentFuneralPlan, 5)
        End If
    End Sub

    Private Sub cboConsentMedSocObtainedBy_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboConsentMedSocObtainedBy.SelectedIndexChanged

        'drh FSMod 06/04/03 - Select the best match based on the captured text
        Call TextMatch(cboConsentMedSocObtainedBy)

    End Sub


    Private Sub cboConsentMedSocObtainedBy_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboConsentMedSocObtainedBy.Enter

        'drh FSMod 06/04/03 - Clear the text match variable
        CapturedText = ""

    End Sub


    Private Sub cboConsentMedSocObtainedBy_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles cboConsentMedSocObtainedBy.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'drh FSMod 06/04/03 - Select the best match for the text that was typed
        Call TextCapture(KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cboConsentMedSocObtainedBy_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboConsentMedSocObtainedBy.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/17/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            'Clear the text match variable
            CapturedText = ""

            cboConsentMedSocObtainedBy.SelectedIndex = 0
        End If
    End Sub

    Private Sub cboConsentMedSocPaperwork_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboConsentMedSocPaperwork.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/23/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboConsentMedSocPaperwork.SelectedIndex = 0
        End If
    End Sub


    Private Sub cboHospitalApproachedBy_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboHospitalApproachedBy.SelectedIndexChanged

        'drh FSMod 06/04/03 - Select the best match based on the captured text
        Call TextMatch(cboHospitalApproachedBy)

    End Sub


    Private Sub cboHospitalApproachedBy_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboHospitalApproachedBy.Enter

        'drh FSMod 06/04/03 - Clear the text match variable
        CapturedText = ""

    End Sub

    Private Sub cboHospitalApproachedBy_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles cboHospitalApproachedBy.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'drh FSMod 06/04/03 - Select the best match for the text that was typed
        Call TextCapture(KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cboHospitalApproachedBy_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles cboHospitalApproachedBy.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        'drh FSMod 07/29/03 - New Sub

        If KeyCode = 8 Or KeyCode = 46 Then
            cboHospitalApproachedBy.SelectedIndex = 0
        End If
    End Sub


    Private Sub cboHospitalApproachType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboHospitalApproachType.SelectedIndexChanged
        'drh FSMod 06/03/03 - New Sub

        'Check if Hospital Approach is blank, "Not Approached", or "Unknown"
        If modControl.GetID((Me.cboHospitalApproachType)) = -1 Or modControl.GetID((Me.cboHospitalApproachType)) = 1 Or modControl.GetID((Me.cboHospitalApproachType)) = 7 Then
            'Hospital Approached By Person field
            cboHospitalApproachedBy.Enabled = False
            cboHospitalApproachedBy.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            Call modControl.SelectID((Me.cboHospitalApproachedBy), -1)

            'Hospital Approach Outcome field
            cboHospitalApproachOutcome.Enabled = False
            cboHospitalApproachOutcome.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            Call modControl.SelectID((Me.cboHospitalApproachOutcome), -1)

            'Hospital Approached By Person Detail Button
            cmdHospitalApproachPersonDetail.Enabled = False

        Else
            'Hospital Approach By Person field
            cboHospitalApproachedBy.Enabled = True
            cboHospitalApproachedBy.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

            'Hospital Approach Outcome field
            cboHospitalApproachOutcome.Enabled = True
            cboHospitalApproachOutcome.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

            'Hospital Approached By Person Detail Button
            cmdHospitalApproachPersonDetail.Enabled = True

        End If

    End Sub


    Private Sub chkApproached_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkApproached.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If Len(lblApproachedPersonDateTime.Text) > 0 Then
            Call ReverseSetFSStage(CShort(Me.chkApproached.Tag))
            Me.lblApproachedPersonDateTime.Text = ""
        Else 'save person new data
            Call SetFSStage(CShort(Me.chkApproached.Tag))
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
            If Len(lblFinalPersonDateTime.Text) > 0 Then
                Call ReverseSetFSStage(CShort(Me.chkFinal.Tag))
                Me.lblFinalPersonDateTime.Text = ""
            Else 'save person new data
                Call SetFSStage(CShort(Me.chkFinal.Tag))
            End If

        End If

    End Sub


    Private Sub chkSecondaryBillable_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryBillable.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryBillable_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        vField1 = "@FSCaseBillSecondaryUserId"
        vField2 = "@FSCaseBillDateTime"

        If Me.chkSecondaryBillable.CheckState = TriState.False Then
            Me.lblSecondaryBillable.Text = ""

            vQuery = "Exec UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & "; "

            'If this is the first time this has been manually turned off, record the user id
            If Me.SecondaryAutoBill Then
                Me.SecondaryAutoBill = False

                vQuery = vQuery & "Exec UpdateFSCase " & "@SecondaryManualBillPersonId = " & AppMain.ParentForm.StatEmployeeID & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
            End If
        Else
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()

    End Sub


    Private Sub chkSecondaryComplete_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryComplete.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If Len(lblSecondaryCompletePersonDateTime.Text) > 0 Then
            Call ReverseSetFSStage(CShort(Me.chkSecondaryComplete.Tag))
            Me.lblSecondaryCompletePersonDateTime.Text = ""
        Else 'save person new data
            Call SetFSStage(CShort(Me.chkSecondaryComplete.Tag))
        End If

    End Sub
    Private Sub chkSecondaryCryolifeFormCompleted_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryCryolifeFormCompleted.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryCryolifeFormCompleted_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""
        Dim vField3 As String

        vField1 = "@FSCaseBillCryoFormUserId"
        vField2 = "@FSCaseBillCryoFormDateTime"
        vField3 = "@FSCaseBillCryoFormCount" '1/16/03 drh

        If Me.chkSecondaryCryolifeFormCompleted.CheckState = TriState.False Then
            Me.lblSecondaryCryolifeFormCompleted.Text = ""

            '1/16/03 drh - Added vField3
            vQuery = "EXEC UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null" & ", " & vField3 & " = 0 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"

        Else
            '1/16/03 drh - Added vField3
            vQuery = "EXEC UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", " & vField3 & " = 1 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()

    End Sub




    Private Sub chkSecondaryFamilyApproach_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryFamilyApproach.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryFamilyApproach_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""
        Dim vField3 As String

        vField1 = "@FSCaseBillApproachUserId"
        vField2 = "@FSCaseBillApproachDateTime"
        vField3 = "@FSCaseBillApproachCount" '1/16/03 drh

        If Me.chkSecondaryFamilyApproach.CheckState = TriState.False Then
            Me.lblSecondaryFamilyApproach.Text = ""

            '1/16/03 drh - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null" & ", " & vField3 & " = 0 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        Else
            '1/16/03 drh - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", " & vField3 & " = 1 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()

    End Sub


    Private Sub chkSecondaryFamilyUnavailable_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryFamilyUnavailable.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryFamilyApproach_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        vField1 = "@FSCaseBillFamUnavailUserId"
        vField2 = "@FSCaseBillFamUnavailDateTime"

        If Me.chkSecondaryFamilyUnavailable.CheckState = TriState.False Then
            Me.lblSecondaryFamilyUnavailable.Text = ""

            vQuery = "Exec UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        Else
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()

    End Sub


    Private Sub chkSecondaryMedSoc_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryMedSoc.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryMedSoc_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""
        Dim vField3 As String

        vField1 = "@FSCaseBillMedSocUserId"
        vField2 = "@FSCaseBillMedSocDateTime"
        vField3 = "@FSCaseBillMedSocCount" '1/16/03 drh

        If Me.chkSecondaryMedSoc.CheckState = TriState.False Then
            Me.lblSecondaryMedSoc.Text = ""

            '1/16/03 drh - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null " & ", " & vField3 & " = 0 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        Else
            '1/16/03 drh - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", " & vField3 & " = 1 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()

    End Sub


    Private Sub chkSecondaryOTE_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryOTE.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: chkSecondaryMedSoc_MouseUp
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""
        Dim vField3 As String

        vField1 = "@FSCaseBillOTEUserId"
        vField2 = "@FSCaseBillOTEDateTime"
        vField3 = "@FSCaseBillOTECount" 'T.T 11/01/2006

        If Me.chkSecondaryOTE.CheckState = False Then
            Me.lblSecondaryOTE.Text = ""

            ''T.T 11/01/2006 - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null" & ", " & vField3 & " = 0 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        Else
            ''T.T 11/01/2006 - Added vField3
            vQuery = "Exec UpdateFSCase " & vField1 & " = " & AppMain.ParentForm.StatEmployeeID & ", " & vField2 & " = '" & Now & "'" & ", " & vField3 & " = 1 " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetSecondaryBilling()
    End Sub

    Private Sub chkSecondaryTBINotNeeded_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSecondaryTBINotNeeded.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        'ccarroll 06/06/2007 StatTrac 8.4 release requirement 3.6 - TBI Number

        If Me.chkSecondaryTBINotNeeded.CheckState = 1 Then
            Me.txtSecondaryTBIComment.Enabled = True
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.Color.White
            Me.txtSecondaryTBIComment.Focus()

            'Assign TBI note content
            'ccarroll 01/22/2010 Changed note from TBI to CTDN : Build 8.4.11
            Me.TBINoteText = "The assignment of CTDN # " & Me.DataTextArray(36).Text & " was not needed. This action was executed by " & AppMain.ParentForm.StatEmployeeName

            'set TBIUpdateFlag
            Me.TBIUpdateFlag = True

        Else
            Me.txtSecondaryTBIComment.Text = ""
            Me.txtSecondaryTBIComment.Enabled = False
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)

            'Assign TBI note content
            Me.TBINoteText = "The CTDN # " & Me.DataTextArray(36).Text & " has been reassigned by " & AppMain.ParentForm.StatEmployeeName

            'set TBIUpdateFlag
            Me.TBIUpdateFlag = True
        End If

    End Sub

    Private Sub chkSystemEvents_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles chkSystemEvents.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        If Len(lblSystemEventsPersonDateTime.Text) > 0 Then
            Call ReverseSetFSStage(CShort(Me.chkSystemEvents.Tag))
            Me.lblSystemEventsPersonDateTime.Text = ""
        Else 'save person new data
            Call SetFSStage(CShort(Me.chkSystemEvents.Tag))
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
        Call modStatQuery.QueryOpenLogEvent(Me)
        'Me.chkViewLogEventDeleted

    End Sub

    Private Sub Cmdactivate_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Cmdactivate.Click
        Me.cmdDonorTrac.Visible = True
        Me.cmdDonorTrac.Enabled = True
    End Sub

    Private Sub cmdAddMedication_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddMedication.Click
        Dim I As Short
        For I = Me.lstAvailableMeds.Items.Count - 1 To 0 Step -1
            If Me.lstAvailableMeds.GetSelected(I) Then
                Me.lstSelectedMeds.Items.Add(Me.lstAvailableMeds.Items(I))

                Me.lstAvailableMeds.Items.RemoveAt((I))
            End If
        Next I

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
        '************************************************************************************
        'Name: CmdCancel_Click
        'Date Created: Unknown                          Created by: Unkown
        'Release: Unknown                               Task: Unknown
        'Description: Closes out a canceled FS Referral
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vCallOpenByID As Short
        Dim vReturns As New Object
        Dim I As Short

        'Force user to confirm intent to cancel
        Dim vReturn As Short = MsgBox("Are you sure you want to Cancel?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Cancel")
        If vReturn = MsgBoxResult.No Then
            Exit Sub
        End If

        'Save cumulative call time and cancel user open by id
        If TimerTotalTime.Enabled = True Then
            vQuery = "EXEC UpdateFSCase " & "@FSCaseTotalTime = '" & Me.CallTotalTime & "'" & ", @CallID = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'"

            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If


        'check to see if the user has access to set the callopenby
        If modStatRefQuery.RefQueryCall(vReturns, Me.CallId) = SUCCESS Then
            vCallOpenByID = CShort(vReturns(0, 5))

            If vCallOpenByID > 0 And vCallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                'Char Chaput 12/27/05
                'Update call open by only if have save ability and callopenbyid = AppMain.ParentForm.StatEmployeeID
                If Me.btnSaveAndClose.Enabled Then
                    Me.CallOpenByID = -1
                    'bret 06/08/07 use new save routine
                    Call modStatSave.SaveCallCancel(Me)
                End If
            Else
                'if callopend by = 0 then some has opened the referral int he update report
                'if the OK button is enabled reset the callopenby
                If Me.btnSaveAndClose.Enabled Then
                    Me.CallOpenByID = -1
                    'bret 06/08/07 use new save routine
                    Call modStatSave.SaveCallCancel(Me)
                End If
            End If
        End If
        'bret 08/15/07 8.4
        'we need to log the user is reading referral the orignialgoal was to only log this to referral
        'but because of pending referrals we cannot do this
        Call modStatSave.SaveReferralCancel(Me)


        'Close related windows
        For I = 0 To Application.OpenForms.Count - 1
            If Application.OpenForms.Item(I).Name = "FrmOpenLogEvent" Or Application.OpenForms.Item(I).Name = "FrmLogEvent" Or Application.OpenForms.Item(I).Name = "FrmOnCallEvent" Or Application.OpenForms.Item(I).Name = "FrmDonorIntent" Or Application.OpenForms.Item(I).Name = "FrmDonorIntentFax" Or Application.OpenForms.Item(I).Name = "FrmCustom1" Then
                Application.OpenForms(I).Close()
            End If
        Next I

        Me.Close()

    End Sub

    Private Sub CmdColorKey_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdColorKey.Click
        frmColorKey = New FrmColorKey()
        frmColorKey.Show()
    End Sub

    Private Sub cmdConsentMedSocPersonDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdConsentMedSocPersonDetail.Click
        'drh FSMod 06/03/03 - New sub

        Call ProcessPersonDetail(cboConsentMedSocObtainedBy)
    End Sub

    Private Sub cmdConsentPaperworkPersonDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdConsentPaperworkPersonDetail.Click
        'drh FSMod 06/03/03 - New sub

        Call ProcessPersonDetail(cboConsentBy)
    End Sub

    Private Sub cmdContactDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdContactDetail.Click
        'drh FSMod 06/13/03 - New sub
        'Allows new additions to the available contact list, but doesn't select the new person

        On Error GoTo ErrorNextI

        Dim I As Integer

        'Get the control
        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryPatientContactName" Then
                'Call process to open person form
                Call ProcessPersonDetail(DataComboArray(I))
                Exit Sub
            End If
        Next I

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Private Sub cmdCoroner_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCoroner.Click

        On Error Resume Next

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryCoronerOrganization" Then
                If modControl.GetID(DataComboArray(I)) = -1 Then
                    Call MsgBox("Please select a coroner before establishing a contact.", , "Select Coroner")
                    DataComboArray(I).Focus()
                    Exit Sub
                End If

                Exit For
            End If
        Next I

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryCoronerOrganization" Then
                frmLogEvent.DefaultOrganization = DataComboArray(I).Text
            ElseIf DataComboArray(I).Tag = "SecondaryCoronerInvestigatorName" Then
                frmLogEvent.DefaultContactName = DataComboArray(I).Text
            End If
        Next I

        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryCoronerInvestigatorPhone" Then
                frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
                Exit For
            End If
        Next I

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


        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Private Sub cmdCreateCOP_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCreateCOP.Click
        On Error Resume Next

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryPatientHospitalName" Then
                If DataTextArray(I).Text = "" Then
                    Call MsgBox("Please select a hospital before establishing a contact.", , "Select Hospital")
                    DataTextArray(I).Focus()
                    Exit Sub
                End If

                Exit For
            End If
        Next I

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryPatientHospitalName" Then
                frmLogEvent.DefaultOrganization = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryBodyHoldPhone" Then
                frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryBodyFutureContact" Then
                frmLogEvent.DefaultContactName = DataTextArray(I).Text
            End If
        Next I

        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryPatientContactName" Then
                frmLogEvent.DefaultContactName = IIf(frmLogEvent.DefaultContactName = "", DataComboArray(I).Text, frmLogEvent.DefaultContactName)
            End If
        Next I

        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryPatientPhone" Then
                frmLogEvent.DefaultContactPhone = IIf(frmLogEvent.DefaultContactPhone = "", DataTextArray(I).Text, frmLogEvent.DefaultContactPhone)
            End If
        Next I

        frmLogEvent.DefaultContactType = CALLBACK_PENDING

        'Set event types
        vEventTypeList(0) = CALLBACK_PENDING
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()


        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If
    End Sub

    Private Sub cmdCreateMedication_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCreateMedication.Click
        'drh FSMod 06/17/03 - New Sub

        'Check if there's a value
        Dim vMedName As String = ""
        If Trim(txtMedicationName.Text) <> "" Then

            'Capitalize the Med Name
            vMedName = UCase(VB.Left(txtMedicationName.Text, 1)) & VB.Right(txtMedicationName.Text, Len(txtMedicationName.Text) - 1)

            'Save the new med
            If SaveMedication(vMedName) Then
                'Repopulate the available meds (minus any currently-selected meds)
                Call modStatRefQuery.SecQueryCurrentlyAvailableMedication(Me)

                txtMedicationName.Text = ""
            End If
        End If

    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        '************************************************************************************
        'Name: CmdDelete_Click
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Creates the SQL to save a LogEvent to the DB and executes it.
        'Returns: Return value of executed query in pvResults.
        'Params: pvForm = calling form,
        '
        '        pvResults = returning results
        'Stored Procedures: UpdateFSCase and InsertFSCase
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:
        '     Changed code to use InsertCall and UpdateCall
        '     Add LastStatEmployeeID
        '     fix event indexes
        '====================================================================================
        Dim vLogEventID As Integer
        Dim I As Short
        Dim vRow As Short
        Dim vReturn As Short

        On Error Resume Next

        'Do not allow the deletion of the original incoming call event
        ' subItem 1 is Event Type
        'bret 06/11/2007 if the list is sorted this statement does not work.
        'subItem 5 is LogEvent Order Number
        If CDbl(LstViewLogEvent.FocusedItem.SubItems(6).Text) = 1 And LstViewLogEvent.FocusedItem.SubItems(1).Text = "Incoming Call" Then
            Call MsgBox("You may not delete the original incoming call event.")
            Exit Sub
        End If


        'ccarroll 06/13/2007 StatTrac 8.4 release requirement 3.6 - TBI Number
        'bret fixed
        'Do not allow the deletion of a TBI event
        'ccarroll 01/22/2010 Changed note from TBI to CTDN : Build 8.4.11
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
        Call modStatSave.DeleteLogEvent(Me)

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

    End Sub

    Private Sub cmdDonorTrac_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDonorTrac.Click
        '************************************************************************************
        'Name: cmdDonorTrac_Click()
        'Date Created: 04/26/2007                        Created by: Thien Ta
        'Release: release 8.3.5                              Task:  unknown
        'Description:   Open DonorTrac with a URL
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================

        Dim DonorTracUrl As String = ""
        Dim CallOpenByName As String = ""
        Dim CallIDUrl As String = ""
        Dim Res As New Object

        Dim error_Renamed As Object

        'bret 06/17/2010 moved command to where it is used.
        'T.T 02/05/2007 donortrac url open object
        ie = CreateObject("InternetExplorer.Application")

        'ccarroll 05/23/2007 StatTrac 8.4 release
        'Record billing information
        If Me.BillMedSocManualEnable = False Then
            Call modStatSave.UpdateSecondaryAutoBillMedSoc(Me)
        End If

        On Error GoTo ErrorNextI

        If CaseOpen Then
            MsgBox("This DonorTrac case has previously been opened. Please make sure the window is closed and reopen the case.", MsgBoxStyle.Information)
            CaseOpen = False
            Exit Sub
        End If

        CallOpenByName = modStatQuery.QueryCallOpenByName(Me)




        Call modStatQuery.QueryCallWebPersonPass(Me)
        Call modStatQuery.QueryCallDonorTracURL(Me, (Me.SourceCode.Name))
        'MsgBox Me.CallOpenByName
        'CallOpenByName = "Family_Services"
        CallIDUrl = CStr(Me.CallId)
        'CallIDUrl = 5836966

        'ccarroll 05/03/2007 - added test url for testers
        'Test URL:

        DonorTracUrl = Me.URL & "/Login.aspx?statlineuser=" & Me.CallOpenByName & "&statlinepassword=" & Me.CallOpenbyWebPersonPassword & "&statlinecaseid=" & CallIDUrl

        'Production URL:
        'DonorTracUrl = "http://www.donortrac.org/" & Me.SourceCode.Name & "/Login.aspx?statlineuser=" & CallOpenByName & "&statlinepassword=donortrac&statlinecaseid=" & CallIDUrl
        'ShellExecute hWnd, "open", "http://test.donortrac.org/DEV1/Login.aspx?statlineuser=statline&statlinepassword=statline&statlinecaseid=5822391", vbNullString, vbNullString, Empty


        If GetCookie() Then
            Res = MsgBox("This DonorTrac Case is already Open!", MsgBoxStyle.Information, "DonorTrac")
        Else
            'T.T method to open url
            modReport.ShellExecute(Handle.ToInt32, "open", DonorTracUrl, vbNullString, vbNullString, CInt(Nothing))


        End If



        Exit Sub
ErrorNextI:
        'Set ie = Nothing
        'Set ie = CreateObject("InternetExplorer.Application")
        error_Renamed = modStatSave.InsertNote(CStr(Me.CallId), "This DonorTrac Case could not be opened" & ControlChars.NewLine & "DonorTrac Case not able to be opened", VB.Right(Me.CallNumber, 3), (Me.OrganizationId))
        MsgBox("This case has previously been opened. Please close the window to reopen the case", MsgBoxStyle.Information)

    End Sub
    Function GetCookie() As Boolean
        Dim sCookieVal As New VB6.FixedLengthString(256)
        Dim bRet As Boolean

        bRet = InternetGetCookie("http://www.Zilloe.com", "", sCookieVal.Value, 255)

        If bRet = False Then
            'MsgBox "No Cookie Available"
            GetCookie = False
        Else
            'MsgBox sCookieVal
            GetCookie = True

        End If

    End Function

    Private Sub cmdEventRecieved_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdEventRecieved.Click
        '************************************************************************************
        'Name: cmdEventRecieved_Click()
        'Date Created: 04/26/2007                        Created by: Thien Ta
        'Release: release 8.3.5                              Task:  unknown
        'Description:   Recieved event from webservice for testing
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Call objMOWeb_OnRegistryWarning()
    End Sub

    Private Sub cmdeventrecievedFound_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdeventrecievedFound.Click
        '************************************************************************************
        'Name: cmdeventrecievedFound_Click()
        'Date Created: 04/26/2007                        Created by: Thien Ta
        'Release: release 8.3.5                              Task:  unknown
        'Description:   Recieved event from webservice for testing
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        ' Call objMOWeb_OnRegistryFound()
    End Sub

    Private Sub cmdFuneralHome_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdFuneralHome.Click

        On Error Resume Next

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryFuneralHomeName" Then
                If DataTextArray(I).Text = "" Then
                    Call MsgBox("Please select a funeral home before establishing a contact.", , "Select Funeral Home")
                    DataTextArray(I).Focus()
                    Exit Sub
                End If

                Exit For
            End If
        Next I

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryFuneralHomeName" Then
                frmLogEvent.DefaultOrganization = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryFuneralHomePhone" Then
                frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryFuneralHomeContact" Then
                frmLogEvent.DefaultContactName = DataTextArray(I).Text
            End If
        Next I

        frmLogEvent.DefaultContactType = FUNERAL_HOME

        'Set event types
        vEventTypeList(0) = FUNERAL_HOME
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()


        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Private Sub cmdGenerateTBI_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdGenerateTBI.Click
        'ccarroll 06/04/2007 StatTrac 8.4 release, requirement 3.6

        Dim TBINoteText As String = ""

        If Me.DataTextArray(36).Text = "" And Me.TBIAccess = True Then
            'get TBIPrefix and TBIdate
            Call modStatQuery.QuerySecondaryTBIPrefix(Me)

            If Me.TBIPrefix <> "" Then 'If TBI prefix is missing disallow TBI number generation.

                'Check if valid Cardiac Death date
                If IsDate(DataTextArray(54).Text) = True Then
                    'Use Cardiac Death date for TBI number
                    Me.TBIDate = VB6.Format(CDate(DataTextArray(54).Text), "yyyy") & VB6.Format(CDate(DataTextArray(54).Text), "mm")

                    Me.DataTextArray(36).Text = modStatSave.SaveSecondaryTBINumber(Me)
                    Me.cmdGenerateTBI.Enabled = False

                    'Enable the (TBI Not Needed) checkbox and comment area
                    Me.chkSecondaryTBINotNeeded.Enabled = True
                    Me.txtSecondaryTBIComment.Enabled = False

                    'Generate TBI note for Button press
                    TBINoteText = "A CTDN number has been generated by " & AppMain.ParentForm.StatEmployeeName & ". The CTDN # is " & Me.DataTextArray(36).Text

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

    Private Sub cmdHospital_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdHospital.Click
        On Error Resume Next

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryPatientHospitalName" Then
                If DataTextArray(I).Text = "" Then
                    Call MsgBox("Please select a hospital before establishing a contact.", , "Select Hospital")
                    DataTextArray(I).Focus()
                    Exit Sub
                End If

                Exit For
            End If
        Next I

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        For I = 0 To DataTextArray.UBound
            If DataTextArray(I).Tag = "SecondaryPatientHospitalName" Then
                frmLogEvent.DefaultOrganization = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryPatientPhone" Then
                frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
            ElseIf DataTextArray(I).Tag = "SecondaryFuneralHomeContact" Then
                frmLogEvent.DefaultContactName = DataTextArray(I).Text
            End If
        Next I

        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryPatientContactName" Then
                frmLogEvent.DefaultContactName = DataComboArray(I).Text
            End If
        Next I

        frmLogEvent.DefaultContactType = OUTGOING

        'Set event types
        vEventTypeList(0) = OUTGOING
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()


        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If
    End Sub


    Private Sub cmdHospitalApproachPersonDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdHospitalApproachPersonDetail.Click
        'drh FSMod 06/03/03 - New sub

        Call ProcessPersonDetail(cboHospitalApproachedBy)
    End Sub


    Private Sub cmdInformedApproachPersonDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdInformedApproachPersonDetail.Click
        'drh FSMod 06/03/03 - New sub

        Call ProcessPersonDetail(cboApproachedBy)
    End Sub


    Private Sub CmdNewEvent_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNewEvent.Click

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        If Me.ShiftKey Then

            Me.CurrentLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

            'Get the selected event
            Call modStatQuery.QueryLogEvent(Me, frmLogEvent)
            Me.ShiftKey = False
        Else

            'Default fields
            On Error GoTo ErrorNextI
            For Each dataComboBox As ComboBox In DataComboArray
                If dataComboBox.Tag = "SecondaryPatientContactName" Then
                    frmLogEvent.DefaultContactName = dataComboBox.Text
                End If

            Next

            For Each dataTextBox As TextBox In DataTextArray
                If dataTextBox.Tag = "SecondaryPatientHospitalName" Then
                    frmLogEvent.DefaultOrganization = dataTextBox.Text
                ElseIf dataTextBox.Tag = "SecondaryPatientPhone" Then
                    frmLogEvent.DefaultContactPhone = dataTextBox.Text
                End If
            Next

            frmLogEvent.DefaultOrganizationID = Me.OrganizationId
            On Error Resume Next

            'BJK 03/27/02: adding code to set OrganizationID in FrmLogEvent Defaul OrganizationID
            'is not used but this is not guaranteed.  OrganizationID is save with the logEvent when saved.
            frmLogEvent.OrganizationId = Me.OrganizationId
            frmLogEvent.DefaultContactType = -1
        End If

        'Set the call number of the Details form
        frmLogEvent.CallNumber = Me.CallNumber

        'Set event types
        'Items past ALL_TYPES are to exclude.
        Dim vEventTypeList = New Object() {ALL_TYPES, OUTGOING_FAX}
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
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

        '7/3/01 drh Get the FS stage
        Call GetFSStage()

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub


    Private Sub CmdNOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdNOK.Click

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(1) As Object
        Dim vSubItemsList As New Object
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        On Error GoTo ErrorNextI

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        For I = 0 To DataTextArray.UBound
            If Me.NOKID > 0 Or Me.NOK = "" Or IsDBNull(Me.NOKID) Then 'No new NOK and no old NOK
                frmLogEvent.DefaultContactName = DataTextArray(31).Text & " " & DataTextArray(32).Text
                If DataTextArray(I).Tag = "SecondaryNOKPhone" Then
                    frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
                End If
            Else
                If DataTextArray(I).Tag = "SecondaryNOKName" Then
                    frmLogEvent.DefaultContactName = DataTextArray(I).Text
                ElseIf DataTextArray(I).Tag = "SecondaryNOKPhone" Then
                    frmLogEvent.DefaultContactPhone = DataTextArray(I).Text
                End If
            End If
        Next I

        frmLogEvent.DefaultOrganization = "Next of kin."
        frmLogEvent.DefaultContactType = OUTGOING

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

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles btnSaveAndClose.Click
        Dim vSave As New Object
        'carroll 10/18/2006 - Added check to see if call is open
        'StatTrac 8.0 Iteration 2 - two users in case
        vSave = modControl.CheckCallOpen(Me)
        Dim vRegistration As Boolean            'T.T 8/16/2004 call to registration function
        'vSave state options
        'vSave = 2 Yes - Save and Exit
        'vSave = 1 No - Don't Save and Exit
        'vSave = 0 Cancel - Don't Save, Don't Exit

        ' Check to see which button was clicked - save or 'save & close'
        CloseAfterSave = eventSender.Name.ToLower().Contains("close")

        Select Case vSave
            Case 2 'vSave = 2 Yes - Save and Exit
                Call modUtility.Work()

                '02/13/03 drh - Validate Date Fields
                If DateValidate() Then
                    If ModNOK = True Or AddNOK = True Then
                        'Me.NOKFirstName = InStr(1,DataTextArray(143).Text, chr()
                        Me.NOKRefPhone = DataTextArray(144).Text
                        Me.NOKApproachRelation = DataComboArray(43).Text
                    End If

                    'Save Triage Data
                    Call SaveTriageReferralData()

                    'Delete the deleted medications before saving anynew
                    Call ProcessDeletedSecondaryMedication()

                    'Save Secondary Data
                    Call SaveSecondaryReferralData()


                    'Save Secondary Approach tab info
                    Call SaveSecondaryApproach(Me)

                    'Save the Call
                    Call SaveSecondaryCall()

                    'Save RegistryStatus
                    Call modStatSave.SaveRegStatusFS(Me)

                    'Save Registration
                    'bret 01/06/10 variable not used            
                    vRegistration = Me.RegistryLogEvent()

                    'Save the Disposition
                    '12/02/02 drh - Only save if Disposition is loaded

                    '6/22/2003 T.T save the disposition if final is checked.
                    If Me.ctlSecondaryDisposition1.Visible = True Then
                        Me.ctlSecondaryDisposition1.Save()
                    ElseIf Me.ctlSecondaryDisposition1.Visible = False Then
                        If Len(lblFinalPersonDateTime.Text) > 0 Then
                            Me.ctlSecondaryDisposition1.CallId = Me.CallId
                            'Me.ctlSecondaryDisposition1.Visible = True
                            'Me.cmdVerify.Caption = "Verify"
                            Me.ctlSecondaryDisposition1.Save()
                        End If
                    End If

                    'Update Referral.CurrentReferralTypeId
                    Call modStatSave.UpdateCurrentReferralType(Me.CallId, Me.CallerOrg.ServiceLevel.ID, Statline.Stattrac.Constant.StattracIdentity.Identity.UserId)

                    Call modUtility.Done()
                    If CloseAfterSave Then
                        Me.Close()
                    End If
                Else
                    Call modUtility.Done()
                End If

            Case 1 'vSave = 1 No - Don't Save and Exit
                If CloseAfterSave Then
                    Me.Close()
                End If
        End Select

    End Sub



    Private Sub CmdOrganizationDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdOrganizationDetail.Click
        On Error Resume Next

        'frmOrganization.SourceCode = Me.SourceCode
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If


        uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, Me.OrganizationId)

        'Get the organization name
        Dim vResultArray As New Object
        Call modStatRefQuery.RefQueryOrganization(vResultArray, Me.OrganizationId)

        'Get Hospital Name field index
        Dim HospitalNameCtlList(1, 0) As Object
        HospitalNameCtlList(1, 0) = "SecondaryPatientHospitalName"
        Call GetDataFieldIndex(HospitalNameCtlList, CTL_TEXT)

        'Populate Location/Hospital Name fields
        Me.DataTextArray(HospitalNameCtlList(0, 0)).Text = vResultArray(0, 1)
        Me.txtHospitalName.Text = vResultArray(0, 1)

    End Sub

    Private Sub cmdPhysicianDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdPhysicianDetail.Click
        'drh FSMod 06/17/03 - New sub

        On Error GoTo ErrorNextI

        Dim I As Integer

        'Get the control
        For I = 0 To DataComboArray.UBound
            If DataComboArray(I).Tag = "SecondaryMDAttendingId" Then
                'Call process to open person form
                Call ProcessPersonDetail(DataComboArray(I))

                'Add blank item back in
                Call SetTextIDItem(DataComboArray(I), -1, "")
                Exit Sub
            End If
        Next I

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub


    Private Sub CmdReferral_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReferral.Click

        Dim vEventTypeList(12) As Object
        frmOnCallEvent = New FrmOnCallEvent()
        frmOnCallEvent.vParentForm = Me

        On Error Resume Next

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
        vEventTypeList(9) = SECONDARY_PENDING
        vEventTypeList(10) = EMAIL_PENDING
        vEventTypeList(11) = EMAIL_SENT
        vEventTypeList(12) = PAGE_SENT

        frmOnCallEvent.SourceCode = Me.SourceCode
        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        frmOnCallEvent.OnCallType = REFERRAL
        frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)
        frmOnCallEvent.AutoResponseMsg = modStatValidate.SetRefAutoResponse(Me)
        frmOnCallEvent.AutoResponseSbj = modStatValidate.SetRefAutoResponseSbj(Me)

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
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

    End Sub

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
        '====================================================================================
        'Date Changed: 06/25/2007                      Changed by: Thien Ta
        'Release #: 8.4                              Task:
        'Description:   columns have shifted in the event log changing subitems to new feature
        '====================================================================================
        Dim strNotChecked As String = ""
        Dim vLogEventID As Integer
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        Dim vMessageExtension As New Object
        Dim vEventID As New Object
        Dim ChangeMessage As String = ""
        Dim x As New Object
        Dim OldMessage As String = ""


        If Me.cboRegistryStatusFS.Text = "Not Checked" Then
            Exit Function
        End If

        TabDonor.SelectedIndex = 1

        If Me.CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent Then

            If Not DonorSearchState.WasSearched Then
                If vNoteChange <> "" Then 'was <>


                    For x = 1 To LstViewLogEvent.Items.Count
                        'T.T 06/25/2007 columns have shifted over changed subitems
                        If LstViewLogEvent.Items.Item(x).SubItems(1).Text = "Note" And LstViewLogEvent.Items.Item(x).SubItems(2).Text = "Donor Registry" Then
                            vLogEventID = LstViewLogEvent.Items.Item(x).Tag

                            'T.T 10/06/2004 This section of code will modify the Registry note when the registry has been searched again.
                            '**********************************************************
                            vEventID = vLogEventID
                            OldMessage = modStatQuery.ChangeQueryLogEvent(vEventID)
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
                                Call modStatSave.DeleteLogEventID(vLogEventID, (Me.CallId))
                                Call modStatSave.SaveLogEvent(Me, GENERAL, ChangeMessage)
                            End If

                            If Me.TxtDonorFirstName.Text = "" Then
                                strNotChecked = "has not been Checked because Missing First Name"
                            ElseIf Me.TxtDonorLastName.Text = "" Then
                                strNotChecked = "has not been Checked because Missing Last Name"
                            ElseIf Me.TxtDOB.Text = "" Then
                                strNotChecked = "has not been Checked because Missing DOB"
                            End If


                            'T.T 08/09/2007 commented out for normal canceled note
                            '                                If Me.vNoteChange = "Canceled" Then
                            '                                    strRegistryMessage = Me.InstanceFound & " Instances of " & Me.DonorFirstName & " " & Me.DonorLastName & " found. " & " Registered person is Unknown "
                            '                                Else
                            strRegistryMessage = strRegistryMessage & ControlChars.NewLine & Chr(10) & vMessageExtension
                            '                                End If

                            Call modStatSave.SaveLogEvent(Me, GENERAL, "The Registry has Changed" & strNotChecked)

                        End If


                    Next x

                End If 'vNote



            End If 'DonorSearchState.DonorRegistryTypeSelection = DonorRegistryTypeSelection.Unknown
        End If 'ServiceLevel
        If DonorSearchState.WasSearched Then
            If strRegistryMessage <> "" Then
                '*********log the event********

                For x = 0 To LstViewLogEvent.Items.Count - 1
                    'For x = 1 To LstViewLogEvent.Items.Count
                    'T.T 06/25/2007 columns have shifted over changed subitems
                    If LstViewLogEvent.Items.Item(x).SubItems(1).Text = "Note" And LstViewLogEvent.Items.Item(x).SubItems(2).Text = "Donor Registry" Then
                        vLogEventID = LstViewLogEvent.Items.Item(x).Tag

                        'T.T 10/06/2004 This section of code will modify the Registry note when the registry has been searched again. *CodeReview
                        '**********************************************************
                        vEventID = vLogEventID
                        OldMessage = modStatQuery.ChangeQueryLogEvent(vEventID)
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
                            Call modStatSave.DeleteLogEventID(vLogEventID, (Me.CallId))
                            Call modStatSave.SaveLogEvent(Me, GENERAL, ChangeMessage)
                        End If

                    End If

                    If vLogEventID > 0 Then
                        'Call modStatSave.DeleteLogEventID(vLogEventID, Me.CallId)
                        'Call modStatSave.SaveLogEvent(me,General)
                    End If
                Next x
                If Me.DonorSearchState.HasDonor Then
                    Dim donorService As DonorService = New DonorServiceFactory(CallerOrg.ServiceLevel.ID).Create()
                    vMessageExtension = donorService.GetFormattedDonorDetailsAsync(Me).GetAwaiter().GetResult()
                Else
                    vMessageExtension = ""
                End If
                'T.T 08/09/2007 commented out for normal registry note
                '                If Me.vNoteChange = "Canceled" Then
                '                    strRegistryMessage = Me.InstanceFound & " Instances of " & Me.DonorFirstName & " " & Me.DonorLastName & " found. " & " Registered person is Unknown "
                '                Else
                strRegistryMessage = strRegistryMessage & ControlChars.NewLine & Chr(10) & vMessageExtension
                '                End If
                On Error Resume Next

                'Save the event
                Call modStatSave.SaveLogEvent(Me, GENERAL, strRegistryMessage)
            End If
        End If

    End Function

    Private Sub cmdRemoveMedication_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveMedication.Click
        Dim test As New Object
        Dim I As Short
        For I = Me.lstSelectedMeds.Items.Count - 1 To 0 Step -1
            If Me.lstSelectedMeds.GetSelected(I) Then
                Me.lstAvailableMeds.Items.Add(Me.lstSelectedMeds.Items(I))
                DeletedSecondaryMedicationList(UBound(DeletedSecondaryMedicationList)) = Me.lstSelectedMeds.Items(I).Value
                ReDim Preserve DeletedSecondaryMedicationList(UBound(DeletedSecondaryMedicationList) + 1)

                Me.lstSelectedMeds.Items.RemoveAt((I))
            End If
        Next I

    End Sub

    Private Sub CmdVerify_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdVerify.Click
        modUtility.Work()
        '12/02/02 drh - Check whether Disposition is loaded
        If Me.ctlSecondaryDisposition1.Visible = True Then
            Call Me.ctlSecondaryDisposition1.Verify()
        Else
            Me.ctlSecondaryDisposition1.CallId = Me.CallId
            Me.ctlSecondaryDisposition1.Visible = True
            Me.cmdVerify.Text = "Verify"
        End If
        modUtility.Done()
    End Sub

    Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
        Dim vEventTypeList(9) As Object

        On Error Resume Next
        frmOnCallEvent = New FrmOnCallEvent()
        frmOnCallEvent.vParentForm = Me

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

        frmOnCallEvent.SourceCode = Me.SourceCode
        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        frmOnCallEvent.OnCallType = REFERRAL
        '    frmOnCallEvent.TxtAlert.Text = Me.ScheduleAlert
        '    frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)

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
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)
    End Sub

    Private Sub Command2_Click()

        Me.ctlSecondaryDisposition1.CollapseGroups()

    End Sub

    Private Sub DataComboArray_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles DataComboArray.SelectedIndexChanged
        Dim Index As Integer = DataComboArray.GetIndex(eventSender)

        Dim I As Integer
        Dim j As Integer
        On Error Resume Next
        Dim vReturn As New Object

        On Error GoTo ErrorNextI

        If DataComboArray(Index).Tag = "SecondaryCoronerState" Then

            'Set defaults
            For Each textBoxTemp As TextBox In DataTextArray
                If textBoxTemp.Tag = "SecondaryCoronerInvestigatorPhone" Then
                    textBoxTemp.Text = ""
                End If
            Next

            For Each comboBoxTemp As ComboBox In DataComboArray
                If comboBoxTemp.Tag = "SecondaryCoronerInvestigatorName" Then
                    comboBoxTemp.Items.Clear()
                End If
            Next

            'Fill the list with coroners from the state of the hospital org
            For Each comboBoxTemp As ComboBox In DataComboArray
                If comboBoxTemp.Tag = "SecondaryCoronerOrganization" Then

                    comboBoxTemp.Items.Clear()

                    If comboBoxTemp.Items.Count = 0 Then
                        If modStatQuery.QueryStateCoroners(modControl.GetID(DataComboArray(Index)), vReturn) = SUCCESS Then

                            Call modControl.SetTextID(comboBoxTemp, vReturn)
                            comboBoxTemp.Items.Insert(0, "")
                        End If
                    End If

                    Exit For
                End If
            Next

        ElseIf DataComboArray(Index).Tag = "SecondaryCoronerOrganization" Then
            If Me.FormLoad = False Then
                If modStatQuery.QueryCoroner(modControl.GetID(DataComboArray(Index)), vReturn) = SUCCESS Then

                    For Each comboBoxTemp As ComboBox In DataComboArray
                        If comboBoxTemp.Tag = "SecondaryCoronerInvestigatorName" Then
                            Call modControl.SetTextID(comboBoxTemp, vReturn, True)

                            'comboBoxTemp.AddItem "Not Available"
                            'comboBoxTemp.ItemData(comboBoxTemp.NewIndex) = -1

                            Call modControl.SelectID(comboBoxTemp, -1)
                        End If
                    Next

                Else

                    For Each comboBoxTemp As ComboBox In DataComboArray
                        If comboBoxTemp.Tag = "SecondaryCoronerInvestigatorName" Then
                            comboBoxTemp.Items.Add(New ValueDescriptionPair(-1, "Not Available"))
                            Call modControl.SelectFirst(comboBoxTemp)
                        End If
                    Next
                End If
            End If

            'ccarroll 03/04/2013 5744 moved CoronorOrgId assignment
            'ccarroll 01/28/2013 bug wi: 5484, HS 34684 StatTrac Import for DonorTrac
            CoronerOrgID = modControl.GetID(DataComboArray(Index))

        ElseIf DataComboArray(Index).Tag = "SecondaryCoronerInvestigatorName" Then
            If Me.FormLoad = False Then
                For Each textBoxTemp As TextBox In DataTextArray
                    If textBoxTemp.Tag = "SecondaryCoronerInvestigatorPhone" Then
                        textBoxTemp.Text = ""
                    End If
                Next
            End If

        ElseIf DataComboArray(Index).Tag = "SecondaryPatientContactName" Then
            'Get the PersonType of the selected person
            Me.PersonID = modControl.GetID(DataComboArray(Index))

            For Each textBoxTemp As TextBox In DataTextArray
                If textBoxTemp.Tag = "SecondaryPatientContactTitle" Then
                    Call modStatQuery.QueryPersonPersonType(Me, textBoxTemp)

                    'Clear the title if multiple names or no match
                    If DataComboArray(Index).SelectedIndex = -1 Then
                        textBoxTemp.Text = ""
                    End If

                    Exit For
                End If
            Next

            'drh FSMod 06/24/03 - Added logic for Witnessed
        ElseIf DataComboArray(Index).Tag = "SecondaryDeathWitnessed" Then
            For Each textBoxTemp As TextBox In DataTextArray
                If textBoxTemp.Tag = "SecondaryLSADate" Or textBoxTemp.Tag = "SecondaryLSATime" Then
                    If DataComboArray(Index).Text = "Yes" Then
                        textBoxTemp.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000013)
                    Else
                        textBoxTemp.BackColor = System.Drawing.Color.White
                    End If
                End If
            Next

            For Each comboBoxTemp As ComboBox In DataComboArray
                If comboBoxTemp.Tag = "SecondaryRhythm" Then
                    If DataComboArray(Index).Text = "Yes" Then
                        comboBoxTemp.Enabled = True
                    Else
                        comboBoxTemp.Enabled = False
                    End If
                End If
            Next

        End If

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If

    End Sub

    Private Sub DataComboArray_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles DataComboArray.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = DataComboArray.GetIndex(eventSender)
        '11/05/02 drh - Validate MaxLength for the field
        'Note: HelpContextID is used to store the MaxLength for DataCombo controls

        Dim vMaxLen As Short
        If DataComboArray(Index).DropDownStyle = 0 Then
            vMaxLen = DataComboArray(Index).MaxLength

            If Len(DataComboArray(Index).Text) > vMaxLen - 1 And KeyAscii <> 8 Then
                DataComboArray(Index).Text = VB.Left(DataComboArray(Index).Text, vMaxLen)
                KeyAscii = 0
            End If
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub DataComboArray_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles DataComboArray.Leave
        Dim Index As Short = DataComboArray.GetIndex(eventSender)
        If DataComboArray(Index).Tag = "SecondaryNOKRelation" Or DataComboArray(Index).Tag = "SecondaryNOKState" Then
            If Me.NOKID > 0 Or Me.NOK = "" Or IsDBNull(Me.NOKID) Then 'No new NOK and no old NOK
                Me.ModNOK = True
            Else
                Me.AddNOK = True
            End If
        End If

        If DataComboArray(Index).Tag = "SecondaryNOKState" Then
            Me.NOKStateID = modControl.GetID(DataComboArray(Index))
        End If
    End Sub

    Private Sub DataComboArray_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles DataComboArray.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        Dim Index As Short = DataComboArray.GetIndex(eventSender)
        '11/05/02 drh - Validate MaxLength for the field
        'Note: HelpContextID is used to store the MaxLength for DataCombo controls

        Dim vMaxLen As Short
        If DataComboArray(Index).DropDownStyle = 0 Then
            vMaxLen = DataComboArray(Index).MaxLength

            If modControl.GetID(DataComboArray(Index)) = -1 And Len(DataComboArray(Index).Text) > vMaxLen Then
                DataComboArray(Index).Text = VB.Left(DataComboArray(Index).Text, vMaxLen)
            End If
        End If

        eventArgs.Cancel = Cancel
    End Sub


    Private Sub DataRTFArray_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles DataRTFArray.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        Dim Index As Short = DataRTFArray.GetIndex(eventSender)

        If DataRTFArray(Index).Tag = "SecondaryCircumstanceOfDeath" Or DataRTFArray(Index).Tag = "SecondaryMedicalHistory" Or DataRTFArray(Index).Tag = "SecondaryPhysicalAppearance" Or DataRTFArray(Index).Tag = "SecondarySubstanceAbuseDetail" Then
            If Shift = 2 Then
                KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
            End If

            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Return, 0, KeyCode)

        End If

    End Sub

    Private Sub DataRTFArray_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles DataRTFArray.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = DataRTFArray.GetIndex(eventSender)

        If DataRTFArray(Index).Tag = "SecondaryCircumstanceOfDeath" Or DataRTFArray(Index).Tag = "SecondaryMedicalHistory" Or DataRTFArray(Index).Tag = "SecondaryPhysicalAppearance" Or DataRTFArray(Index).Tag = "SecondarySubstanceAbuseDetail" Then
            Call modStatQuery.QueryKeyCodePhrase(DataRTFArray(Index), KeyAscii)

        End If


        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub DataRTFArray_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles DataRTFArray.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        Dim Index As Short = DataRTFArray.GetIndex(eventSender)

        On Error Resume Next

        If DataRTFArray(Index).Tag = "SecondaryCircumstanceOfDeath" Or DataRTFArray(Index).Tag = "SecondaryMedicalHistory" Or DataRTFArray(Index).Tag = "SecondaryPhysicalAppearance" Or DataRTFArray(Index).Tag = "SecondarySubstanceAbuseDetail" Then
            Call modStatValidate.ValidateSpelling(DataRTFArray(Index))

            '12/02/02 drh - Only verify if Disposition is loaded
            If Me.ctlSecondaryDisposition1.Visible = True Then
                Dim verifyAllData As Boolean = True
                Call Me.ctlSecondaryDisposition1.Verify(verifyAllData)
            End If

        End If

        eventArgs.Cancel = Cancel
    End Sub



    Private Sub DataTextArray_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles DataTextArray.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        Dim Index As Short = DataTextArray.GetIndex(eventSender)
        If DataTextArray(Index).Tag = "SecondaryNOKName" Or DataTextArray(Index).Tag = "SecondaryNOKPhone" Or DataTextArray(Index).Tag = "SecondaryNOKAddress" Or DataTextArray(Index).Tag = "SecondaryNOKFirstName" Or DataTextArray(Index).Tag = "SecondaryNOKLastName" Then
            If Me.NOKID > 0 Or Me.NOK = "" Or IsDBNull(Me.NOKID) Then 'No new NOK and no old NOK
                Me.ModNOK = True
            Else
                Me.AddNOK = True
            End If
        End If
    End Sub

    Private Sub DataTextArray_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles DataTextArray.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = DataTextArray.GetIndex(eventSender)
        Dim I As Short

        'Date 2000 Mask
        Dim vAscii As Integer
        Dim vTimeZoneDif As Integer
        Dim vClientTime As String = ""
        If DataTextArray(Index).Tag = "SecondaryPatientDOB" Then
            KeyAscii = modMask.DateMask2000(KeyAscii, eventSender)

            'Date Mask (Set 1)
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientDOD" Or DataTextArray(Index).Tag = "SecondaryPatientDeathType1" Or DataTextArray(Index).Tag = "SecondaryPatientDeathType2" Or DataTextArray(Index).Tag = "SecondaryWBC1Date" Or DataTextArray(Index).Tag = "SecondaryWBC2Date" Or DataTextArray(Index).Tag = "SecondaryWBC3Date" Or DataTextArray(Index).Tag = "SecondaryAdmissionDate" Or DataTextArray(Index).Tag = "SecondaryNOKNotifiedDate" Or DataTextArray(Index).Tag = "SecondaryBodyRefrigerationDate" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleDrawnDate" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleHeldDate" Or DataTextArray(Index).Tag = "SecondaryIntubationDate" Or DataTextArray(Index).Tag = "SecondaryExtubationDate" Or DataTextArray(Index).Tag = "SecondaryBrainDeathDate" Or DataTextArray(Index).Tag = "SecondaryDNRDate" Or DataTextArray(Index).Tag = "SecondaryPostMordemSampleCollectionDate" Or DataTextArray(Index).Tag = "SecondaryLabTemp1Date" Or DataTextArray(Index).Tag = "SecondaryLabTemp2Date" Or DataTextArray(Index).Tag = "SecondaryLabTemp3Date" Or DataTextArray(Index).Tag = "SecondaryAutopsyDate" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToPatientDate" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToHospitalDate" Or DataTextArray(Index).Tag = "SecondaryLSADate" Then
            If DataTextArray(Index).SelectedText <> "" Then
                DataTextArray(Index).Text = ""
            End If
            KeyAscii = modMask.DateMask_LY(KeyAscii, eventSender)

            'Date Mask (Set 2)
        ElseIf DataTextArray(Index).Tag = "SecondaryCulture1DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCulture2DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCulture3DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCXR1Date" Or DataTextArray(Index).Tag = "SecondaryCXR2Date" Or DataTextArray(Index).Tag = "SecondaryCXR3Date" Or DataTextArray(Index).Tag = "SecondaryAntibiotic1StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic2StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic3StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic4StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic5StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic1EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic2EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic3EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic4EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic5EndDate" Or DataTextArray(Index).Tag = "SecondaryBodyHoldPlaced" Then
            If DataTextArray(Index).SelectedText <> "" Then
                DataTextArray(Index).Text = ""
            End If
            KeyAscii = modMask.DateMask_LY(KeyAscii, eventSender)


            'Time Mask
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientTOD" Or DataTextArray(Index).Tag = "SecondaryPatientTOD1" Or DataTextArray(Index).Tag = "SecondaryPatientTOD2" Or DataTextArray(Index).Tag = "SecondaryNOKNotifiedTime" Or DataTextArray(Index).Tag = "SecondaryNOKETA" Or DataTextArray(Index).Tag = "SecondaryBodyRefrigerationTime" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleDrawnTime" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleHeldTime" Or DataTextArray(Index).Tag = "SecondaryAdmissionTime" Or DataTextArray(Index).Tag = "SecondaryCODTime" Or DataTextArray(Index).Tag = "SecondaryIntubationTime" Or DataTextArray(Index).Tag = "SecondaryExtubationTime" Or DataTextArray(Index).Tag = "SecondaryBrainDeathTime" Or DataTextArray(Index).Tag = "SecondaryPostMordemSampleCollectionTime" Or DataTextArray(Index).Tag = "SecondaryLabTemp1Time" Or DataTextArray(Index).Tag = "SecondaryLabTemp2Time" Or DataTextArray(Index).Tag = "SecondaryLabTemp3Time" Or DataTextArray(Index).Tag = "SecondaryAutopsyTime" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToPatientTime" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToHospitalTime" Or DataTextArray(Index).Tag = "SecondaryLSATime" Or DataTextArray(Index).Tag = "SecondaryACLSProvidedTime" Or DataTextArray(Index).Tag = "SecondaryBodyHoldPlacedTime" Then
            KeyAscii = modMask.TimeMask(KeyAscii, eventSender, Me.OrganizationTimeZone)

            'Time Mask (special)
        ElseIf DataTextArray(Index).Tag = "SecondaryEstTimeSinceLeft" Then
            vAscii = KeyAscii

            If Len(DataTextArray(Index).Text) = 8 Then
                DataTextArray(I).Text = ""
            End If

            KeyAscii = modMask.TimeMask(KeyAscii, eventSender, Me.OrganizationTimeZone)

            If Len(DataTextArray(Index).Text) = 8 Then
                On Error GoTo ErrorNextI

                For I = 0 To DataTextArray.UBound
                    If DataTextArray(I).Tag = "SecondaryTimeLeftInMT" Then

                        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(VB.Right(DataTextArray(Index).Text, 2)) '(AppMain.ParentForm.TimeZone)

                        vClientTime = VB.Left(DataTextArray(Index).Text, 5)
                        vClientTime = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(vClientTime)), "hh:mm")

                        DataTextArray(I).Text = VB.Left(vClientTime, 4)
                        DataTextArray(I).SelectionStart = 4
                        KeyAscii = modMask.TimeMask(vAscii, DataTextArray(I), "MT")
                        Exit For
                    End If
                Next I
            End If

            'Time (MT Time Zone)
        ElseIf DataTextArray(Index).Tag = "SecondaryTimeLeftInMT" Then
            KeyAscii = modMask.TimeMask(KeyAscii, eventSender, "MT")

            'Phone Mask
            'drh FSMod 06/19/03 - Added SecondaryBodyHoldPhone
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientPhone" Or DataTextArray(Index).Tag = "SecondaryPatientHospitalPhone" Or DataTextArray(Index).Tag = "SecondaryNOKPhone" Or DataTextArray(Index).Tag = "SecondaryNOKAltPhone" Or DataTextArray(Index).Tag = "SecondaryCoronerInvestigatorPhone" Or DataTextArray(Index).Tag = "SecondaryFuneralHomePhone" Or DataTextArray(Index).Tag = "SecondaryNOKAltContactPhone" Or DataTextArray(Index).Tag = "SecondaryPCPPhone" Or DataTextArray(Index).Tag = "SecondaryBodyHoldPhone" Or DataTextArray(Index).Tag = "SecondaryMDAttendingPhone" Then
            KeyAscii = modMask.PhoneMask(KeyAscii, eventSender)

            'SSN Mask
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientSSN" Then
            KeyAscii = modMask.SSNMask(KeyAscii, eventSender)

            'Num Mask
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientAge" Or DataTextArray(Index).Tag = "SecondaryGestationalAge" Or DataTextArray(Index).Tag = "SecondaryPatientHeightFeet" Or DataTextArray(Index).Tag = "SecondaryPatientHeightInches" Then
            KeyAscii = modMask.NumMask(KeyAscii, 3, eventSender)

            'drh FSMod 06/24/03 - Moved Weight from above and added logic for lbs/kg conversion
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientWeight" Then
            If (KeyAscii = 107 Or KeyAscii = 75) Then
                If lblWeight.Text = "lbs" Then
                    lblWeight.Text = "kg"
                End If
            ElseIf (KeyAscii = 108 Or KeyAscii = 76) Then
                If lblWeight.Text = "kg" Then
                    lblWeight.Text = "lbs"
                End If
            End If

            KeyAscii = modMask.DecimalMask(KeyAscii, 7, 1, eventSender)

            'drh FSMod 06/16/03 - Moved from Num Mask above
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientBMICalc" Then
            KeyAscii = modMask.DecimalMask(KeyAscii, 10, 2, eventSender)
        End If

        GoTo EventExitSub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If

EventExitSub:
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub DataTextArray_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles DataTextArray.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        Dim Index As Short = DataTextArray.GetIndex(eventSender)
        'drh FSMod 06/24/03
        On Error GoTo ErrorNextI

        Dim I As Short
        If KeyCode <> 16 Then
            If DataTextArray(Index).Tag = "SecondaryAdmissionDate" And Len(DataTextArray(Index).Text) = 8 Then
                For I = 0 To DataTextArray.UBound
                    If DataTextArray(I).Tag = "SecondaryAdmissionTime" Then
                        DataTextArray(I).Focus()
                        Exit For
                    End If
                Next I

            ElseIf DataTextArray(Index).Tag = "SecondaryLSADate" And Len(DataTextArray(Index).Text) = 8 Then
                For I = 0 To DataTextArray.UBound
                    If DataTextArray(I).Tag = "SecondaryLSATime" Then
                        DataTextArray(I).Focus()
                        Exit For
                    End If
                Next I

            ElseIf DataTextArray(Index).Tag = "SecondaryBodyHoldPlaced" And Len(DataTextArray(Index).Text) = 8 Then
                For I = 0 To DataTextArray.UBound
                    If DataTextArray(I).Tag = "SecondaryBodyHoldPlacedTime" Then
                        DataTextArray(I).Focus()
                        Exit For
                    End If
                Next I

            End If
        End If

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If
    End Sub

    Private Sub DataTextArray_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles DataTextArray.Leave
        Dim Index As Short = DataTextArray.GetIndex(eventSender)
        '02/05/03 drh - Added because Validate event is not fired when TabDonor tabs are selected
        Dim vCancel As Boolean
        vCancel = False

        If eventSender.Name <> "tbReferralData" And eventSender.Name <> "CmdCancel" Then
            If DataTextArray(Index).Tag = "SecondaryPatientWeight" Then
                If lblWeight.Text = "lbs" And DataTextArray(Index).Text <> "" Then
                    DataTextArray(Index).Text = FormatNumber(System.Math.Round(CDbl(DataTextArray(Index).Text) / 2.2, 1), 1)
                End If
                lblWeight.Text = "kg"
            End If

            Call DataTextArray_Validating(DataTextArray.Item(Index), New System.ComponentModel.CancelEventArgs(vCancel))
            If vCancel = True Then
                TabDonor.SelectedIndex = 0
                DataTextArray(Index).Focus()
            End If
        End If

        If DataTextArray(Index).Tag = "SecondaryNOKFirstName" Then
            Me.NOKFirstName = DataTextArray(Index).Text
        End If

        If DataTextArray(Index).Tag = "SecondaryNOKLastName" Then
            Me.NOKLastName = DataTextArray(Index).Text
        End If

        'If DataTextArray(Index).Tag = "SecondaryNOKStreetAddress" Then
        'Me.NOKFirstName = DataTextArray(Index).Text
        'End If

        If DataTextArray(Index).Tag = "SecondaryNOKCity" Then
            Me.NOKCity = DataTextArray(Index).Text
        End If

        If DataTextArray(Index).Tag = "SecondaryNOKState" Then
            Me.NOKFirstName = DataComboArray(Index).Text
        End If

        If DataTextArray(Index).Tag = "SecondaryNOKZip" Then
            Me.NOKZip = DataTextArray(Index).Text
        End If

    End Sub

    Private Sub DataTextArray_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles DataTextArray.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        Dim Index As Short = DataTextArray.GetIndex(eventSender)

        On Error Resume Next
        Dim I As Short

        Dim vBMI As Double
        Dim vWeight As Double
        Dim vHeightFeet As Short
        Dim vHeightInches As Short
        Dim vBMIIdx As Integer
        Dim vDays As Short
        Dim vAgeCtl As New System.Windows.Forms.Control
        Dim vAgeUnitCtl As New System.Windows.Forms.Control
        If DataTextArray(Index).Tag = "SecondaryLSATime" Or DataTextArray(Index).Tag = "SecondaryPatientAge" Then
            '12/02/02 drh - Only verify if Disposition is loaded
            If Me.ctlSecondaryDisposition1.Visible = True Then
                Dim verifyAllData As Boolean = True
                Call Me.ctlSecondaryDisposition1.Verify(verifyAllData)
            End If

            'BMI Calculation
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientWeight" Or DataTextArray(Index).Tag = "SecondaryPatientHeightFeet" Or DataTextArray(Index).Tag = "SecondaryPatientHeightInches" Then

            On Error GoTo ErrorNextI


            For I = 0 To DataTextArray.UBound
                If DataTextArray(I).Tag = "SecondaryPatientWeight" Then
                    vWeight = CDbl(IIf(DataTextArray(I).Text = "", 0, DataTextArray(I).Text)) 'T.T 11/05/2006 changed cInt to cDbl for weight
                ElseIf DataTextArray(I).Tag = "SecondaryPatientHeightFeet" Then
                    vHeightFeet = CShort(IIf(DataTextArray(I).Text = "", 0, DataTextArray(I).Text))
                ElseIf DataTextArray(I).Tag = "SecondaryPatientHeightInches" Then
                    vHeightInches = CShort(IIf(DataTextArray(I).Text = "", 0, DataTextArray(I).Text))
                ElseIf DataTextArray(I).Tag = "SecondaryPatientBMICalc" Then
                    vBMIIdx = I
                End If
            Next I

            If vHeightFeet + vHeightInches = 0 Or vWeight = 0 Then
                DataTextArray(vBMIIdx).Text = ""
            Else
                DataTextArray(vBMIIdx).Text = VB.Left(CStr(System.Math.Round(CalculateBMI(vWeight, vHeightFeet, vHeightInches), 2)), 10)
            End If

            If DataTextArray(Index).Tag = "SecondaryPatientWeight" Then
                '12/02/02 drh - Only verify if Disposition is loaded
                If Me.ctlSecondaryDisposition1.Visible = True Then
                    Dim verifyAllData As Boolean = True
                    Call Me.ctlSecondaryDisposition1.Verify(verifyAllData)
                End If
            End If

            '02/05/03 drh - Added code to validate Date for 8 characters and IsDate
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientDOD" Or DataTextArray(Index).Tag = "SecondaryPatientDeathType1" Or DataTextArray(Index).Tag = "SecondaryPatientDeathType2" Or DataTextArray(Index).Tag = "SecondaryWBC1Date" Or DataTextArray(Index).Tag = "SecondaryWBC2Date" Or DataTextArray(Index).Tag = "SecondaryWBC3Date" Or DataTextArray(Index).Tag = "SecondaryNOKNotifiedDate" Or DataTextArray(Index).Tag = "SecondaryBodyRefrigerationDate" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleDrawnDate" Or DataTextArray(Index).Tag = "SecondaryPreTransfusionSampleHeldDate" Or DataTextArray(Index).Tag = "SecondaryAdmissionDate" Or DataTextArray(Index).Tag = "SecondaryIntubationDate" Or DataTextArray(Index).Tag = "SecondaryExtubationDate" Or DataTextArray(Index).Tag = "SecondaryBrainDeathDate" Or DataTextArray(Index).Tag = "SecondaryDNRDate" Or DataTextArray(Index).Tag = "SecondaryPostMordemSampleCollectionDate" Or DataTextArray(Index).Tag = "SecondaryLabTemp1Date" Or DataTextArray(Index).Tag = "SecondaryLabTemp2Date" Or DataTextArray(Index).Tag = "SecondaryLabTemp3Date" Or DataTextArray(Index).Tag = "SecondaryAutopsyDate" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToPatientDate" Or DataTextArray(Index).Tag = "SecondaryEMSArrivalToHospitalDate" Or DataTextArray(Index).Tag = "SecondaryLSADate" Then
            If DataTextArray(Index).Text <> "" And (Len(DataTextArray(Index).Text) < 8 Or Not IsDate(DataTextArray(Index).Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

            '02/05/03 drh - Added code to validate Date for 8 characters and IsDate
            'Date Mask (Set 2)
        ElseIf DataTextArray(Index).Tag = "SecondaryCulture1DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCulture2DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCulture3DrawnDate" Or DataTextArray(Index).Tag = "SecondaryCXR1Date" Or DataTextArray(Index).Tag = "SecondaryCXR2Date" Or DataTextArray(Index).Tag = "SecondaryCXR3Date" Or DataTextArray(Index).Tag = "SecondaryAntibiotic1StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic2StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic3StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic4StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic5StartDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic1EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic2EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic3EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic4EndDate" Or DataTextArray(Index).Tag = "SecondaryAntibiotic5EndDate" Or DataTextArray(Index).Tag = "SecondaryBodyHoldPlaced" Then
            If DataTextArray(Index).Text <> "" And (Len(DataTextArray(Index).Text) < 8 Or Not IsDate(DataTextArray(Index).Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

            '02/05/03 drh - Added code to validate Date for 10 characters and IsDate
        ElseIf DataTextArray(Index).Tag = "SecondaryPatientDOB" Then
            If DataTextArray(Index).Text <> "" And (Len(DataTextArray(Index).Text) < 10 Or Not IsDate(DataTextArray(Index).Text)) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

            'drh FSMod 06/13/03 - Convert date into age - BEGIN***
            On Error GoTo ErrorNextI


            'Get the Age control
            For I = 0 To DataTextArray.UBound
                If DataTextArray(I).Tag = "SecondaryPatientAge" Then
                    vAgeCtl = DataTextArray(I)
                    Exit For
                End If
            Next I

            'Get the Age Unit control
            For I = 0 To DataComboArray.UBound
                If DataComboArray(I).Tag = "SecondaryPatientAgeUnit" Then
                    vAgeUnitCtl = DataComboArray(I)
                    Exit For
                End If
            Next I

            'Get the number of days between today and birth date
            vDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(VB6.Format(DataTextArray(Index).Text, "mm/dd/yyyy")), CDate(VB6.Format(Now, "mm/dd/yyyy")))

            'If less than 31 days, set the age and age unit to days
            If vDays = 0 Then
                vAgeCtl.Text = CStr(vDays + 1)
                vAgeUnitCtl.Text = "Days"
            End If

            If vDays > 0 And vDays <= 31 Then
                vAgeCtl.Text = CStr(vDays)
                vAgeUnitCtl.Text = "Days"
            End If

            'If greater than 31 days but less than 730 days (24 months),
            'then convert to months
            If vDays > 31 And vDays < 730 Then
                vAgeCtl.Text = CStr(modConv.AgeMonths(DataTextArray(Index).Text))
                vAgeUnitCtl.Text = "Months"
            End If

            'If greater than 730 days, set the age and age unit to years
            If vDays >= 730 Then
                vAgeCtl.Text = CStr(modConv.Age(DataTextArray(Index).Text))
                vAgeUnitCtl.Text = "Years"
            End If
            'drh FSMod 06/13/03 - Convert date into age - END***

        End If

        GoTo EventExitSub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub
    Private Sub cmdCallSheet_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCallSheet.Click

        Dim vReturn As New Object
        Dim I As Short
        frmNDRICallSheet = New FrmNDRICallSheet()

        On Error Resume Next

        'Set the call id and number of the Details form
        frmNDRICallSheet.CallId = Me.CallId
        frmNDRICallSheet.CallNumber = Me.CallNumber
        frmNDRICallSheet.OrganizationTimeZone = Me.OrganizationTimeZone


        '10/8/01 drh
        frmNDRICallSheet.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmNDRICallSheet.Display()

        Exit Sub

        '11/23/03 drh - Temporary: Keep for quick reference later
        'ErrorNextI:
        '    If Err.Number = 340 Then
        '        i = i + 1
        '        Resume
        '    End If

    End Sub

    Private Sub FrmReferralView_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        On Error Resume Next
        'BJK 1/15/01 add bitwise check. Code was a simple if Shift = 1 (1 is the value for vbShiftMask, which is the shift key)
        ' The code checks to see if vbShiftMask (1) exists in Shift
        If (Shift And VB6.ShiftConstants.ShiftMask) = VB6.ShiftConstants.ShiftMask Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

        Select Case KeyCode
            Case System.Windows.Forms.Keys.F1
                TabDonor.SelectedIndex = 0
                'TabDisposition.SetFocus
            Case System.Windows.Forms.Keys.F2
                TabDonor.SelectedIndex = 1
                LstViewPending.Focus()
            Case System.Windows.Forms.Keys.F3
                TabDonor.SelectedIndex = 2
                '02/05/03 drh - Was setting focus to non-existent TxtSecondaryNote control
                'Modified to set focus to CmdCancel since the controls on this tab aren't always enabled
                CmdCancel.Focus()
                '02/05/03 drh - Added hotkey for Approach tab
            Case System.Windows.Forms.Keys.F4
                TabDonor.SelectedIndex = 3
                cboApproached.Focus()

        End Select

    End Sub

    Public Sub DisplayCriteria(ByRef pvCallId As Integer, ByRef pvCriteriaId As Integer, ByRef pvDonorCategoryId As Object, ByRef pvSubCriteriaId As Integer)

        frmCriteria = New FrmCriteria()
        frmCriteria.DonorCategoryID = pvDonorCategoryId

        'Set the donor category id
        Select Case pvDonorCategoryId

            Case ORGAN
                frmCriteria.DonorCategoryName = "Organ"

            Case BONE
                frmCriteria.DonorCategoryName = "Bone"

            Case TISSUE
                frmCriteria.DonorCategoryName = "Soft Tissue"

            Case SKIN
                frmCriteria.DonorCategoryName = "Skin"

            Case VALVES
                frmCriteria.DonorCategoryName = "Valves"

            Case EYES
                frmCriteria.DonorCategoryName = "Eyes"

            Case RESEARCH
                frmCriteria.DonorCategoryName = "Other"

        End Select


        'Set frmCriteria.SourceCode = Me.SourceCode
        frmCriteria.ReferralOrganizationID = Me.OrganizationId
        frmCriteria.CriteriaStatusID = CURRENT_CRITERIA
        frmCriteria.CriteriaGroupID = pvCriteriaId
        frmCriteria.CurrentSubCriteriaId = pvSubCriteriaId


        frmCriteria.CmdOK.Visible = False
        frmCriteria.Saved = True
        frmCriteria.CmdCancel.Text = "&Close"
        frmCriteria.TabCriteria.TabPages.RemoveAt(2)
        frmCriteria.TabCriteria.TabPages.RemoveAt(1)
        frmCriteria.SSTab1.TabPages.RemoveAt(2)
        frmCriteria.SSTab1.TabPages.RemoveAt(1)
        frmCriteria.SSTab1.TabPages.RemoveAt(0)
        frmCriteria.cmdSaveSubCriteria.Visible = False
        frmCriteria.cmdAddConditional.Visible = False
        frmCriteria.cmdRemoveConditional.Visible = False
        frmCriteria.cmdAddScheduleSub.Visible = False
        frmCriteria.cmdRemoveScheduleSub.Visible = False
        frmCriteria.cmdTemp.Visible = False 'TEMPORARY - REMOVE TO GO LIVE
        frmCriteria.TabCriteria.SelectedIndex = 2
        frmCriteria.SSTab1.SelectedIndex = 3
        frmCriteria.Show()

    End Sub

    Public Function ReverseSetFSStage(ByRef vStage As Short) As Boolean
        '************************************************************************************
        'Name: ReverseSetFSStage
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Secondary Bill information in FSCase
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 07/03/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vField2 As String = ""

        Select Case vStage
            Case 1
                vField1 = "@FSCaseOpenUserId"
                vField2 = "@FSCaseOpenDateTime"
            Case 2
                vField1 = "@FSCaseSysEventsUserId"
                vField2 = "@FSCaseSysEventsDateTime"
            Case 3
                vField1 = "@FSCaseSecCompUserId"
                vField2 = "@FSCaseSecCompDateTime"
            Case 4
                vField1 = "@FSCaseApproachUserId"
                vField2 = "@FSCaseApproachDateTime"
            Case 5
                vField1 = "@FSCaseFinalUserId"
                vField2 = "@FSCaseFinalDateTime"
        End Select

        vQuery = "EXEC UpdateFSCase " & vField1 & " = " & 0 & ", " & vField2 & " = null " & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call GetFSStage()

    End Function

    Public Function GetFSStage() As Boolean

        Dim vResults As New Object
        Dim vFSStage As New Object 'Stage FS Case is in currently

        Dim FS_CREATED As New Object 'Secondary Event has been created
        Dim FS_OPEN As New Object 'FS Case marked "Open"
        Dim FS_SYSEVENT As New Object 'FS Case marked "System Events"
        Dim FS_SECCOMP As New Object 'FS Case marked "Secondary Complete"
        Dim FS_APPROACHED As New Object 'FS Case marked "Approached"
        Dim FS_FINAL As New Object 'FS Case marked "Final"

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
        Call modStatQuery.QueryFSCase(Me, vResults)

        '7/23/01 drh Get info for each stage
        If Not IsNothing(vResults) Then
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
        End If

        '7/23/01 drh Get FS Stage
        If Not IsNothing(vResults) Then
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
        Me.fmSecondaryStatus.Visible = True
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

        Else
            Me.chkCaseOpen.Enabled = True
            Me.chkSystemEvents.Enabled = False
        End If

        If vFSSysEventUserId <> 0 Then
            Me.chkSystemEvents.Enabled = True
            Me.chkSystemEvents.CheckState = System.Windows.Forms.CheckState.Checked
            lblSystemEventsPersonDateTime.Visible = True
            lblSystemEventsPersonDateTime.Text = vFSSysEventName & " - " & vFSSysEventDateTime
        Else
            If vFSStage = FS_OPEN Then
                Me.chkSystemEvents.Enabled = True
            End If
        End If

        If vFSSecCompUserId <> 0 Then
            Me.chkSecondaryComplete.Enabled = True
            Me.chkSystemEvents.Enabled = False
            Me.chkSecondaryComplete.CheckState = System.Windows.Forms.CheckState.Checked
            lblSecondaryCompletePersonDateTime.Visible = True
            lblSecondaryCompletePersonDateTime.Text = vFSSecCompName & " - " & vFSSecCompDateTime
        Else
            If vFSStage = FS_SYSEVENT Then
                Me.chkSecondaryComplete.Enabled = True
            End If
        End If

        If vFSApproachUserId <> 0 Then
            Me.chkApproached.Enabled = True
            Me.chkSecondaryComplete.Enabled = False
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
            Me.chkApproached.Enabled = False
            Me.chkFinal.CheckState = System.Windows.Forms.CheckState.Checked
            lblFinalPersonDateTime.Visible = True
            lblFinalPersonDateTime.Text = vFSFinalName & " - " & vFSFinalDateTime

            'Disable everything if Final
            Me.chkCaseOpen.Enabled = False
            Me.chkSecondaryComplete.Enabled = False
            Me.chkApproached.Enabled = False
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

    Public Function GetFSStageWithSecondaryBilling() As Boolean

        'FSStage

        Dim vResults As New Object
        Dim vFSStage As New Object 'Stage FS Case is in currently

        Dim FS_CREATED As New Object 'Secondary Event has been created
        Dim FS_OPEN As New Object 'FS Case marked "Open"
        Dim FS_SYSEVENT As New Object 'FS Case marked "System Events"
        Dim FS_SECCOMP As New Object 'FS Case marked "Secondary Complete"
        Dim FS_APPROACHED As New Object 'FS Case marked "Approached"
        Dim FS_FINAL As New Object 'FS Case marked "Final"

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
        Call modStatQuery.QueryFSCaseWithSecondaryBilling(Me, vResults)

        '7/23/01 drh Get info for each stage
        If Not IsNothing(vResults) Then
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
        End If

        '7/23/01 drh Get FS Stage
        If Not IsNothing(vResults) Then
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
        Me.fmSecondaryStatus.Visible = True
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

        Else
            Me.chkCaseOpen.Enabled = True
            Me.chkSystemEvents.Enabled = False
        End If

        If vFSSysEventUserId <> 0 Then
            Me.chkSystemEvents.Enabled = True
            Me.chkSystemEvents.CheckState = System.Windows.Forms.CheckState.Checked
            lblSystemEventsPersonDateTime.Visible = True
            lblSystemEventsPersonDateTime.Text = vFSSysEventName & " - " & vFSSysEventDateTime
        Else
            If vFSStage = FS_OPEN Then
                Me.chkSystemEvents.Enabled = True
            End If
        End If

        If vFSSecCompUserId <> 0 Then
            Me.chkSecondaryComplete.Enabled = True
            Me.chkSystemEvents.Enabled = False
            Me.chkSecondaryComplete.CheckState = System.Windows.Forms.CheckState.Checked
            lblSecondaryCompletePersonDateTime.Visible = True
            lblSecondaryCompletePersonDateTime.Text = vFSSecCompName & " - " & vFSSecCompDateTime
        Else
            If vFSStage = FS_SYSEVENT Then
                Me.chkSecondaryComplete.Enabled = True
            End If
        End If

        If vFSApproachUserId <> 0 Then
            Me.chkApproached.Enabled = True
            Me.chkSecondaryComplete.Enabled = False
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
            Me.chkApproached.Enabled = False
            Me.chkFinal.CheckState = System.Windows.Forms.CheckState.Checked
            lblFinalPersonDateTime.Visible = True
            lblFinalPersonDateTime.Text = vFSFinalName & " - " & vFSFinalDateTime

            'Disable everything if Final
            Me.chkCaseOpen.Enabled = False
            Me.chkSecondaryComplete.Enabled = False
            Me.chkApproached.Enabled = False
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

        'Secondary Billing

        'Dim vResults As New Object
        Dim I As Short

        'Get FS Case record
        'Call modStatQuery.QuerySecondaryBilling(Me, vResults)

        '1/16/03 drh - Populate multiple billing dropdowns
        Me.cboSecondaryFamilyApproach.Items.Clear()
        Me.cboSecondaryMedSoc.Items.Clear()
        Me.cboSecondaryCryolifeFormCompleted.Items.Clear()

        For I = 0 To 10
            Call Me.cboSecondaryFamilyApproach.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryFamilyApproach, I, I)
            Call Me.cboSecondaryMedSoc.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryMedSoc, I, I)
            Call Me.cboSecondaryCryolifeFormCompleted.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryCryolifeFormCompleted, I, I)
        Next I

        'Get info for each billing item
        If Not IsNothing(vResults) Then
            Me.chkSecondaryBillable.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 21))) > 0, 1, 0)
            Me.chkSecondaryFamilyUnavailable.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 23))) > 0, 1, 0)
            Me.chkSecondaryFamilyApproach.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 25))) > 0, 1, 0)
            Me.chkSecondaryMedSoc.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 28))) > 0, 1, 0)
            Me.chkSecondaryCryolifeFormCompleted.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 31))) > 0, 1, 0)
            Me.lblSecondaryBillable.Text = modConv.NullToText(vResults(0, 34)) & IIf(Me.chkSecondaryBillable.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 22))
            Me.lblSecondaryOTE.Text = modConv.NullToText(vResults(0, 39)) & IIf(Me.chkSecondaryOTE.CheckState = 1, " - ", " ") & modConv.NullToText(vResults(0, 41))
            Me.lblSecondaryFamilyUnavailable.Text = modConv.NullToText(vResults(0, 35)) & IIf(Me.chkSecondaryFamilyUnavailable.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 24))
            Me.lblSecondaryFamilyApproach.Text = modConv.NullToText(vResults(0, 19)) & IIf(Me.chkSecondaryFamilyApproach.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 26))
            Me.lblSecondaryMedSoc.Text = modConv.NullToText(vResults(0, 37)) & IIf(Me.chkSecondaryMedSoc.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 39))
            Me.lblSecondaryCryolifeFormCompleted.Text = modConv.NullToText(vResults(0, 38)) & IIf(Me.chkSecondaryCryolifeFormCompleted.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 32))
            Me.cboSecondaryFamilyApproach.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 27)))
            Me.cboSecondaryMedSoc.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 30)))
            Me.cboSecondaryCryolifeFormCompleted.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 33)))
        End If

        '1/16/03 drh - Disable Family Unavailable or Family Approach if the other is checked
        Me.chkSecondaryFamilyApproach.Enabled = IIf(Me.chkSecondaryFamilyUnavailable.CheckState = System.Windows.Forms.CheckState.Unchecked, True, False)
        Me.chkSecondaryFamilyUnavailable.Enabled = IIf(Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Unchecked, True, False)

        '1/16/03 drh - Disable/Enable dropdowns based on checkbox status
        Me.cboSecondaryFamilyApproach.Enabled = IIf(Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Checked, True, False)
        Me.cboSecondaryMedSoc.Enabled = IIf(Me.chkSecondaryMedSoc.CheckState = System.Windows.Forms.CheckState.Checked, True, False)
        Me.cboSecondaryCryolifeFormCompleted.Enabled = IIf(Me.chkSecondaryCryolifeFormCompleted.CheckState = System.Windows.Forms.CheckState.Checked, True, False)

        '1/20/03 drh - For items with multiple billing option, remove item at index=0 from list if corresponding checkbox is checked
        If Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryFamilyApproach.Items.RemoveAt(0)
        End If
        If Me.chkSecondaryMedSoc.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryMedSoc.Items.RemoveAt(0)
        End If
        If Me.chkSecondaryCryolifeFormCompleted.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryCryolifeFormCompleted.Items.RemoveAt(0)
        End If

        'If Person Type is Triage Coordinator or another person has the Referral open, disable all checkboxes
        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Or (Me.CallOpenByID <> 0 And Me.CallOpenByID <> AppMain.ParentForm.StatEmployeeID) Then
            Me.chkSecondaryBillable.Enabled = False
            Me.chkSecondaryFamilyUnavailable.Enabled = False '1/16/03 drh
            Me.chkSecondaryFamilyApproach.Enabled = False
            Me.chkSecondaryMedSoc.Enabled = False
            Me.chkSecondaryCryolifeFormCompleted.Enabled = False '1/16/03 drh
            Me.cboSecondaryFamilyApproach.Enabled = False '1/16/03 drh
            Me.cboSecondaryMedSoc.Enabled = False '1/16/03 drh
            Me.cboSecondaryCryolifeFormCompleted.Enabled = False '1/16/03 drh
        End If

        'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
        'Disallow user to decrement Family Approach counts
        If Me.BillFamilyApproachManualEnable = False Then
            For I = 0 To (Me.cboSecondaryFamilyApproach.SelectedIndex - 1)
                Call Me.cboSecondaryFamilyApproach.Items.RemoveAt(0)
            Next I
        End If

        'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
        'Disallow user to decrement MedSoc counts
        If Me.BillMedSocManualEnable = False Then
            For I = 0 To (Me.cboSecondaryMedSoc.SelectedIndex - 1)
                Call Me.cboSecondaryMedSoc.Items.RemoveAt(0)
            Next I
        End If

        'ccarroll 05/18/2007 StatTrac 8.4 release, requirement 3.2
        'Enable/disable Auto/Manual Billing feature
        'ccarroll 06/18/2008 StatTrac 8.4.6 - Check for BillApproachOnly disable if True

        If Me.BillApproachOnly = False Then
            If Me.BillSecondaryManualEnable = False Then
                Me.chkSecondaryBillable.Enabled = False
            End If
        Else
            Me.chkSecondaryBillable.Enabled = False
        End If


        'Enable/disable Auto/Manual Family Approach feature
        If Me.BillFamilyApproachManualEnable = False Then
            Me.chkSecondaryFamilyApproach.Enabled = False
        End If
        'Enable/disable Auto/Manual MedSoc feature
        If Me.BillMedSocManualEnable = False Then
            Me.chkSecondaryMedSoc.Enabled = False
        End If

        'ccarroll 05/22/2007 StatTrac 8.4 release, requirement 3.2
        'Set SecondaryBillableComplete
        If Me.chkSecondaryBillable.CheckState = 1 Then
            Me.BillSecondaryComplete = True
        End If

    End Function

    Public Function GetSecondaryBilling() As Boolean


        Dim vResults As New Object
        Dim I As Short

        'Get FS Case record
        Call modStatQuery.QuerySecondaryBilling(Me, vResults)

        '1/16/03 drh - Populate multiple billing dropdowns
        Me.cboSecondaryFamilyApproach.Items.Clear()
        Me.cboSecondaryMedSoc.Items.Clear()
        Me.cboSecondaryCryolifeFormCompleted.Items.Clear()

        For I = 0 To 10
            Call Me.cboSecondaryFamilyApproach.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryFamilyApproach, I, I)
            Call Me.cboSecondaryMedSoc.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryMedSoc, I, I)
            Call Me.cboSecondaryCryolifeFormCompleted.Items.Insert(I, CStr(I))
            VB6.SetItemData(Me.cboSecondaryCryolifeFormCompleted, I, I)
        Next I

        'Get info for each billing item
        If Not IsNothing(vResults) Then
            Me.chkSecondaryBillable.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 2))) > 0, 1, 0)
            Me.chkSecondaryFamilyUnavailable.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 4))) > 0, 1, 0) '1/16/03 drh
            Me.chkSecondaryFamilyApproach.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 6))) > 0, 1, 0)
            Me.chkSecondaryMedSoc.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 9))) > 0, 1, 0)
            Me.chkSecondaryCryolifeFormCompleted.CheckState = IIf(modConv.TextToLng(modConv.NullToText(vResults(0, 12))) > 0, 1, 0) '1/16/03 drh
            Me.lblSecondaryBillable.Text = modConv.NullToText(vResults(0, 17)) & IIf(Me.chkSecondaryBillable.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 3))
            Me.lblSecondaryOTE.Text = modConv.NullToText(vResults(0, 22)) & IIf(Me.chkSecondaryOTE.CheckState = 1, " - ", " ") & modConv.NullToText(vResults(0, 24))
            Me.lblSecondaryFamilyUnavailable.Text = modConv.NullToText(vResults(0, 18)) & IIf(Me.chkSecondaryFamilyUnavailable.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 5)) '1/16/03 drh
            Me.lblSecondaryFamilyApproach.Text = modConv.NullToText(vResults(0, 19)) & IIf(Me.chkSecondaryFamilyApproach.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 7))
            Me.lblSecondaryMedSoc.Text = modConv.NullToText(vResults(0, 20)) & IIf(Me.chkSecondaryMedSoc.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 10))
            Me.lblSecondaryCryolifeFormCompleted.Text = modConv.NullToText(vResults(0, 21)) & IIf(Me.chkSecondaryCryolifeFormCompleted.CheckState = 1, " - ", "") & modConv.NullToText(vResults(0, 13)) '1/16/03 drh
            Me.cboSecondaryFamilyApproach.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 8))) '1/16/03 drh
            Me.cboSecondaryMedSoc.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 11))) '1/16/03 drh
            Me.cboSecondaryCryolifeFormCompleted.SelectedIndex = modConv.NullToText(modConv.TextToInt(vResults(0, 14))) '1/16/03 drh
        End If

        '1/16/03 drh - Disable Family Unavailable or Family Approach if the other is checked
        Me.chkSecondaryFamilyApproach.Enabled = IIf(Me.chkSecondaryFamilyUnavailable.CheckState = System.Windows.Forms.CheckState.Unchecked, True, False)
        Me.chkSecondaryFamilyUnavailable.Enabled = IIf(Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Unchecked, True, False)

        '1/16/03 drh - Disable/Enable dropdowns based on checkbox status
        Me.cboSecondaryFamilyApproach.Enabled = IIf(Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Checked, True, False)
        Me.cboSecondaryMedSoc.Enabled = IIf(Me.chkSecondaryMedSoc.CheckState = System.Windows.Forms.CheckState.Checked, True, False)
        Me.cboSecondaryCryolifeFormCompleted.Enabled = IIf(Me.chkSecondaryCryolifeFormCompleted.CheckState = System.Windows.Forms.CheckState.Checked, True, False)

        '1/20/03 drh - For items with multiple billing option, remove item at index=0 from list if corresponding checkbox is checked
        If Me.chkSecondaryFamilyApproach.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryFamilyApproach.Items.RemoveAt(0)
        End If
        If Me.chkSecondaryMedSoc.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryMedSoc.Items.RemoveAt(0)
        End If
        If Me.chkSecondaryCryolifeFormCompleted.CheckState = System.Windows.Forms.CheckState.Checked Then
            Call Me.cboSecondaryCryolifeFormCompleted.Items.RemoveAt(0)
        End If

        'If Person Type is Triage Coordinator or another person has the Referral open, disable all checkboxes
        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Or (Me.CallOpenByID <> 0 And Me.CallOpenByID <> AppMain.ParentForm.StatEmployeeID) Then
            Me.chkSecondaryBillable.Enabled = False
            Me.chkSecondaryFamilyUnavailable.Enabled = False '1/16/03 drh
            Me.chkSecondaryFamilyApproach.Enabled = False
            Me.chkSecondaryMedSoc.Enabled = False
            Me.chkSecondaryCryolifeFormCompleted.Enabled = False '1/16/03 drh
            Me.cboSecondaryFamilyApproach.Enabled = False '1/16/03 drh
            Me.cboSecondaryMedSoc.Enabled = False '1/16/03 drh
            Me.cboSecondaryCryolifeFormCompleted.Enabled = False '1/16/03 drh
        End If

        'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
        'Disallow user to decrement Family Approach counts
        If Me.BillFamilyApproachManualEnable = False Then
            For I = 0 To (Me.cboSecondaryFamilyApproach.SelectedIndex - 1)
                Call Me.cboSecondaryFamilyApproach.Items.RemoveAt(0)
            Next I
        End If

        'ccarroll 05/23/2007 StatTrac 8.4 release, requirement 3.2
        'Disallow user to decrement MedSoc counts
        If Me.BillMedSocManualEnable = False Then
            For I = 0 To (Me.cboSecondaryMedSoc.SelectedIndex - 1)
                Call Me.cboSecondaryMedSoc.Items.RemoveAt(0)
            Next I
        End If

        'ccarroll 05/18/2007 StatTrac 8.4 release, requirement 3.2
        'Enable/disable Auto/Manual Billing feature
        'ccarroll 06/18/2008 StatTrac 8.4.6 - Check for BillApproachOnly disable if True

        If Me.BillApproachOnly = False Then
            If Me.BillSecondaryManualEnable = False Then
                Me.chkSecondaryBillable.Enabled = False
            End If
        Else
            Me.chkSecondaryBillable.Enabled = False
        End If


        'Enable/disable Auto/Manual Family Approach feature
        If Me.BillFamilyApproachManualEnable = False Then
            Me.chkSecondaryFamilyApproach.Enabled = False
        End If
        'Enable/disable Auto/Manual MedSoc feature
        If Me.BillMedSocManualEnable = False Then
            Me.chkSecondaryMedSoc.Enabled = False
        End If

        'ccarroll 05/22/2007 StatTrac 8.4 release, requirement 3.2
        'Set SecondaryBillableComplete
        If Me.chkSecondaryBillable.CheckState = 1 Then
            Me.BillSecondaryComplete = True
        End If


    End Function


    Private Sub FrmReferralView_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift > 0 Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

    End Sub


    Private Sub FrmReferralView_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        On Error GoTo localError

        'add to control Arrays
        DataItemListArray = New Hashtable
        DataItemListArray.Add(CShort(0), _DataItemListArray_0)
        DataItemListArray.Add(CShort(1), _DataItemListArray_1)

        'add tab page to array to allow hiding pages
        tabPages(0) = tbReferralData.TabPages().Item(0)
        tabPages(1) = tbReferralData.TabPages().Item(1)
        tabPages(2) = tbReferralData.TabPages().Item(2)
        tabPages(3) = tbReferralData.TabPages().Item(3)
        tabPages(4) = tbReferralData.TabPages().Item(4)
        tabPages(5) = tbReferralData.TabPages().Item(5)
        tabPages(6) = tbReferralData.TabPages().Item(6)
        tabPages(7) = tbReferralData.TabPages().Item(7)
        'fmCreateMedication
        'fmeApproach
        'fmeConsent
        'fmOrgSpecialNotes
        'fmSecondaryStatus

        'ccarroll 05/18/2007 StatTrac 8.4 release, requirement 3.2
        'AutoBilling - set defaults
        Me.BillSecondaryManualEnable = False
        Me.BillFamilyApproachManualEnable = False
        Me.BillMedSocManualEnable = False

        'ccarroll 06/17/2008 StatTrac 8.4.6
        Me.BillApproachOnly = False


        '10/16/02 drh - Save Audit info
        Dim vTempAuditLogId As Integer 'Note: Can't pass properties byRef, so use intermediate variable
        vTempAuditLogId = 0
        Me.AuditLogId = -1

        'Code copied from Triage Referral Form
        Call LoadTriageReferral()

        'Initialize Tabs/Frames
        Call InitializeTabFrames()

        'Load Tree Fields/Groups
        Call LoadReferralDataTree()

        'Initialize the combo boxes
        Call PopulateComboBoxes()

        'Get Triage Data
        Call GetTriageReferralData()

        'Get Secondary Data
        Call GetSecondaryReferralData()

        'Get info for Approach tab
        Call GetApproachConsent()

        'Get Disposition Grid Data
        '12/02/02 drh - Disposition is loaded manually now (see cmdVerify_Click)
        'Me.ctlSecondaryDisposition1.CallId = Me.CallId

        'Set User Permissions
        Call SetUserPermissions()

        If Me.NOKID > 0 Or Me.NOK = "" Or IsDBNull(Me.NOKID) Then 'No new NOK and no old NOK
            'After 8.0 name broken out
            Me.DataTextArray(143).Enabled = False
            Me.DataTextArray(143).Visible = False
            Me.DataLabelArray(183).Enabled = False
            Me.DataLabelArray(183).Visible = False
            'pre 8.0 address
            Me.DataTextArray(146).Enabled = False
            Me.DataTextArray(146).Visible = False

            'set tab order
            Me.DataTextArray(31).TabIndex = 1 'first name
            Me.DataTextArray(32).TabIndex = 2 'last name
            Me.DataTextArray(144).TabIndex = 3 'phone
            Me.DataTextArray(145).TabIndex = 4 'alt phone
            Me.DataComboArray(43).TabIndex = 5 'relation
            Me.DataComboArray(86).TabIndex = 6 ' nok gender
            Me.DataTextArray(35).TabIndex = 7 ' address
            Me.DataTextArray(33).TabIndex = 8 'city
            Me.DataComboArray(7).TabIndex = 9 'state
            Me.DataTextArray(34).TabIndex = 10 'zip
            Me.DataComboArray(45).TabIndex = 11 'legal nok

        Else
            'pre 8.0 name name not broken out
            Me.DataTextArray(31).Enabled = False
            Me.DataTextArray(31).Visible = False
            Me.DataLabelArray(53).Enabled = False
            Me.DataLabelArray(53).Visible = False

            Me.DataTextArray(32).Enabled = False
            Me.DataTextArray(32).Visible = False
            Me.DataLabelArray(54).Enabled = False
            Me.DataLabelArray(54).Visible = False
            'pre 8.0 address not broken out
            Me.DataTextArray(35).Enabled = False
            Me.DataTextArray(35).Visible = False
            'city
            Me.DataTextArray(33).Enabled = False
            Me.DataTextArray(33).Visible = False
            Me.DataLabelArray(57).Enabled = False
            Me.DataLabelArray(57).Visible = False

            'zip
            Me.DataTextArray(34).Enabled = False
            Me.DataTextArray(34).Visible = False
            Me.DataLabelArray(62).Enabled = False
            Me.DataLabelArray(62).Visible = False

            'state
            Me.DataComboArray(7).Enabled = False
            Me.DataComboArray(7).Visible = False
            Me.DataLabelArray(61).Enabled = False
            Me.DataLabelArray(61).Visible = False


        End If

        '6/22/2004 T.T added to start at approach Tab
        TabDonor.SelectedIndex = 0
        AppMain.frmOpenAll.ExitReferral = False
        'T.T 08/23/2006 code to check call id and mixing of referral with duplicate referral numbers
        Dim Rmes As New Object
        If Trim(CStr(CallId)) <> VB.Left(Trim(CallNumber), InStr(1, Trim(CallNumber), "-") - 1) Then
            Rmes = MsgBox("The CallNumber does not match the CallID! This Referral will be closed. Please Re-Open Referral!", MsgBoxStyle.Critical)
            AppMain.frmOpenAll.ExitReferral = True
            Me.Close()
        End If

        'T.T 04/26/2007 query for registry status
        Call modStatQuery.QueryRegistryStatusFS((Me.CallId))

        'T.T 04/26/2007 get the servicelevel for this referral
        Dim vRslist As ADODB.Recordset
        Call modStatQuery.QueryFamilyServicesServiceLevel(Me)

        'ccarroll 05/29/2007 StatTrac 8.4 release, requirement 3.2 AutoBill
        'Get servicelevel for referral
        Call modStatQuery.QueryServiceLevelAutoBillable(Me)


        'ccarroll 06/08/2007 StatTrac 8.4 release requirement 3.6
        'ccarroll 07/06/2007 added check for two users in case
        If Me.btnSaveAndClose.Enabled = True Then
            'Get Secondary TBI ServiceLevel and set TBIAccess
            Call modStatQuery.QuerySecondaryTBIAccess(Me)
        Else
            TBIAccess = False
        End If

        'ccarroll 06/04/2007 StatTrac 8.4 release, requirement 3.6
        ' initialize TBI control items
        Me.DataTextArray(36).Enabled = False

        If Me.TBIAccess = False Then
            Me.cmdGenerateTBI.Enabled = False
        End If


        If Me.chkSecondaryTBINotNeeded.CheckState = 1 And Me.TBIAccess = True Then
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.Color.White
        Else
            Me.txtSecondaryTBIComment.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
        End If

        '07/03/07 bret initialize the array
        ReDim Preserve DeletedSecondaryMedicationList(0)

        Me.TxtDOB = DataTextArray(24)
        Me.TxtDonorFirstName = DataTextArray(23)
        Me.TxtDonorLastName = DataTextArray(21)

        Exit Sub
localError:
        Resume Next
        Resume

    End Sub

    Private Sub Label4_Click()

    End Sub

    Private Sub txtSecondaryTBIComment_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtSecondaryTBIComment.TextChanged
        'ccarroll 02/08/2010 - HS22385, HS22279 removed following
        'Me.TBIUpdateFlag = True
    End Sub

    Private Sub txtSecondaryTBIComment_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtSecondaryTBIComment.Leave
        If Me.txtSecondaryTBIComment.Text = "" Then
            Call MsgBox("Please comment why CTDN assignment was not needed.", MsgBoxStyle.OkOnly)
            Me.txtSecondaryTBIComment.Focus()

        End If
    End Sub

    Private Sub VP_Timer_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles VP_Timer.Tick
        '8/18/03 drh - Timer event for adding CallId to Voiceprint call record
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

        End Get
        Set(ByVal Value As Object)

            fvCallDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm"))

        End Set
    End Property




    Public Property Age() As Object
        Get
            For Each dataText As TextBox In DataTextArray
                If dataText.Tag = "SecondaryPatientAge" Then
                    Return dataText.Text
                End If
            Next

        End Get
        Set(ByVal Value As Object)

        End Set
    End Property


    Public Property Weight() As Object
        Get
            For Each dataText As TextBox In DataTextArray
                If dataText.Tag = "SecondaryPatientWeight" Then
                    Return dataText.Text
                End If
            Next
        End Get
        Set(ByVal Value As Object)

        End Set
    End Property


    Public Property Gender() As Object
        Get
            For Each dataCombo As ComboBox In DataComboArray
                If dataCombo.Tag = "SecondaryPatientGender" Then
                    Return dataCombo.Text
                End If
            Next
        End Get
        Set(ByVal Value As Object)

        End Set
    End Property


    Public Property WeightUnit() As Object
        Get

            'This is always kg!
            WeightUnit = "kg"


        End Get
        Set(ByVal Value As Object)

        End Set
    End Property


    Public Property MedicalHistory() As Object
        Get
            For Each dataCombo As ComboBox In DataComboArray
                If dataCombo.Tag = "SecondaryTriageHX" Then
                    Return dataCombo.Text
                End If
            Next
        End Get
        Set(ByVal Value As Object)

        End Set
    End Property

    Public Property AgeUnit() As Object
        Get

            For Each dataCombo As ComboBox In DataComboArray
                If dataCombo.Tag = "SecondaryPatientAgeUnit" Then
                    Return dataCombo.Text
                End If
            Next
        End Get
        Set(ByVal Value As Object)

        End Set
    End Property

    Private Function LoadReferralDataTree() As Integer
        'FSProj drh 5/30/02

        Dim c As Integer
        Dim vReturn As New Object
        Dim Tree() As tTree
        Dim I As Short

        'Initialize the image list
        tvTreeView.ImageList = Me.ImageList1

        'Clear the tree
        tvTreeView.Nodes.Clear()

        'Get ServiceLevelId
        Me.ServiceLevelId = modStatQuery.QueryServiceLevelId((Me.CallId))

        'Get the Tree data
        Call modStatQuery.QueryDataTree(Me, vReturn, Me.ServiceLevelId) 'For Testing: 0, 2785

        'If array element doesn't exist, go to handler
        On Error GoTo ErrorNextI

        'Populate tree
        If Not IsNothing(vReturn) Then
            'Populate User-defined type/array first
            ReDim Tree(UBound(vReturn))
            For c = 0 To UBound(vReturn)
                Tree(c).TreeItemId = """" & vReturn(c, 0) & """"
                Tree(c).ParentId = """" & vReturn(c, 2) & """"
                Tree(c).DisplayText = vReturn(c, 4)
                Tree(c).Checked = IIf(vReturn(c, 6), True, False)
                Tree(c).ControlName = vReturn(c, 3)


                'Enable the corresponding control (combo boxes)
                For Each comboBoxTemp As ComboBox In DataComboArray

                    If comboBoxTemp.Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then
                        comboBoxTemp.Enabled = True
                        comboBoxTemp.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

                        '11/05/02 drh - Set Max Characters (DataCombo's store Max Characters in the HelpContextId property since there's no MaxLength property)
                        'Note: If it's a "Dropdown Combo" style control, the database Id ServiceLevelSecondaryCtls record holds the Max Characters even though it's determined by the database "other" field
                        comboBoxTemp.MaxLength = vReturn(c, 12)

                        Exit For
                    End If
                Next



                'Enable the corresponding control (text fields)
                For Each textBoxTemp As TextBox In Me.DataTextArray

                    I = Me.DataTextArray.GetIndex(textBoxTemp)
                    'Char Chaput 09/26/05 set the BMI Calc field to always disabled. CR # 3332
                    If textBoxTemp.Tag = "SecondaryPatientBMICalc" Then
                        Call modControl.Disable(textBoxTemp)
                        'Me.DataTextArray.Item(i).Enabled = False
                        'Me.DataTextArray.Item(i).BackColor = &H80000005
                    End If


                    If I = 110 Then
                        textBoxTemp.Enabled = True
                    End If

                    If I = 173 Then
                        textBoxTemp.Enabled = True
                    End If



                    If textBoxTemp.Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then


                        textBoxTemp.Enabled = True
                        textBoxTemp.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

                        'If phone is enabled, we will need to enable extension
                        If textBoxTemp.Tag = "SecondaryPatientPhone" Then
                            DataTextArray(250).Enabled = True
                            DataTextArray(250).BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                        End If

                        '11/05/02 drh - Set Max Characters
                        textBoxTemp.MaxLength = vReturn(c, 12)


                        'T.T 05/17/2004 added to remove SecondaryTimeLeftInMT for LO Family services
                        'unless the Lease Organization has a MT time zone.
                        If vReturn(c, 3) = "SecondaryTimeLeftInMT" Then
                            If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Or AppMain.ParentForm.LeaseOrganizationType = "TriageFamilyServices" Then
                                If AppMain.ParentForm.TimeZone <> "MT" Then
                                    textBoxTemp.Enabled = False
                                    textBoxTemp.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
                                End If
                            End If
                        End If


                        Exit For
                    End If
                Next





                'Enable the corresponding control (Rich Textboxes)
                For Each richTextBoxTemp As RichTextBox In DataRTFArray
                    If richTextBoxTemp.Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then
                        richTextBoxTemp.Enabled = True
                        richTextBoxTemp.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

                        '11/05/02 drh - Set Max Characters
                        richTextBoxTemp.MaxLength = vReturn(c, 12)

                        Exit For
                    End If

                Next



                'drh FSMod 06/19/03 - Enable the corresponding control (Checkboxes)
                For Each checkBoxTemp As CheckBox In DataCheckboxArray
                    If checkBoxTemp.Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then
                        checkBoxTemp.Enabled = True
                        Exit For
                    End If
                Next


                'Enable the corresponding control (Data Frames)
                For Each groupBoxTemp As GroupBox In DataFrameArray
                    I = DataFrameArray.GetIndex(groupBoxTemp)
                    If groupBoxTemp.Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then
                        groupBoxTemp.Enabled = True

                        'Hard-coded child controls for now, since there's only one of these
                        If I = 0 Then
                            Me.lstAvailableMeds.Enabled = True
                            Me.lstAvailableMeds.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                            Me.lstSelectedMeds.Enabled = True
                            Me.lstSelectedMeds.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                            Me.cmdAddMedication.Enabled = True
                            Me.cmdAddMedication.BackColor = System.Drawing.SystemColors.Control
                            Me.cmdRemoveMedication.Enabled = True
                            Me.cmdRemoveMedication.BackColor = System.Drawing.SystemColors.Control
                        End If

                        Exit For
                    End If
                Next



                'drh FSMod 06/06/03 - Enable the corresponding control (user controls)

                For I = 0 To DataItemListArray.Count - 1 'bret 03/05/10 replace control array Me.DataItemListArray.UBound
                    If Me.DataItemListArray(I).Tag = vReturn(c, 3) And vReturn(c, 3) <> "" Then
                        Me.DataItemListArray(I).Enabled = True

                        'drh FSMod 06/11/03 - Due to a known bug with UserControl property pages, this needs to be set manually
                        If I = 0 Then
                            Me.DataItemListArray(I).MedicationType = "steroid"
                        ElseIf I = 1 Then
                            Me.DataItemListArray(I).MedicationType = "antibiotic"
                        End If

                        Exit For
                    End If
                Next I
            Next

            For c = 0 To UBound(Tree) - 1
                Select Case Tree(c).ParentId
                    'is this a root entry?
                    Case """"""
                        ThisNode = tvTreeView.Nodes.Add(Tree(c).TreeItemId, Tree(c).DisplayText, "image_bell")
                        ThisNode.Tag = Tree(c).ControlName


                        'must be a child entry
                    Case Else
                        ThisNode = tvTreeView.Nodes.Find(Tree(c).ParentId, True)(0).Nodes.Add(Tree(c).TreeItemId, Tree(c).DisplayText, "image_blue")
                        ThisNode.Tag = Tree(c).ControlName
                End Select

                'See if the item needs to be checked
                If Tree(c).Checked Then
                    ThisNode.Checked = True
                End If
                System.Windows.Forms.Application.DoEvents()
            Next

            ThisNode = tvTreeView.Nodes.Item(0)
            tvTreeView.SelectedNode = ThisNode
            Call SetDataTabs()

        End If

        Exit Function

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Function

    Private Sub FrmReferralView_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize

        ''On Error Resume Next
        ''If VB6.PixelsToTwipsY(Me.Height) < 3000 Then Me.Height = VB6.TwipsToPixelsY(3000)
        ''SizeControls((VB6.PixelsToTwipsY(imgSplitter.Top)))

    End Sub

    Private Sub FrmReferralView_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        'ccarroll 05/20/07 StatTrac 8.4 release - added Secondary billable based on event
        'If autobill is on, then mark SecondaryBilling if any fields have been filled out
        'ccarroll 06/17/2008 StatTrac 8.4.6 - Added BillApproachOnly. When True Secondary Billing is disabled.
        If Me.BillApproachOnly = False Then

            If Me.BillSecondaryManualEnable = True Then
                Call UpdateSecondaryAutoBillStatus()
            Else
                If Me.BillSecondaryFlag = True And Me.BillSecondaryComplete = False Then
                    Me.SecondaryAutoBill = True
                    Me.SecondaryUpdated = False
                    Call UpdateSecondaryAutoBillStatus()
                    Me.BillSecondaryComplete = True
                End If
            End If
        End If

        'bret 09/20/2010 set ctlSecondaryDisposition.CallId = 0 to clear dataSource
        ctlSecondaryDisposition1.CallId = 0
        AppMain.frmReferralView = Nothing
        'Me.Dispose()

    End Sub

    Private Sub imgSplitter_MouseDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs)
        ''Dim Button As Short = eventArgs.Button \ &H100000
        ''Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        ''Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        ''Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        ''With imgSplitter
        ''    picSplitter.SetBounds(.Left, .Top, VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(.Width) - 20), VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(.Height) / 2))
        ''End With
        ''picSplitter.Visible = True
        ''mbMoving = True

    End Sub

    Private Sub imgSplitter_MouseMove(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs)


    End Sub

    Private Sub imgSplitter_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs)
        ''Dim Button As Short = eventArgs.Button \ &H100000
        ''Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        ''Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        ''Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        ''SizeControls((VB6.PixelsToTwipsY(picSplitter.Top)))
        ''picSplitter.Visible = False
        ''mbMoving = False

    End Sub


    Private Sub List2_Click()

        '    MsgBox Me.List2.Text & ": " & CStr(Me.List2.ItemData(Me.List2.ListIndex)), vbOKOnly, "test"

    End Sub

    Private Sub Label32_Click()

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
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        If String.IsNullOrWhiteSpace(LstViewLogEvent.FocusedItem.Text) Then
            Exit Sub
        End If

        On Error Resume Next

        'bret 06/11/2007 8.4.3.9 edit deleted event
        'SubItems(1) = Event Type
        'If LstViewLogEvent.SelectedItem.SubItems(1) = "DELETED EVENT" Then
        '    Call MsgBox("You may not edit a Deleted Event.")
        '    Exit Sub
        'End If

        'Get the call ID and set the values to be passed
        frmLogEvent.FormState = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to 0 to indicate table maintenence
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber
        frmLogEvent.OrganizationTimeZone = Me.OrganizationTimeZone

        'Get the ID of the LogEvent to open
        frmLogEvent.LogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)
        If modStatRefQuery.RefQueryLogEventType(vReturn, frmLogEvent.LogEventID) = SUCCESS Then
            frmLogEvent.LogEventTypeID = vReturn(0, 0)
        End If

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/8/01 drh
        frmLogEvent.vParentForm = Me

        '    'Get the LogEvent id from the LogEvent form after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

        Me.Activate()

    End Sub


    Private Sub LstViewLogEvent_ItemClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewLogEvent.SelectedIndexChanged

        Dim vLogEventID As Integer
        Dim vLogEventDesc As String = ""

        If IsNothing(LstViewLogEvent.FocusedItem) Then
            Exit Sub
        End If
        'Get the ID of the selected LogEvent
        vLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

        Call modStatQuery.QueryLogEventDesc(vLogEventID, vLogEventDesc)

    End Sub


    Private Sub LstViewPending_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPending.DoubleClick

        On Error GoTo ErrorNextI

        Dim vEventTypeList() As Object
        Dim vLogEventTypeID As Integer
        Dim vOrganizationId As Integer
        Dim vScheduleGroupID As Integer
        Dim vPosition As Short
        Dim I As Integer
        frmLogEvent = New FrmLogEvent()
        frmLogEvent.vParentForm = Me

        '***********************
        'Then open the log event
        '***********************

        'Get the call ID and set the values to be passed
        frmLogEvent.FormState = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        If InStr(1, LstViewPending.FocusedItem.Tag, "|") <> 0 Then
            'The pending event is a pending contact so open the oncall event form

            ReDim vEventTypeList(2)

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

            frmOnCallEvent.SourceCode = Me.SourceCode
            frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

            frmOnCallEvent.OnCallType = REFERRAL
            '        frmOnCallEvent.TxtAlert.Text = Me.ScheduleAlert
            '        frmOnCallEvent.AlphaMsg = modStatValidate.SetRefAlpha(Me)
            '
            '        '10/8/01 drh
            '        Set frmOnCallEvent.vParentForm = Me
            '
            '        Call frmOnCallEvent.Display
            '
        Else
            'The pending event is a log event

            ReDim vEventTypeList(1)

            'Get the ID of the LogEvent to open
            frmLogEvent.LogEventID = modConv.TextToLng(LstViewPending.FocusedItem.Tag)

            'Find the event type
            Call modStatQuery.QueryLogEventTypeID((frmLogEvent.LogEventID), vLogEventTypeID)

            Select Case vLogEventTypeID

                Case CONSENT_PENDING
                    vEventTypeList(0) = CONSENT_RESPONSE
                    vEventTypeList(1) = NO_CONSENT_RESPONSE
                    frmLogEvent.DefaultContactType = CONSENT_RESPONSE
                Case PAGE_PENDING
                    vEventTypeList(0) = PAGE_RESPONSE
                    vEventTypeList(1) = NO_PAGE_RESPONSE
                    frmLogEvent.DefaultContactType = PAGE_RESPONSE
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
                Case EMAIL_PENDING
                    vEventTypeList(0) = EMAIL_RESPONSE
                    vEventTypeList(1) = NO_PAGE_RESPONSE
                    frmLogEvent.DefaultContactType = EMAIL_RESPONSE

            End Select

            frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)
            frmLogEvent.UpdatePendingEvent = True

            'set default settings
            For Each dataComboBox As ComboBox In DataComboArray
                If dataComboBox.Tag = "SecondaryPatientContactName" Then
                    frmLogEvent.DefaultContactName = dataComboBox.Text
                    Exit For
                End If

            Next
            For Each dataTextBox As TextBox In DataTextArray
                If dataTextBox.Tag = "SecondaryPatientPhone" Then
                    frmLogEvent.DefaultContactPhone = dataTextBox.Text
                ElseIf dataTextBox.Tag = "SecondaryPatientHospitalName" Then
                    frmLogEvent.DefaultOrganization = dataTextBox.Text
                End If
            Next

            frmLogEvent.DefaultOrganizationID = Me.OrganizationId

            '10/8/01 drh
            frmLogEvent.vParentForm = Me

            'Get the LogEvent id from the LogEvent form after the user is done.
            Me.SendToBack()
            Call frmLogEvent.Display()

        End If


        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Clear the grid
        LstViewPending.Items.Clear()
        Call modStatQuery.QueryPendingEvents(Me)

        '    'Check for pending contacts
        '    Call modStatValidate.ValidateReferralContacts(Me, False)

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

        If vLogEventTypeID = CONSENT_PENDING Then
            TabDonor.SelectedIndex = 0
            'TabDisposition.Tab = 3
        End If

        If vLogEventTypeID = RECOVERY_PENDING Then
            TabDonor.SelectedIndex = 0
            ' TabDisposition.Tab = 0
        End If

        Me.Activate()

        Exit Sub

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        Else
            Resume Next
        End If

    End Sub


    Private Sub TabDonor_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabDonor.SelectedIndexChanged
        Static PreviousTab As Short = TabDonor.SelectedIndex()


        On Error Resume Next




        Call modUtility.Work()

        If TabDonor.SelectedIndex = 0 Then

            LstViewPending.TabStop = False
            CmdReferral.TabStop = False
            CmdNewEvent.TabStop = False
            LstViewLogEvent.TabStop = False

        ElseIf TabDonor.SelectedIndex = 1 Then

            LstViewPending.TabStop = True
            CmdReferral.TabStop = True
            CmdNewEvent.TabStop = True
            LstViewLogEvent.TabStop = True

            'Clear the grid
            LstViewLogEvent.Items.Clear()
            LstViewLogEvent.View = View.Details

            'Clear the grid
            LstViewPending.Items.Clear()

            Call modStatQuery.QueryPendingEvents(Me)

            '        'Check for pending contacts
            '        Call modStatValidate.ValidateReferralContacts(Me, False)

            'Fill Grid
            Call modStatQuery.QueryOpenLogEvent(Me)

            'Reversed the order of two ListView columns to avoid a potentially breaking
            'change to the order of items returned by StoredProcedure: GetLogEventList
            LstViewLogEvent.Columns(5).DisplayIndex = 4
            LstViewLogEvent.Columns(4).DisplayIndex = 5

            modControl.SetRTFText(rtbScheduleAlert, rtfOrgSpecialNotes.Text)

        ElseIf TabDonor.SelectedIndex = 2 Then

            'ccarroll 05/20/07 StatTrac 8.4 release - added Secondary billable based on event
            'If autobill is on, then mark SecondaryBilling if any fields have been filled out
            'ccarroll 06/17/2008 StatTrac 8.4.6 - Added BillApproachOnly. When True, Secondary Billing is disabled.
            If Me.BillApproachOnly = False Then

                If Me.BillSecondaryManualEnable = True Then
                    Call UpdateSecondaryAutoBillStatus()
                Else
                    If Me.BillSecondaryFlag = True And Me.BillSecondaryComplete = False Then
                        'Me.chkSecondaryBillable.Value = 1
                        Me.SecondaryAutoBill = True
                        Me.SecondaryUpdated = False
                        Call UpdateSecondaryAutoBillStatus()
                        Me.BillSecondaryComplete = True
                    End If
                End If
            End If 'BillApproachOnly

            Call GetFSStageWithSecondaryBilling()

            '3/11/04 drh FSASP: Make Billing fields invisible for LO's
            'ccarroll 11/19/2008 Execept Visible for MTF ASP Internet Users (14019)
            If AppMain.ParentForm.LeaseOrganization <> 0 And AppMain.ParentForm.LeaseOrganization <> 14019 Then
                Frame(0).Visible = False
            End If

            'ccarroll removed. causing undisired results
            'by firing TabDonor.SelectedIndexChange in vb.net
            'T.T 06/10/2007 pending events open
            'If OldTab <> Me.TabDonor.SelectedIndex Then
            '    OldTab = Me.TabDonor.SelectedIndex
            '    Me.TabDonor.SelectedIndex = 1
            '    Me.TabDonor.SelectedIndex = OldTab
            'End If

            Me.chkFinal.Enabled = True

            'Disable finalize if pending events still exist
            If Me.LstViewPending.Items.Count > 0 Then
                'mess = MsgBox("Pending Events Open, Cannot Finalize Case!", vbInformation)
                Me.chkFinal.Enabled = False
                Call modUtility.Done()
                Exit Sub
            End If

            'Set the dispositionNotFinished Flag
            '12/02/02 drh - Check whether Disposition is loaded
            If Me.ctlSecondaryDisposition1.Visible = True Then
                'not verfitying all data
                Dim verifyAllData As Boolean = False
                Call Me.ctlSecondaryDisposition1.Verify(verifyAllData)
            End If
            'ccarroll 10/28/2010 (8201) Removed following Else statment.
            'Assigning value here was causing columns to render incorrectly in grid
            'Me.ctlSecondaryDisposition1.CallId = Me.CallId



            'Disable finalize if disposition not finished
            If Me.DispositionNotFinished = True Then
                Me.chkFinal.Enabled = False
            End If

            'enable finalize if Cardiac death time is blank
            If DataTextArray(54).Text = "" Then
                Me.chkFinal.Enabled = True
            End If

        End If



        Call modUtility.Done()

        PreviousTab = TabDonor.SelectedIndex()
    End Sub

    Private Sub tbReferralData_Selected(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tbReferralData.Selected

        Dim vRoot As New System.Windows.Forms.TreeNode
        Dim vChild As New System.Windows.Forms.TreeNode
        Dim I As Integer

        'Get Root Node for selected tab
        Call GetTreeRoot(tvTreeView.SelectedNode, vRoot)

        For I = 0 To vRoot.GetNodeCount(False) - 1
            If I = 0 Then
                vChild = vRoot.FirstNode
            Else
                vChild = vChild.NextNode
            End If

            If vChild.Text = tbReferralData.SelectedTab.Text Or vRoot.Text = tbReferralData.SelectedTab.Text Then
                ThisNode = vChild
                tvTreeView.SelectedNode = ThisNode
                'Call SetDataTabs()
                Exit For
            End If
        Next I


    End Sub
    ''' <summary>
    ''' Disabling functionality of tick to fix issue.
    ''' </summary>
    ''' <param name="eventSender"></param>
    ''' <param name="eventArgs"></param>
    ''' <remarks></remarks>
    Private Sub TimerTotalTime_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TimerTotalTime.Tick



    End Sub



    Public Function GetTabSelectText(ByRef pvNode As System.Windows.Forms.TreeNode) As String

        Dim vTabString As String = ""

        vTabString = pvNode.FullPath

        If InStr(1, vTabString, "\") > 0 Then
            'Take the first occurrance of "\" out
            vTabString = VB.Right(vTabString, Len(vTabString) - InStr(1, vTabString, "\"))

            'Any more occurrances?
            If InStr(1, vTabString, "\") > 0 Then
                'Take the first occurrance of "\" out
                vTabString = VB.Left(vTabString, InStr(1, vTabString, "\") - 1)
            End If
        Else
            vTabString = ""
        End If

        GetTabSelectText = vTabString

    End Function

    Public Function GetTreeRoot(ByRef pvNode As System.Windows.Forms.TreeNode, ByRef pvRoot As System.Windows.Forms.TreeNode) As Object

        Dim vPos As Integer

        pvRoot = pvNode
        vPos = InStr(1, pvRoot.FullPath, "\")

        While vPos > 0
            pvRoot = pvRoot.Parent
            vPos = InStr(1, pvRoot.FullPath, "\")
        End While

    End Function

    Public Sub PopulateComboBoxes()
        '************************************************************************************
        'Name: PopulateComboBoxes
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Populates comboboxes
        'Returns: n/a
        'Params: n/a
        '
        '
        'Stored Procedures: n/a
        '====================================================================================
        '====================================================================================
        'Date Changed: 07/10/2007                       Changed by: Thien Ta
        'Release #: 8.4                                 Task: Registrymatch button visible
        'Description:
        '
        '
        '====================================================================================
        On Error GoTo localError
        Dim I As Short
        'drh FSMod 06/16/03 - Some queries require the OrgId, so get that first
        Call QueryReferralOrganizationID(Me)

        'T.T 01/12/2007 - Determine if client is donortrac organization
        Call modStatQuery.QueryDonorTracClient(Me)

        If modConv.IntToBool(Me.DonorTracClient, -1) Then
            Me.cmdDonorTrac.Visible = True
            Me.cmdDonorTrac.Enabled = True
        End If

        'drh FSMod 06/09/03 - Populate dropdown in ctlItemList control - BEGIN***/
        For I = 0 To DataItemListArray.Count - 1
            Call DataItemListArray(I).populateAvailable()
        Next I
        'drh FSMod 06/09/03 - END***/


        'drh FSMod 06/12/03 - END***/

        'drh FSMod 06/16/03 - AttendingMD - BEGIN***/
        Dim AttendingMDCtlList(1, 0) As Object
        AttendingMDCtlList(1, 0) = "SecondaryMDAttendingId"
        Call GetDataFieldIndex(AttendingMDCtlList, CTL_COMBOID)

        For I = 0 To UBound(AttendingMDCtlList, 2)
            Call modStatQuery.QueryLocationPhysicians(Me,  , DataComboArray(AttendingMDCtlList(0, I)))
            Call SetTextIDItem(DataComboArray(AttendingMDCtlList(0, I)), -1, "")
        Next I
        'drh FSMod 06/16/03 - END***/

        'Blood Products
        Dim BloodProductList As New Object
        Dim BloodProductCtlList(1, 2) As Object
        BloodProductCtlList(1, 0) = "SecondaryBloodProductsReceived1Type"
        BloodProductCtlList(1, 1) = "SecondaryBloodProductsReceived2Type"
        BloodProductCtlList(1, 2) = "SecondaryBloodProductsReceived3Type"
        Call GetDataFieldIndex(BloodProductCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryBloodProduct(BloodProductList)
        For I = 0 To UBound(BloodProductCtlList, 2)
            Call modControl.SetTextID(DataComboArray(BloodProductCtlList(0, I)), BloodProductList)
        Next I

        'Colloids
        Dim ColloidList As New Object
        Dim ColloidCtlList(1, 2) As Object
        ColloidCtlList(1, 0) = "SecondaryColloidsInfused1Type"
        ColloidCtlList(1, 1) = "SecondaryColloidsInfused2Type"
        ColloidCtlList(1, 2) = "SecondaryColloidsInfused3Type"
        Call GetDataFieldIndex(ColloidCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryColloid(ColloidList,  ,  ,  , Me.Name)
        For I = 0 To UBound(ColloidCtlList, 2)
            Call modControl.SetTextID(DataComboArray(ColloidCtlList(0, I)), ColloidList)
        Next I

        'Crystalloids
        Dim CrystalloidList As New Object
        Dim CrystalloidCtlList(1, 2) As Object
        CrystalloidCtlList(1, 0) = "SecondaryCrystalloids1Type"
        CrystalloidCtlList(1, 1) = "SecondaryCrystalloids2Type"
        CrystalloidCtlList(1, 2) = "SecondaryCrystalloids3Type"
        Call GetDataFieldIndex(CrystalloidCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryCrystalloid(CrystalloidList)
        For I = 0 To UBound(CrystalloidCtlList, 2)
            Call modControl.SetTextID(DataComboArray(CrystalloidCtlList(0, I)), CrystalloidList)
        Next I

        'Cultures
        Dim CultureList As New Object
        Dim CultureCtlList(1, 2) As Object
        CultureCtlList(1, 0) = "SecondaryCulture1Type"
        CultureCtlList(1, 1) = "SecondaryCulture2Type"
        CultureCtlList(1, 2) = "SecondaryCulture3Type"
        Call GetDataFieldIndex(CultureCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryCulture(CultureList)
        For I = 0 To UBound(CultureCtlList, 2)
            Call modControl.SetTextID(DataComboArray(CultureCtlList(0, I)), CultureList)
        Next I

        'Cause of Death
        Dim CauseOfDeathList As New Object
        Dim CauseOfDeathCtlList(1, 0) As Object
        CauseOfDeathCtlList(1, 0) = "SecondaryCOD"
        Call GetDataFieldIndex(CauseOfDeathCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryCauseOfDeath(CauseOfDeathList)
        For I = 0 To UBound(CauseOfDeathCtlList, 2)
            Call modControl.SetTextID(DataComboArray(CauseOfDeathCtlList(0, I)), CauseOfDeathList)
        Next I

        'Race
        Dim RaceList As New Object
        Dim RaceCtlList(1, 0) As Object
        RaceCtlList(1, 0) = "SecondaryPatientRace"
        Call GetDataFieldIndex(RaceCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryRace(RaceList)
        For I = 0 To UBound(RaceCtlList, 2)
            Call modControl.SetTextID(DataComboArray(RaceCtlList(0, I)), RaceList)
        Next I

        'State
        Dim StateList As New Object
        Dim StateCtlList(1, 0) As Object
        StateCtlList(1, 0) = "SecondaryCoronerState"
        Call GetDataFieldIndex(StateCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryState(StateList)
        For I = 0 To UBound(StateCtlList, 2)
            Call modControl.SetTextID(DataComboArray(StateCtlList(0, I)), StateList)
        Next I

        'state nok
        StateCtlList(1, 0) = "SecondaryNOKState"
        Call GetDataFieldIndex(StateCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryState(StateList)
        For I = 0 To UBound(StateCtlList, 2)
            Call modControl.SetTextID(DataComboArray(StateCtlList(0, I)), StateList)
        Next I

        'SubLocation (ie. Unit)
        Dim UnitList As New Object
        Dim UnitCtlList(1, 0) As Object
        UnitCtlList(1, 0) = "SecondaryPatientHospitalUnit"

        Call GetDataFieldIndex(UnitCtlList, CTL_COMBOID)
        Call modStatRefQuery.SecQueryUnit(UnitList)

        For I = 0 To UBound(UnitCtlList, 2)
            Call modControl.SetTextID(DataComboArray(UnitCtlList(0, I)), UnitList)
        Next I


        'Yes/No/NA
        Dim YesNoList As New Object
        Dim YesNoCtlList(1, 38) As Object 'drh FSMod 06/24/03 - Updated ubound to 38
        YesNoCtlList(1, 0) = "SecondaryNOKaware"
        YesNoCtlList(1, 1) = "SecondaryFamilyInterested"
        YesNoCtlList(1, 2) = "SecondaryFamilyConsent"
        YesNoCtlList(1, 3) = "SecondaryNOKatHospital"
        YesNoCtlList(1, 4) = "SecondaryFluidsGiven"
        YesNoCtlList(1, 5) = "SecondaryBloodLoss"
        YesNoCtlList(1, 6) = "SecondarySignOfInfection"
        YesNoCtlList(1, 7) = "SecondaryNOKLegal"
        YesNoCtlList(1, 8) = "SecondaryCoronerCase"
        YesNoCtlList(1, 9) = "SecondaryFuneralHomeSelected"
        YesNoCtlList(1, 10) = "SecondaryFuneralHomeNotified"
        YesNoCtlList(1, 11) = "SecondaryFuneralHomeMorgueCooled"
        YesNoCtlList(1, 12) = "SecondaryHoldOnBody"
        YesNoCtlList(1, 13) = "SecondaryPreTransfusionSampleRequired"
        YesNoCtlList(1, 14) = "SecondaryPreTransfusionSampleAvailable"
        YesNoCtlList(1, 15) = "SecondaryPatientVent"
        YesNoCtlList(1, 16) = "SecondaryBloodProducts"
        YesNoCtlList(1, 17) = "SecondaryMedication"
        YesNoCtlList(1, 18) = "SecondaryPostMordemSampleTestSuitable"
        YesNoCtlList(1, 19) = "SecondaryAutopsy"
        YesNoCtlList(1, 20) = "SecondaryAutopsyBloodRequested"
        YesNoCtlList(1, 21) = "SecondaryAutopsyCopyRequested"
        YesNoCtlList(1, 22) = "SecondaryERORDeath"
        YesNoCtlList(1, 23) = "SecondaryPatientTerminal"
        YesNoCtlList(1, 24) = "SecondaryDeathWitnessed"
        YesNoCtlList(1, 25) = "SecondaryACLSProvided"
        YesNoCtlList(1, 26) = "SecondaryAntibiotic"
        YesNoCtlList(1, 27) = "SecondaryColloidsInfused"
        YesNoCtlList(1, 28) = "SecondarySputumCharacteristics"
        YesNoCtlList(1, 29) = "SecondaryNOKPostMortemAuthorization"
        YesNoCtlList(1, 30) = "SecondaryCrystalloids"
        YesNoCtlList(1, 31) = "SecondaryCXRAvailable"
        YesNoCtlList(1, 32) = "SecondaryHistorySubstanceAbuse"
        YesNoCtlList(1, 33) = "SecondaryAutopsyReminderYN"
        YesNoCtlList(1, 34) = "SecondaryFHReminderYN"
        YesNoCtlList(1, 35) = "SecondaryBodyCareReminderYN"
        YesNoCtlList(1, 36) = "SecondaryWrapUpReminderYN"
        YesNoCtlList(1, 37) = "SecondaryActiveInfection"
        YesNoCtlList(1, 38) = "SecondarySteroid" 'drh FSMod 06/24/03

        Call GetDataFieldIndex(YesNoCtlList, CTL_COMBOID)

        Call modStatRefQuery.SecQueryYesNo(YesNoList)
        For I = 0 To UBound(YesNoCtlList, 2)
            Call modControl.SetTextID(DataComboArray(YesNoCtlList(0, I)), YesNoList)
            Call modControl.SelectFirst(DataComboArray(YesNoCtlList(0, I)))
        Next I

        'drh FSMod 06/13/03 - ABO - BEGIN****
        Dim ABOList As New Object
        Dim ABOCtlList(1, 0) As Object
        ABOCtlList(1, 0) = "SecondaryPatientABO"
        Call GetDataFieldIndex(ABOCtlList, CTL_COMBOID)

        For I = 0 To UBound(ABOCtlList, 2)
            Call modStatRefQuery.ListSecABORef(DataComboArray(ABOCtlList(0, I)), ABOList)
        Next I
        'drh FSMod 06/13/03 - ABO - END****

        'drh FSMod 06/17/03 - Pt. Ventilated - BEGIN****
        Dim PtVentilatedList(2, 1) As Object 'drh FSMod 06/03/03 - Added blank value
        PtVentilatedList(0, 0) = 2
        PtVentilatedList(0, 1) = "Currently"
        PtVentilatedList(1, 0) = 0
        PtVentilatedList(1, 1) = "Never"
        PtVentilatedList(2, 0) = 1
        PtVentilatedList(2, 1) = "Previously"

        Dim PtVentilatedCtlList(1, 0) As Object
        PtVentilatedCtlList(1, 0) = "SecondaryPatientVentilated"
        Call GetDataFieldIndex(PtVentilatedCtlList, CTL_COMBOID)

        For I = 0 To UBound(PtVentilatedCtlList, 2)
            Call modControl.SetTextID(DirectCast(DataComboArray(PtVentilatedCtlList(0, I)), ComboBox), PtVentilatedList)
        Next I
        'drh FSMod 06/17/03 - Pt. Ventilated - END****

        'drh FSMod 06/17/03 - Rhythm - BEGIN****
        Dim RhythmList As New Object
        Dim RhythmCtlList(1, 0) As Object
        RhythmCtlList(1, 0) = "SecondaryRhythm"
        Call GetDataFieldIndex(RhythmCtlList, CTL_COMBOID)

        For I = 0 To UBound(RhythmCtlList, 2)
            Call modStatRefQuery.ListSecRhythm(DataComboArray(RhythmCtlList(0, I)), RhythmList)
        Next I
        'drh FSMod 06/13/03 - Rhythm - END****


        'Bret 6/14/2010 change comobbox population
        'jth  6/23/2010 commented out because its causing dupes to be in drop downs...ask bret what he was doing when he gets back
        _DataComboArray_49.Items.Add(New ValueDescriptionPair(1, "Released"))
        _DataComboArray_49.Items.Add(New ValueDescriptionPair(2, "Declined"))
        _DataComboArray_49.Items.Add(New ValueDescriptionPair(3, "Release w/restrictions"))

        '_DataComboArray_1.Items.Add(New ValueDescriptionPair(1, "NA"))
        '_DataComboArray_1.Items.Add(New ValueDescriptionPair(2, "Yes"))
        '_DataComboArray_1.Items.Add(New ValueDescriptionPair(3, "No"))


        _DataComboArray_7.Items.Add(New ValueDescriptionPair(1, "Adult Child"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(2, "Adult Sibling"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(3, "Guardian"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(4, "Other"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(5, "Parent"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(6, "Representative"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(7, "Spouse"))
        _DataComboArray_7.Items.Add(New ValueDescriptionPair(8, "Unknown"))

        _DataComboArray_86.Items.Add(New ValueDescriptionPair(1, "M"))
        _DataComboArray_86.Items.Add(New ValueDescriptionPair(2, "F"))
        _DataComboArray_86.Items.Add(New ValueDescriptionPair(3, "Unknown"))

        _DataComboArray_43.Items.Add(New ValueDescriptionPair(1, "Adult Child"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(2, "Adult Sibling"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(3, "Guardian"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(4, "Other"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(5, "Parent"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(6, "Representative"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(7, "Spouse"))
        _DataComboArray_43.Items.Add(New ValueDescriptionPair(8, "Unknown"))


        _DataComboArray_20.Items.Add(New ValueDescriptionPair(1, "blood bank"))
        _DataComboArray_20.Items.Add(New ValueDescriptionPair(2, "micro lab"))
        _DataComboArray_20.Items.Add(New ValueDescriptionPair(3, "lab"))


        _DataComboArray_58.Items.Add(New ValueDescriptionPair(1, "Cooled morgue"))
        _DataComboArray_58.Items.Add(New ValueDescriptionPair(2, "Cooling blankets"))
        _DataComboArray_58.Items.Add(New ValueDescriptionPair(3, "Ice packs"))

        _DataComboArray_88.Items.Add(New ValueDescriptionPair(1, "Days"))
        _DataComboArray_88.Items.Add(New ValueDescriptionPair(2, "Months"))
        _DataComboArray_88.Items.Add(New ValueDescriptionPair(3, "Years"))

        _DataComboArray_13.Items.Add(New ValueDescriptionPair(1, "M"))
        _DataComboArray_13.Items.Add(New ValueDescriptionPair(2, "F"))

        _DataComboArray_75.Items.Add(New ValueDescriptionPair(1, "250"))
        _DataComboArray_75.Items.Add(New ValueDescriptionPair(2, "300"))
        _DataComboArray_75.Items.Add(New ValueDescriptionPair(3, "350"))

        _DataComboArray_74.Items.Add(New ValueDescriptionPair(1, "250"))
        _DataComboArray_74.Items.Add(New ValueDescriptionPair(2, "300"))
        _DataComboArray_74.Items.Add(New ValueDescriptionPair(3, "350"))

        _DataComboArray_73.Items.Add(New ValueDescriptionPair(1, "250"))
        _DataComboArray_73.Items.Add(New ValueDescriptionPair(2, "300"))
        _DataComboArray_73.Items.Add(New ValueDescriptionPair(3, "350"))

        _DataComboArray_26.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_26.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_26.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_25.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_25.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_25.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_24.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_24.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_24.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_51.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_51.Items.Add(New ValueDescriptionPair(2, "Morgue"))
        _DataComboArray_51.Items.Add(New ValueDescriptionPair(3, "Funeral Home"))
        _DataComboArray_51.Items.Add(New ValueDescriptionPair(4, "Coroners Office"))

        _DataComboArray_78.Items.Add(New ValueDescriptionPair(1, "10"))
        _DataComboArray_78.Items.Add(New ValueDescriptionPair(2, "50"))
        _DataComboArray_78.Items.Add(New ValueDescriptionPair(3, "275"))
        _DataComboArray_78.Items.Add(New ValueDescriptionPair(4, "500"))

        _DataComboArray_77.Items.Add(New ValueDescriptionPair(1, "10"))
        _DataComboArray_77.Items.Add(New ValueDescriptionPair(2, "50"))
        _DataComboArray_77.Items.Add(New ValueDescriptionPair(3, "275"))
        _DataComboArray_77.Items.Add(New ValueDescriptionPair(4, "500"))

        _DataComboArray_76.Items.Add(New ValueDescriptionPair(1, "10"))
        _DataComboArray_76.Items.Add(New ValueDescriptionPair(2, "50"))
        _DataComboArray_76.Items.Add(New ValueDescriptionPair(3, "275"))
        _DataComboArray_76.Items.Add(New ValueDescriptionPair(4, "500"))

        _DataComboArray_29.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_29.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_29.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_28.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_28.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_28.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_30.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_30.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_30.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_81.Items.Add(New ValueDescriptionPair(1, "100"))
        _DataComboArray_81.Items.Add(New ValueDescriptionPair(2, "1000"))

        _DataComboArray_80.Items.Add(New ValueDescriptionPair(1, "100"))
        _DataComboArray_80.Items.Add(New ValueDescriptionPair(2, "1000"))

        _DataComboArray_79.Items.Add(New ValueDescriptionPair(1, "100"))
        _DataComboArray_79.Items.Add(New ValueDescriptionPair(2, "1000"))

        _DataComboArray_34.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_34.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_34.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_33.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_33.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_33.Items.Add(New ValueDescriptionPair(3, "ICU"))

        _DataComboArray_32.Items.Add(New ValueDescriptionPair(1, "OR"))
        _DataComboArray_32.Items.Add(New ValueDescriptionPair(2, "ER"))
        _DataComboArray_32.Items.Add(New ValueDescriptionPair(3, "ICU"))

        Exit Sub
localError:
        Resume Next
        Resume
    End Sub



    Public Function GetDataFieldIndex(ByRef vCtlList As Object, Optional ByRef vCtlType As Short = 0) As Object

        Dim I As Integer
        Dim j As Integer

        'If array element doesn't exist, go to handler
        On Error GoTo ErrorNextI

        'NOTE: Broke this into two branches for performance reasons (ie. 0 = ComboBoxes; 1 = TextBoxes)
        If vCtlType = CTL_COMBOID Or vCtlType = CTL_COMBOTEXT Then
            For Each comboBoxTemp As ComboBox In DataComboArray 'For I = 0 To Me.DataComboArray.UBound - 1
                For j = 0 To UBound(vCtlList, 2)
                    If comboBoxTemp.Tag = vCtlList(1, j) Then
                        vCtlList(0, j) = DataComboArray.GetIndex(comboBoxTemp)
                        Exit For
                    End If
                Next j
            Next

        ElseIf vCtlType = CTL_TEXT Then
            For Each textBoxTemp As TextBox In DataTextArray
                For j = 0 To UBound(vCtlList, 2)
                    If textBoxTemp.Tag = vCtlList(1, j) Then
                        vCtlList(0, j) = DataTextArray.GetIndex(textBoxTemp)
                        Exit For
                    End If
                Next j
            Next
        ElseIf vCtlType = CTL_RICHTEXT Then
            For Each richTextBoxTemp As RichTextBox In DataRTFArray
                For j = 0 To UBound(vCtlList, 2)
                    If richTextBoxTemp.Tag = vCtlList(1, j) Then
                        vCtlList(0, j) = DataRTFArray.GetIndex(richTextBoxTemp)
                        Exit For
                    End If
                Next j
            Next
            'drh FSMod 06/09/03 - Added for new User control type
        ElseIf vCtlType = CTL_ITEMLISTCTL Then
            For I = 0 To DataItemListArray.Count - 1 'bret 03/05/10 replace control array Me.DataItemListArray.UBound
                For j = 0 To UBound(vCtlList, 2)
                    If Me.DataItemListArray(I).Tag = vCtlList(1, j) Then
                        vCtlList(0, j) = I
                        Exit For
                    End If
                Next j
            Next I
            'drh FSMod 06/19/03 - Added for checkbox type
        ElseIf vCtlType = CTL_CHECKBOXCTL Then
            For Each checkBoxTemp As CheckBox In DataCheckboxArray
                For j = 0 To UBound(vCtlList, 2)
                    If checkBoxTemp.Tag = vCtlList(1, j) Then
                        vCtlList(0, j) = DataCheckboxArray.GetIndex(checkBoxTemp)
                        Exit For
                    End If
                Next j
            Next
        End If

        Exit Function

ErrorNextI:
        If Err.Number = 340 Then
            I = I + 1
            Resume
        End If

    End Function

    Public Function SetDataTabs() As Object

        'drh FSMod 06/05/03 - Changed to go to error handler
        'On Error Resume Next
        On Error GoTo ErrorNextI

        Dim vRoot As System.Windows.Forms.TreeNode
        Dim vChild As System.Windows.Forms.TreeNode
        Dim I As Integer
        Dim j As Integer
        Dim vTabNum As Integer
        Dim vTabSelectText As String = ""
        Dim vTabSelect As Integer
        Dim vSelectedFrame As New System.Windows.Forms.GroupBox




        'Get Root Node for selected tab
        Call GetTreeRoot(tvTreeView.SelectedNode, vRoot)

        'Get Text of Selected Tab
        vTabSelectText = GetTabSelectText(tvTreeView.SelectedNode)

        'Initialize Tabs/Frames
        Call InitializeTabFrames()

        'Set the tab info
        vTabNum = 0
        vTabSelect = -1
        If vRoot.GetNodeCount(False) > 0 Then

            'If any data fields exist, the first tab should be "General"
            For I = 0 To vRoot.GetNodeCount(False) - 1
                If I = 0 Then
                    vChild = vRoot.FirstNode
                Else
                    vChild = vChild.NextNode
                End If

                'Are there any fields under the root?  If so, create a "General" tab.  DO THIS FIRST!!
                If vChild.GetNodeCount(False) = 0 Then
                    'Make tab visible
                    If (Me.tbReferralData.TabPages.IndexOf(tabPages(vTabNum)) < 0) Then

                        Me.tbReferralData.TabPages.Add(tabPages(vTabNum))
                        'Name the tab
                        Me.tbReferralData.TabPages.Item(vTabNum).Text = vRoot.Text '"General"

                        'Give the tab focus so we can display the frame
                        Me.tbReferralData.SelectedIndex = vTabNum

                        'Select this tab if the selected item is on it
                        If vTabSelectText = vChild.Text Then
                            vTabSelect = vTabNum
                        End If

                    End If

                    'Increment the tab number
                    vTabNum = vTabNum + 1

                    'We only need one "General" tab, so exit the loop
                    Exit For
                End If
            Next I

            'Is it a group?  If so, we need to create a tab for each.
            For I = 0 To vRoot.GetNodeCount(False) - 1
                If I = 0 Then
                    vChild = vRoot.FirstNode
                Else
                    vChild = vChild.NextNode
                End If

                If vChild.GetNodeCount(False) > 0 Then
                    'Make tab visible
                    If (Me.tbReferralData.TabPages.IndexOf(tabPages(vTabNum)) < 0) Then

                        Me.tbReferralData.TabPages.Add(tabPages(vTabNum))

                        'Name the tab
                        Me.tbReferralData.TabPages.Item(vTabNum).Text = vChild.Text

                        'Give the tab focus so we can display the frame
                        Me.tbReferralData.SelectedIndex = vTabNum

                        'Select this tab if the selected item is on it
                        If vTabSelectText = vChild.Text Then
                            vTabSelect = vTabNum
                        End If
                    End If
                    'Increment the tab number
                    vTabNum = vTabNum + 1
                End If
            Next I

            'Select the tab for the selected tree node
            Me.tbReferralData.SelectedIndex = IIf(vTabSelect = -1, 0, vTabSelect)
        End If

        'Display correct Frame on tab
        'drh FSMod 06/05/03 - Changed to Me.fmDataFrame.UBound from Me.fmDataFrame.Count - 1
        For j = 0 To Me.fmDataFrame.UBound
            If Me.fmDataFrame(j).Tag = "t" & CStr(IIf(vTabSelect = -1, 0, vTabSelect)) & vRoot.Text Then
                Me.fmDataFrame(j).Visible = True
                Me.fmDataFrame(j).Location = New System.Drawing.Point(4, 4)
                vSelectedFrame = Me.fmDataFrame(j)
                Exit For
            End If
        Next j

        'Set the focus to the selected control (ie. Field node selected) or first control (ie. Group node selected)
        Call SetDataFocus(vSelectedFrame)


        'drh FSMod 06/05/03
        Exit Function

        'drh FSMod 06/05/03 - Added ErrorNextI
ErrorNextI:
        If Err.Number = 340 Then
            j = j + 1
            Resume
        Else
            Resume Next
        End If

    End Function

    Public Function Find(ByRef vCompareText As String) As Boolean
        Dim found As Boolean = False


        'Dim dataRTF As RichTextBox
        Dim richTextBoxOptions As RichTextBoxFinds = System.Windows.Forms.RichTextBoxFinds.WholeWord + System.Windows.Forms.RichTextBoxFinds.MatchCase

        For Each dataRTF As RichTextBox In DataRTFArray
            If dataRTF.Tag = "SecondaryTriageHX" Or dataRTF.Tag = "SecondaryCircumstanceOfDeath" Or dataRTF.Tag = "SecondaryMedicalHistory" Or dataRTF.Tag = "SecondaryPhysicalAppearance" Or dataRTF.Tag = "SecondarySubstanceAbuseDetail" Then
                If dataRTF.Find(vCompareText, richTextBoxOptions) <> -1 Then
                    found = True
                    Return found
                End If

            End If

        Next
        'For I As Short = 0 To DataRTFArray.UBound
        '    If Not IsNothing(DataRTFArray(I)) Then
        '        dataRTF = DataRTFArray(I)
        '        If dataRTF.Tag = "SecondaryTriageHX" Or dataRTF.Tag = "SecondaryCircumstanceOfDeath" Or dataRTF.Tag = "SecondaryMedicalHistory" Or dataRTF.Tag = "SecondaryPhysicalAppearance" Or dataRTF.Tag = "SecondarySubstanceAbuseDetail" Then
        '            If dataRTF.Find(vCompareText, richTextBoxOptions) <> -1 Then
        '                found = True
        '                Return found
        '            End If

        '        End If
        '    End If
        'Next I
        Return found


    End Function
    Public Function ProcessDeletedSecondaryMedication() As Object

        '7/03/07 bret 8.4.3.8 only delete the medication that were deleted
        Dim LoopCount As Integer
        Dim MedicationID As Integer

        For LoopCount = 0 To UBound(DeletedSecondaryMedicationList)
            If DeletedSecondaryMedicationList(LoopCount) > 0 Then
                MedicationID = DeletedSecondaryMedicationList(LoopCount)
                Call modStatSave.DeleteSecondaryMedication(MedicationID, (Me.CallId))
            End If

        Next LoopCount
    End Function

    Private Sub tvTreeView_AfterSelect(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TreeViewEventArgs) Handles tvTreeView.AfterSelect
        Call SetDataTabs()
    End Sub

    Private Sub ctlSecondaryDisposition1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub


    Private Sub lstAvailableMeds_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstAvailableMeds.Enter
        txtlstViewAvailableMeds = ""
    End Sub
    Private Sub lstAvailableMeds_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstAvailableMeds.Click
        txtlstViewAvailableMeds = ""
    End Sub
    Private Sub lstAvailableMeds_OnKeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles lstAvailableMeds.KeyPress

        Dim indexValue As Integer
        txtlstViewAvailableMeds = txtlstViewAvailableMeds + e.KeyChar

        indexValue = lstAvailableMeds.FindString(txtlstViewAvailableMeds)
        If indexValue > -1 Then
            lstAvailableMeds.SelectedIndex = -1
            lstAvailableMeds.SelectedIndex = indexValue
            'lstAvailableMeds.

        End If
        e.Handled = True
    End Sub

    Private Sub cboSecondaryFamilyApproach_SelectionChangeCommitted(ByVal eventSender As System.Object, ByVal e As System.EventArgs) Handles cboSecondaryFamilyApproach.SelectionChangeCommitted
        '************************************************************************************
        'Name: cboSecondaryFamilyApproach_Click
        'Date Created: '1/16/03                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Determines FSCase Approach Billiong
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vSecondaryFamilyApproachCount As Integer = 0

        If eventSender.Name = Me.cboSecondaryFamilyApproach.Name Then
            'ccarroll 10/27/2010 - Added TryParse to FamilyApproach count. Was using cdo Index id (zero based) 
            Int32.TryParse(Me.cboSecondaryFamilyApproach.Text, vSecondaryFamilyApproachCount)
            vField1 = "@FSCaseBillApproachCount"

            vQuery = "EXEC UpdateFSCase " & vField1 & " = " & vSecondaryFamilyApproachCount & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"
            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
    End Sub

    Private Sub cboSecondaryMedSoc_SelectionChangeCommitted(ByVal eventSender As System.Object, ByVal e As System.EventArgs) Handles cboSecondaryMedSoc.SelectionChangeCommitted
        '************************************************************************************
        'Name: cboSecondaryMedSoc_Click
        'Date Created: '1/16/03                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Determines FSCase Status for MedSoc
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vSecondaryMedSocCount As Integer = 0
        If eventSender.Name = Me.cboSecondaryMedSoc.Name Then
            'ccarroll 10/27/2010 - Added TryParse to MedSoc count. Was using cdo Index id (zero based) 
            Int32.TryParse(Me.cboSecondaryMedSoc.Text, vSecondaryMedSocCount)
            vField1 = "@FSCaseBillMedSocCount"
            vQuery = "EXEC UpdateFSCase " & vField1 & " = " & vSecondaryMedSocCount & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"

            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

    End Sub

    Private Sub cboSecondaryCryolifeFormCompleted_SelectionChangeCommitted(ByVal eventSender As System.Object, ByVal e As System.EventArgs) Handles cboSecondaryCryolifeFormCompleted.SelectionChangeCommitted
        '************************************************************************************
        'Name: cboSecondaryCryolifeFormCompleted_Click
        'Date Created: '1/16/03                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Determines Billing for Cryo Form
        '
        'Stored Procedures: UpdateFSCase
        '====================================================================================
        'Date Changed: 07/5/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vQuery As String = ""
        Dim vField1 As String = ""
        Dim vSecondaryCryolifeFormCompletedCount As Integer = 0

        If eventSender.Name = Me.cboSecondaryCryolifeFormCompleted.Name Then
            'ccarroll 10/27/2010 - Added TryParse to SecondaryCryolifeFormCompleted count.
            Int32.TryParse(Me.cboSecondaryCryolifeFormCompleted.Text, vSecondaryCryolifeFormCompletedCount)
            vField1 = "@FSCaseBillCryoFormCount"

            vQuery = "EXEC UpdateFSCase " & vField1 & " = " & vSecondaryCryolifeFormCompletedCount & ", @CallId = " & Me.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @timeZone = '" & AppMain.ParentForm.TimeZone & "'" & ";"

            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
    End Sub

    Private Sub _DataTextArray_24_TextChanged(sender As System.Object, e As System.EventArgs) Handles _DataTextArray_24.TextChanged
        '************************************************************************************
        'Name: _DataTextArray_24_TextChanged
        'Date Created: '10/28/2014                      Created by: Mike Berenson
        'Release: Unknown                               Bug: 18963
        'Description: Adds TextChanged Event To TextBox: _DataTextArray_24_TextChanged
        '====================================================================================
        DisableAgeFieldsAsNeeded()
    End Sub

    Private Sub DisableAgeFieldsAsNeeded()
        '************************************************************************************
        'Name: DisableAgeFieldsAsNeeded
        'Date Created: '10/28/2014                      Created by: Mike Berenson
        'Release: Unknown                               Bug: 18963
        'Description: Disables Age & Age Unit Fields If A Valid DateOfBirth Is Entered
        '====================================================================================

        'Make sure DateOfBirth & Age Are Enabled
        Dim isDobEntered As Boolean
        Dim isDobValid As Boolean
        isDobEntered = _DataTextArray_24.Enabled And Len(_DataTextArray_24.Text) > 0
        isDobValid = _DataTextArray_24.Enabled And Len(_DataTextArray_24.Text) = 10 And IsDate(_DataTextArray_24.Text)

        'Enable/Disable Age Controls
        If isDobEntered And isDobValid Then
            modControl.Disable(_DataTextArray_25)
            modControl.Disable(_DataComboArray_88)
        Else
            modControl.Enable(_DataTextArray_25)
            modControl.Enable(_DataComboArray_88)
        End If

    End Sub

    Private Sub cmdDonorTrac_TabIndexChanged(sender As Object, e As EventArgs) Handles cmdDonorTrac.TabIndexChanged

    End Sub

    Private Sub BtnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        CmdOK_Click(sender, e)
    End Sub
End Class
