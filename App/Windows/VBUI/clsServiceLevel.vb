Option Strict Off
Option Explicit On
Public Class clsServiceLevel

    Public ID As Integer
    Public Name As String

    Public AssignedOrgs As Object

    Public TriageLevel As Short
    Public OTE_MROLevel As Short
    Public TE_MROLevel As Short
    Public E_MROLevel As Short

    Public LastName As Short
    Public FirstName As Short
    Public NameMI As Short
    Public RecordNum As Short
    Public SSN As Short
    Public Gender As Short
    Public Age As Short
    Public Weight As Short
    Public WeightAgeUpperLimit As Short
    Public Race As Short
    Public Vent As Short
    Public HeartBeat As Short '01/06/04 mds: Added for heartbeat field
    Public ExcludePrevVent As Short
    Public PrevVentClass As Short
    Public DOB As Short
    Public DOBILB As Short
    Public DOA As Short
    Public DeathDate As Short
    Public DeathTime As Short
    Public BrainDeathDate As Short
    Public BrainDeathTime As Short
    Public AdmitDate As Short
    Public AdmitTime As Short
    Public CauseOfDeath As Short
    Public SpecificCauseofDeath As Short

    Public CheckRegistryMode As CheckRegistryMode

    Public CoronerInfo As Short
    Public AttendingMD As Short
    Public PronouncingMD As Short
    Public AttendingMDPhone As Short
    Public PronouncingMDPhone As Short

    Public EmailDisposition As Short ' Added for ver. 7.7.2 to hold email disposition value.  12/8/04 - SAP

    Public ApproachMethod As Short
    Public ApproachOTEPrompt As Short
    Public ApproachTEPrompt As Short
    Public ApproachEPrompt As Short
    Public ApproachROPrompt As Short

    Public ApproachBy As Short
    Public NOKName As Short
    Public NOKRelation As Short
    Public NOKPhone As Short
    Public NOKAddress As Short
    Public NOKConsent As Short 'T.T 8/18/2004 added for NOK consent info
    Public NOKRegistration As Short 'T.T 8/18/2004 added for NOK registration

    Public AppropriateOrgan As Short
    Public AppropriateBone As Short
    Public AppropriateTissue As Short
    Public AppropriateSkin As Short
    Public AppropriateValves As Short
    Public AppropriateEyes As Short
    Public AppropriateResearch As Short

    Public ApproachOrgan As Short
    Public ApproachBone As Short
    Public ApproachTissue As Short
    Public ApproachSkin As Short
    Public ApproachValves As Short
    Public ApproachEyes As Short
    Public ApproachResearch As Short

    Public ConsentOrgan As Short
    Public ConsentBone As Short
    Public ConsentTissue As Short
    Public ConsentSkin As Short
    Public ConsentValves As Short
    Public ConsentEyes As Short
    Public ConsentResearch As Short

    Public RecoveryOrgan As Short
    Public RecoveryBone As Short
    Public RecoveryTissue As Short
    Public RecoverySkin As Short
    Public RecoveryValves As Short
    Public RecoveryEyes As Short
    Public RecoveryResearch As Short

    Public CheckDupName As Boolean

    Public Parent As Object


    Public CustomPromptOn As Short

    Public AlertField1 As String
    Public AlertField2 As String

    Public FieldLabel1 As String
    Public FieldLabel2 As String
    Public FieldLabel3 As String
    Public FieldLabel4 As String
    Public FieldLabel5 As String
    Public FieldLabel6 As String
    Public FieldLabel7 As String
    Public FieldLabel8 As String
    Public FieldLabel9 As String
    Public FieldLabel10 As String
    Public FieldLabel11 As String
    Public FieldLabel12 As String
    Public FieldLabel13 As String
    Public FieldLabel14 As String
    Public FieldLabel15 As String
    Public FieldLabel16 As String

    Public ListField9 As New Object
    Public ListField10 As New Object
    Public ListField11 As New Object
    Public ListField12 As New Object
    Public ListField13 As New Object
    Public ListField14 As New Object
    Public ListField15 As New Object
    Public ListField16 As New Object

    Public SecondaryOn As Short

    Public SecondaryAlert As String
    Public SecondaryHistory As Short
    Public Hemodilution As Short

    Public FaxYN As Short
    Public NurseScript As String
    Public OrganizationId As Integer
    Public FaxId As Integer
    Public PersonID As Integer
    Public Retries As Short
    Public DocumentName As String
    Public RegCheckRegistry As Short
    Public ApproachLevel As Short 'T.T 08/21/06 added to approach Service Level
    Public DisableASPSave As Short 'T.T 11/13/2006 added to service level Diable the Save for asp clients
    Public AlwaysPopRegistry As Boolean 'T.T 05/16/2007 added to pop multiples screen everytime
    Public SecondaryTBIPrefix As String 'ccarroll 05/31/2007 - StatTrac 8.4 release
    Public VerifyWeight As Short 'T.T 06/10/2007 verify Weight 8.4 req 2.4
    Public VerifySex As Short 'T.T 06/10/2007 verify Sex 8.4 req 2.4
    Public PNEAllowSaveWithoutContactRequired 'ccarroll 0913/2011 CCRST151
    Public DCDPotentialMessageEnabled
    Public PendingCase

    'drh FSMod 06/23/03
    Public EyeCareReminder As String

    Public Function GetData() As Object

        '====================================================================================
        'Date Changed: 6/17/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Added new referral screen fields. MD Phone, Brain Death Date/time,
        '              Specific COD, Patient MI
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/07/2007                          Changed by: Thien Ta
        'Release #: 8.4                               Requirement:3.4.1,3.4.11, 3.4.1.1.1, 3.4.1.1.2, 3.4.1.2, 3.4.1.3
        'Description:  Added VerifyWeight and Verify Gender
        '====================================================================================
        On Error GoTo localError

        Dim Query As String = ""
        Dim ReturnArray As New Object
        Dim RS As New Object

        If Me.ID = -1 Then
            GetData = NO_DATA
            Exit Function
        End If

        Query = "SELECT * " & "FROM ServiceLevel " & "WHERE ServiceLevelID = " & Me.ID

        GetData = modODBC.Exec(Query, ReturnArray, , True, RS)

        If RS.EOF <> True Then

            Me.Name = modConv.NullToText(RS("ServiceLevelGroupName").Value)

            Me.TriageLevel = modConv.TextToInt(RS("ServiceLevelTriageLevel").Value)
            Me.OTE_MROLevel = modConv.TextToInt(RS("ServiceLevelOTEMROLevel").Value)
            Me.TE_MROLevel = modConv.TextToInt(RS("ServiceLevelTEMROLevel").Value)
            Me.E_MROLevel = modConv.TextToInt(RS("ServiceLevelEMROLevel").Value)

            Me.LastName = modConv.TextToInt(RS("ServiceLevelLastName").Value)
            Me.FirstName = modConv.TextToInt(RS("ServiceLevelFirstName").Value)
            Me.NameMI = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelDonorNameMI").Value))
            Me.RecordNum = modConv.TextToInt(RS("ServiceLevelRecNum").Value)
            Me.SSN = modConv.TextToInt(RS("ServiceLevelSSN").Value)
            Me.Gender = modConv.TextToInt(RS("ServiceLevelGender").Value)
            Me.Age = modConv.TextToInt(RS("ServiceLevelAge").Value)
            Me.Weight = modConv.TextToInt(RS("ServiceLevelWeight").Value)
            Me.WeightAgeUpperLimit = modConv.TextToInt(RS("ServiceLevelWeightAgeLimit").Value)
            Me.Race = modConv.TextToInt(RS("ServiceLevelRace").Value)
            Me.Vent = modConv.TextToInt(RS("ServiceLevelVent").Value)
            '01/06/04 mds Added HeartBeat as a ServiceLevel defined field
            Me.HeartBeat = modConv.TextToInt(RS("ServiceLevelHeartBeat").Value)
            Me.ExcludePrevVent = modConv.TextToInt(RS("ServiceLevelExcludePrevVent").Value)
            Me.PrevVentClass = modConv.TextToInt(RS("ServiceLevelPrevVentClass").Value)
            Me.DOB = modConv.TextToInt(RS("ServiceLevelDOB").Value)
            Me.DOBILB = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelDOB_ILB").Value))
            Me.DOA = modConv.TextToInt(RS("ServiceLevelDOA").Value)
            Me.DeathDate = modConv.TextToInt(RS("ServiceLevelDeathDate").Value)
            Me.DeathTime = modConv.TextToInt(RS("ServiceLevelDeathTime").Value)
            Me.BrainDeathDate = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelDonorBrainDeathDate").Value))
            Me.BrainDeathTime = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelDonorBrainDeathTime").Value))
            Me.AdmitDate = modConv.TextToInt(RS("ServiceLevelAdmitDate").Value)
            Me.AdmitTime = modConv.TextToInt(RS("ServiceLevelAdmitTime").Value)
            Me.CauseOfDeath = modConv.TextToInt(RS("ServiceLevelCOD").Value)
            Me.SpecificCauseofDeath = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelDonorSpecificCOD").Value))
            Me.CheckRegistryMode = modConv.TextToInt(RS("ServiceLevelCheckRegistry").Value)

            Me.CoronerInfo = modConv.TextToLng(RS("ServiceLevelCoroner").Value)
            Me.AttendingMD = modConv.TextToLng(RS("ServiceLevelAttendingMD").Value)
            Me.PronouncingMD = modConv.TextToLng(RS("ServiceLevelPronouncingMD").Value)
            Me.AttendingMDPhone = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelAttendingMDPhone").Value))
            Me.PronouncingMDPhone = modConv.TextToInt(modConv.NullToText(RS("ServiceLevelPronouncingMDPhone").Value))

            Me.ApproachMethod = modConv.TextToInt(RS("ServiceLevelApproachMethod").Value)

            Me.ApproachOTEPrompt = modConv.TextToInt(RS("ServiceLevelApproachOTEPrompt").Value)
            Me.ApproachTEPrompt = modConv.TextToInt(RS("ServiceLevelApproachTEPrompt").Value)
            Me.ApproachEPrompt = modConv.TextToInt(RS("ServiceLevelApproachEPrompt").Value)
            Me.ApproachROPrompt = modConv.TextToInt(RS("ServiceLevelApproachROPrompt").Value)

            Me.ApproachBy = modConv.TextToInt(RS("ServiceLevelApproachBy").Value)
            Me.NOKName = modConv.TextToInt(RS("ServiceLevelNOK").Value)
            Me.NOKRelation = modConv.TextToInt(RS("ServiceLevelRelation").Value)
            Me.NOKPhone = modConv.TextToInt(RS("ServiceLevelNOKPhone").Value)
            Me.NOKAddress = modConv.TextToLng(RS("ServiceLevelNOKAddress").Value)
            Me.NOKConsent = modConv.TextToLng(RS("ServiceLevelNOKConsent").Value) 'T.T 8/18/2004 nok consent
            Me.NOKRegistration = modConv.TextToLng(RS("ServiceLevelNOKRegistration").Value) 'T.T 8/18/2004 nok registration

            Me.AppropriateOrgan = modConv.TextToInt(RS("ServiceLevelAppropriateOrgan").Value)
            Me.AppropriateBone = modConv.TextToInt(RS("ServiceLevelAppropriateBone").Value)
            Me.AppropriateTissue = modConv.TextToInt(RS("ServiceLevelAppropriateTissue").Value)
            Me.AppropriateSkin = modConv.TextToInt(RS("ServiceLevelAppropriateSkin").Value)
            Me.AppropriateValves = modConv.TextToInt(RS("ServiceLevelAppropriateValves").Value)
            Me.AppropriateEyes = modConv.TextToInt(RS("ServiceLevelAppropriateEyes").Value)
            Me.AppropriateResearch = modConv.TextToInt(RS("ServiceLevelAppropriateRsch").Value)

            Me.ApproachOrgan = modConv.TextToInt(RS("ServiceLevelApproachOrgan").Value)
            Me.ApproachBone = modConv.TextToInt(RS("ServiceLevelApproachBone").Value)
            Me.ApproachTissue = modConv.TextToInt(RS("ServiceLevelApproachTissue").Value)
            Me.ApproachSkin = modConv.TextToInt(RS("ServiceLevelApproachSkin").Value)
            Me.ApproachValves = modConv.TextToInt(RS("ServiceLevelApproachValves").Value)
            Me.ApproachEyes = modConv.TextToInt(RS("ServiceLevelApproachEyes").Value)
            Me.ApproachResearch = modConv.TextToInt(RS("ServiceLevelApproachRsch").Value)

            Me.ConsentOrgan = modConv.TextToInt(RS("ServiceLevelConsentOrgan").Value)
            Me.ConsentBone = modConv.TextToInt(RS("ServiceLevelConsentBone").Value)
            Me.ConsentTissue = modConv.TextToInt(RS("ServiceLevelConsentTissue").Value)
            Me.ConsentSkin = modConv.TextToInt(RS("ServiceLevelConsentSkin").Value)
            Me.ConsentValves = modConv.TextToInt(RS("ServiceLevelConsentValves").Value)
            Me.ConsentEyes = modConv.TextToInt(RS("ServiceLevelConsentEyes").Value)
            Me.ConsentResearch = modConv.TextToInt(RS("ServiceLevelConsentRsch").Value)

            Me.RecoveryOrgan = modConv.TextToInt(RS("ServiceLevelRecoveryOrgan").Value)
            Me.RecoveryBone = modConv.TextToInt(RS("ServiceLevelRecoveryBone").Value)
            Me.RecoveryTissue = modConv.TextToInt(RS("ServiceLevelRecoveryTissue").Value)
            Me.RecoverySkin = modConv.TextToInt(RS("ServiceLevelRecoverySkin").Value)
            Me.RecoveryValves = modConv.TextToInt(RS("ServiceLevelRecoveryValves").Value)
            Me.RecoveryEyes = modConv.TextToInt(RS("ServiceLevelRecoveryEyes").Value)
            Me.RecoveryResearch = modConv.TextToInt(RS("ServiceLevelRecoveryRsch").Value)

            '9/27/01 drh
            Me.FaxYN = modConv.TextToInt(RS("ServiceLevelDonorIntentFaxYN").Value)
            Me.NurseScript = modConv.NullToText(RS("ServiceLevelDonorIntentNurseScript").Value)
            Me.OrganizationId = modConv.TextToInt(RS("ServiceLevelDonorIntentOrganizationId").Value)
            Me.FaxId = modConv.TextToInt(RS("ServiceLevelDonorIntentFaxId").Value)
            Me.PersonID = modConv.TextToInt(RS("ServiceLevelDonorIntentPersonId").Value)
            Me.Retries = modConv.TextToInt(RS("ServiceLevelDonorIntentRetries").Value)
            Me.DocumentName = modConv.NullToText(RS("ServiceLevelDonorIntentDocumentName").Value)

            '10/11/01 drh
            Me.RegCheckRegistry = modConv.TextToInt(RS("ServiceLevelRegCheckRegistry").Value)

            'drh FSMod 06/23/03
            Me.EyeCareReminder = modConv.NullToText(RS("ServiceLevelEyeCareReminder").Value)

            'Added in conjunction with Email capability.  ver. 7.7.2  12/9/04 - SAP
            Me.EmailDisposition = modConv.TextToInt(RS("ServiceLevelEmailDisposition").Value)

            'T.T 08/21/06 added Service Level Approach
            Me.ApproachLevel = modConv.TextToInt(RS("ServiceLevelApproachLevel").Value)
            'T.T 11/13/06 added Service Level for Disable asp save
            Me.DisableASPSave = modConv.TextToInt(RS("ServiceLevelDisableASPSave").Value)
            'T.T 05/17/2007 added Service Level for always pop registry
            Me.AlwaysPopRegistry = If(modConv.TextToInt(RS("ServiceLevelAlwaysPopRegistry").Value) = -1, True, False)
            'T.T 06/10/2007 added ServiceLevel for R/O checks req 2.4 release 8.4
            Me.VerifyWeight = modConv.TextToInt(RS("ServiceLevelVerifyWeight").Value)
            Me.VerifySex = modConv.TextToInt(RS("ServiceLevelVerifySex").Value)

            Me.PNEAllowSaveWithoutContactRequired = modConv.TextToInt(RS("ServiceLevelPNEAllowSaveWithoutContactRequired").Value)
            Me.DCDPotentialMessageEnabled = modConv.TextToInt(RS("ServiceLevelDCDPotentialMessageEnabled").Value)
            Me.PendingCase = modConv.TextToInt(RS("ServiceLevelPendingCase").Value)

        End If

        'Get the custom data
        Call GetCustom()

        'Get the secondary data
        Call GetSecondary()

        Exit Function

localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err, Me.ID)
        Resume Next

    End Function
    Public Function GetCustom() As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ReturnArray As New Object

        If Me.ID = -1 Then
            GetCustom = NO_DATA
            Exit Function
        End If

        Query = "SELECT * " & "FROM ServiceLevelCustomField " & "WHERE ServiceLevelID = " & Me.ID

        GetCustom = modODBC.Exec(Query, ReturnArray)

        If GetCustom = NO_DATA Then
            Exit Function
        End If

        Me.CustomPromptOn = ReturnArray(0, 1)

        Me.AlertField1 = ReturnArray(0, 2)
        Me.AlertField2 = ReturnArray(0, 3)

        Me.FieldLabel1 = ReturnArray(0, 4)
        Me.FieldLabel2 = ReturnArray(0, 5)
        Me.FieldLabel3 = ReturnArray(0, 6)
        Me.FieldLabel4 = ReturnArray(0, 7)
        Me.FieldLabel5 = ReturnArray(0, 8)
        Me.FieldLabel6 = ReturnArray(0, 9)
        Me.FieldLabel7 = ReturnArray(0, 10)
        Me.FieldLabel8 = ReturnArray(0, 11)
        Me.FieldLabel9 = ReturnArray(0, 12)
        If Me.FieldLabel9 <> "" Then
            Call GetCustomList(ListField9, 9)
        End If
        Me.FieldLabel10 = ReturnArray(0, 13)
        If Me.FieldLabel10 <> "" Then
            Call GetCustomList(ListField10, 10)
        End If
        Me.FieldLabel11 = ReturnArray(0, 14)
        If Me.FieldLabel11 <> "" Then
            Call GetCustomList(ListField11, 11)
        End If
        Me.FieldLabel12 = ReturnArray(0, 15)
        If Me.FieldLabel12 <> "" Then
            Call GetCustomList(ListField12, 12)
        End If
        Me.FieldLabel13 = ReturnArray(0, 16)
        If Me.FieldLabel13 <> "" Then
            Call GetCustomList(ListField13, 13)
        End If
        Me.FieldLabel14 = ReturnArray(0, 17)
        If Me.FieldLabel14 <> "" Then
            Call GetCustomList(ListField14, 14)
        End If
        Me.FieldLabel15 = ReturnArray(0, 18)
        If Me.FieldLabel15 <> "" Then
            Call GetCustomList(ListField15, 15)
        End If
        Me.FieldLabel16 = ReturnArray(0, 19)
        If Me.FieldLabel16 <> "" Then
            Call GetCustomList(ListField16, 16)
        End If


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetSecondary() As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ReturnArray As New Object

        If Me.ID = -1 Then
            GetSecondary = NO_DATA
            Exit Function
        End If

        Query = "SELECT * " & "FROM ServiceLevelSecondary " & "WHERE ServiceLevelID = " & Me.ID

        GetSecondary = modODBC.Exec(Query, ReturnArray)

        If GetSecondary = NO_DATA Then
            Exit Function
        End If

        Me.SecondaryOn = ReturnArray(0, 1)

        Me.SecondaryAlert = ReturnArray(0, 2)
        Me.SecondaryHistory = ReturnArray(0, 3)
        Me.Hemodilution = ReturnArray(0, 4)
        'ccarroll 06/05/2007 StatTrac 8.4 release Requirement 3.6 TBI
        Me.SecondaryTBIPrefix = ReturnArray(0, 6)


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function


    Public Function GetCustomList(ByRef pvList As Object, ByRef pvListField As Object) As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ReturnArray As New Object

        If Me.ID = -1 Then
            GetCustomList = NO_DATA
            Exit Function
        End If

        Query = "SELECT ServiceLevelID, ServiceLevelListItem " & "FROM ServiceLevelCustomList " & "WHERE ServiceLevelID = " & Me.ID & "AND ServiceLevelListField = " & pvListField

        GetCustomList = modODBC.Exec(Query, ReturnArray)

        If GetCustomList = NO_DATA Then
            Exit Function
        End If

        pvList = ReturnArray

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function


    Public Function CheckOrgAssociation(ByRef OrgID As Object) As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ResultsArray As New Object

        Query = "SELECT DISTINCT ServiceLevelID " & "FROM ServiceLevel30Organization " & "WHERE OrganizationID = " & OrgID & " " & "AND ServiceLevelID = " & Me.ID

        CheckOrgAssociation = modODBC.Exec(Query, ResultsArray)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function


    Public Function GetAssignedOrgs(Optional ByRef pcList As Control = Nothing) As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim Results As New Object

        Query = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName " & "FROM ServiceLevel30Organization, Organization, OrganizationType, State " & "WHERE Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "AND Organization.StateID = State.StateID " & "AND ServiceLevel30Organization.OrganizationID = Organization.OrganizationID " & "AND ServiceLevel30Organization.ServiceLevelID = " & Me.ID & " " & "ORDER BY Organization.OrganizationName ASC"

        GetAssignedOrgs = modODBC.Exec(Query, Results)

        Dim List As System.Windows.Forms.Control
        If GetAssignedOrgs = SUCCESS Then

            Me.AssignedOrgs = Results

            If Not IsNothing(pcList) Then
                List = pcList
                If TypeOf pcList Is System.Windows.Forms.ListView Then
                    Call modControl.SetListViewRows(Results, True, List, False)
                ElseIf TypeOf pcList Is System.Windows.Forms.ComboBox Or TypeOf pcList Is System.Windows.Forms.ListBox Then

                    Call modControl.SetTextID(DirectCast(List, ComboBox), Results)
                End If
            End If

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetAvailableDSNs(Optional ByRef pcList As Object = Nothing) As Object
        '03/10/03 drh - Get Registry Data Sources

        On Error GoTo localError

        Dim Query As String = ""
        Dim Results As New Object

        Query = "SELECT DISTINCT DRDSN.DRDSNID, " & "DRDSN.DRDSNName, DRDSN.DRDSNODBC " & "FROM DRDSN " & "WHERE DRDSNID NOT IN" & "(SELECT DRDSNID FROM ServiceLevelDRDSN " & "WHERE ServiceLevelDRDSN.ServiceLevelID = " & Me.ID & ") " & "ORDER BY DRDSN.DRDSNName ASC"

        GetAvailableDSNs = modODBC.Exec(Query, Results)

        Dim List As System.Windows.Forms.Control
        If GetAvailableDSNs = SUCCESS Then

            If Not IsNothing(pcList) Then
                List = pcList
                If TypeOf pcList Is System.Windows.Forms.ListView Then
                    Call modControl.SetListViewRows(Results, True, List, False)
                ElseIf TypeOf pcList Is System.Windows.Forms.ComboBox Or TypeOf pcList Is System.Windows.Forms.ListBox Then
                    Call modControl.SetTextID(List, Results)
                End If
            End If

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetSelectedDSNs(Optional ByRef pcList As Object = Nothing) As Object
        '03/10/03 drh - Get Registry Data Sources

        On Error GoTo localError

        Dim Query As String = ""
        Dim Results As New Object

        Query = "SELECT DISTINCT DRDSN.DRDSNID, " & "DRDSN.DRDSNName, DRDSN.DRDSNODBC " & "FROM ServiceLevelDRDSN, DRDSN " & "WHERE ServiceLevelDRDSN.DRDSNID = DRDSN.DRDSNID " & "AND ServiceLevelDRDSN.ServiceLevelID = " & Me.ID & " " & "ORDER BY DRDSN.DRDSNName ASC"

        GetSelectedDSNs = modODBC.Exec(Query, Results)

        Dim List As System.Windows.Forms.Control
        If GetSelectedDSNs = SUCCESS Then

            If Not IsNothing(pcList) Then
                List = pcList
                If TypeOf pcList Is System.Windows.Forms.ListView Then
                    Call modControl.SetListViewRows(Results, True, List, False)
                ElseIf TypeOf pcList Is System.Windows.Forms.ComboBox Or TypeOf pcList Is System.Windows.Forms.ListBox Then
                    Call modControl.SetTextID(List, Results)
                End If
            End If

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetDonorIntentPeople(ByRef pcList As Object, ByRef pvServiceLevelId As Object) As Object

        On Error GoTo localError
        Dim Query As String = ""
        Dim Results As New Object

        Query = "SELECT DISTINCT Person.PersonID, " & "Person.PersonFirst + ' ' + Person.PersonLast, " & "Person.PersonFirst, Person.PersonLast " & "From ServiceLevel30Organization " & "JOIN Organization ON ServiceLevel30Organization.OrganizationId = Organization.OrganizationId " & "JOIN Person ON Organization.OrganizationId = Person.OrganizationId " & "Where ServiceLevel30Organization.ServiceLevelId = " & pvServiceLevelId & "AND Organization.OrganizationTypeId = 1 and Person.Inactive <> 1" & "ORDER BY Person.PersonFirst, Person.PersonLast"

        Call modODBC.Exec(Query, Results)

        Dim List As System.Windows.Forms.Control
        If GetAssignedOrgs() = SUCCESS Then

            Me.AssignedOrgs = Results

            If Not IsNothing(pcList) Then
                List = pcList
                If TypeOf pcList Is System.Windows.Forms.ListView Then
                    Call modControl.SetListViewRows(Results, True, List, False)
                ElseIf TypeOf pcList Is System.Windows.Forms.ComboBox Or TypeOf pcList Is System.Windows.Forms.ListBox Then
                    Call modControl.SetTextID(List, Results)
                End If
            End If

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetOrgFaxNumbers(ByRef pcList As Object, ByRef pvOrganizationId As Integer) As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim Results As New Object

        Query = "SELECT FaxId, FaxNumber FROM Fax WHERE OrganizationId = " & pvOrganizationId

        GetOrgFaxNumbers = modODBC.Exec(Query, Results)

        If GetOrgFaxNumbers = SUCCESS Then

            '11/7/01 drh Fixed per Issue #27
            Call modControl.SetTextID(pcList, Results)

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function
    Public Function DeleteOrgAssociation(ByRef pvOrgID As Object) As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim I As Short

        'Delete each row
        Query = Query & "DELETE FROM ServiceLevel30Organization " & "WHERE ServiceLevelID = " & Me.ID & " " & "AND OrganizationID = " & CInt(pvOrgID)

        DeleteOrgAssociation = modODBC.Exec(Query)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function Save() As Object
        '************************************************************************************
        'Name: Save
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves ServiceLevel object variables to DB
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added new variable, EmailDisposition, to function.
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/17/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Added new referral screen fields. MD Phone, Brain Death Date/time,
        '              Specific COD, Patient MI
        '====================================================================================
        '************************************************************************************
        '====================================================================================
        'Date Changed: 6/10/2007                          Changed by: Thien Ta
        'Release #: 8.4                               requirement 2.4
        'Description:  added new serviceLevels for verify weight and sex
        '====================================================================================
        '************************************************************************************

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim I As Integer

        'drh FSMod 06/23/03 - Updated for Eye Care Reminder
        '01/06/04 mds - Updated for HeartBeat from 77 to 78
        'Update to 81 for EmailDisposition, ver. 7.7.2.  12/8/04 - SAP
        'T.T Update to 89 for approachServiceLevel
        'T.T 11/13/2006 Update to 90 for DisableASPSave
        'T.T 05/17/2007 Always pop registry
        'T.T 06/10/2007 Verify sex and weight params 93
        'ccarroll 09/13/2011 ServiceLevelPNEAllowSaveWithoutContactRequired CCRST151
        Dim Params(96) As Object

        I = 0
        Params(I) = Me.Name

        Params(modUtility.Increment(I)) = Me.TriageLevel
        Params(modUtility.Increment(I)) = Me.OTE_MROLevel
        Params(modUtility.Increment(I)) = Me.TE_MROLevel
        Params(modUtility.Increment(I)) = Me.E_MROLevel
        Params(modUtility.Increment(I)) = Me.LastName
        Params(modUtility.Increment(I)) = Me.FirstName
        Params(modUtility.Increment(I)) = Me.NameMI
        Params(modUtility.Increment(I)) = Me.RecordNum
        Params(modUtility.Increment(I)) = Me.SSN
        Params(modUtility.Increment(I)) = Me.Gender
        Params(modUtility.Increment(I)) = Me.Age
        Params(modUtility.Increment(I)) = Me.Weight
        Params(modUtility.Increment(I)) = Me.WeightAgeUpperLimit
        Params(modUtility.Increment(I)) = Me.Race
        Params(modUtility.Increment(I)) = Me.Vent
        Params(modUtility.Increment(I)) = Me.ExcludePrevVent
        Params(modUtility.Increment(I)) = Me.PrevVentClass
        Params(modUtility.Increment(I)) = Me.DeathDate
        Params(modUtility.Increment(I)) = Me.DeathTime
        Params(modUtility.Increment(I)) = Me.BrainDeathDate

        Params(modUtility.Increment(I)) = Me.BrainDeathTime
        Params(modUtility.Increment(I)) = Me.AdmitDate
        Params(modUtility.Increment(I)) = Me.AdmitTime
        Params(modUtility.Increment(I)) = Me.CauseOfDeath
        Params(modUtility.Increment(I)) = Me.SpecificCauseofDeath
        Params(modUtility.Increment(I)) = Me.DOB
        Params(modUtility.Increment(I)) = Me.DOBILB
        Params(modUtility.Increment(I)) = Me.DOA
        Params(modUtility.Increment(I)) = Me.CheckRegistryMode

        Params(modUtility.Increment(I)) = Me.CoronerInfo
        Params(modUtility.Increment(I)) = Me.AttendingMD
        Params(modUtility.Increment(I)) = Me.PronouncingMD
        Params(modUtility.Increment(I)) = Me.AttendingMDPhone
        Params(modUtility.Increment(I)) = Me.PronouncingMDPhone

        Params(modUtility.Increment(I)) = Me.ApproachMethod
        Params(modUtility.Increment(I)) = Me.ApproachOTEPrompt
        Params(modUtility.Increment(I)) = Me.ApproachTEPrompt
        Params(modUtility.Increment(I)) = Me.ApproachEPrompt
        Params(modUtility.Increment(I)) = Me.ApproachROPrompt

        Params(modUtility.Increment(I)) = Me.ApproachBy
        Params(modUtility.Increment(I)) = Me.NOKName
        Params(modUtility.Increment(I)) = Me.NOKRelation
        Params(modUtility.Increment(I)) = Me.NOKPhone
        Params(modUtility.Increment(I)) = Me.NOKAddress
        Params(modUtility.Increment(I)) = Me.NOKConsent 'T.T 8/18/2004 added for nok consent
        Params(modUtility.Increment(I)) = Me.NOKRegistration 'T.T 8/18/2004 added for nok registration

        Params(modUtility.Increment(I)) = Me.AppropriateOrgan
        Params(modUtility.Increment(I)) = Me.AppropriateBone
        Params(modUtility.Increment(I)) = Me.AppropriateTissue
        Params(modUtility.Increment(I)) = Me.AppropriateSkin
        Params(modUtility.Increment(I)) = Me.AppropriateValves
        Params(modUtility.Increment(I)) = Me.AppropriateEyes
        Params(modUtility.Increment(I)) = Me.AppropriateResearch

        Params(modUtility.Increment(I)) = Me.ApproachOrgan
        Params(modUtility.Increment(I)) = Me.ApproachBone
        Params(modUtility.Increment(I)) = Me.ApproachTissue
        Params(modUtility.Increment(I)) = Me.ApproachSkin
        Params(modUtility.Increment(I)) = Me.ApproachValves
        Params(modUtility.Increment(I)) = Me.ApproachEyes
        Params(modUtility.Increment(I)) = Me.ApproachResearch

        Params(modUtility.Increment(I)) = Me.ConsentOrgan
        Params(modUtility.Increment(I)) = Me.ConsentBone
        Params(modUtility.Increment(I)) = Me.ConsentTissue
        Params(modUtility.Increment(I)) = Me.ConsentSkin
        Params(modUtility.Increment(I)) = Me.ConsentValves
        Params(modUtility.Increment(I)) = Me.ConsentEyes
        Params(modUtility.Increment(I)) = Me.ConsentResearch

        Params(modUtility.Increment(I)) = Me.RecoveryOrgan
        Params(modUtility.Increment(I)) = Me.RecoveryBone
        Params(modUtility.Increment(I)) = Me.RecoveryTissue
        Params(modUtility.Increment(I)) = Me.RecoverySkin
        Params(modUtility.Increment(I)) = Me.RecoveryValves
        Params(modUtility.Increment(I)) = Me.RecoveryEyes
        Params(modUtility.Increment(I)) = Me.RecoveryResearch

        '10/11/01 drh
        Params(modUtility.Increment(I)) = Me.FaxYN
        Params(modUtility.Increment(I)) = Me.NurseScript
        Params(modUtility.Increment(I)) = Me.OrganizationId
        Params(modUtility.Increment(I)) = Me.FaxId
        Params(modUtility.Increment(I)) = Me.PersonID
        Params(modUtility.Increment(I)) = Me.Retries
        Params(modUtility.Increment(I)) = Me.DocumentName
        Params(modUtility.Increment(I)) = Me.RegCheckRegistry

        'FSProj drh 5/6/02 - New fields for historical ServiceLevels
        Params(modUtility.Increment(I)) = WORKING_SERVICELEVEL
        Params(modUtility.Increment(I)) = 1
        Params(modUtility.Increment(I)) = IIf(Me.ID = -1, 0, Me.ID)

        'drh FSMod 06/23/03
        Params(modUtility.Increment(I)) = Me.EyeCareReminder

        '01/06/04 mds Added HeartBeat
        Params(modUtility.Increment(I)) = Me.HeartBeat

        'Added in conjunction with email capability.  ver. 7.7.2 12/8/04 - SAP
        Params(modUtility.Increment(I)) = Me.EmailDisposition

        'T.T 08/23/2006 approach serviceLevel
        Params(modUtility.Increment(I)) = Me.ApproachLevel

        'T.T 11/13/2006 servicelevel Disable asp Save
        Params(modUtility.Increment(I)) = Me.DisableASPSave

        'T.T 05/17/2007 serviceleve always pop registry
        Params(modUtility.Increment(I)) = If(Me.AlwaysPopRegistry, -1, 0)

        'T.T 06/10/2007 servicelevel verify sex and weight release 8.4 req 2.4
        Params(modUtility.Increment(I)) = Me.VerifyWeight
        Params(modUtility.Increment(I)) = Me.VerifySex

        Params(modUtility.Increment(I)) = Me.PNEAllowSaveWithoutContactRequired
        Params(modUtility.Increment(I)) = Iif(Me.DCDPotentialMessageEnabled IsNot Nothing, Me.DCDPotentialMessageEnabled, 0)
        Params(modUtility.Increment(I)) = Iif(Me.PendingCase IsNot Nothing, Me.PendingCase, 0)

        'drh FSMod 06/23/03 - Updated for Eye Care Reminder
        '01/06/04 mds: Updated for HeartBeat from 77 to 78
        'Update to 81 for EmailDisposition, ver. 7.7.2.  12/8/04 - SAP
        'T.T 08/23/2006 Update to 89 ApproachServiceLevel
        Dim Fields(96) As Object

        I = 0
        Fields(I) = "ServiceLevelGroupName"

        Fields(modUtility.Increment(I)) = "ServiceLevelTriageLevel"
        Fields(modUtility.Increment(I)) = "ServiceLevelOTEMROLevel"
        Fields(modUtility.Increment(I)) = "ServiceLevelTEMROLevel"
        Fields(modUtility.Increment(I)) = "ServiceLevelEMROLevel"

        Fields(modUtility.Increment(I)) = "ServiceLevelLastName"
        Fields(modUtility.Increment(I)) = "ServiceLevelFirstName"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorNameMI"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecNum"
        Fields(modUtility.Increment(I)) = "ServiceLevelSSN"
        Fields(modUtility.Increment(I)) = "ServiceLevelGender"
        Fields(modUtility.Increment(I)) = "ServiceLevelAge"
        Fields(modUtility.Increment(I)) = "ServiceLevelWeight"
        Fields(modUtility.Increment(I)) = "ServiceLevelWeightAgeLimit"
        Fields(modUtility.Increment(I)) = "ServiceLevelRace"
        Fields(modUtility.Increment(I)) = "ServiceLevelVent"
        Fields(modUtility.Increment(I)) = "ServiceLevelExcludePrevVent"
        Fields(modUtility.Increment(I)) = "ServiceLevelPrevVentClass"
        Fields(modUtility.Increment(I)) = "ServiceLevelDeathDate"
        Fields(modUtility.Increment(I)) = "ServiceLevelDeathTime"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorBrainDeathDate"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorBrainDeathTime"
        Fields(modUtility.Increment(I)) = "ServiceLevelAdmitDate"
        Fields(modUtility.Increment(I)) = "ServiceLevelAdmitTime"
        Fields(modUtility.Increment(I)) = "ServiceLevelCOD"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorSpecificCOD"
        Fields(modUtility.Increment(I)) = "ServiceLevelDOB"
        Fields(modUtility.Increment(I)) = "ServiceLevelDOB_ILB"
        Fields(modUtility.Increment(I)) = "ServiceLevelDOA"
        Fields(modUtility.Increment(I)) = "ServiceLevelCheckRegistry"

        Fields(modUtility.Increment(I)) = "ServiceLevelCoroner"
        Fields(modUtility.Increment(I)) = "ServiceLevelAttendingMD"
        Fields(modUtility.Increment(I)) = "ServiceLevelPronouncingMD"
        Fields(modUtility.Increment(I)) = "ServiceLevelAttendingMDPhone"
        Fields(modUtility.Increment(I)) = "ServiceLevelPronouncingMDPhone"

        Fields(modUtility.Increment(I)) = "ServiceLevelApproachMethod"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachOTEPrompt"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachTEPrompt"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachEPrompt"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachROPrompt"

        Fields(modUtility.Increment(I)) = "ServiceLevelApproachBy"
        Fields(modUtility.Increment(I)) = "ServiceLevelNOK"
        Fields(modUtility.Increment(I)) = "ServiceLevelRelation"
        Fields(modUtility.Increment(I)) = "ServiceLevelNOKPhone"
        Fields(modUtility.Increment(I)) = "ServiceLevelNOKAddress"
        Fields(modUtility.Increment(I)) = "ServiceLevelNOKConsent" 'T.T 8/18/2004 added nok consent
        Fields(modUtility.Increment(I)) = "ServiceLevelNOKRegistration" 'T.T 8/18/2004 added nok registration


        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateOrgan"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateBone"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateTissue"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateSkin"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateValves"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateEyes"
        Fields(modUtility.Increment(I)) = "ServiceLevelAppropriateRsch"

        Fields(modUtility.Increment(I)) = "ServiceLevelApproachOrgan"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachBone"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachTissue"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachSkin"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachValves"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachEyes"
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachRsch"

        Fields(modUtility.Increment(I)) = "ServiceLevelConsentOrgan"
        Fields(modUtility.Increment(I)) = "ServiceLevelConsentBone"
        Fields(modUtility.Increment(I)) = "ServiceLevelConsentTissue"
        Fields(modUtility.Increment(I)) = "ServiceLevelConsentSkin"
        Fields(modUtility.Increment(I)) = "ServiceLevelConsentValves"
        Fields(modUtility.Increment(I)) = "ServiceLevelConsentEyes"

        Fields(modUtility.Increment(I)) = "ServiceLevelConsentRsch"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryOrgan"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryBone"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryTissue"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoverySkin"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryValves"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryEyes"
        Fields(modUtility.Increment(I)) = "ServiceLevelRecoveryRsch"

        '10/11/01 drh
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentFaxYN"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentNurseScript"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentOrganizationId"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentFaxId"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentPersonId"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentRetries"
        Fields(modUtility.Increment(I)) = "ServiceLevelDonorIntentDocumentName"
        Fields(modUtility.Increment(I)) = "ServiceLevelRegCheckRegistry"

        'FSProj drh 5/6/02 - New fields for historical ServiceLevels
        Fields(modUtility.Increment(I)) = "ServiceLevelStatus"
        Fields(modUtility.Increment(I)) = "WorkingStatusUpdatedFlag"
        Fields(modUtility.Increment(I)) = "WorkingServiceLevelId"

        'drh FSMod 06/23/03
        Fields(modUtility.Increment(I)) = "ServiceLevelEyeCareReminder"

        '01/06/04 mds HeartBeat
        Fields(modUtility.Increment(I)) = "ServiceLevelHeartBeat"

        'Added in conjunction with email capability.  ver. 7.7.2 12/8/04 - SAP
        Fields(modUtility.Increment(I)) = "ServiceLevelEmailDisposition"

        'T.T 08/23/3006 added for approach ServiceLevel
        Fields(modUtility.Increment(I)) = "ServiceLevelApproachLevel"

        'T.T 11/13/2006 added for Service Level Disable ASP Save
        Fields(modUtility.Increment(I)) = "ServiceLevelDisableASPSave"

        'T.T 05/17/2007 added for always pop registry servicelevel
        Fields(modUtility.Increment(I)) = "ServiceLevelAlwaysPopRegistry"

        'T.T 06/10/2007 servicelevel weight and sex verify release 8.4 req 2.4
        Fields(modUtility.Increment(I)) = "ServiceLevelVerifyWeight"
        Fields(modUtility.Increment(I)) = "ServiceLevelVerifySex"

        Fields(modUtility.Increment(I)) = "ServiceLevelPNEAllowSaveWithoutContactRequired"
        Fields(modUtility.Increment(I)) = "ServiceLevelDCDPotentialMessageEnabled"
        Fields(modUtility.Increment(I)) = "ServiceLevelPendingCase"


        If Me.CheckDupName Then
            'FSProj drh 5/2/02 - Added AND clause so we only check against Working Service Levels
            Query = "Select ServiceLevelGroupName " & "FROM ServiceLevel " & "WHERE ServiceLevelGroupName = " & modODBC.BuildField(Params(0)) & " AND ServiceLevelStatus = " & WORKING_SERVICELEVEL

            QueryResult = modODBC.Exec(Query, ResultArray)

            If QueryResult = SUCCESS Then
                'This name already exists for this Organization
                Call MsgBox("This name already exists. You may not create this group.", MsgBoxStyle.Exclamation, "Duplicate Group Name")
                Exit Function
            End If
        End If

        'Build and execute the query
        If Me.ID = -1 Then
            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
            Query = "INSERT INTO ServiceLevel (" & Values & ")"

            QueryResult = modODBC.Exec(Query, ResultArray)

        Else
            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "UPDATE ServiceLevel SET " & Values & " WHERE ServiceLevelID = " & Me.ID

            QueryResult = modODBC.Exec(Query)

        End If

        If QueryResult = SUCCESS And Me.ID = -1 Then
            'Get the ID the the record just inserted.
            Me.ID = modConv.TextToLng(ResultArray(0, 0))

            'FSProj drh 5/6/02 - Update the new record's WorkingCriteriaId with the new CriteriaId
            Query = "UPDATE ServiceLevel SET WorkingServiceLevelId = " & Me.ID & " WHERE ServiceLevelId = " & Me.ID
            QueryResult = modODBC.Exec(Query)

            'FSProj drh 5/22/02 - Add Secondary Data Fields/Groups
            Query = "spi_ServiceLevelData " & Me.ID & ",0"
            QueryResult = modODBC.Exec(Query)

        End If

        If QueryResult = SUCCESS Then
            Call Me.SaveCustom()
            Call Me.SaveCustomList()
            Call Me.SaveSecondary()
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveCustom() As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim CustomFieldsExist As Boolean

        Dim Params(19) As Object

        Params(0) = Me.ID
        Params(1) = Me.CustomPromptOn

        Params(2) = Me.AlertField1
        Params(3) = Me.AlertField2

        Params(4) = Me.FieldLabel1
        Params(5) = Me.FieldLabel2
        Params(6) = Me.FieldLabel3
        Params(7) = Me.FieldLabel4
        Params(8) = Me.FieldLabel5
        Params(9) = Me.FieldLabel6
        Params(10) = Me.FieldLabel7
        Params(11) = Me.FieldLabel8
        Params(12) = Me.FieldLabel9
        Params(13) = Me.FieldLabel10
        Params(14) = Me.FieldLabel11
        Params(15) = Me.FieldLabel12
        Params(16) = Me.FieldLabel13
        Params(17) = Me.FieldLabel14
        Params(18) = Me.FieldLabel15
        Params(19) = Me.FieldLabel16

        Dim Fields(19) As Object

        Fields(0) = "ServiceLevelID"

        Fields(1) = "ServiceLevelCustomOn"
        Fields(2) = "ServiceLevelCustomTextAlert"
        Fields(3) = "ServiceLevelCustomListAlert"

        Fields(4) = "ServiceLevelCustomFieldLabel1"
        Fields(5) = "ServiceLevelCustomFieldLabel2"
        Fields(6) = "ServiceLevelCustomFieldLabel3"
        Fields(7) = "ServiceLevelCustomFieldLabel4"
        Fields(8) = "ServiceLevelCustomFieldLabel5"
        Fields(9) = "ServiceLevelCustomFieldLabel6"
        Fields(10) = "ServiceLevelCustomFieldLabel7"
        Fields(11) = "ServiceLevelCustomFieldLabel8"
        Fields(12) = "ServiceLevelCustomFieldLabel9"
        Fields(13) = "ServiceLevelCustomFieldLabel10"
        Fields(14) = "ServiceLevelCustomFieldLabel11"
        Fields(15) = "ServiceLevelCustomFieldLabel12"
        Fields(16) = "ServiceLevelCustomFieldLabel13"
        Fields(17) = "ServiceLevelCustomFieldLabel14"
        Fields(18) = "ServiceLevelCustomFieldLabel15"
        Fields(19) = "ServiceLevelCustomFieldLabel16"

        'Check if custom fields have been saved
        Query = "SELECT ServiceLevelID " & "FROM ServiceLevelCustomField " & "WHERE ServiceLevelID = " & modODBC.BuildField(Me.ID)

        QueryResult = modODBC.Exec(Query, ResultArray)

        If QueryResult = SUCCESS Then
            'This name already exists for this Organization
            CustomFieldsExist = True
        ElseIf QueryResult = NO_DATA Then
            CustomFieldsExist = False
        Else
            SaveCustom = QueryResult
        End If


        'Build and execute the query
        If CustomFieldsExist = False Then
            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
            Query = "INSERT INTO ServiceLevelCustomField (" & Values & ")"

            QueryResult = modODBC.Exec(Query)

        Else
            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "UPDATE ServiceLevelCustomField SET " & Values & " WHERE ServiceLevelID = " & Me.ID

            QueryResult = modODBC.Exec(Query)

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function
    Public Function SaveSecondary() As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim SecondaryExist As Boolean

        Dim Params(5) As Object

        Params(0) = Me.ID
        Params(1) = Me.SecondaryOn
        Params(2) = Me.SecondaryAlert
        Params(3) = Me.SecondaryHistory
        Params(4) = Me.Hemodilution
        Params(5) = Me.SecondaryTBIPrefix 'ccarroll 05/31/2007 - StatTrac 8.4 release

        Dim Fields(5) As Object

        Fields(0) = "ServiceLevelID"

        Fields(1) = "ServiceLevelSecondaryOn"
        Fields(2) = "ServiceLevelSecondaryAlert"
        Fields(3) = "ServiceLevelSecondaryHistory"
        Fields(4) = "ServiceLevelSecondaryHemodilution"
        Fields(5) = "ServiceLevelSecondaryTBIPrefix" 'ccarroll 05/31/2007 - StatTrac 8.4 release

        'Check if custom fields have been saved
        Query = "SELECT ServiceLevelID " & "FROM ServiceLevelSecondary " & "WHERE ServiceLevelID = " & modODBC.BuildField(Me.ID)

        QueryResult = modODBC.Exec(Query, ResultArray)

        If QueryResult = SUCCESS Then
            'This name already exists for this Organization
            SecondaryExist = True
        ElseIf QueryResult = NO_DATA Then
            SecondaryExist = False
        Else
            SaveSecondary = QueryResult
        End If


        'Build and execute the query
        If SecondaryExist = False Then
            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
            Query = "INSERT INTO ServiceLevelSecondary (" & Values & ")"

            QueryResult = modODBC.Exec(Query)

        Else
            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "UPDATE ServiceLevelSecondary SET " & Values & " WHERE ServiceLevelID = " & Me.ID

            QueryResult = modODBC.Exec(Query)

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveCustomList() As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim I As Short

        'Call GetCustom()
        'Delete all custom lists associated with this service level
        Query = "DELETE ServiceLevelCustomList WHERE ServiceLevelID = " & Me.ID
        QueryResult = modODBC.Exec(Query)

        If QueryResult <> SUCCESS Then
            Exit Function
        End If

        'Save each list
        If Not IsNothing(Me.ListField9) Then
            For I = 0 To UBound(Me.ListField9)
                Call Me.SaveCustomListItem(9, Me.ListField9(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField10) Then
            For I = 0 To UBound(Me.ListField10)
                Call Me.SaveCustomListItem(10, Me.ListField10(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField11) Then
            For I = 0 To UBound(Me.ListField11)
                Call Me.SaveCustomListItem(11, Me.ListField11(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField12) Then
            For I = 0 To UBound(Me.ListField12)
                Call Me.SaveCustomListItem(12, Me.ListField12(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField13) Then
            For I = 0 To UBound(Me.ListField13)
                Call Me.SaveCustomListItem(13, Me.ListField13(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField14) Then
            For I = 0 To UBound(Me.ListField14)
                Call Me.SaveCustomListItem(14, Me.ListField14(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField15) Then
            For I = 0 To UBound(Me.ListField15)
                Call Me.SaveCustomListItem(15, Me.ListField15(I, 1))
            Next I
        End If

        If Not IsNothing(Me.ListField16) Then
            For I = 0 To UBound(Me.ListField16)
                Call Me.SaveCustomListItem(16, Me.ListField16(I, 1))
            Next I
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveCustomListItem(ByVal pvFieldNumber As Object, ByVal pvListItem As Object) As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As New Object

        Dim Params(2) As Object

        Params(0) = Me.ID
        Params(1) = pvFieldNumber
        Params(2) = pvListItem

        Dim Fields(2) As Object

        Fields(0) = "ServiceLevelID"
        Fields(1) = "ServiceLevelListField"
        Fields(2) = "ServiceLevelListItem"

        'The record is new and should be inserted.
        Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
        Query = "INSERT INTO ServiceLevelCustomList (" & Values & ")"

        QueryResult = modODBC.Exec(Query)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveOrgAssociation(ByRef pvOrgID As Object) As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim I As Short

        Dim Params(1) As Object
        Dim Fields(1) As Object

        Params(0) = Me.ID
        Params(1) = CInt(pvOrgID)

        Fields(0) = "ServiceLevelID"
        Fields(1) = "OrganizationID"

        'Check if the item to be added already exists
        If Me.CheckOrgAssociation(Params(1)) = NO_DATA Then
            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
            Query = "INSERT INTO ServiceLevel30Organization (" & Values & ");"
            SaveOrgAssociation = modODBC.Exec(Query)
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveDSNAssociations(ByRef pvSelectListArray As Object) As Object
        '03/10/03 drh - Save DSN associations

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim I As Short

        Dim Params(1) As Object
        Dim Fields(1) As Object

        Query = "DELETE ServiceLevelDRDSN WHERE ServiceLevelID = " & Me.ID & "; "

        For I = 0 To UBound(pvSelectListArray, 1)

            Params(0) = Me.ID
            Params(1) = CInt(pvSelectListArray(I, 0))

            Fields(0) = "ServiceLevelID"
            Fields(1) = "DRDSNID"


            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)
            Query = Query & "INSERT INTO ServiceLevelDRDSN (" & Values & "); "

        Next I

        SaveDSNAssociations = modODBC.Exec(Query)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function
End Class