Option Strict Off
Option Explicit On
Option Infer On
Imports System.Collections.Generic
Imports Statline.Stattrac.Framework
Imports Statline.Stattrac.Framework.Validater
Imports Stattrac.UIServices.Donor.Search

Partial Module modStatQuery
    Public Function QueryNOK(ByRef pvForm As FrmReferral) As Short

        '************************************************************************************
        'Name: QueryReferral%
        'Date Created: 07/06/05                          Created by: Char Chaput
        'Release: 8.0                             Task: None
        'Description: Queries the database for NOK information.
        'Returns: Return value of executed query.
        'Params: pvForm = calling form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/08/05                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Added new NOK database table and fields. Broke out name and address fields.
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim RS As New Object

        'Find the NOK belonging to the referral.
        vQuery = "EXEC SELECTNOK @NOKID = " & pvForm.NOKID & " ;"

        Try
            QueryNOK = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        pvForm.NOKFirstName = modConv.NullToText(RS("NOKFirstName").Value)
        pvForm.NOKLastName = modConv.NullToText(RS("NOKLastName").Value)

        'Set the relation combo box with the relationid
        'Call modControl.SelectText(pvForm.CboRelation, modConv.NullToText(RS("NOKApproachRelation").Value))
        pvForm.NOKApproachRelation = modConv.NullToText(RS("NOKApproachRelation").Value)
        pvForm.NOKRefPhone = modConv.NullToText(RS("NOKPhone").Value)
        'pvForm.NOKRefAddress = modConv.NullToText(RS("NOKAddress").Value)
        pvForm.NOKCity = modConv.NullToText(RS("NOKCity").Value)

        'Set the state combo box with the stateid
        'Call modControl.SelectID(pvForm.CboState, RS("NOKStateID").Value)
        pvForm.NOKStateID = modConv.NullToText(RS("NOKStateID").Value)

        pvForm.NOKZip = modConv.NullToText(RS("NOKZip").Value)

    End Function
    Public Function QueryNDRICallSheet(ByRef pvForm As FrmNDRICallSheet) As Short
        'drh NDRI 11/23/03 - New Function
        'T.T 05/03/2005 - new function

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vTimeZoneDif As Short
        Dim vResult As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(pvForm.OrganizationTimeZone)

        'Create the query to get the call sheet data
        vQuery = "SELECT * FROM NDRICallSheet " & "WHERE CallId = " & pvForm.CallId

        Try
            vResult = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS AndAlso ObjectIsValidArray(vParams, 2, 0, 32) Then
            pvForm.FormState = EXISTING_RECORD

            'Set the event data
            pvForm.CallId = vParams(0, 1)
            pvForm.TxtCallDate.Text = VB6.Format(modConv.NullToText(vParams(0, 2)), "mm/dd/yy")
            pvForm.txtCallTime.Text = modConv.NullToText(vParams(0, 3))
            pvForm.TxtDonorNumber.Text = modConv.NullToText(vParams(0, 4))
            pvForm.txtCoordName.Text = modConv.NullToText(vParams(0, 5))
            pvForm.txtSource.Text = modConv.NullToText(vParams(0, 6))
            pvForm.TxtSourcePhone.Text = modConv.NullToText(vParams(0, 7))
            pvForm.txtAge.Text = modConv.NullToText(vParams(0, 8))
            Call modControl.SelectText(pvForm.cboAgeUnit, vParams(0, 9))
            Call modControl.SelectID(pvForm.cboRace, CInt(vParams(0, 10)))
            pvForm.cboGender.Text = modConv.NullToText(vParams(0, 11))
            Call modControl.SelectID(pvForm.cboABO_Rh, CInt(vParams(0, 12)))
            pvForm.txtDOD.Text = VB6.Format(modConv.NullToText(vParams(0, 14)), "mm/dd/yy")
            pvForm.txtTOD.Text = modConv.NullToText(vParams(0, 15))
            pvForm.txtCD4.Text = modConv.NullToText(vParams(0, 16))
            pvForm.txtViralLoad.Text = modConv.NullToText(vParams(0, 17))
            pvForm.txtOtherDiseases.Text = modConv.NullToText(vParams(0, 18))
            Call modControl.SelectID(pvForm.cboSepsis, CInt(vParams(0, 19)))
            Call modControl.SelectID(pvForm.cboChemotherapy, CInt(vParams(0, 20)))
            Call modControl.SelectID(pvForm.cboRadiation, CInt(vParams(0, 21)))
            Call modControl.SelectID(pvForm.cboSubstanceAbuse, CInt(vParams(0, 22)))
            pvForm.txtMedHxOther.Text = modConv.NullToText(vParams(0, 23))
            pvForm.txtAttendingHospital.Text = modConv.NullToText(vParams(0, 24))
            pvForm.txtAttendingNurse.Text = modConv.NullToText(vParams(0, 25))
            pvForm.txtAttendingPhysician.Text = modConv.NullToText(vParams(0, 26))
            pvForm.txtAttendingPhone.Text = modConv.NullToText(vParams(0, 27))
            Call modControl.SelectID(pvForm.cboFamilyAtHospital, CInt(vParams(0, 28)))
            Call modControl.SelectID(pvForm.cboFamilyKnowsStatus, CInt(vParams(0, 29)))
            pvForm.txtFuneralHome.Text = modConv.NullToText(vParams(0, 30))
            pvForm.txtAdditionalComments.Text = modConv.NullToText(vParams(0, 31))

            'COD_S is special since it's a dropdown combobox (can be ID or text)
            If vParams(0, 13) = "-1" Then
                pvForm.cboCOD_S.Text = vParams(0, 32)
            Else
                Call modControl.SelectID(pvForm.cboCOD_S, CInt(vParams(0, 13)))
            End If

        Else
            'Create the query to get the default call sheet data from the Referral
            vQuery = "sps_GetNDRICallSheetDefaults " & pvForm.CallId
            Try
                vResult = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS AndAlso ObjectIsValidArray(vParams, 2, 0, 18) Then

                pvForm.CallId = vParams(0, 0)
                pvForm.TxtCallDate.Text = VB6.Format(modConv.NullToText(vParams(0, 1)), "mm/dd/yy")
                pvForm.txtCallTime.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, CDate(vParams(0, 1))), "hh:nn") & " " & pvForm.OrganizationTimeZone
                pvForm.txtCoordName.Text = modConv.NullToText(vParams(0, 2))
                pvForm.txtAge.Text = modConv.NullToText(vParams(0, 3))
                Call modControl.SelectText(pvForm.cboAgeUnit, vParams(0, 4))
                Call modControl.SelectID(pvForm.cboRace, CInt(vParams(0, 5)))
                pvForm.cboGender.Text = modConv.NullToText(vParams(0, 6))
                Call modControl.SelectID(pvForm.cboABO_Rh, CInt(vParams(0, 7)))
                pvForm.txtDOD.Text = VB6.Format(modConv.NullToText(vParams(0, 10)), "mm/dd/yy")
                pvForm.txtTOD.Text = modConv.NullToText(vParams(0, 11))
                pvForm.txtOtherDiseases.Text = modConv.NullToText(vParams(0, 12))
                Call modControl.SelectID(pvForm.cboSubstanceAbuse, CInt(vParams(0, 13)))
                pvForm.txtAttendingHospital.Text = modConv.NullToText(vParams(0, 14))
                pvForm.txtAttendingNurse.Text = modConv.NullToText(vParams(0, 15))
                pvForm.txtAttendingPhysician.Text = modConv.NullToText(vParams(0, 16))
                pvForm.txtAttendingPhone.Text = modConv.NullToText(vParams(0, 17))
                pvForm.txtFuneralHome.Text = modConv.NullToText(vParams(0, 18))

                'COD_S is special since it's a dropdown combobox (can be ID or text)
                If vParams(0, 8) = "-1" Then
                    pvForm.cboCOD_S.Text = vParams(0, 9)
                Else
                    Call modControl.SelectID(pvForm.cboCOD_S, CInt(vParams(0, 8)))
                End If

            End If
        End If

    End Function

    Public Function QueryPhoneOrganization(ByRef pvForm As FrmNew) As Short

        'This query looks up Organizations based on the phone number passed
        'to the function.

        Dim vQuery As String = ""
        Dim vQuery1 As String = ""
        Dim I As Short
        Dim vReturn As New Object
        Dim vReturn1 As New Object
        Dim vMsg As String = ""


        Dim vAreaCode As String = ""
        Dim vPrefix As String = ""
        Dim vNumber As String = ""
        Dim vPIN As String = ""

        'Strip out the components of the phone number
        vAreaCode = Mid(pvForm.TxtPhone.Text, 2, 3)
        vPrefix = Mid(pvForm.TxtPhone.Text, 7, 3)
        vNumber = Mid(pvForm.TxtPhone.Text, 11, 4)
        vPIN = Mid(pvForm.TxtPhone.Text, 16, 10)


        'The phone number exists so
        'get the organizations associated with the phone ID
        '03/30/2012 ccarroll - Added quote to phone parameter strings (CCRST169)
        vQuery = String.Format("EXECUTE [OrganizationByPhoneSelect] @PhoneAreaCode='{0}', @PhonePrefix='{1}', @PhoneNumber='{2}', @PhonePin = '{3}';", vAreaCode, vPrefix, vNumber, vPIN)

        Try
            QueryPhoneOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPhoneOrganization = NO_DATA Then
            Exit Function
        ElseIf QueryPhoneOrganization = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 5) _
            AndAlso UBound(vReturn, 1) = 0 Then
            If (vReturn(0, 5) = True) Then
                Dim messageString As String = String.Format("{0} is inactive, Please enter a valid active number!", pvForm.TxtPhone.Text)
                MsgBox(messageString, MsgBoxStyle.OkOnly, "Inactive Phone Number")
                pvForm.TxtPhone.Text = ""
            ElseIf ObjectIsValidArray(vReturn, 2, 0, 3) Then
                'Get the org ID
                pvForm.OrganizationId = vReturn(0, 0)
                pvForm.SubLocationID = vReturn(0, 2)
                'pvForm.SubLocationLevelID = vReturn(0, 3)
                pvForm.SubLocationLevel = vReturn(0, 3)
            End If

        ElseIf QueryPhoneOrganization = SUCCESS And UBound(vReturn, 1) > 0 _
            And ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 1) Then

            'Alert the user
            MsgBox("There are multiple hospitals associated with this phone number. After completing the referral, notify a supervisor.", MsgBoxStyle.OkOnly, "Phone Number")

            For I = 0 To UBound(vReturn, 1)
                'Save the multiple organizations as a system alert
                vMsg = "Multiple organizations associated with phone:  " & pvForm.TxtPhone.Text & ", Org - " & vReturn(I, 1)
                Call modStatSave.SaveSystemAlert(vMsg, 1)
                vMsg = ""
            Next I

            QueryPhoneOrganization = NO_DATA

        End If

    End Function

    Public Function QueryLocationPerson(ByRef pvForm As Object, Optional ByRef DefaultOrgId As Short = 0, Optional ByRef Ctl As Object = Nothing) As Short
        'FSProj drh 6/15/02 - Added Ctl parameter

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturnCode As Short
        Dim vOrgId As Short

        If DefaultOrgId <= 0 Then
            vOrgId = pvForm.OrganizationId
        Else
            vOrgId = DefaultOrgId
        End If
        'Check if there is a match for the location
        vQuery = "SELECT Person.PersonID, Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast as PersonName " 'drh FSMod 06/13/03 - Added as PersonName

        vQuery = vQuery & "FROM Person " & "WHERE Person.OrganizationID = " & vOrgId & " AND Person.Inactive <> 1 " & "ORDER BY PersonName" 'drh FSMod 06/13/03

        Try
            QueryLocationPerson = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 6/15/02 - Control depends on form
        If pvForm.Name = "FrmReferralView" Then
            Call modControl.SetTextID(Ctl, vResult)
        Else
            If pvForm.Controls.Find("CboName", True).Length > 0 Then
                Call modControl.SetTextID(pvForm.CboName, vResult)
            End If

        End If

        If QueryLocationPerson = SUCCESS Then
            'Indicate matching locations were found.
            Exit Function
        Else
            'If there is no match
            'then clear the list
            'and set the query to false

            'FSProj drh 6/15/02 - Control depends on form
            If pvForm.Name = "FrmReferralView" Then
                Ctl.Clear()
            Else
                pvForm.CboName.Items.Clear()
            End If
        End If
        Exit Function
    End Function
    Public Function QueryLocationApproachPerson(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vOnCallReturn As New Object
        Dim vReturnCode As Short
        Dim I As Short

        'Check if there is a match for the location
        vQuery = "SELECT Person.PersonID, Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast "

        vQuery = vQuery & "FROM Person " & "WHERE (Person.OrganizationID = " & pvForm.OrganizationId & " "

        'Get all the organizations on call for the selected location and
        'finish building the query
        If QueryScheduleOrganizationsOnCall(pvForm, vOnCallReturn) = SUCCESS _
            AndAlso ObjectIsValidArray(vOnCallReturn, 2, UBound(vOnCallReturn), 0) Then

            For I = 0 To UBound(vOnCallReturn)

                vQuery = vQuery & "OR Person.OrganizationID = " & vOnCallReturn(I, 0) & " "

            Next I

        End If

        'Check if there if any of the options are approached by Statline
        If pvForm.Name = "FrmReferralView" Then
            vQuery = vQuery & "OR OrganizationID = 194 "
        Else
            If QueryStatlineConsent(pvForm) = SUCCESS Then
                vQuery = vQuery & "OR OrganizationID = 194 "
            End If
        End If

        vQuery = vQuery & ") AND Person.Inactive <> 1 "

        'FSProj drh 7/24/02 - ORDER BY name
        If pvForm.Name = "FrmReferralView" Then
            vQuery = vQuery & "ORDER BY 2"
        End If

        Try
            QueryLocationApproachPerson = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.Name = "FrmReferralView" Then
            'drh FSMod 06/03/03 - Copied from above; added pClear parameter value
            Call modControl.SetTextID(pvForm.CboApproachedBy, vResult, False)

            'drh FSMod 06/03/03 - Added pClear parameter value
            Call modControl.SetTextID(pvForm.cboConsentBy, vResult, False)

            'drh FSMOD 05/27/03
            Call modControl.SetTextID(pvForm.cboHospitalApproachedBy, vResult, False)
            Call modControl.SetTextID(pvForm.cboConsentMedSocObtainedBy, vResult, False)
        ElseIf pvForm.Name = "FrmReferral" Then
            'drh FSMod 06/03/03 - Added Else stmt.; Moved from above
            Call modControl.SetTextID(pvForm.CboApproachedBy, vResult)
        End If

        If QueryLocationApproachPerson = SUCCESS Then
            'Indicate matching locations were found.
            Exit Function
        Else
            'If there is no match
            'then clear the list
            'and set the query to false
            If pvForm.Name <> "FrmNew" Then
                pvForm.CboApproachedBy.items.Clear()
            End If

        End If
        Exit Function
    End Function


    Public Function QueryLocationPhysicians(ByRef pvForm As Object, Optional ByRef DefaultOrgId As Short = 0, Optional ByRef vCtl As Object = Nothing) As Short
        'drh FSMod 06/16/03 - Added vCtl param

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturnCode As Short
        Dim vOrgId As Short

        If DefaultOrgId <= 0 Then
            vOrgId = pvForm.OrganizationId
        Else
            vOrgId = DefaultOrgId
        End If
        'Check if there is a match for the location
        'SELECT Person.PersonID, PersonLast+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+ PersonFirst,Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast FROM Person WHERE Person.OrganizationID = 2627 AND Person.Inactive <> 1 order by person.personlast
        vQuery = "SELECT Person.PersonID, PersonLast+RTRIM(' '+(ISNULL(PersonMI,'')))+', '+ PersonFirst,Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast "

        vQuery = vQuery & "FROM Person " & "WHERE Person.OrganizationID = " & vOrgId & " AND Person.Inactive <> 1 "

        Try
            QueryLocationPhysicians = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'drh FSMod 06/16/03 - Added If stmt
        If pvForm.Name = "FrmReferral" Then
            pvForm.CboPhysician(0).Items.Clear()
            'FrmReferral.CboPhysician(0).Tag = 0
            pvForm.CboPhysician(1).Items.Clear()
            'FrmReferral.CboPhysician(1).Tag = 0
            If QueryLocationPhysicians = SUCCESS Then
                'Indicate matching locations were found.
                Call modControl.SetTextID(pvForm.CboPhysician(0), vResult)
                Call modControl.SetTextID(pvForm.CboPhysician(1), vResult)
            End If
        Else
            vCtl.Clear()

            If QueryLocationPhysicians = SUCCESS Then
                'Indicate matching locations were found.
                Call modControl.SetTextID(vCtl, vResult)
            End If
        End If

    End Function

    Public Function QueryRegistryStatus(ByRef CallId As Integer) As Short
        '***********************************************************************
        'T.T 04/26/2007
        'Module: modStatQuery
        'Parameters:    pvForm - Form
        '
        'Definition:    This Function looks up the registrystatus for the current
        '               referral and fills the cbobox cboRegistryStatus
        '***********************************************************************


        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturnCode As New Object
        Dim vOrgId As Short
        Dim vRS As New Object
        Dim vFound As String = ""

        'Check if there is a match for the location
        vQuery = "EXEC SelectRegistryStatus @CallID = " & CallId & ";"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        vQuery = "EXEC SelectRegistryStatusType @ID = " & vRS("RegistryStatus").Value & ";"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        vFound = vRS("RegistryType").Value
        If Not IsNothing(AppMain.frmReferral) Then
            Call modControl.Enable((AppMain.frmReferral.cboRegistryStatus)) 'T.T 9/11/2004 added to fill registrystatus box
            vReturnCode = modControl.cbofill((AppMain.frmReferral.cboRegistryStatus), vFound, False, False) 'T.T 9/11/2004 added to fill registrystatus box

            If vFound = "" Then
                AppMain.frmReferral.cboRegistryStatus.Visible = False
                AppMain.frmReferral.RegStatus.Visible = False
            End If
        End If
    End Function
    Public Function QueryRegistryStatusFS(ByRef CallId As Integer) As Short
        '***********************************************************************
        'T.T 04/26/2007
        'Module: modStatQuery
        'Parameters:    pvForm - Form
        '
        'Definition:    This Function looks up the registrystatus for the current
        '               referral and fills the cbobox cboRegistryStatus
        '***********************************************************************


        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturnCode As New Object
        Dim vOrgId As Short
        Dim vRS As New Object
        Dim vFound As String = ""


        'Check if there is a match for the location
        vQuery = "EXEC SelectRegistryStatus @CallID = " & CallId & ";"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        vQuery = "EXEC SelectRegistryStatusType @ID = " & vRS("RegistryStatus").Value & ";"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        vFound = vRS("RegistryType").Value
        If Not IsNothing(AppMain.frmReferralView) Then
            Call modControl.Enable((AppMain.frmReferralView.cboRegistryStatusFS)) 'T.T 9/11/2004 added to fill registrystatus box
            vReturnCode = modControl.cbofillFS((AppMain.frmReferralView.cboRegistryStatusFS), vFound, False, False) 'T.T 9/11/2004 added to fill registrystatus box

            If vFound = "" Then
                AppMain.frmReferralView.cboRegistryStatusFS.Visible = False

            End If
        End If




    End Function

    Public Function QueryPhoneSubLocation(ByRef pvForm As FrmNew) As Short

        Dim vQuery As String = ""
        Dim vResults As New Object
        Dim vReturnCode As Short

        'The phone number exists so
        'get the sub locations associated with the phone ID
        vQuery = "SELECT DISTINCT SubLocation.SubLocationID, SubLocation.SubLocationName " & "FROM Referral, SubLocation " & "WHERE Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID " & "AND Referral.ReferralCallerPhoneID = " & pvForm.CallPhoneNumberID & ";"

        Try
            QueryPhoneSubLocation = modODBC.Exec(vQuery, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPhoneSubLocation = SUCCESS _
            AndAlso ObjectIsValidArray(vResults, 2, 0, 0) _
            AndAlso UBound(vResults, 1) = 0 Then

            'Get the item ID
            pvForm.SubLocationID = vResults(0, 0)

        Else

            'If there is no match
            'then set the query to false
            QueryPhoneSubLocation = NO_DATA

        End If

    End Function


    Public Function QueryPhoneSubLocationLevel(ByRef pvForm As FrmNew) As Short

        Dim vQuery As String = ""
        Dim vResults As New Object
        Dim vReturnCode As Short

        'The phone number exists so
        'get the sub locations associated with the phone ID
        vQuery = "SELECT DISTINCT SubLocationLevel.SubLocationLevelID, SubLocationLevel.SubLocationLevelName " & "FROM Referral, SubLocationLevel " & "WHERE Referral.ReferralCallerLevelID = SubLocationLevel.SubLocationLevelID " & "AND Referral.ReferralCallerPhoneID = " & pvForm.CallPhoneNumberID & ";"

        Try
            QueryPhoneSubLocationLevel = modODBC.Exec(vQuery, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPhoneSubLocationLevel = SUCCESS _
            AndAlso ObjectIsValidArray(vResults, 2, 0, 0) _
            AndAlso UBound(vResults, 1) = 0 Then

            'Get the item ID
            pvForm.SubLocationLevel = vResults(0, 0)

        Else

            'If there is no match
            'then set the query to false
            QueryPhoneSubLocationLevel = NO_DATA

        End If

    End Function


    Public Function QueryAreaOrganization(ByRef pvForm As Object, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vAreaCode As String = ""

        'Find all the organization belonging that have the same area code
        'as the area code entered

        If IsNothing(pvReturn) Then

            'Strip out the area code of the phone number
            vAreaCode = Mid(pvForm.TxtPhone.Text, 2, 3)

            vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization, Phone " & "WHERE Organization.PhoneID = Phone.PhoneID " & "AND Phone.PhoneAreaCode = " & modODBC.BuildField(vAreaCode) & ";"

            Try
                QueryAreaOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryAreaOrganization = SUCCESS Then
                Call modControl.SetTextID(pvForm.CboOrganization, vReturn)
            End If

        Else

            'Strip out the area code of the phone number
            vAreaCode = Mid(pvForm.TxtCentralPhone.Text, 2, 3)

            vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization, Phone " & "WHERE Organization.PhoneID = Phone.PhoneID " & "AND Phone.PhoneAreaCode = " & modODBC.BuildField(vAreaCode) & " " & "AND Organization.OrganizationID <> " & pvForm.OrganizationId & ";"

            Try
                QueryAreaOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryAreaOrganization = SUCCESS Then
                pvReturn = VB6.CopyArray(vReturn)
            End If

        End If

    End Function
    Public Function QueryCountyOrganization(ByRef pvForm As FrmOrganization, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vCountyID As Integer
        Dim vStateID As Integer

        'Find all the organizations that have the same CountyID

        'Get the county ID
        vCountyID = modControl.GetID(pvForm.CboCounty)
        'Get the State ID
        vStateID = modControl.GetID(pvForm.CboState)

        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM  Organization " & "WHERE Organization.CountyID = " & vCountyID & " " & "AND Organization.StateID = " & vStateID & " " & "AND OrganizationID <> " & pvForm.OrganizationId & ";"

        Try
            QueryCountyOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCountyOrganization = SUCCESS Then
            pvReturn = VB6.CopyArray(vReturn)
        End If

    End Function

    Public Function QueryStateOrganization(ByRef pvForm As FrmOrganization, ByRef pvReturn As Object, Optional ByRef pvIncludeOrg As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vStateID As Integer

        'Find all the organizations that have the same StateID

        'Get the State ID
        vStateID = modControl.GetID(pvForm.CboState)

        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM  Organization " & "WHERE Organization.StateID = " & vStateID & " "

        If Not IsNothing(pvIncludeOrg) Then
            If pvIncludeOrg = True Then
                vQuery = vQuery & "AND OrganizationID <> " & pvForm.OrganizationId & ";"
            Else
                vQuery = vQuery & ";"
            End If
        Else
            vQuery = vQuery & ";"
        End If

        Try
            QueryStateOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryStateOrganization = SUCCESS Then
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryCityOrganization(ByRef pvForm As FrmOrganization, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vCity As String = ""
        Dim vStateID As Integer

        'Find all the organizations that have the same city as the city entered

        'Get the city name
        vCity = pvForm.TxtCity.Text
        'Get the State ID
        vStateID = modControl.GetID(pvForm.CboState)

        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization " & "WHERE Organization.OrganizationCity = " & modODBC.BuildField(vCity) & " " & "AND Organization.StateID = " & vStateID & " " & "AND OrganizationID <> " & pvForm.OrganizationId & ";"

        Try
            QueryCityOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCityOrganization = SUCCESS Then
            pvReturn = VB6.CopyArray(vReturn)
        End If

    End Function
#Region "Rotation"

    Public Function QueryRotationName(ByRef RotationID As Object, ByRef RotationGroupID As Object) As String

        '*********************************************************************************
        'Name: QueryRotationName
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub Reloads the RotationGroupscbo box
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vRS As New Object
        'Find all Rotation Groups
        vQuery = "Select RotationName from Rotation where RotationGroupID = " & RotationGroupID & " and RotationID = " & RotationID
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        QueryRotationName = vRS("RotationName").Value
        vRS = Nothing
    End Function
    Public Function QueryRotationSequenceMatrix(ByRef RotationGroupID As Object) As ADODB.Recordset

        '*********************************************************************************
        'Name: QueryRotationSequenceMatrix
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub returns the sequence of the group
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vRS As New Object

        vQuery = "Select RotationID, RotationName, ServiceLevelName, RotationSequence,RotationLastRun,RotationNextRun from Rotation  where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        QueryRotationSequenceMatrix = vRS

    End Function
    Public Function QueryRotationGroups(ByRef pvForm As FrmRotateOrganization) As Short

        '*********************************************************************************
        'Name: QueryRotationGroups
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub Reloads the RotationGroupscbo box
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vResult As New Object
        'Find all Rotation Groups
        vQuery = "Select RotationGroupID,RotationGroupName from RotationGroupName"
        Try
            QueryRotationGroups = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        Call modControl.SetTextID(pvForm.CboRotationGroup, vResult, True, False)
    End Function
    Public Function QueryRotationOrganizationselect(ByRef pvForm As FrmRotateOrganization, ByRef RotationGroupID As Short) As Short
        '***********************************************************************
        'T.T 09/11/2004
        'Module: QueryRotationOrganizationselect
        'Parameters:    pvForm - Form
        '
        'Definition:    This function fills the listview for the organizations selected
        '***********************************************************************


        Dim vQuery As String = ""
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT RotationOrganization.OrganizationID, RotationOrganization.OrganizationName, RotationOrganization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName FROM (RotationOrganization INNER JOIN OrganizationType ON RotationOrganization.OrganizationType = OrganizationType.OrganizationTypeID) INNER JOIN State ON RotationOrganization.OrganizationState = State.StateID where RotationGroupID = " & RotationGroupID
        'Check if there is a match for the location
        Try
            Call modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
            pvForm.SelectedGridList = vReturn
        End If
    End Function
    Public Function QueryAddRotation(ByRef pvForm As FrmRotateOrganization, ByRef vGridList As Object) As Short

        '*********************************************************************************
        'Name: QueryAddRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub adds the organization to the Organization.
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vParams(5) As Object
        Dim vFields(5) As Object
        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vScheduleID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim RotationGroupID As Short
        Dim OrgID As Short
        Dim vRS As ADODB.Recordset

        RotationGroupID = modControl.GetID(pvForm.CboRotationGroup)
        vParams(0) = RotationGroupID

        vFields(0) = "RotationGroupID"
        vFields(1) = "OrganizationID"
        vFields(2) = "OrganizationName"
        vFields(3) = "OrganizationCity"
        vFields(4) = "OrganizationState"
        vFields(5) = "OrganizationType"
        'Get and save each row of the group organizations
        For I = 0 To UBound(vGridList, 1)
            OrgID = modConv.TextToLng(vGridList(I, 0))
            vParams(1) = modConv.TextToLng(vGridList(I, 0))
            'Check if the item to be added already exists
            If modStatQuery.QueryRotationOrganization(pvForm, RotationGroupID, OrgID, , vReturn) = NO_DATA Then
                'find name of Organization
                vQuery = "Select OrganizationName,OrganizationCity,StateID,OrganizationTypeID from Organization where OrganizationID = " & OrgID
                Try
                    Call modODBC.Exec(vQuery, vReturn, , True, vRS)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                If vRS.EOF = False Then
                    vParams(2) = vRS.Fields("OrganizationName").Value
                    vParams(3) = vRS.Fields("OrganizationCity").Value
                    vParams(4) = vRS.Fields("StateID").Value
                    vParams(5) = vRS.Fields("OrganizationTypeID").Value
                    vRS = Nothing
                End If

                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = "INSERT INTO RotationOrganization (" & vValues & ");"
                Try
                    QueryAddRotation = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Else
                QueryAddRotation = NO_DATA
            End If
        Next I

    End Function
    Public Function QueryScheduleOrganizationsRotation(ByRef pvForm As Object, Optional ByRef setbox As Short = 0) As Short
        'T.T 11/20/2004 added to find rotation organization schedules
        '*********************************************************************************
        'Name: QueryScheduleOrganizationsRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub Reloads the Schedule cbo box
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vResult As New Object

        'Find all the organizations with a schedule
        vQuery = "SELECT DISTINCT Organization.OrganizationID, OrganizationName " & "From Organization " & "JOIN ScheduleGroup ON ScheduleGroup.OrganizationID = Organization.OrganizationID " & "JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID "

        ' Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            ' Changed Where clause to IN instead of = because we can get multiple rows back in subquery
            vQuery = vQuery & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroup.ScheduleGroupID " & "JOIN SourceCode ON SourceCode.SourceCodeID = ScheduleGroupSourceCode.SourceCodeID " & "WHERE SourceCode.SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM SourceCodeOrganization " & "  LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "  Where(SourceCodeType = 2 Or SourceCodeType = 4) " & "  AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ")"

        End If

        Try
            QueryScheduleOrganizationsRotation = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If setbox = 0 Then
            pvForm.CboOrganization.Items.Clear()

            If TypeOf vResult Is Array Then
                Call modControl.SetTextID(pvForm.CboOrganization, vResult, True, True)
            End If
        Else
            pvForm.CboOrganization2.Items.Clear()

            If TypeOf vResult Is Array Then
                Call modControl.SetTextID(pvForm.CboOrganization2, vResult, True, True)
            End If
        End If

    End Function
#End Region

    Public Function QueryScheduleOrganizations(ByRef pvForm As Object, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object

        'Find all the organizations with a schedule
        vQuery = "SELECT DISTINCT Organization.OrganizationID, OrganizationName " & "From Organization " & "JOIN ScheduleGroup ON ScheduleGroup.OrganizationID = Organization.OrganizationID " & "JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID "

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'drh 11/6/01 Changed Where clause to IN instead of = because we can get multiple rows back in subquery
            vQuery = vQuery & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroup.ScheduleGroupID " & "JOIN SourceCode ON SourceCode.SourceCodeID = ScheduleGroupSourceCode.SourceCodeID " & "WHERE SourceCode.SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM SourceCodeOrganization " & "  LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "  Where(SourceCodeType = 2 Or SourceCodeType = 4) " & "  AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ")"

        End If

        Try
            QueryScheduleOrganizations = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        pvForm.CboOrganization.Items.Clear()

        If Not IsNothing(vResult) Then
            If Not IsNothing(pvAddAllItem) Then
                If pvAddAllItem = True Then
                    Call modControl.SetTextID(pvForm.CboOrganization, vResult, True, True)

                    'FSProj drh 5/17/02 - Populate Schedule Orgs on Subtype/Schedule Groups tab
                    Call modControl.SetTextID(pvForm.cboOrganizationSub, vResult, True, True)
                Else
                    Call modControl.SetTextID(pvForm.CboOrganization, vResult)

                    'FSProj drh 5/17/02 - Populate Schedule Orgs on Subtype/Schedule Groups tab
                    Call modControl.SetTextID(pvForm.cboOrganizationSub, vResult)
                End If
            Else
                Call modControl.SetTextID(pvForm.CboOrganization, vResult)

                'FSProj drh 5/17/02 - Populate Schedule Orgs on Subtype/Schedule Groups tab
                'Call modControl.SetTextID(pvForm.cboOrganizationSub, vResult)

            End If
        End If

    End Function

    Public Function QueryOrganizationPerson(ByRef pvForm As Object, Optional ByRef pvAllPersons As Boolean = False) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Find all the people beloning to the given organization
        vQuery = "SELECT Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+' '+PersonLast " & "END  AS Person, "

        vQuery = vQuery & "PersonType.PersonTypeName " & "FROM Person " & "JOIN Organization ON Organization.OrganizationID = Person.OrganizationID " & "JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID " & "WHERE Person.OrganizationID = " & pvForm.OrganizationId & " "

        If IsNothing(pvAllPersons) Then
            If pvForm.OptActive(0).Checked Then
                vQuery = vQuery & "AND Person.Inactive = 0 "
            Else
                vQuery = vQuery & "AND Person.Inactive = 1 "
            End If
        Else
            If pvAllPersons = False Then
                If pvForm.Name = "FrmOrganization" Then
                    If pvForm.OptActive(0).Checked Then
                        vQuery = vQuery & "AND Person.Inactive = 0 "
                    Else
                        vQuery = vQuery & "AND Person.Inactive = 1 "
                    End If
                Else
                    vQuery = vQuery & "AND Person.Inactive = 0 "
                End If
            End If
        End If

        vQuery = vQuery & "ORDER BY PersonFirst, PersonLast"

        Try
            QueryOrganizationPerson = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.Name = "FrmOrganization" Then

            If QueryOrganizationPerson = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewPerson, False)
                pvForm.CmdOpen.Enabled = True
            Else
                pvForm.CmdOpen.Enabled = False
            End If

        ElseIf pvForm.Name = "FrmSchedule" Then

            If QueryOrganizationPerson = SUCCESS Then
                Call modSSGrid.SetTextID(pvForm.SSCboCall1, vReturn, True)
                Call modSSGrid.SetTextID(pvForm.SSCboCall2, vReturn, True)
                Call modSSGrid.SetTextID(pvForm.SSCboCall3, vReturn, True)
                Call modSSGrid.SetTextID(pvForm.SSCboCall4, vReturn, True)
                Call modSSGrid.SetTextID(pvForm.SSCboCall5, vReturn, True)
                Call modSSGrid.SetTextID(pvForm.SSCboCall6, vReturn, True)
            End If

        ElseIf pvForm.Name = "FrmMessage" Then

            If QueryOrganizationPerson = SUCCESS Then
                Call modControl.SetTextID(pvForm.CboName, vReturn)
            End If

        ElseIf pvForm.Name = "FrmOnCallEvent" Or pvForm.Name = "FrmOnCall" Then

            If QueryOrganizationPerson = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewPerson, True)
            End If

        ElseIf pvForm.Name = "FrmQuickLook" Then

            If QueryOrganizationPerson = SUCCESS Then
                Call modControl.SetTextID(pvForm.LstPerson, vReturn)
            End If

        End If
    End Function
    Public Function QueryOrganizationPersons(ByVal pvOrganizationId As Integer, ByRef prReturn As Object, Optional ByRef pvAllPersons As Boolean = False) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Find all the people beloning to the given organization
        vQuery = "SELECT Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+' '+PersonLast " & "END  AS Person, "

        vQuery = vQuery & "PersonType.PersonTypeName " & "FROM Person " & "JOIN Organization ON Organization.OrganizationID = Person.OrganizationID " & "JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID " & "WHERE Person.OrganizationID = " & pvOrganizationId & " "

        If Not IsNothing(pvAllPersons) Then
            If pvAllPersons = False Then
                vQuery = vQuery & "AND Person.Inactive = 0 "
            End If
        End If

        vQuery = vQuery & "ORDER BY PersonFirst "

        Try
            QueryOrganizationPersons = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationPersons = SUCCESS Then
            prReturn = VB6.CopyArray(vReturn)
        End If

    End Function

    Public Function QueryStateCounty(ByVal pvStateID As Short, ByRef pvList As ComboBox) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object

        'Find all the Counties belonging to the given state.
        vQuery = "SELECT DISTINCT County.CountyID, County.CountyName " & "FROM County " & "WHERE County.StateID = " & pvStateID & ";"

        Try
            QueryStateCounty = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        Call modControl.SetTextID(pvList, vResult)

    End Function

    Public Function QueryOpenOrganization(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM (Organization " & "INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID "

        'Added bjk 06/2001: Lease Organization
        'Check if LO add join statment if it is.
        If AppMain.ParentForm.LeaseOrganization <> 0 Then

            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID "

        End If

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then
            'The select statment was removed from the portion of the if statment during LO modifications 5/25/01

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE State.StateID = " & modControl.GetID(pvForm.CboState) & " "

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " "

        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and add to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'check if a where exists in the vQuery use where if it doesn't and AND if it does.
            If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
                vQuery = vQuery & "WHERE "
            Else
                vQuery = vQuery & "AND "
            End If

            vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ") "
        End If

        vQuery = vQuery & "ORDER BY Organization.OrganizationName ASC;"

        Try
            QueryOpenOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenOrganization = SUCCESS Then

            Select Case pvForm.Name

                Case "FrmRotateOrganization"
                    pvForm.GridList = VB6.CopyArray(vReturn)
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
                Case "FrmOpenOrganization"
                    'Copy results set to the form array
                    pvForm.GridList = VB6.CopyArray(vReturn)
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOrganization, False)
                Case "FrmAlert", "FrmCriteria", "FrmReport", "FrmSchedule", "FrmServiceLevel"
                    'Copy results set to the form array
                    pvForm.AvailableGridList = VB6.CopyArray(vReturn)
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)

            End Select

        End If

    End Function

    Public Function QueryOpenProcessor(ByRef pvForm As Object) As Short
        'FSProj drh 5/8/02 - New function to find available processors

        Dim vQuery As String = ""
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM (Organization " & "INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID "

        'Added bjk 06/2001: Lease Organization
        'Check if LO add join statment if it is.
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID "

        End If

        If modControl.GetID(pvForm.cboProcessorState) = ALL_STATES And modControl.GetID(pvForm.cboProcessorOrganizationType) = ALL_ORG_TYPES Then
            'The select statment was removed from the portion of the if statment during LO modifications 5/25/01

        ElseIf modControl.GetID(pvForm.cboProcessorState) <> ALL_STATES And modControl.GetID(pvForm.cboProcessorOrganizationType) = ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE State.StateID = " & modControl.GetID(pvForm.cboProcessorState) & " "

        ElseIf modControl.GetID(pvForm.cboProcessorState) = ALL_STATES And modControl.GetID(pvForm.cboProcessorOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE Organization.OrganizationTypeID = " & modControl.GetID(pvForm.cboProcessorOrganizationType) & " "

        ElseIf modControl.GetID(pvForm.cboProcessorState) <> ALL_STATES And modControl.GetID(pvForm.cboProcessorOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = vQuery & "WHERE State.StateID = " & modControl.GetID(pvForm.cboProcessorState) & " " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.cboProcessorOrganizationType) & " "

        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and add to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'check if a where exists in the vQuery use where if it doesn't and AND if it does.
            If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
                vQuery = vQuery & "WHERE "
            Else
                vQuery = vQuery & "AND "
            End If

            vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ") "
        End If

        vQuery = vQuery & "ORDER BY Organization.OrganizationName ASC;"

        Try
            QueryOpenProcessor = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenProcessor = SUCCESS Then

            Select Case pvForm.Name

                Case "FrmOpenOrganization"
                    'Copy results set to the form array
                    pvForm.GridList = VB6.CopyArray(vReturn)
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewProcessor, False)
                Case "FrmSchedule", "FrmCriteria"
                    'Copy results set to the form array
                    pvForm.AvailableGridList = VB6.CopyArray(vReturn)
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableProcessors, False)

            End Select

        End If

    End Function

    Public Function QueryUnassignedServiceLevelOrganization(ByRef pvForm As FrmServiceLevel) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM ((Organization " & "LEFT JOIN ServiceLevel30Organization ON Organization.OrganizationID = ServiceLevel30Organization.OrganizationID) " & "INNER JOIN State ON Organization.StateID = State.StateID)" & "INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE ServiceLevel30Organization.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC;"

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM ((Organization " & "LEFT JOIN ServiceLevel30Organization ON Organization.OrganizationID = ServiceLevel30Organization.OrganizationID) " & "INNER JOIN State ON Organization.StateID = State.StateID)" & "INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE ServiceLevel30Organization.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC;"

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM ((Organization " & "LEFT JOIN ServiceLevel30Organization ON Organization.OrganizationID = ServiceLevel30Organization.OrganizationID) " & "INNER JOIN State ON Organization.StateID = State.StateID)" & "INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE ServiceLevel30Organization.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC;"

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM ((Organization " & "LEFT JOIN ServiceLevel30Organization ON Organization.OrganizationID = ServiceLevel30Organization.OrganizationID) " & "INNER JOIN State ON Organization.StateID = State.StateID)" & "INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE ServiceLevel30Organization.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC;"

        End If

        Try
            QueryUnassignedServiceLevelOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedServiceLevelOrganization = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function
    Public Function QueryUnassignedScheduleGroupOrganization(ByRef pvForm As FrmSchedule) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vScheduleGroupType As Short
        Dim vQuery2 As String

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT ScheduleGroupOrganization.OrganizationID INTO #TempScheduleOrg " & "FROM ScheduleGroupOrganization " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID "

            If pvForm.CboOrganization.Text <> "" Then
                vQuery = vQuery & "WHERE ScheduleGroup.OrganizationID = " & modControl.GetID(pvForm.CboOrganization) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempScheduleOrg ON #TempScheduleOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempScheduleOrg.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT ScheduleGroupOrganization.OrganizationID INTO #TempScheduleOrg " & "FROM ScheduleGroupOrganization " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID "

            If pvForm.CboOrganization.Text <> "" Then
                vQuery = vQuery & "WHERE ScheduleGroup.OrganizationID = " & modControl.GetID(pvForm.CboOrganization) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempScheduleOrg ON #TempScheduleOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempScheduleOrg.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT ScheduleGroupOrganization.OrganizationID INTO #TempScheduleOrg " & "FROM ScheduleGroupOrganization " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID "

            If pvForm.CboOrganization.Text <> "" Then
                vQuery = vQuery & "WHERE ScheduleGroup.OrganizationID = " & modControl.GetID(pvForm.CboOrganization) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempScheduleOrg ON #TempScheduleOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempScheduleOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT ScheduleGroupOrganization.OrganizationID INTO #TempScheduleOrg " & "FROM ScheduleGroupOrganization " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID "

            If pvForm.CboOrganization.Text <> "" Then
                vQuery = vQuery & "WHERE ScheduleGroup.OrganizationID = " & modControl.GetID(pvForm.CboOrganization) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempScheduleOrg ON #TempScheduleOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempScheduleOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        End If

        'combined sql statements because vb.Net runs as seperate SQL. This caused DB error when accessing temp table        
        vQuery2 = "SET NOCOUNT ON; " & vQuery & " " & vQuery2 & " DROP TABLE #TempScheduleOrg"
        Try
            QueryUnassignedScheduleGroupOrganization = modODBC.Exec(vQuery2, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedScheduleGroupOrganization = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function

    Public Function QueryUnassignedWebReportGroupOrg(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vWebReportGroupType As Short
        Dim vQuery2 As String

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT WebReportGroupOrg.OrganizationID INTO #TempWebReportOrg " & "FROM WebReportGroupOrg " & "JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "

            If pvForm.CboReportParent.Text <> "" Then
                vQuery = vQuery & "WHERE WebReportGroup.OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            End If

            If pvForm.CboReportGroup.Text <> "" Then
                vQuery = vQuery & "AND WebReportGroupOrg.WebReportGroupID = " & modControl.GetID(pvForm.CboReportGroup) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempWebReportOrg ON #TempWebReportOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempWebReportOrg.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboReportParentType) = ALL_ORG_TYPES Then

            vQuery = "SELECT WebReportGroupOrg.OrganizationID INTO #TempWebReportOrg " & "FROM WebReportGroupOrg " & "JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "

            If pvForm.CboReportParent.Text <> "" Then
                vQuery = vQuery & "WHERE WebReportGroup.OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            End If

            If pvForm.CboReportGroup.Text <> "" Then
                vQuery = vQuery & "AND WebReportGroupOrg.WebReportGroupID = " & modControl.GetID(pvForm.CboReportGroup) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempWebReportOrg ON #TempWebReportOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempWebReportOrg.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT WebReportGroupOrg.OrganizationID INTO #TempWebReportOrg " & "FROM WebReportGroupOrg " & "JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "

            If pvForm.CboReportParent.Text <> "" Then
                vQuery = vQuery & "WHERE WebReportGroup.OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            End If

            If pvForm.CboReportGroup.Text <> "" Then
                vQuery = vQuery & "AND WebReportGroupOrg.WebReportGroupID = " & modControl.GetID(pvForm.CboReportGroup) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempWebReportOrg ON #TempWebReportOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempWebReportOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboReportParentType) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT WebReportGroupOrg.OrganizationID INTO #TempWebReportOrg " & "FROM WebReportGroupOrg " & "JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "

            If pvForm.CboReportParent.Text <> "" Then
                vQuery = vQuery & "WHERE WebReportGroup.OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            End If

            If pvForm.CboReportGroup.Text <> "" Then
                vQuery = vQuery & "AND WebReportGroupOrg.WebReportGroupID = " & modControl.GetID(pvForm.CboReportGroup) & " "
            End If

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempWebReportOrg ON #TempWebReportOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempWebReportOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboReportParentType) & " " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        End If

        'combined sql statements because vb.Net runs as seperate SQL. This caused DB error when accessing temp table        
        vQuery2 = "SET NOCOUNT ON; " & vQuery & " " & vQuery2 & " DROP TABLE #TempWebReportOrg"
        Try
            QueryUnassignedWebReportGroupOrg = modODBC.Exec(vQuery2, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedWebReportGroupOrg = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function


    Public Function QueryUnassignedCriteriaOrganization(ByRef pvForm As FrmCriteria) As Short
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vCriteriaType As Short
        Dim vQuery2 As String

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            'FSProj drh 4/25/02 - Added AND clause to only select working criteria
            vQuery = "SELECT OrganizationID INTO #TempCriteriaOrg " & "FROM CriteriaOrganization " & "JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID " & "WHERE DonorCategoryID = " & modControl.GetID(pvForm.CboDonorCategory) & " " & "AND CriteriaStatus = " & WORKING_CRITERIA & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempCriteriaOrg ON #TempCriteriaOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempCriteriaOrg.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            'FSProj drh 4/25/02 - Added AND clause to only select working criteria
            vQuery = "SELECT OrganizationID INTO #TempCriteriaOrg " & "FROM CriteriaOrganization " & "JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID " & "WHERE DonorCategoryID = " & modControl.GetID(pvForm.CboDonorCategory) & " " & "AND CriteriaStatus = " & WORKING_CRITERIA & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempCriteriaOrg ON #TempCriteriaOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempCriteriaOrg.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            'FSProj drh 4/25/02 - Added AND clause to only select working criteria
            vQuery = "SELECT OrganizationID INTO #TempCriteriaOrg " & "FROM CriteriaOrganization " & "JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID " & "WHERE DonorCategoryID = " & modControl.GetID(pvForm.CboDonorCategory) & " " & "AND CriteriaStatus = " & WORKING_CRITERIA & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempCriteriaOrg ON #TempCriteriaOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempCriteriaOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            'FSProj drh 4/25/02 - Added AND clause to only select working criteria
            vQuery = "SELECT OrganizationID INTO #TempCriteriaOrg " & "FROM CriteriaOrganization " & "JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID " & "WHERE DonorCategoryID = " & modControl.GetID(pvForm.CboDonorCategory) & " " & "AND CriteriaStatus = " & WORKING_CRITERIA & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempCriteriaOrg ON #TempCriteriaOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempCriteriaOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        End If

        'combined sql statements because vb.Net runs as seperate SQL. This caused DB error when accessing temp table        
        vQuery2 = "SET NOCOUNT ON; " & vQuery & " " & vQuery2 & " DROP TABLE #TempCriteriaOrg"

        Try
            QueryUnassignedCriteriaOrganization = modODBC.Exec(vQuery2, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedCriteriaOrganization = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function


    Public Function QueryUnassignedAlertOrganization(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vAlertType As Short
        Dim vQuery2 As String

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempAlertOrg " & "FROM AlertOrganization " & "JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID " & "WHERE AlertTypeID = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempAlertOrg ON #TempAlertOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempAlertOrg.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempAlertOrg " & "FROM AlertOrganization " & "JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID " & "WHERE AlertTypeID = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempAlertOrg ON #TempAlertOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempAlertOrg.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempAlertOrg " & "FROM AlertOrganization " & "JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID " & "WHERE AlertTypeID = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempAlertOrg ON #TempAlertOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempAlertOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempAlertOrg " & "FROM AlertOrganization " & "JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID " & "WHERE AlertTypeID = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempAlertOrg ON #TempAlertOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempAlertOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        End If
        'combined sql statements because 2008 was running them seperately, so the temp table in vQuery2 didn't know about the one in vQuery        
        vQuery2 = "SET NOCOUNT ON; " & vQuery & " " & vQuery2 & " DROP TABLE #TempAlertOrg"
        Try
            QueryUnassignedAlertOrganization = modODBC.Exec(vQuery2, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedAlertOrganization = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function

    Public Function QueryUnassignedSourceCodeOrganization(ByRef pvForm As FrmSourceCode) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vSourceCodeType As Short
        Dim vQuery2 As String

        If modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempSourceCodeOrg " & "FROM SourceCodeOrganization " & "JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "WHERE SourceCodeType = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempSourceCodeOrg ON #TempSourceCodeOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempSourceCodeOrg.OrganizationID Is Null " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) = ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempSourceCodeOrg " & "FROM SourceCodeOrganization " & "JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "WHERE SourceCodeType = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempSourceCodeOrg ON #TempSourceCodeOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempSourceCodeOrg.OrganizationID Is Null " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "


        ElseIf modControl.GetID(pvForm.CboState) = ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempSourceCodeOrg " & "FROM SourceCodeOrganization " & "JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "WHERE SourceCodeType = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempSourceCodeOrg ON #TempSourceCodeOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempSourceCodeOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "ORDER BY Organization.OrganizationName ASC "

        ElseIf modControl.GetID(pvForm.CboState) <> ALL_STATES And modControl.GetID(pvForm.CboOrganizationType) <> ALL_ORG_TYPES Then

            vQuery = "SELECT OrganizationID INTO #TempSourceCodeOrg " & "FROM SourceCodeOrganization " & "JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "WHERE SourceCodeType = " & modControl.GetID(pvForm.CboType) & " "

            vQuery2 = "SELECT Organization.OrganizationID, Organization.OrganizationName, " & "Organization.OrganizationCity, State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM Organization " & "LEFT JOIN #TempSourceCodeOrg ON #TempSourceCodeOrg.OrganizationID = Organization.OrganizationID " & "LEFT JOIN State ON Organization.StateID = State.StateID " & "LEFT JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "WHERE #TempSourceCodeOrg.OrganizationID Is Null " & "AND Organization.OrganizationTypeID = " & modControl.GetID(pvForm.CboOrganizationType) & " " & "AND State.StateID = " & modControl.GetID(pvForm.CboState) & " " & "ORDER BY Organization.OrganizationName ASC "

        End If

        'combined sql statements because vb.Net runs as seperate SQL. This caused DB error when accessing temp table        
        vQuery2 = "SET NOCOUNT ON; " & vQuery & " " & vQuery2 & " DROP TABLE #TempSourceCodeOrg"

        Try
            QueryUnassignedSourceCodeOrganization = modODBC.Exec(vQuery2, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryUnassignedSourceCodeOrganization = SUCCESS Then
            pvForm.AvailableGridList = VB6.CopyArray(vReturn)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableOrganizations, False)
        End If

    End Function
    Public Function QueryOpenLogEvent(ByRef pvForm As Object, Optional sortColumnName As String = "Date           Time", Optional sortOrder As String = "ASC") As Short
        '************************************************************************************
        'Name: QueryOpenLogEvent%
        'Date Created: Unknown                          Created by: Tim Klug
        'Release: Unknown                               Task: Unknown
        'Description: Queries the LogEvents for the current referral
        'Returns: N/A
        'Params: pvForm = calling form,
        '
        'Stored Procedures: GetLogEventList
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/07/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9 LogEvent
        'Description:   Replace dynamic sproc with GetLogEventList
        '
        '====================================================================================
        Dim vQuery As String = ""
        Dim vReturn As New Object

        vQuery = "EXEC GetLogEventList @CallID = " & pvForm.CallId & ", @TimeZone = " & AppMain.ParentForm.TimeZone & ", @ViewLogEventDeleted = " & IIf(IsNothing(pvForm.chkViewLogEventDeleted), System.DBNull.Value, DirectCast(pvForm.chkViewLogEventDeleted, CheckBox).Checked) & ", @SortColumn = '" & sortColumnName & "', @AscDesc = '" & sortOrder & "'"

        Try
            QueryOpenLogEvent = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryOpenLogEvent = SQL_ERROR
        End Try

        If QueryOpenLogEvent = SUCCESS Then
            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 1)

            Try
                If (pvForm.Name = "FrmEventLogDescription") Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewLogEventdesc, False)
                Else
                    'Make sure LstViewLogEvent is available before we use it
                    If Not IsNothing(pvForm.GetType().GetProperty("LstViewLogEvent")) Then
                        Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewLogEvent, False)
                    End If
                    'Make sure TxtEventDesc is available before we use it
                    If Not IsNothing(pvForm.GetType().GetProperty("TxtEventDesc")) Then
                        pvForm.TxtEventDesc.Text = ""
                    End If
                End If
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

    End Function


    Public Function QueryCall(ByRef pvForm As Object, Optional ByRef prReturn As Object = Nothing) As Short
        '************************************************************************************
        'Name: QueryCall
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Retrieves Call information from DB
        'Returns: Integer
        'Params: pvForm, Optional prReturn
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 4/22/05                          Changed by: Scott Plummer
        'Release #: 7.7.33                              Task: None
        'Description:  Allow Triage Coordinators to add Log Events to referrals in Family
        '              Services.
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Scott Plummer
        'Release #: 7.7.34                              Task: 420
        'Description:  Allow Triage Coordinators to view the Log Events in referrals already
        '              in Family Services.
        '====================================================================================
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Char Chaput
        'Release #: 7.7.36                              Task: 484
        'Description:  Stattrac was allowing multiple into a referral. Added a transaction
        'on the record along with modifying so that the call to modStatSave.SaveCallOpenBy
        'occured when the form was open.
        '====================================================================================
        '************************************************************************************
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vReturn2 As New Object
        Dim vReturn3 As Object '7/9/01 drh Result set for FS Case
        Dim vTimeZoneDif As Short
        Dim referralCallOpenByWebPersonId As New Object
        Dim iResponse As Short
        Dim sOpenMsg As String = ""
        Dim pvunlock As Short

        referralCallOpenByWebPersonId = 16

        Try
            vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '11/16/05 C.Chaput Set the callopenbyid equal to the person in the instance of Stattrac and trying
        'to access the referral. You need to set callopenbyid so the select below works properly. A
        'DB transaction has been created in modStatSave.SaveCallOpenBy so only one person can access a referral
        'at a time.

        '12/30/05 check to see if family services and set a flag so callopenbyid won't get set if no access.
        If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralView" Or pvForm.Name = "FrmMessage" Then
            If pvForm.Name = "FrmReferral" Then
                If pvForm.CallExclusive = False Then
                    'ccarroll 0624/2011 - wi:12930, Removed from If: And pvForm.CallFSCase = False Then
                    Try
                        Call modStatSave.SaveCallOpenBy(pvForm)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If
            If pvForm.Name = "FrmMessage" And pvForm.CallExclusive = False Then
                Try
                    Call modStatSave.SaveCallOpenBy(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
            If pvForm.Name = "FrmReferralView" And pvForm.CallExclusive = False Then
                Try
                    Call modStatSave.SaveCallOpenBy(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        Else
            Try
                Call modStatSave.SaveCallOpenBy(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
15:

        'FSProj drh 7/2/02 - Get TotalTime and Seconds from FSCase table for Secondary Referrals
20:     If pvForm.Name = "FrmReferralView" Then
            vQuery = "SELECT " & "c.CallID, c.CallNumber, c.CallTypeID, " & "DATEADD(hh, " & vTimeZoneDif & ", c.CallDateTime) AS CallDateTime , " & "c.StatEmployeeID, fs.FSCaseTotalTime as CallTotalTime, c.CallTempExclusive, c.Inactive, fs.FSCaseSeconds as CallSeconds, c.LastModified, c.CallTemp, " & "c.SourceCodeID, c.CallOpenByID, c.CallTempSavedByID, c.CallExtension, c.UpdatedFlag, c.CallOpenByWebPersonId " & "FROM Call c " & "JOIN FSCase fs ON c.CallId = fs.CallId " & "WHERE c.CallID = " & pvForm.CallId & ";"
30:     Else
            vQuery = "SELECT " & "CallID, CallNumber, CallTypeID, " & "DATEADD(hh, " & vTimeZoneDif & ", CallDateTime) AS CallDateTime , " & "StatEmployeeID, CallTotalTime, CallTempExclusive, Inactive, CallSeconds, LastModified, CallTemp, " & "SourceCodeID, CallOpenByID, CallTempSavedByID, CallExtension, UpdatedFlag, CallOpenByWebPersonId FROM Call " & "WHERE CallID = " & pvForm.CallId & ";"
40:     End If

50:     Try
            QueryCall = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

60:     If QueryCall = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, referralCallOpenByWebPersonId) Then

            'Set the call data
70:         pvForm.CallNumber = vParams(0, 1)
80:         pvForm.CallType = modConv.TextToInt(vParams(0, 2))
90:         pvForm.CallDate = VB6.Format(vParams(0, 3), "mm/dd/yy  hh:mm")
100:        Call modControl.SelectID(pvForm.CboCallByEmployee, CInt(vParams(0, 4)))
110:        If pvForm.Name = "FrmReferralView" Then
120:            pvForm.CallTotalTime = IIf(vParams(0, 5) = "", "00:00:00", vParams(0, 5))
            Else
130:            pvForm.CallTotalTime = vParams(0, 5)
            End If
140:        pvForm.TimeSnapshot = Now  'change this to Now to represnt date and time instead of just time TimeOfDay
150:        pvForm.ChkTemp.Checked = modConv.DBTrueValueToChkValue(vParams(0, 10))
160:        pvForm.ChkExclusive.Checked = modConv.DBTrueValueToChkValue(vParams(0, 6))

170:        'If pvForm.ChkExclusive.Checked = System.Windows.Forms.CheckState.Checked Then
            'Checked shows boolean (true or false) and the condition is never equal
            If pvForm.ChkExclusive.CheckState = System.Windows.Forms.CheckState.Checked Then
                'Check if the call was saved incomplete by someone else
180:            If vParams(0, 13) <> "-1" And vParams(0, 13) <> "" And AppMain.ParentForm.StatEmployeeID <> vParams(0, 13) Then

                    'Check if the opening person has override permissions on an exclusive incomplete
190:                If Not modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowIncompleteAccess") Then

                        'The call was saved incomplete exclusively by someone else.
200:                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, modConv.TextToInt(vParams(0, 13))) = SUCCESS Then
                            Call MsgBox("This call was saved incomplete with exclusive access by " & vReturn2(0, 1) & "." & Chr(10) & "You will not be able to save any changes until " & vReturn2(0, 1) & " has saved the call as complete or without exclusive access.", MsgBoxStyle.OkOnly, "Incomplete - Exclusive")
210:                    Else
                            Call MsgBox("The call was saved incomplete with exclusive access by another user, but there has been a problem determining who has the call open.", MsgBoxStyle.OkOnly, "Incomplete - Exclusive")
                        End If

220:                    pvForm.CmdOK.Enabled = False
                        'pvForm.CmdModify.Enabled = False
230:                    pvForm.ChkTemp.Enabled = False
240:                    pvForm.ChkExclusive.Enabled = False

                    End If

                End If

            End If

250:        Call pvForm.SourceCode.GetItem(modConv.TextToLng(vParams(0, 11)))

            'First, see if the user has rights to close the referral, if open by another.  5/27/05 - SAP
            If vParams(0, 12) <> "-1" And vParams(0, 12) <> "" And AppMain.ParentForm.StatEmployeeID <> vParams(0, 12) And GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCloseReferral") Then
                If (CDbl(vParams(0, 12)) <> 0 And modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) < 1) Or (modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 And DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(vParams(0, 9)), Now) < 10) Then

                    Try
                        If modStatRefQuery.RefQueryStatEmployee(vReturn2, modConv.TextToInt(vParams(0, 12))) = SUCCESS _
                            AndAlso ObjectIsValidArray(vReturn2, 2, 0, 1) Then
                            sOpenMsg = "This call is already open by " & vReturn2(0, 1)
                        Else
                            sOpenMsg = "This call is already open."
                        End If
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    If modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 Then
                        sOpenMsg = sOpenMsg & " online." & Chr(10)
                    Else
                        sOpenMsg = sOpenMsg & "." & Chr(10)
                    End If
                    sOpenMsg = sOpenMsg & "To close the call and open it yourself, click 'Yes'," & Chr(10)
                    sOpenMsg = sOpenMsg & "to open it in read-only mode, click 'No'."
                    iResponse = MsgBox(sOpenMsg, MsgBoxStyle.YesNo + MsgBoxStyle.Question, "Call Open")

                    If iResponse = MsgBoxResult.Yes Then ' User chose Yes.
                        'WARNING THESE TWO LINE EXIST THREE PLACES IN THE PROCEDURE
                        pvunlock = 1
                        pvForm.CallOpenByID = AppMain.ParentForm.StatEmployeeID
                        Try
                            Call modStatSave.SaveCallOpenBy(pvForm, pvunlock)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                        pvunlock = 0
                    Else ' User chose No.
                        'This Else runs when a referral is open by someone other than the current StatEmployee
                        'This code sets the call to readonly
                        pvForm.CmdOK.Enabled = False
                        'pvForm.CmdModify.Enabled = False
                        pvForm.CallOpenByID = vReturn2(0, 0)
                        pvForm.ChkTemp.Enabled = False
                        pvForm.ChkExclusive.Enabled = False
                        If pvForm.Name = "FrmReferral" Then 'T.T 11/05/2004 added for QueryCall error
                            pvForm.chkCaseOpen.Enabled = False
                            pvForm.chkSystemEvents.Enabled = False
                            pvForm.chkSecondaryComplete.Enabled = False
                            pvForm.chkApproached.Enabled = False
                            pvForm.chkFinal.Enabled = False
                        End If
                    End If
                ElseIf modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 And DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(vParams(0, 9)), Now) > 10 Then
                    'WebPerson has been in call for greater than 10 minutes.
                    'Reset the Call and allow Read/Write Access
                    'BJK; WARNING THESE TWO LINE EXIST THREE PLACES IN THE PROCEDURE
                    pvForm.CallOpenByID = AppMain.ParentForm.StatEmployeeID
                    pvunlock = 1 ' pass 1 to SaveCallOpenBy to unlock call
                    Try
                        Call modStatSave.SaveCallOpenBy(pvForm, pvunlock)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If

                'Else if the user has no such rights, carry on with a warning.
260:        ElseIf vParams(0, 12) <> "-1" And vParams(0, 12) <> "" And AppMain.ParentForm.StatEmployeeID <> vParams(0, 12) Then

                'The call is already open by someone notify current user.
                'BJK 11/15/02 code to check if a webperson is in the requested call
                If (CDbl(vParams(0, 12)) <> 0 And modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) < 1) Or (modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 And DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(vParams(0, 9)), Now) < 10) Then
                    Try
270:                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, modConv.TextToInt(vParams(0, 12))) = SUCCESS _
                            AndAlso ObjectIsValidArray(vReturn2, 2, 0, 1) Then

                            sOpenMsg = "This call is already open by " & vReturn2(0, 1)
                            If modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 Then
                                sOpenMsg = sOpenMsg & " online." & Chr(10)
                            Else
                                sOpenMsg = sOpenMsg & "." & Chr(10)
                            End If
                            sOpenMsg = sOpenMsg & "You will not be able to save any changes until " & vReturn2(0, 1) & " has closed the call."
                            Call MsgBox(sOpenMsg, MsgBoxStyle.OkOnly, "Call Open")
290:                    Else
                            Call MsgBox("The call is already open by another user, but there has been a problem determining who has the call open.", MsgBoxStyle.OkOnly, "Call Open")
                        End If
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If

                'BJK 11/15/02 code to check if a webperson is in the requested call
                'BJK 11/13/08 changed the code to check for webpersonID instead of check statemployeeID = 0
                ' this if handles 2 situations
                ' 1 a user in Stattrac has the call open a message is always displayed
                ' 2 a user opens the call on the web and has not had it open for more than 10 minutes
300:            If modConv.TextToInt(vParams(0, referralCallOpenByWebPersonId)) > 1 And DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(vParams(0, 9)), Now) > 10 Then
                    'WebPerson has been in call for greater than 10 minutes.
                    'Reset the Call and allow Read/Write Access
                    'BJK; WARNING THESE TWO LINE EXIST THREE PLACES IN THE PROCEDURE
310:                pvForm.CallOpenByID = AppMain.ParentForm.StatEmployeeID
                    pvunlock = 1 ' pass 1 to SaveCallOpenBy to unlock call
                    Try
320:                    Call modStatSave.SaveCallOpenBy(pvForm, pvunlock)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                ElseIf ObjectIsValidArray(vReturn2, 2, 0, 0) Then
                    'if the current user cannot unlock the call then set callopenby back to the current person
                    pvForm.CallOpenByID = vReturn2(0, 0)
                    'This Else runs when a referral is open by someone other than the current StatEmployee
                    'This code sets the call to readonly
330:                pvForm.CmdOK.Enabled = False
                    '   pvForm.CmdModify.Enabled = False  'T.T 03/02/2007 commenting out there is not cmdmodify button
340:                'pvForm.CallOpenByID = AppMain.ParentForm.StatEmployeeID
350:                pvForm.ChkTemp.Enabled = False
360:                pvForm.ChkExclusive.Enabled = False

                    '7/9/01 drh Disable FS Case checkboxes
                    If pvForm.Name = "FrmReferral" Then 'T.T 11/05/2004 added for QueryCall error
370:                    pvForm.chkCaseOpen.Enabled = False
380:                    pvForm.chkSystemEvents.Enabled = False
390:                    pvForm.chkSecondaryComplete.Enabled = False
400:                    pvForm.chkApproached.Enabled = False
410:                    pvForm.chkFinal.Enabled = False
                    End If
                End If
            Else
                'BJK; WARNING THESE TWO LINE EXIST TWICE IN THE PROCEDURE
                '12/30/05 check to if family services and set a flag so callopenbyid won't get set if no access.
                If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralView" Or pvForm.Name = "FrmMessage" Then
                    If pvForm.Name = "FrmReferral" Then
                        If pvForm.CallExclusive = False And pvForm.CallFSCase = False Then
                            Try
                                Call modStatSave.SaveCallOpenBy(pvForm)
                            Catch ex As Exception
                                StatTracLogger.CreateInstance().Write(ex)
                            End Try
                        End If
                    End If
                    If pvForm.Name = "FrmMessage" And pvForm.CallExclusive = False Then
                        Try
                            Call modStatSave.SaveCallOpenBy(pvForm)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    End If
                    If pvForm.Name = "FrmReferralView" And pvForm.CallExclusive = False Then
                        Try
                            Call modStatSave.SaveCallOpenBy(pvForm)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    End If
                Else
                    Try
                        Call modStatSave.SaveCallOpenBy(pvForm)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If


            '7/9/01 drh Is this an FS Case?
440:        If pvForm.Name = "FrmReferral" Then
450:            Call QueryFSCase(pvForm, vReturn3)
                If Not IsNothing(vReturn3) _
                    AndAlso ObjectIsValidArray(vReturn3, 2, 0, 12) Then
                    If vReturn3(0, 4) <> 0 And vReturn3(0, 12) = 0 Then
                        'If so, then disable for changes if Person is a TC
                        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Then
                            Call MsgBox("This is a Family Services call.  You will not be able to save any changes.", MsgBoxStyle.OkOnly)

                            pvForm.CmdOK.Enabled = False
                            'pvForm.CmdModify.Enabled = False
                            pvForm.CallOpenByID = AppMain.ParentForm.StatEmployeeID
                            pvForm.ChkTemp.Enabled = False
                            pvForm.ChkExclusive.Enabled = False
                            pvForm.chkCaseOpen.Enabled = False
540:                        pvForm.chkSystemEvents.Enabled = False
550:                        pvForm.chkSecondaryComplete.Enabled = False
560:                        pvForm.chkApproached.Enabled = False
570:                        pvForm.chkFinal.Enabled = False
580:                        pvForm.CmdDelete.Enabled = False
                            ' Changed to allow Triage Coordinators to add new events, even if in FS.  4/22/05 - SAP
590:                        pvForm.CmdNewEvent.Enabled = True
600:                        pvForm.LstViewPending.Enabled = False
                            ' Changed to allow Triage Coordinators to add new events, even if in FS.  4/22/05 - SAP
610:                        pvForm.LstViewLogEvent.Enabled = True
                        End If
                    End If
                End If
            End If

        Else
620:        prReturn = VB6.CopyArray(vParams)
        End If

        Exit Function

    End Function
    Public Function QueryCallAccess(ByRef pvForm As Object, Optional ByRef prReturn As Object = Nothing) As Short
        '************************************************************************************
        'Name: QueryCallExclusive
        'Date Created: Char Chaput                          Created by: Char Chaput
        'Release:7.7.36                                                    Task:484
        'Description: Retrieves Call information from DB and checks for access rights for a case
        'Returns: Integer
        'Params: pvForm, Optional prReturn
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vReturn3 As New Object '7/9/01 drh Result set for FS Case
        Dim vTimeZoneDif As Short

10:     vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

20:     If pvForm.Name = "FrmReferralView" Then
            vQuery = "SELECT " & "c.CallID, c.CallNumber, c.CallTypeID, " & "DATEADD(hh, " & vTimeZoneDif & ", c.CallDateTime) AS CallDateTime , " & "c.StatEmployeeID, fs.FSCaseTotalTime as CallTotalTime, c.CallTempExclusive, c.Inactive, fs.FSCaseSeconds as CallSeconds, c.LastModified, c.CallTemp, " & "c.SourceCodeID, c.CallOpenByID, c.CallTempSavedByID, c.CallExtension, c.UpdatedFlag " & "FROM Call c " & "JOIN FSCase fs ON c.CallId = fs.CallId " & "WHERE c.CallID = " & pvForm.CallId & ";"
30:     Else
            vQuery = "SELECT " & "CallID, CallNumber, CallTypeID, " & "DATEADD(hh, " & vTimeZoneDif & ", CallDateTime) AS CallDateTime , " & "StatEmployeeID, CallTotalTime, CallTempExclusive, Inactive, CallSeconds, LastModified, CallTemp, " & "SourceCodeID, CallOpenByID, CallTempSavedByID, CallExtension, UpdatedFlag FROM Call " & "WHERE CallID = " & pvForm.CallId & ";"
40:     End If

50:     Try
            QueryCallAccess = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

60:     If QueryCallAccess = SUCCESS AndAlso ObjectIsValidArray(vParams, 2, 0, 13) Then

160:        pvForm.ChkExclusive.Checked = modConv.DBTrueValueToChkValue(vParams(0, 6))

            'pvForm.CallExclusive = False
170:        'If pvForm.ChkExclusive.Checked = System.Windows.Forms.CheckState.Checked Then
            'Checked shows boolean (true or false) and the condition is never equal
            If pvForm.ChkExclusive.CheckState = System.Windows.Forms.CheckState.Checked Then

                'Check if the call was saved incomplete by someone else
180:            If vParams(0, 13) <> "-1" And vParams(0, 13) <> "" And AppMain.ParentForm.StatEmployeeID <> vParams(0, 13) Then

                    'Check if the opening person has override permissions on an exclusive incomplete if they don't then
                    'set the flag to not allow access and not call savecallopenby in querycall
190:                If Not modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowIncompleteAccess") Then
                        pvForm.CallExclusive = True
                    End If

                End If

            End If

250:
        Else
620:        prReturn = VB6.CopyArray(vParams)
        End If


        '12/30/05 check to if family services and set a flag so callopenbyid won't get set if no access.
        Try
            Call QueryFSCase(pvForm, vReturn3)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If ObjectIsValidArray(vReturn3, 2, 0, 12) Then
            If vReturn3(0, 4) <> 0 And vReturn3(0, 12) = 0 Then
                If pvForm.Name <> "FrmReferralView" Then
                    'If so, then disable for changes if Person is a TC
                    If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Then
                        pvForm.CallFSCase = True
                    End If
                End If
            End If
        End If

        Exit Function

    End Function
    Public Function QueryDonorName(ByRef pvForm As FrmReferral, ByRef prReturn As Object, Optional ByRef useMedicalRecordNumber As Boolean = False) As Short
        '************************************************************************************
        'Name: QueryDonorName
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: queries the database for duplicate records
        'Returns: Return value of executed query in pvResults.
        'Params: pvForm = calling form,
        '
        '        pvResults = returning results
        'Stored Procedures: GetDuplicateReferral
        '====================================================================================
        '====================================================================================
        'Date Changed: 07/3/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.3 Performance reduce TimeOuts
        'Description:   replace dynamic query with GetDuplicateReferral stored procedure
        '====================================================================================
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim medicalRecordNumber As String = ""
        'add this to either search MedicalRecord Number of ReferralDonorLastName
        Dim referralDonorLastName As String = pvForm.TxtDonorLastName.Text
        Dim CardiacDateIsNull As Boolean = True
        Dim UserOrganizationID As Integer = 194
        If pvForm.TxtRecNum.Text.Length > 0 And useMedicalRecordNumber Then
            medicalRecordNumber = RemoveInvalidChars(pvForm.TxtRecNum.Text)

            referralDonorLastName = ""
        End If
        If pvForm.TxtDeathTime.Text.Length > 0 Then
            CardiacDateIsNull = False
        End If
        If ParentForm.LeaseOrganization > 0 Then
            UserOrganizationID = ParentForm.LeaseOrganization
        End If
        vQuery = String.Format("EXEC GetDuplicateReferral @ReferralDonorLastName = {0}, @SourceCodeID = {1}, @TimeZone = {2}, @UserOrganizationID = {3}, @MedicalRecordNumber = {4}, @ReferralCallerOrganizationID = {5}, @CardiacDateNull = {6}", modODBC.BuildField(referralDonorLastName), pvForm.SourceCode.ID, AppMain.ParentForm.TimeZone, UserOrganizationID, modODBC.BuildField(medicalRecordNumber), pvForm.OrganizationId, CardiacDateIsNull)

        Try
            QueryDonorName = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryDonorName = SUCCESS Then
            prReturn = vParams
        End If

    End Function


    Public Function QueryAlert(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Modified select to convert ntext fields to varchar
        'to display as rtf. Also had to set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************


        Dim vQuery As New Object
        Dim vParams As New Object
        Dim I As Short

        Dim byteChunk() As Byte
        Dim strAlert As String = ""
        Dim Offset As Integer
        Dim Totalsize As Integer
        Dim Remainder As Integer
        Dim NumOfChuncks As Integer
        'Dim CurrentRecPos As Long
        Dim FieldSize As Integer
        'Dim fieldactualsize As Long
        'Dim FileNumber As Integer
        'Const HeaderSize As Long = 78
        Const ChunkSize As Integer = 100
        'Const TempFile As String = "tempfile.tmp"


        pvForm.TxtAlerts(0).Text = ""
        pvForm.TxtAlerts(1).Text = ""
        pvForm.TxtAlerts(2).Text = ""
        pvForm.TxtAlerts(3).Text = ""
        pvForm.TxtAlerts(4).Text = ""

        'vQuery = "SELECT * " & _
        ''"FROM Alert " & _
        ''"WHERE AlertID = " & pvForm.AlertID

        'Char Chaput 04/19/2006 modified select to convert ntext fields to varchar to display rtf
        vQuery = "SELECT AlertID, AlertGroupName, " & "CAST(AlertMessage1 AS varchar(8000)), CAST(AlertMessage2 AS varchar(8000)), LastModified, AlertTypeID, " & "AlertLookupCode, CAST(AlertScheduleMessage  AS varchar(8000)), UpdatedFlag, CAST(AlertQAMessage1 AS varchar(8000)), CAST(AlertQAMessage2 AS varchar(8000)) " & "FROM Alert " & "WHERE AlertID = " & pvForm.AlertID

        Try
            QueryAlert = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryAlert = SUCCESS AndAlso ObjectIsValidArray(vParams, 2, 0, 10) Then
            modControl.SetRTFText(pvForm.TxtAlerts(0), vParams(0, 2))
            modControl.SetRTFText(pvForm.TxtAlerts(1), vParams(0, 3))
            modControl.SetRTFText(pvForm.TxtAlerts(2), vParams(0, 7))
            modControl.SetRTFText(pvForm.TxtAlerts(3), vParams(0, 9))
            modControl.SetRTFText(pvForm.TxtAlerts(4), vParams(0, 10))
        End If

    End Function
#Region "Family Services"

    '6/29/01 drh Added function to query Case Type
    Public Function QueryFSCase(ByRef pvForm As Object, ByRef pvResults As Object) As Short


        Dim vQuery As String = ""

        'Get FSCase Info
        vQuery = "exec sps_fscase1 " & pvForm.CallId & ", " & AppMain.ParentForm.TimeZone

        Try
            Call modODBC.Exec(vQuery, pvResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        QueryFSCase = True

    End Function

    Public Function QueryFSCaseWithSecondaryBilling(ByRef pvForm As Object, ByRef pvResults As Object) As Short

        Dim vQuery As String = ""

        'Get FSCaseWithBilling Info
        vQuery = "exec sps_FSCaseWithSecondaryBilling " & pvForm.CallId & ", " & AppMain.ParentForm.TimeZone

        Try
            Call modODBC.Exec(vQuery, pvResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryFSCaseWithSecondaryBilling = True

    End Function
#End Region

    Public Function QueryFamilyServicesServiceLevel(ByRef pvForm As FrmReferralView) As Object
        '************************************************************************************
        'Name: QueryFamilyServicesServiceLevel%
        'Date Created: 07/10/2007                          Created by: T.T
        'Release: 8.4                             Task: None
        'Description: query servicelevel for family services
        'Returns:
        'Params: pvForm = calling form
        'Stored Procedures: None
        '====================================================================================
        Dim vQuery As New Object
        Dim vQuery2 As Object
        Dim vRslist As New ADODB.Recordset
        Dim vResult As New Object
        Dim vResult2 As New Object
        Dim I As Short

        vQuery = "Select ServiceLevelID from callcriteria where callID = " & pvForm.CallId
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRslist)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        pvForm.CallerOrg.ServiceLevel.ID = vRslist.Fields("ServiceLevelID").Value

        vQuery2 = "select ServiceLevelDonorIntentdocumentName,ServiceLeveldonorIntentRetries,ServiceLevelDonorIntentOrganizationId,ServiceLevelDonorIntentFaxId,ServiceLevelDonorIntentPersonId,ServiceLevelCheckRegistry,ServiceLevelAlwaysPopRegistry from servicelevel where servicelevelID = " & pvForm.CallerOrg.ServiceLevel.ID
        Try
            Call modODBC.Exec(vQuery2, vResult2, , True, vRslist)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        pvForm.CallerOrg.ServiceLevel.DocumentName = vRslist.Fields("ServiceLevelDonorIntentdocumentName").Value
        pvForm.CallerOrg.ServiceLevel.Retries = vRslist.Fields("ServiceLeveldonorIntentRetries").Value
        pvForm.CallerOrg.ServiceLevel.OrganizationId = vRslist.Fields("ServiceLevelDonorIntentOrganizationId").Value
        pvForm.CallerOrg.ServiceLevel.FaxId = vRslist.Fields("ServiceLevelDonorIntentFaxId").Value
        pvForm.CallerOrg.ServiceLevel.PersonID = vRslist.Fields("ServiceLevelDonorIntentPersonId").Value
        pvForm.CallerOrg.ServiceLevel.CheckRegistryMode = vRslist.Fields("ServiceLevelCheckRegistry").Value
        pvForm.CallerOrg.ServiceLevel.AlwaysPopRegistry = If(vRslist.Fields("ServiceLevelAlwaysPopRegistry").Value = -1, True, False)

    End Function

    Public Function QuerySecondaryBilling(ByRef pvForm As FrmReferralView, ByRef pvResults As Object) As Short
        'FSProj drh 6/26/02


        Dim vQuery As New Object
        Dim I As Short

        'Get FSCase Info
        vQuery = "exec sps_fsbilling1 " & pvForm.CallId & ", " & AppMain.ParentForm.TimeZone

        Try
            Call modODBC.Exec(vQuery, pvResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        QuerySecondaryBilling = True

    End Function

    Public Function QuerySecondaryApproach(ByRef pvForm As FrmReferralView) As Short
        'FSProj drh 6/28/02

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vPersonResults As New Object
        Dim RS As New Object
        Dim I As Integer
        Dim j As Integer

        'BUILD/RUN THE QUERY (SECONDARYAPPROACH TABLE)
        '**************************************************************
        'Add the FROM/WHERE Clauses
        vQuery = "EXEC SelectSecondaryApproach @CallID = " & pvForm.CallId & ";"

        'Run the Query
        Try
            QuerySecondaryApproach = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        '**************************************************************


        'GET/SET THE APPROACH INFORMATION
        '**************************************************************
        If Not RS.EOF Then
            Call modControl.SelectID(pvForm.cboApproached, modConv.TextToLng(modConv.NullToText(RS("SecondaryApproached").Value)))
            Call modControl.SelectID(pvForm.cboApproachedBy, modConv.TextToLng(modConv.NullToText(RS("SecondaryApproachedBy").Value)))
            Call modControl.SelectID(pvForm.cboApproachType, modConv.TextToLng(modConv.NullToText(RS("SecondaryApproachType").Value)))
            Call modControl.SelectID(pvForm.cboApproachOutcome, modConv.TextToLng(modConv.NullToText(RS("SecondaryApproachOutcome").Value)))
            Call modControl.SelectID(pvForm.cboApproachReason, modConv.TextToLng(modConv.NullToText(RS("SecondaryApproachReason").Value)))
            Call modControl.SelectID(pvForm.cboConsent, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsented").Value)))
            Call modControl.SelectID(pvForm.cboConsentBy, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentBy").Value)))
            Call modControl.SelectID(pvForm.cboConsentResearch, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentResearch").Value)))

            'drh FSMod 07/16/03 - Default to N/A if blank
            If pvForm.cboConsentResearch.SelectedIndex = -1 Then
                Call modControl.SelectID(pvForm.cboConsentResearch, 3)
            End If

            'drh FSMod 05/28/03 - New Approach/Consent fields
            Call modControl.SelectID(pvForm.cboHospitalApproachType, modConv.TextToLng(modConv.NullToText(RS("SecondaryHospitalApproach").Value)))
            Call modControl.SelectID(pvForm.cboHospitalApproachedBy, modConv.TextToLng(modConv.NullToText(RS("SecondaryHospitalApproachedBy").Value)))
            Call modControl.SelectID(pvForm.cboHospitalApproachOutcome, modConv.TextToLng(modConv.NullToText(RS("SecondaryHospitalOutcome").Value)))
            Call modControl.SelectID(pvForm.cboConsentMedSocPaperwork, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentMedSocPaperwork").Value)))
            Call modControl.SelectID(pvForm.cboConsentMedSocObtainedBy, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentMedSocObtainedBy").Value)))
            Call modControl.SelectID(pvForm.cboConsentLongSleeves, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentLongSleeves").Value)))
            Call modControl.SelectID(pvForm.cboConsentFuneralPlan, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentFuneralPlans").Value)))

            'drh FSMod 07/16/03 - Default to N/A if blank
            If pvForm.cboConsentLongSleeves.SelectedIndex = -1 Then
                Call modControl.SelectID(pvForm.cboConsentLongSleeves, 0)
            End If

            If pvForm.cboConsentFuneralPlan.SelectedIndex = -1 Then
                If modConv.NullToText(RS("SecondaryConsentFuneralPlansOther").Value) <> "" Then
                    pvForm.cboConsentFuneralPlan.Text = modConv.NullToText(RS("SecondaryConsentFuneralPlansOther").Value)
                Else
                    'drh FSMod 07/16/03 - Default to N/A if blank
                    Call modControl.SelectID(pvForm.cboConsentFuneralPlan, 5)
                End If
            End If

            'drh FSMod 05/28/03 - No longer use these flds
            'Call modControl.SelectID(pvForm.cboConsentOutcome, modConv.TextToLng(modConv.NullToText(RS("SecondaryConsentOutcome").Value)))
            'pvForm.txtRecoveryLocation.Text = modConv.NullToText(RS("SecondaryRecoveryLocation").Value)

        End If
        '**************************************************************

    End Function
    Public Function QuerySecondaryTBIPrefix(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date 06/05/2007                              by: ccarroll
        'Release #: 8.4, requirement 3.6
        'Description:  Get data for Secondary TBI Prefix
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vResult As New Object

        vQuery = "GetTBIPrefix " & pvForm.CallerOrg.ServiceLevel.ID

        Try
            vResult = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case pvForm.Name
            Case "FrmReferralView"
                If QuerySecondaryTBIPrefix = SUCCESS _
                    AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then

                    pvForm.TBIPrefix = modConv.NullToText(vParams(0, 0))

                ElseIf QuerySecondaryTBIPrefix = NO_DATA Then
                    pvForm.TBIPrefix = ""

                End If

            Case "FrmReferral"
                If QuerySecondaryTBIPrefix = SUCCESS _
                    AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then

                    pvForm.TBIPrefix = modConv.NullToText(vParams(0, 0))

                ElseIf QuerySecondaryTBIPrefix = NO_DATA Then
                    pvForm.TBIPrefix = ""

                End If

        End Select

    End Function
    Public Function QuerySecondaryTBIAccess(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date 06/08/2007                              by: ccarroll
        'Release #: 8.4, requirement 3.6
        'Description:  Get Secondary TBI Access
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "GetTBIAccess " & pvForm.CallerOrg.ServiceLevel.ID

        Try
            QuerySecondaryTBIAccess = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySecondaryTBIAccess = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            pvForm.TBIAccess = vParams(0, 0)
        Else
            pvForm.TBIAccess = 0
        End If


    End Function

    Public Function QuerySecondaryTBI(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date 06/01/2007                              by: ccarroll
        'Release #: 8.4, requirement 3.6
        'Description:  Get data for Secondary TBI
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "GetTBI " & pvForm.CallId

        Try
            QuerySecondaryTBI = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case pvForm.Name
            Case "FrmReferralView"
                If QuerySecondaryTBI = SUCCESS _
                    AndAlso ObjectIsValidArray(vParams, 2, 0, 2) Then

                    pvForm.DataTextArray(36).Text = modConv.NullToText(vParams(0, 0))

                    'TBI number exists, disable editing and new number creation
                    'and enable checkbox for comment
                    pvForm.cmdGenerateTBI.Enabled = False
                    pvForm.chkSecondaryTBINotNeeded.Enabled = True
                    pvForm.txtSecondaryTBIComment.Enabled = True

                    pvForm.chkSecondaryTBINotNeeded.Checked = IIf(CDbl(vParams(0, 1)) = -1, 1, 0)
                    pvForm.txtSecondaryTBIComment.Text = modConv.NullToText(vParams(0, 2))

                ElseIf QuerySecondaryTBI = NO_DATA Then
                    pvForm.DataTextArray(36).Text = ""
                    pvForm.chkSecondaryTBINotNeeded.Checked = 0
                    pvForm.txtSecondaryTBIComment.Text = ""
                End If

            Case "FrmReferral"
                If QuerySecondaryTBI = SUCCESS _
                    AndAlso ObjectIsValidArray(vParams, 2, 0, 2) Then

                    pvForm.txtSecondaryTBINumber.Text = modConv.NullToText(vParams(0, 0))

                    'TBI number exists, disable editing and new number creation
                    'Note: DataTextArray(36) not used
                    'in FrmReferral.
                    pvForm.cmdGenerateTBI.Enabled = False
                    pvForm.chkSecondaryTBINotNeeded.Enabled = True
                    pvForm.txtSecondaryTBIComment.Enabled = True

                    pvForm.chkSecondaryTBINotNeeded.Checked = IIf(CDbl(vParams(0, 1)) = -1, 1, 0)
                    pvForm.txtSecondaryTBIComment.Text = modConv.NullToText(vParams(0, 2))

                ElseIf QuerySecondaryTBI = NO_DATA Then
                    pvForm.txtSecondaryTBINumber.Text = ""
                    pvForm.chkSecondaryTBINotNeeded.Checked = 0
                    pvForm.txtSecondaryTBIComment.Text = ""
                End If

        End Select

    End Function
    Public Function QueryOrganizationAlert(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF
        '====================================================================================
        '************************************************************************************


        Dim vQuery As New Object
        Dim vParams As New Object
        Dim I As Short

        pvForm.TxtAlerts(0).Text = ""
        pvForm.TxtAlerts(1).Text = ""

        'Char Chaput 04/19/2006 modified select to convert ntext fields to varchar to display rtf
        vQuery = "SELECT A.AlertID, A.AlertGroupName, " & "CAST(A.AlertMessage1 AS varchar(8000)), CAST(A.AlertMessage2 AS varchar(8000)), A.LastModified, A.AlertTypeID, " & "A.AlertLookupCode, CAST(A.AlertScheduleMessage AS varchar(8000)), A.UpdatedFlag, CAST(A.AlertQAMessage1 AS varchar(8000)), CAST(A.AlertQAMessage2 AS varchar(8000)) " & "FROM Alert A " & "JOIN AlertOrganization ON AlertOrganization.AlertID = A.AlertID " & "JOIN AlertSourceCode ON AlertSourceCode.AlertID = A.AlertID " & "WHERE OrganizationID = " & modODBC.BuildField(pvForm.OrganizationId) & " " & "AND A.AlertTypeID = " & modODBC.BuildField(pvForm.AlertType) & " " & "AND AlertSourceCode.SourceCodeID = " & modODBC.BuildField(pvForm.SourceCode.ID)


        Try
            QueryOrganizationAlert = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationAlert = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 7) Then
            modControl.SetRTFText(pvForm.TxtAlerts(0), vParams(0, 2))
            modControl.SetRTFText(pvForm.TxtAlerts(1), vParams(0, 3))
            pvForm.ScheduleAlert = vParams(0, 7)
        ElseIf QueryOrganizationAlert = NO_DATA Then
            pvForm.TxtAlerts(0).Text = ""
            pvForm.TxtAlerts(1).Text = ""
            pvForm.ScheduleAlert = ""
        End If

    End Function




    Public Function QueryLogEventScheduleID(ByRef pvForm As FrmReferral, ByVal pvScheduleGroupID As Integer, ByRef pvAlreadyContactedScheduleGroups As Object, ByRef pvOption As Object) As Boolean

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vResult As Short
        Dim vContactConfirmed As Boolean
        Dim vPendingPage As Boolean

        'Check if there are any confirmed contacts
        vQuery = "EXEC SelectLogEvent @CallID = " & pvForm.CallId & ", @ScheduleGroupID = " & pvScheduleGroupID & ", @LogEventContactConfirmed = 1 ;"

        Try
            vResult = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryLogEventScheduleID = False
        End Try

        'If there are results, then contact has been confirmed
        If vResult = SUCCESS Then
            vContactConfirmed = True
        Else
            vContactConfirmed = False
        End If

        'Check if there are any pending pages with callback pending
        vQuery = "EXEC SelectLogEvent @CallID = " & pvForm.CallId & ", @ScheduleGroupID = " & pvScheduleGroupID & ", @LogEventTypeID = " & PAGE_PENDING & ", @LogEventCallbackPending = 1 ;"

        Try
            vResult = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryLogEventScheduleID = False
        End Try

        'If there are results, then there is a pending page
        If vResult = SUCCESS Then
            vPendingPage = True
        Else
            vPendingPage = False
        End If


        'Return results
        'If there are any confirmed contacts, then no contact warning needs to be made
        If vContactConfirmed Then
            'Set an array element to show the schedule group has already been contacted.
            ReDim Preserve pvAlreadyContactedScheduleGroups(1, UBound(pvAlreadyContactedScheduleGroups, 2) + 1)
            pvAlreadyContactedScheduleGroups(0, UBound(pvAlreadyContactedScheduleGroups, 2)) = pvScheduleGroupID
            pvAlreadyContactedScheduleGroups(1, UBound(pvAlreadyContactedScheduleGroups, 2)) = pvOption

            QueryLogEventScheduleID = False
            Exit Function
        End If

        'If contact has not been confirmed, yet there is an active pending page,
        'then no contact warning
        If Not vContactConfirmed And vPendingPage Then
            'Set an array element to show the schedule group has already been contacted.
            ReDim Preserve pvAlreadyContactedScheduleGroups(1, UBound(pvAlreadyContactedScheduleGroups, 2) + 1)
            pvAlreadyContactedScheduleGroups(0, UBound(pvAlreadyContactedScheduleGroups, 2)) = pvScheduleGroupID
            pvAlreadyContactedScheduleGroups(1, UBound(pvAlreadyContactedScheduleGroups, 2)) = pvOption

            QueryLogEventScheduleID = False
            Exit Function
        End If

        'If contact has not been confirmed and there is no active pending page,
        'then give a contact warning
        If Not vContactConfirmed And Not vPendingPage Then
            QueryLogEventScheduleID = True
            Exit Function
        End If


        Exit Function

    End Function
    Public Function QueryOrganization(ByRef pvForm As FrmOrganization) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vPhoneID As Integer
        Dim vReturn As New Object


        vQuery = "EXEC SelectOrganization @OrganizationID = " & pvForm.OrganizationId & ";"

        Try
            QueryOrganization = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the call data
        If ObjectIsValidArray(vParams, 2, 0, 27) Then
            pvForm.OrganizationId = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.TxtAddress1.Text = vParams(0, 2)
            pvForm.TxtAddress2.Text = vParams(0, 3)
            pvForm.TxtCity.Text = vParams(0, 4)
            Call modControl.SelectID(pvForm.CboState, CInt(vParams(0, 5)))

            pvForm.TxtZipCode.Text = vParams(0, 6)
            Call modControl.SelectID(pvForm.CboCounty, CInt(vParams(0, 7)))
            Call modControl.SelectID(pvForm.CboOrganizationType, CInt(vParams(0, 8)))
            vPhoneID = modConv.TextToLng(vParams(0, 9))
            Call modControl.SelectText(pvForm.CboTimeZone, vParams(0, 10))
            pvForm.TxtNotes.Text = vParams(0, 11)
            pvForm.ChkVerified.Checked = modConv.DBTrueValueToChkValue(vParams(0, 14))
            pvForm.TxtCode.Text = vParams(0, 27)
        End If

        'Get the central phone number
        Call modStatRefQuery.RefQueryPhone(vReturn, vPhoneID)
        If ObjectIsValidArray(vReturn, 2, 0, 0) Then
            pvForm.TxtCentralPhone.Tag = modConv.TextToLng(vReturn(0, 0))
        End If
        pvForm.TxtCentralPhone.Text = modUtility.BuildPhone(vReturn)
    End Function
    Public Function QueryOrganizationProperties(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Modified select to convert ntext fields to varchar
        'to display as rtf. Also had to set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************
        'Date Changed: 01/15/07                          Changed by: Thien Ta
        'Release #: 8.0                               Task: Unknown
        'Description:  Added checkbox for donortrac clients
        '====================================================================================
        '************************************************************************************


        Dim vQuery As New Object
        Dim LO As New Object
        Dim vParams As New Object
        Dim vParams1 As Object = New Object
        Dim vPhoneID As Integer

        Dim I As Short
        'change 6/2001 bjk: Built the organization field list. added OrganizationLO, OrganizationEnabled, and callback number
        vQuery = String.Format("SELECT Organization.OrganizationID, Organization.OrganizationName, Organization.OrganizationAddress1, Organization.OrganizationAddress2,  Organization.OrganizationCity, Organization.StateID, Organization.OrganizationZipCode, Organization.CountyID, Organization.OrganizationTypeID, Organization.PhoneID,  TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', Organization.OrganizationNotes, Organization.OrganizationNoPatientName, Organization.OrganizationNoRecordNum,  Organization.Verified, Organization.Inactive, Organization.OrganizationNoAdmitDateTime,  Organization.OrganizationNoWeight, Organization.OrganizationConfCallCust, Organization.Unused2, Organization.Unused3, Organization.Unused4,  Organization.Unused5, Organization.Unused6, Organization.OrganizationPageInterval, Organization.LastModified, Organization.Unused8, Organization.OrganizationUserCode,  CAST(Organization.OrganizationReferralNotes  AS varchar(8000)), CAST(Organization.OrganizationMessageNotes  AS varchar(8000)), Organization.OrganizationConsentInterval, Organization.OrganizationLO, Organization.OrganizationLOEnabled, '(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'') AS CallBack  FROM Organization LEFT JOIN CallBack On CallBack.OrganizationID = Organization.OrganizationID LEFT JOIN Phone On Phone.PhoneID = CallBack.PhoneID LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID WHERE Organization.OrganizationID = {0} ;", pvForm.OrganizationId)

        Try
            QueryOrganizationProperties = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If QueryOrganizationProperties = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 33) Then

            Select Case pvForm.Name

                Case "FrmOrganizationProperties"
                    'Set the data
                    pvForm.OrganizationId = vParams(0, 0)
                    pvForm.ChkNoPatientName.Checked = modConv.DBTrueValueToChkValue(vParams(0, 12))
                    pvForm.ChkNoMedRecord.Checked = modConv.DBTrueValueToChkValue(vParams(0, 13))
                    pvForm.ChkConfCall.Checked = modConv.DBTrueValueToChkValue(vParams(0, 18))
                    pvForm.TxtPageInterval.Text = vParams(0, 24)
                    pvForm.TxtConsentInterval.Text = vParams(0, 30)
                    pvForm.ChkLeaseOrganization.Checked = modConv.DBTrueValueToChkValue(vParams(0, 31))
                    pvForm.TxtPhone.Text = vParams(0, 33)
                    'pvForm.chkDTClient = modConv.DBTrueValueToChkValue(vParams(0, 34))   'T.T 01/15/2007 added to donortrac client check

                    'T.T 5/15/2004 added for Family services LO to check LO checkboxes
                    If CDbl(vParams(0, 31)) = -1 Then
                        LO = modStatQuery.LeaseOrganizationType(modConv.TextToInt(vParams(0, 0)), vParams1)

                        For I = 0 To UBound(vParams1)
                            Select Case vParams1(I, 0)
                                Case "FamilyServices"
                                    pvForm.ChkFamilyServicesLO.Checked = 1
                                Case "Triage"
                                    pvForm.ChkTriageLO.Checked = 1
                            End Select
                        Next I
                    End If


                Case "FrmReferral"

                    If pvForm.FormState = NEW_RECORD Then
                        'Default the name and record number fields
                        If modConv.TextToInt(vParams(0, 12)) = -1 Then
                            pvForm.TxtDonorLastName.Text = "Not Given"
                        End If

                        If modConv.TextToInt(vParams(0, 13)) = -1 Then
                            pvForm.TxtRecNum.Text = "Not Given"
                        End If
                    End If

                Case "FrmSchedule"
                    'Set the data
                    modControl.SetRTFText(pvForm.TxtReferralNotes, vParams(0, 28))
                    modControl.SetRTFText(pvForm.TxtMessageNotes, vParams(0, 29))

            End Select

        End If
        Exit Function
    End Function

    Public Function QueryStatTracPersonProperties(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Name: QueryStatTracPersonProperties%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Returns StatEmployee properties
        'Returns: Integer
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/27/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added new field, AllowCloseReferral, to StatEmployee table
        '====================================================================================
        'Date Changed: 2/10/2011                          Changed by: ccarroll
        'Release #: 9.2                               Task: 
        'Description:  Changed to reference new security Rules from modStatSecurity.GetPermission()
        '====================================================================================
        '************************************************************************************
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vPhoneID As Integer
        Dim QAAccess As New Object

        'drh FSMod 07/24/03 - Added JOIN
        vQuery = "SELECT se.*, p.PersonSecurity, wp.WebPersonID FROM StatEmployee se " & "JOIN Person p ON se.PersonId = p.PersonId " & "JOIN WebPerson wp ON wp.PersonID = p.PersonID " & "WHERE se.PersonID = " & pvForm.PersonID & ";"

        Try
            QueryStatTracPersonProperties = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryStatTracPersonProperties = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 26) Then
            'ccarroll 060706 added case statement to check for QA access
            Select Case pvForm.Name
                Case "FrmPersonProperties"

                    'Set the data
                    pvForm.TxtUserID.Text = vParams(0, 3)
                    pvForm.TxtPassword.Text = vParams(0, 4)
                    pvForm.TxtConfirm.Text = vParams(0, 4)
                    pvForm.ChkAllowDeleteCall.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowCallDelete")
                    pvForm.ChkAllowMaintain.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowMaintainAccess")
                    pvForm.ChkAllowSecurityAccess.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowSecurityAccess")
                    pvForm.TxtEmail.Text = vParams(0, 11)
                    pvForm.ChkAllowStopTimer.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowStopTimerAccess")
                    pvForm.ChkAllowIncomplete.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowIncompleteAccess")
                    pvForm.ChkAllowScheduleAccess.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowScheduleAccess")
                    pvForm.ChkAllowRecovery.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowRecoveryAccess")
                    pvForm.ChkAllowInternetAccess.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowInternetAccess")

                    ' Added value from AllowCloseReferral.  v 8.0, 5/27/05 - SAP
                    pvForm.ChkAllowCloseReferral.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowCloseReferral")

                    'T.T 05/18/2006 allowRecycleCase
                    pvForm.chkAllowRecycleCase.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowRecycleCase")
                    'ccarroll 06/06/2006 AllowQAReview
                    pvForm.ChkAllowQAReview.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowQAReview")

                    'drh FSMod 07/24/03 - Hardcoded bit value for now; will make dynamic later
                    pvForm.ChkAllowAddMedication.Checked = IIf(CShort(vParams(0, 26)) = 256, 1, 0)

                    'T.T 11/13/2006 - ASPSave
                    pvForm.chkAllowASPSave.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowASPSave")

                    'Bret 6/11/2007 AllowViewDeletedLogEvents
                    pvForm.chkAllowViewDeletedLogEvents.Checked = modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowViewDeletedLogEvents")



                    'ccarroll 01/16/2008 - set Webuser values
                    ' moved to this location from outside case statment
                    vQuery = "EXEC SelectWebPerson @PersonID = " & pvForm.PersonID & ";"

                    'PvForm.Chk
                    Try
                        QueryStatTracPersonProperties = modODBC.Exec(vQuery, vParams)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try

                    If QueryStatTracPersonProperties = SUCCESS _
                        AndAlso ObjectIsValidArray(vParams, 2, 0, 9) Then

                        'Set the data
                        pvForm.WebPersonID = vParams(0, 0)
                        pvForm.TxtUserID.Text = vParams(0, 1)
                        pvForm.TxtEmail.Text = vParams(0, 9)

                    Else
                        pvForm.WebPersonID = 0
                    End If


                Case "FrmReferral"
                    If modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowQAReview") Then
                        pvForm.QAAccess = True
                    Else
                        pvForm.QAAccess = False
                    End If

            End Select

        Else
            'ccarroll 01/16/2008 - added default value so new Webuser can be created
            pvForm.WebPersonID = 0

        End If

    End Function

    Public Function QueryPersonProperties(ByRef pvForm As FrmPersonProperties) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vPhoneID As Integer
        Dim vReturn As New Object

        If IsStatTracPerson(pvForm) Then

            Call QueryStatTracPersonProperties(pvForm)

        Else

            vQuery = "EXEC SelectWebPerson @PersonID = " & pvForm.PersonID & ";"

            Try
                QueryPersonProperties = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryPersonProperties = SUCCESS _
                AndAlso ObjectIsValidArray(vParams, 2, 0, 9) Then

                'Set the data
                pvForm.WebPersonID = vParams(0, 0)
                pvForm.TxtUserID.Text = vParams(0, 1)
                pvForm.TxtPassword.Text = vParams(0, 3)
                pvForm.TxtConfirm.Text = vParams(0, 3)
                pvForm.TxtEmail.Text = vParams(0, 9)

            End If

        End If

    End Function




    Public Function QueryPerson(ByRef pvForm As FrmPerson) As Short
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        Dim vQuery As New Object
        Dim vParams As New Object
        'added 6/2001 bjk: OrganizationLO field
        vQuery = "SELECT Person.PersonID , Person.PersonFirst, Person.PersonMI, Person.PersonLast, Person.PersonTypeID, Person.OrganizationId, Person.PersonNotes, Person.PersonBusy, Person.Verified, Person.Inactive, Person.LastModified, Person.PersonBusyUntil, Person.PersonTempNoteActive, Person.PersonTempNoteExpires, Person.PersonTempNote, Person.Unused, Person.UpdatedFlag, Person.AllowInternetScheduleAccess, Person.PersonSecurity, " & "Organization.OrganizationName, Organization.OrganizationLO " & "FROM Person " & "LEFT JOIN Organization ON Person.OrganizationID = Organization.OrganizationID " & "WHERE PersonID = " & pvForm.PersonID & ";"

        Try
            QueryPerson = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 20) Then

            'Set the call data
            pvForm.PersonID = vParams(0, 0)
            pvForm.TxtFirst.Text = vParams(0, 1)
            pvForm.TxtMI.Text = vParams(0, 2)
            pvForm.TxtLast.Text = vParams(0, 3)
            Call modControl.SelectID(pvForm.CboPersonType, CInt(vParams(0, 4)))
            pvForm.TxtNotes.Text = vParams(0, 6)
            pvForm.ChkBusy.Checked = modConv.DBTrueValueToChkValue(vParams(0, 7))
            pvForm.Verified = vParams(0, 8)
            pvForm.ChkInactive.Checked = vParams(0, 9)
            If vParams(0, 11) = "" Then
                pvForm.TxtBusyUntil.Text = ""
            Else
                pvForm.TxtBusyUntil.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, CDate(vParams(0, 11))), "mm/dd/yy  hh:mm")
            End If
            pvForm.ChkTempNote.Checked = modConv.DBTrueValueToChkValue(vParams(0, 12))
            If vParams(0, 13) = "" Then
                pvForm.TxtTempExpires.Text = ""
                pvForm.TxtTempNotes.Text = ""
            Else
                pvForm.TxtTempExpires.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, CDate(vParams(0, 13))), "mm/dd/yy  hh:mm")
                pvForm.TxtTempNotes.Text = vParams(0, 14)
            End If

            'Set the organization list
            pvForm.CboOrganization.Items.Add(New ValueDescriptionPair(modConv.TextToLng(vParams(0, 5)), vParams(0, 19)))

            'Set the organization combo box to the current organization
            Call modControl.SelectID(pvForm.CboOrganization, modConv.TextToLng(vParams(0, 5)))
            'Set OrganizationLO for form

            pvForm.LeaseOrganization = modConv.TextToInt(vParams(0, 20))

        End If

    End Function
    Public Function QueryDuplicateUser(ByRef pvForm As FrmPersonProperties) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT StatEmployee.StatEmployeeUserId " & "FROM StatEmployee " & "WHERE StatEmployee.StatEmployeeUserId = " & modODBC.BuildField(pvForm.TxtUserID.Text) & " " & "AND StatEmployee.PersonId <> " & pvForm.PersonID & ";"

        Try
            QueryDuplicateUser = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function QueryDuplicatePerson(ByRef pvForm As FrmPerson) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT Person.PersonID " & "FROM Person " & "WHERE Person.PersonFirst = " & modODBC.BuildField(pvForm.TxtFirst.Text) & " " & "AND Person.PersonLast = " & modODBC.BuildField(pvForm.TxtLast.Text) & " " & "AND Person.OrganizationID = " & modControl.GetID(pvForm.CboOrganization) & ";"

        Try
            QueryDuplicatePerson = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function QueryPersonPhone(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim I As Short

        If pvForm.Name = "FrmPersonPhone" Then

            vQuery = "SELECT Phone.PhoneID, '(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,''), "
            vQuery = vQuery & "PersonPhone.PersonPhonePIN, Phone.PhoneTypeID, PhoneAlphaPagerEmail " & "FROM Phone, PersonPhone " & "WHERE PersonPhone.PhoneID = Phone.PhoneID " & "AND Phone.PhoneID = " & pvForm.PhoneID & " " & "AND PersonPhone.PersonID = " & pvForm.PersonID & ";"

            Try
                QueryPersonPhone = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryPersonPhone = SUCCESS _
                AndAlso ObjectIsValidArray(vParams, 2, 0, 4) Then
                'Set the data
                pvForm.PhoneID = modConv.TextToLng(vParams(0, 0))
                pvForm.TxtPhone.Text = vParams(0, 1)
                pvForm.TxtPIN.Text = vParams(0, 2)
                Call modControl.SelectID(pvForm.CboPhoneType, CInt(vParams(0, 3)))
                pvForm.TxtAlpha.Text = vParams(0, 4)
            End If

        Else

            vQuery = "EXEC SelectPhoneTypesByPersonId @PersonID=" & pvForm.PersonID & ";"

            Try
                QueryPersonPhone = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryPersonPhone = SUCCESS Then
                If pvForm.Name = "FrmOnCall" Or pvForm.Name = "FrmOnCallEvent" Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewContact, True)
                ElseIf pvForm.Name = "FrmPerson" Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewPhone, False)
                End If
            End If

        End If

    End Function

    Public Function QueryOrganizationPhone(ByRef pvForm As FrmOrganizationProperties) As Short

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vReturn As New Object
        Dim I As Short

        '11/9/01 drh Added isnull to replace nulls with zero; This fixes Issue #7
        vQuery = "SELECT DISTINCT "
        vQuery = vQuery & "isnull(CONVERT(varchar(30), Phone.PhoneID), CONVERT(varchar(1), 0)) + ',' +" & "isnull(CONVERT(varchar(30), SubLocation.SubLocationID), CONVERT(varchar(1), 0)) + ',' +" & "isnull(CONVERT(varchar(30), SubLocationLevel.SubLocationLevelID), CONVERT(varchar(1), 0)), " & "('(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'') + '  ' + ISNULL(Phone.PhonePIN,'')) as PhoneNumber, " & "SubLocation.SubLocationName + ' ' + SubLocationLevel.SubLocationLevelName as PhoneSub "

        vQuery = vQuery & "FROM Phone " & "INNER JOIN ((Referral LEFT JOIN SubLocation " & "ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID) " & "LEFT JOIN SubLocationLevel " & "ON Referral.ReferralCallerLevelID = SubLocationLevel.SubLocationLevelID) " & "ON Phone.PhoneID = Referral.ReferralCallerPhoneID " & "WHERE Referral.ReferralCallerOrganizationID = " & pvForm.OrganizationId & " ORDER BY PhoneNumber, PhoneSub;"

        Try
            QueryOrganizationPhone = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationPhone = SUCCESS Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewPhone, False)
        End If

    End Function

    Public Function QueryOrganizationFax(ByRef pvForm As FrmOrganizationProperties) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim I As Short

        vQuery = "SELECT FaxId, FaxNumber FROM Fax WHERE OrganizationId = " & pvForm.OrganizationId

        Try
            QueryOrganizationFax = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If QueryOrganizationFax = SUCCESS Then
            Call modControl.SetTextID(pvForm.lstFaxNumbers, vReturn, True)
        End If

    End Function

    Public Function QueryReferralList(ByRef pvForm As FrmReferralList) As Short

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vReturn As New Object
        Dim I As Short
        Dim vTimeZoneDif As Short


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vQuery = "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",Call.CallDateTime), " & "PersonLast " & "FROM Call " & "JOIN Referral ON Referral.CallID = Call.CallID " & "JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID " & "JOIN Person ON Person.PersonID = StatEmployee.PersonID " & "WHERE Referral.ReferralCallerPhoneID = " & pvForm.PhoneID & " " & "AND Referral.ReferralCallerSubLocationID = " & pvForm.SubLocationID & " " & "AND Referral.ReferralCallerSubLocationLevel = " & pvForm.SubLocationLevel & " " & "ORDER BY " & "DATEADD(hh, " & vTimeZoneDif & ",Call.CallDateTime) "

        Try
            QueryReferralList = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryReferralList = SUCCESS Then
            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            If QueryReferralList = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstReferralList, False)
            End If
        End If

    End Function
    Public Function QueryOrganizationReferrals(ByRef pvForm As FrmOpenOrganization) As Short

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vReturn As New Object
        Dim I As Short


        vQuery = "SELECT DISTINCT Referral.ReferralID " & "FROM Referral " & "WHERE Referral.ReferralCallerOrganizationID = " & modODBC.BuildField(pvForm.OrganizationId)

        Try
            QueryOrganizationReferrals = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function QueryOrganizationSchedulePerson(ByRef pvForm As Object) As Short

        Dim vQuery As New Object

        Dim vReturn As New Object
        Dim vReturnDetail As New Object
        Dim I As Short
        Dim j As Short
        Dim vReturnCode As Short
        Dim vPersonList As New Object
        Dim vTimeZoneDif As Short


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'Get the person id's of those on call
        vQuery = "SELECT DISTINCT Schedule.ScheduleCall1PersonID, " & "Schedule.ScheduleCall2PersonID, " & "Schedule.ScheduleCall3PersonID, " & "Schedule.ScheduleCall4PersonID, " & "Schedule.ScheduleCall5PersonID, " & "Schedule.ScheduleCall6PersonID, ScheduleID " & "FROM Schedule WHERE Schedule.OrganizationID = " & pvForm.OrganizationId & " " & "AND Schedule.ScheduleGroupID = " & pvForm.ScheduleGroupID & " " & "AND Schedule.ScheduleDate = " & modODBC.BuildField(VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, pvForm.CurrentDate), "mm/dd/yy")) & " " & "AND Schedule.ScheduleShiftID = " & pvForm.ScheduleShiftID & " ORDER BY ScheduleID ASC "

        Try
            QueryOrganizationSchedulePerson = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationSchedulePerson = SUCCESS Then

            'Set the number of rows
            j = 0
            For I = 0 To UBound(vReturn, 2) - 1
                If vReturn(0, I) <> "-1" Then
                    j = j + 1
                End If
            Next I

            ReDim vPersonList(j - 1, 2)

            'Get the person names
            For I = 0 To UBound(vReturn, 2)

                'The first item is a blank item in the return
                vQuery = "SELECT Person.PersonID, " & "Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast, "

                vQuery = vQuery & "PersonType.PersonTypeName, PersonBusy, PersonBusyUntil " & "FROM Person " & "INNER JOIN PersonType " & "ON Person.PersonTypeID = PersonType.PersonTypeID " & "WHERE Person.PersonID = " & modConv.TextToLng(vReturn(0, I)) & ";"

                Try
                    vReturnCode = modODBC.Exec(vQuery, vReturnDetail)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If ObjectIsValidArray(vReturnDetail, 2, 0, 4) AndAlso vReturnDetail(0, 3) = "-1" Then
                    If CDate(vReturnDetail(0, 4)) > Now Then
                        vPersonList(I, 0) = vReturnDetail(0, 0)
                        vPersonList(I, 1) = vReturnDetail(0, 1)
                        vPersonList(I, 2) = "**** Busy ****"
                    Else
                        vQuery = "UPDATE Person SET PersonBusy = 0, PersonBusyUntil = Null " & "WHERE PersonID = " & vReturnDetail(0, 0)
                        Try
                            vReturnCode = modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                        vPersonList(I, 0) = vReturnDetail(0, 0)
                        vPersonList(I, 1) = vReturnDetail(0, 1)
                        vPersonList(I, 2) = vReturnDetail(0, 2)
                    End If
                ElseIf ObjectIsValidArray(vReturnDetail, 2, 0, 2) Then
                    vPersonList(I, 0) = vReturnDetail(0, 0)
                    vPersonList(I, 1) = vReturnDetail(0, 1)
                    vPersonList(I, 2) = vReturnDetail(0, 2)
                End If

            Next I

            'Fill the list view box
            Call modControl.SetListViewRows(vPersonList, True, pvForm.LstViewPerson, True)

        End If

    End Function

    Public Function QueryOrganizationNewSchedulePerson(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim I As Short
        Dim vPersonList As New Object
        '02/25/03 bjk added vTimeZoneDif and function to populate
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'Get the person id's of those on call
        vQuery = "SELECT " & "Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN '(Inactive) ' + Person.PersonFirst+' '+PersonLast " & "ELSE Person.PersonFirst+' '+PersonLast " & "END  AS Person, " & "PersonType.PersonTypeName, " & "Priority, PersonBusy, " & "DATEADD(hh, " & vTimeZoneDif & ", PersonBusyUntil) " & "FROM ScheduleItemPerson " & "JOIN Person ON Person.PersonID = ScheduleItemPerson.PersonID " & "JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID " & "WHERE ScheduleItemID = " & pvForm.ScheduleShiftID & " ORDER BY Priority ASC "

        Try
            QueryOrganizationNewSchedulePerson = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationNewSchedulePerson = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 2) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 2) Then

            'Get the number of people on call
            ReDim vPersonList(UBound(vReturn, 1), 2)

            'Get the person names
            For I = 0 To UBound(vReturn, 1)

                If vReturn(I, 4) = System.Math.Abs(1) Then
                    ' changed: 06/26 vReturn(0,5) to vReturn(i,5)
                    If CDate(vReturn(I, 5)) > Now Then
                        vPersonList(I, 0) = vReturn(I, 0)
                        vPersonList(I, 1) = vReturn(I, 1)
                        vPersonList(I, 2) = "**** Busy ****"
                    Else
                        vQuery = "UPDATE Person SET PersonBusy = 0, PersonBusyUntil = Null " & "WHERE PersonID = " & vReturn(I, 0)
                        Try
                            Call modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                        vPersonList(I, 0) = vReturn(I, 0)
                        vPersonList(I, 1) = vReturn(I, 1)
                        vPersonList(I, 2) = vReturn(I, 2)
                    End If
                Else
                    vPersonList(I, 0) = vReturn(I, 0)
                    vPersonList(I, 1) = vReturn(I, 1)
                    vPersonList(I, 2) = vReturn(I, 2)
                End If

            Next I

            'Fill the list view box
            Call modControl.SetListViewRows(vPersonList, True, pvForm.LstViewPerson, True)

        End If

    End Function
    Public Function QueryCategoryCriteria(ByRef pvForm As Object, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vReturn As New Object
        Dim vReturnCode As Short
        Dim I As Short

        'Build the query
        vQuery = "SELECT * " & "FROM Criteria " & "WHERE Criteria.DonorCategoryID = " & pvForm.DonorCategoryID & " " & "AND Criteria.CriteriaID = " & pvForm.CriteriaGroupID & ";"

        Try
            QueryCategoryCriteria = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCategoryCriteria = NO_DATA Then

            If pvForm.Name = "FrmCriteria" Then
                'If the category group does not have criteria, then set
                'the form state to new.
                pvForm.FormState = NEW_RECORD
                Erase vReturn
            End If

        ElseIf QueryCategoryCriteria = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 31) Then

            If pvForm.Name = "FrmCriteria" Then
                'If the category group has criteria, then set
                'the form state to existing.
                pvForm.FormState = EXISTING_RECORD

                'Set the data
                pvForm.CriteriaID = vReturn(0, 0)
                pvForm.TxtMaleUpper.Text = vReturn(0, 3)
                pvForm.TxtMaleLower.Text = vReturn(0, 4)
                pvForm.TxtFemaleUpper.Text = vReturn(0, 5)
                pvForm.TxtFemaleLower.Text = vReturn(0, 6)
                If pvForm.DonorCategoryID = 0 Then
                    pvForm.TxtVerifyMessage.Text = vReturn(0, 7)
                Else
                    pvForm.TxtGeneralRuleout.Text = vReturn(0, 7)
                End If
                pvForm.ChkNotAppropriateMale.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 9))
                pvForm.ChkNotAppropriateFemale.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 11))
                pvForm.ChkReferNonPotential.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 12))
                pvForm.TxtLowerWeight.Text = vReturn(0, 14)
                pvForm.TxtUpperWeight.Text = vReturn(0, 15)
                If vReturn(0, 22) = "Years" Then
                    pvForm.Lable(11).Text = "Upper              yrs."
                Else
                    pvForm.Lable(11).Text = "Upper              mos."
                End If
                If vReturn(0, 23) = "Years" Then
                    pvForm.Lable(10).Text = "Lower              yrs."
                Else
                    pvForm.Lable(10).Text = "Lower              mos."
                End If
                If vReturn(0, 24) = "Years" Then
                    pvForm.Lable(13).Text = "Upper              yrs."
                Else
                    pvForm.Lable(13).Text = "Upper              mos."
                End If
                If vReturn(0, 25) = "Years" Then
                    pvForm.Lable(15).Text = "Lower              yrs."
                Else
                    pvForm.Lable(15).Text = "Lower              mos."
                End If
                'T.T 08/19/2005 added for donortrac criteria mapping
                If vReturn(0, 31) = "" Then
                    pvForm.CboDonorTracCriteriaGroup.SelectedIndex = 0
                Else
                    pvForm.CboDonorTracCriteriaGroup.SelectedIndex = vReturn(0, 31) - 1
                End If
            ElseIf pvForm.Name = "FrmReferral" Then
                pvReturn = vReturn
            End If

        End If
    End Function

    Public Function QueryTemplateCriteria(ByRef pvForm As FrmCriteriaTemplate, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/15/02

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vReturn As New Object
        Dim vReturnCode As Short
        Dim I As Short

        'Build the query
        vQuery = "SELECT * " & "FROM CriteriaTemplate " & "WHERE CriteriaTemplateID = " & pvForm.vCriteriaTemplateId & ";"

        Try
            QueryTemplateCriteria = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryTemplateCriteria = NO_DATA Then

            pvForm.FormState = NEW_RECORD
            Erase vReturn

        ElseIf QueryTemplateCriteria = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 20) Then

            'If the category group has criteria, then set
            'the form state to existing.
            'pvForm.FormState = EXISTING_RECORD

            'Set the data
            pvForm.txtCriteriaTemplateName.Text = vReturn(0, 2)
            pvForm.TxtMaleUpper.Text = vReturn(0, 3)
            pvForm.TxtMaleLower.Text = vReturn(0, 4)
            pvForm.TxtFemaleUpper.Text = vReturn(0, 5)
            pvForm.TxtFemaleLower.Text = vReturn(0, 6)
            pvForm.TxtGeneralRuleout.Text = vReturn(0, 7)
            pvForm.ChkNotAppropriateMale.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 8))
            pvForm.ChkNotAppropriateFemale.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 9))
            pvForm.ChkReferNonPotential.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 10))
            pvForm.TxtLowerWeight.Text = vReturn(0, 11)
            pvForm.TxtUpperWeight.Text = vReturn(0, 12)
            If Trim(vReturn(0, 15)) = "Years" Then
                pvForm.Lable(11).Text = "Upper              yrs."
            Else
                pvForm.Lable(11).Text = "Upper              mos."
            End If
            If Trim(vReturn(0, 16)) = "Years" Then
                pvForm.Lable(10).Text = "Lower              yrs."
            Else
                pvForm.Lable(10).Text = "Lower              mos."
            End If
            If Trim(vReturn(0, 17)) = "Years" Then
                pvForm.Lable(13).Text = "Upper              yrs."
            Else
                pvForm.Lable(13).Text = "Upper              mos."
            End If
            If Trim(vReturn(0, 18)) = "Years" Then
                pvForm.Lable(15).Text = "Lower              yrs."
            Else
                pvForm.Lable(15).Text = "Lower              mos."
            End If
            pvForm.TxtFemaleLowerWeight.Text = vReturn(0, 20)
            pvForm.TxtFemaleUpperWeight.Text = vReturn(0, 19)
        End If

    End Function

    Public Function QuerySubCriteria(ByRef pvForm As FrmCriteria, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/15/02

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReturnCode As Short
        Dim I As Short
        Dim vSubCriteriaId As Integer

        vSubCriteriaId = modControl.GetID(pvForm.cboSubtypeProcessor(0))

        'Build the query
        vQuery = "SELECT * " & "FROM SubCriteria " & "WHERE SubCriteriaID = " & vSubCriteriaId & ";"

        Try
            QuerySubCriteria = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySubCriteria = NO_DATA Then

            Erase vReturn

        ElseIf QuerySubCriteria = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 23) Then

            'Enable buttons
            pvForm.cmdAddConditional.Enabled = True
            pvForm.cmdRemoveConditional.Enabled = True
            pvForm.cmdSaveSubCriteria.Enabled = True

            'Set the data
            pvForm.TxtMaleUpperSub.Text = vReturn(0, 6)
            pvForm.TxtMaleLowerSub.Text = vReturn(0, 7)
            pvForm.TxtFemaleUpperSub.Text = vReturn(0, 8)
            pvForm.TxtFemaleLowerSub.Text = vReturn(0, 9)
            pvForm.TxtGeneralRuleoutSub.Text = vReturn(0, 10)
            pvForm.ChkNotAppropriateMaleSub.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 11))
            pvForm.ChkNotAppropriateFemaleSub.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 12))
            pvForm.ChkReferNonPotentialSub.Checked = modConv.DBTrueValueToChkValue(vReturn(0, 13))
            pvForm.TxtLowerWeightSub.Text = vReturn(0, 14)
            pvForm.TxtUpperWeightSub.Text = vReturn(0, 15)
            If Trim(vReturn(0, 18)) = "Years" Then
                pvForm.LableSub(11).Text = "Upper              yrs."
            Else
                pvForm.LableSub(11).Text = "Upper              mos."
            End If
            If Trim(vReturn(0, 19)) = "Years" Then
                pvForm.LableSub(10).Text = "Lower              yrs."
            Else
                pvForm.LableSub(10).Text = "Lower              mos."
            End If
            If Trim(vReturn(0, 20)) = "Years" Then
                pvForm.LableSub(13).Text = "Upper              yrs."
            Else
                pvForm.LableSub(13).Text = "Upper              mos."
            End If
            If Trim(vReturn(0, 21)) = "Years" Then
                pvForm.LableSub(15).Text = "Lower              yrs."
            Else
                pvForm.LableSub(15).Text = "Lower              mos."
            End If
            pvForm.TxtFemaleLowerWeightSub.Text = vReturn(0, 22)
            pvForm.TxtFemaleUpperWeightSub.Text = vReturn(0, 23)
        End If

    End Function

    Public Function QuerySubtypeProcessors(ByRef pvForm As FrmCriteria, Optional ByRef pvReturn As Object = Nothing) As Integer
        'FSProj drh 5/14/02 - New function to get Subtypes and subtype/processor combinations
        'ccarroll 07/25/2011 Change Short to Integer on Id Dims
        Dim vQuery As String = ""
        Dim vParams() As String
        Dim vReturn As New Object
        Dim vCriteriaId As Integer
        Dim vProcessorId As Integer

        vCriteriaId = pvForm.CriteriaGroupID
        If pvForm.LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
            vProcessorId = pvForm.LstViewCriteriaTemplates.SelectedItems.Item(0).SubItems(2).Text
            'Build the query to get all Subtypes
            vQuery = "EXEC SelectSubtypeProcessors @CriteriaId = " & vCriteriaId & ", @ProcessorId = " & vProcessorId & ";"

            Try
                QuerySubtypeProcessors = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                RemoveHandler pvForm.LstViewSubtypeProcessors.ItemChecked, AddressOf pvForm.LstViewSubtypeProcessors_ItemChecked
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSubtypeProcessors, False, , , , 4)
                AddHandler pvForm.LstViewSubtypeProcessors.ItemChecked, AddressOf pvForm.LstViewSubtypeProcessors_ItemChecked
            End If
        End If
    End Function

    Public Function QuerySubCriteriaApplicable(ByRef pvForm As FrmCriteria, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/15/02 - New function to get SubCriteria

        Dim vQuery As New Object
        Dim vCriteriaId As New Object
        Dim vReturn As New Object

        vCriteriaId = pvForm.CriteriaGroupID

        'Build the query to get all Subtypes
        vQuery = "select sc.subcriteriaid, " & "s.subtypename + ' - ' + o.organizationname as subproc " & "from subcriteria sc " & "join organization o on sc.processorid = o.organizationid " & "join subtype s on sc.subtypeid = s.subtypeid " & "where criteriaid = " & vCriteriaId & " " & "order by subproc asc;"

        Try
            QuerySubCriteriaApplicable = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pvForm.cboSubtypeProcessor(0), vReturn)
        Call modControl.SetTextID(pvForm.cboSubtypeProcessor(1), vReturn)

        'If we have a SubCriteriaId, then select that item from the lists
        If pvForm.CurrentSubCriteriaId > 0 Then
            Call modControl.SelectID(pvForm.cboSubtypeProcessor(0), pvForm.CurrentSubCriteriaId)
            Call modControl.SelectID(pvForm.cboSubtypeProcessor(1), pvForm.CurrentSubCriteriaId)
        Else
            Call modControl.SelectFirst(pvForm.cboSubtypeProcessor(0))
            Call modControl.SelectFirst(pvForm.cboSubtypeProcessor(1))
        End If

    End Function

    Public Function QueryDataTree(ByRef pvForm As Object, Optional ByRef pvReturn As Object = Nothing, Optional ByRef pvServiceLevelId As Object = Nothing) As Short
        'FSProj drh 5/21/02 - New function to get data for Service Level data tree

        Dim vQuery As New Object
        Dim vServiceLevelId As New Object

        If Not IsNothing(pvServiceLevelId) Then
            vServiceLevelId = pvServiceLevelId
        Else
            vServiceLevelId = pvForm.ServiceLevel.ID
        End If

        If pvForm.Name = "FrmServiceLevel" Then
            'Build the query to get all data
            vQuery = "EXEC SelectServiceLevelSecondaryCtls @ServicelevelID = " & vServiceLevelId & ";"
        ElseIf pvForm.Name = "FrmReferralView" Then
            'Build the query to get all visible fields
            '11/05/02 drh - Added MaxChar field to select list
            vQuery = "EXEC SelectServiceLevelSecondaryCtlsParentId  @ServicelevelID = " & vServiceLevelId & ";"
        End If

        Try
            QueryDataTree = modODBC.Exec(vQuery, pvReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function QueryScheduleReferralOrganization(ByRef pvForm As Object, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vScheduleGroupID As Integer

        If IsNothing(pvParams) Then

            'Get the schedule group ID
            vScheduleGroupID = pvForm.ScheduleGroupID

            vQuery = $"EXEC GetScheduleGroupOrganizationData  @ScheduleGroupID = {vScheduleGroupID};"

            Try
                QueryScheduleReferralOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
                pvForm.SelectedGridList = vReturn
            End If

        Else

            vQuery = $"EXEC GetScheduleGroupOrganizationData  @ScheduleGroupID = {pvParams(0)}, @OrganizationID = {pvParams(1)};"

            Try
                QueryScheduleReferralOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function
    Public Function QuerySchedulePerson(ByVal pvScheduleGroupID As Integer, Optional ByRef pvReturn As Object = Nothing, Optional ByRef pvPersonID As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        'If the person id is missing, get all persons for the schedule group
        If IsNothing(pvPersonID) Then

            vQuery = "SELECT DISTINCT Person.PersonID, PersonFirst + ' ' + PersonLast, PersonTypeName " & "FROM ScheduleGroupPerson " & "JOIN Person ON Person.PersonID = ScheduleGroupPerson.PersonID " & "JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID " & "WHERE ScheduleGroupPerson.ScheduleGroupID = " & pvScheduleGroupID & " " & "ORDER BY PersonFirst + ' ' + PersonLast ASC "

            Try
                QuerySchedulePerson = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        Else
            'Get specific person

            vQuery = "SELECT DISTINCT Person.PersonID, PersonFirst + ' ' + PersonLast, PersonTypeName " & "FROM ScheduleGroupPerson " & "JOIN Person ON Person.PersonID = ScheduleGroupPerson.PersonID " & "JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID " & "WHERE ScheduleGroupPerson.ScheduleGroupID = " & pvScheduleGroupID & " " & "AND ScheduleGroupPerson.PersonID = " & pvPersonID & " " & "ORDER BY PersonFirst + ' ' + PersonLast ASC "

            Try
                QuerySchedulePerson = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function


    Public Function QueryAlertOrganization(ByRef pvForm As FrmAlert, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vAlertID As Integer

        If IsNothing(pvParams) Then

            'Get the Alert group ID
            vAlertID = pvForm.AlertID

            vQuery = "SELECT  AlertOrganization.AlertOrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName " & "FROM AlertOrganization, Organization, OrganizationType, State " & "WHERE Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & "AND Organization.StateID = State.StateID " & "AND AlertOrganization.OrganizationID = Organization.OrganizationID " & "AND AlertOrganization.AlertID = " & vAlertID & " " & "ORDER BY Organization.OrganizationName ASC;"

            Try
                QueryAlertOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
                pvForm.SelectedGridList = vReturn
            End If

        Else

            vQuery = "SELECT Organization.OrganizationID, Organization.OrganizationTypeID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName, AlertOrganization.AlertOrganizationID " & "FROM AlertOrganization INNER JOIN ((Organization INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) " & "ON AlertOrganization.OrganizationID = Organization.OrganizationID " & "WHERE AlertOrganization.AlertID = " & pvParams(0) & "AND Organization.OrganizationID = " & pvParams(1) & ";"

            Try
                QueryAlertOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function

    Public Function QueryAlertSourceCode(ByRef pvForm As FrmAlert) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAlertID As Integer
        Dim I As Short
        Dim SourceCodeArray As New Object


        'Get the Alert group ID
        vAlertID = pvForm.AlertID

        vQuery = "SELECT SourceCode.SourceCodeID, SourceCode.SourceCodeName FROM SourceCode JOIN AlertSourceCode ON AlertSourceCode.SourceCodeID = SourceCode.SourceCodeID WHERE AlertSourceCode.AlertID = " & vAlertID & " ORDER BY SourceCode.SourceCodeName ASC;"

        Try
            QueryAlertSourceCode = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If TypeOf vReturn Is Array Then
            ReDim SourceCodeArray(UBound(vReturn, 1))
            If IsNothing(pvForm.SourceCodes) Then
                pvForm.SourceCodes = New colSourceCodes
            End If

            For I = 0 To UBound(vReturn, 1)

                Dim NewSourceCode As New clsSourceCode

                Call NewSourceCode.GetItem(modConv.TextToLng(vReturn(I, 0)))
                SourceCodeArray(I) = NewSourceCode
                Call pvForm.SourceCodes.AddItem(SourceCodeArray(I))
                NewSourceCode = Nothing
            Next I
            Call pvForm.SourceCodes.FillListView2(pvForm.LstViewSourceCodes)
        End If

    End Function

    Public Function QueryWebReportGroupSourceCode(ByRef pvForm As FrmReport) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vWebReportGroupID As Integer
        Dim I As Short
        Dim SourceCodeArray As New Object


        'Get the WebReportGroup group ID
        vWebReportGroupID = pvForm.ReportGroupID

        vQuery = "SELECT DISTINCT SourceCode.SourceCodeID, SourceCode.SourceCodeName, " & "AccessOrgans, AccessBone, AccessTissue, AccessSkin, AccessValves, AccessEyes, AccessResearch, " & "AccessOrgansUpdate, AccessBoneUpdate, AccessTissueUpdate, AccessSkinUpdate, AccessValvesUpdate, AccessEyesUpdate, AccessResearchUpdate, " & "AccessTypeOTE, AccessTypeTE, AccessTypeEOnly, AccessTypeRuleout " & "FROM SourceCode " & "JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID " & "WHERE WebReportGroupSourceCode.WebReportGroupID = " & vWebReportGroupID & " " & "ORDER BY SourceCode.SourceCodeName ASC;"

        Try
            QueryWebReportGroupSourceCode = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Dim NewSourceCode As New clsSourceCode
        If IsNothing(pvForm.SourceCodes) Then
            pvForm.SourceCodes = New colSourceCodes
        End If
        If ObjectIsValidArray(vReturn, 2, 0, 19) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 19) Then
            ReDim SourceCodeArray(UBound(vReturn, 1))
            For I = 0 To UBound(vReturn, 1)

                'ccarroll 04/13/2010 Moved NewSourceCode inside For loop
                Dim NewSourceCode As New clsSourceCode

                Call NewSourceCode.GetItem(modConv.TextToLng(vReturn(I, 0)))

                NewSourceCode.WebReportGroupAccessOrgans = IIf(String.IsNullOrEmpty(vReturn(I, 2)), 0, vReturn(I, 2))
                NewSourceCode.WebReportGroupAccessBone = IIf(String.IsNullOrEmpty(vReturn(I, 3)), 0, vReturn(I, 3))
                NewSourceCode.WebReportGroupAccessTissue = IIf(String.IsNullOrEmpty(vReturn(I, 4)), 0, vReturn(I, 4))
                NewSourceCode.WebReportGroupAccessSkin = IIf(String.IsNullOrEmpty(vReturn(I, 5)), 0, vReturn(I, 5))
                NewSourceCode.WebReportGroupAccessValves = IIf(String.IsNullOrEmpty(vReturn(I, 6)), 0, vReturn(I, 6))
                NewSourceCode.WebReportGroupAccessEyes = IIf(String.IsNullOrEmpty(vReturn(I, 7)), 0, vReturn(I, 7))
                NewSourceCode.WebReportGroupAccessResearch = IIf(String.IsNullOrEmpty(vReturn(I, 8)), 0, vReturn(I, 8))

                NewSourceCode.WebReportGroupAccessOrgansUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 9)), 0, vReturn(I, 9))
                NewSourceCode.WebReportGroupAccessBoneUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 10)), 0, vReturn(I, 10))
                NewSourceCode.WebReportGroupAccessTissueUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 11)), 0, vReturn(I, 11))
                NewSourceCode.WebReportGroupAccessSkinUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 12)), 0, vReturn(I, 12))
                NewSourceCode.WebReportGroupAccessValvesUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 13)), 0, vReturn(I, 13))
                NewSourceCode.WebReportGroupAccessEyesUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 14)), 0, vReturn(I, 14))
                NewSourceCode.WebReportGroupAccessResearchUpdate = IIf(String.IsNullOrEmpty(vReturn(I, 15)), 0, vReturn(I, 15))

                NewSourceCode.WebReportGroupAccessTypeOTE = IIf(String.IsNullOrEmpty(vReturn(I, 16)), 0, vReturn(I, 16))
                NewSourceCode.WebReportGroupAccessTypeTE = IIf(String.IsNullOrEmpty(vReturn(I, 17)), 0, vReturn(I, 17))
                NewSourceCode.WebReportGroupAccessTypeEyeOnly = IIf(String.IsNullOrEmpty(vReturn(I, 18)), 0, vReturn(I, 18))
                NewSourceCode.WebReportGroupAccessTypeRuleout = IIf(String.IsNullOrEmpty(vReturn(I, 19)), 0, vReturn(I, 19))

                SourceCodeArray(I) = NewSourceCode
                Call pvForm.SourceCodes.AddItem(SourceCodeArray(I))
                NewSourceCode = Nothing
            Next I
            Call pvForm.SourceCodes.FillListView2(pvForm.LstViewSourceCodes)
        End If

    End Function


    Public Function QueryWebReportGroupAccessDate(ByRef pvForm As FrmReport) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vWebReportGroupID As Integer
        Dim I As Short
        Dim SourceCodeArray As New Object


        'Get the WebReportGroup group ID
        vWebReportGroupID = pvForm.ReportGroupID

        vQuery = "sps_ReportGroupAccessDate " & vWebReportGroupID

        Try
            QueryWebReportGroupAccessDate = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryWebReportGroupAccessDate = SUCCESS Then
            'Format the date columns
            Call modMask.DateColumn2000(vReturn, 1)
            Call modMask.DateColumn2000(vReturn, 2)
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewDateAccess, False)
        Else
            pvForm.LstViewDateAccess.Items.Clear()
        End If

    End Function




    Public Function QueryScheduleGroupSourceCode(ByRef pvForm As FrmSchedule) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vScheduleGroupID As Integer
        Dim I As Short
        Dim SourceCodeArray As New Object


        'Get the ScheduleGroup group ID
        vScheduleGroupID = pvForm.ScheduleGroupID

        vQuery = "SELECT DISTINCT SourceCode.SourceCodeID, SourceCode.SourceCodeName " & "FROM SourceCode " & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID " & "WHERE ScheduleGroupSourceCode.ScheduleGroupID = " & vScheduleGroupID & " " & "ORDER BY SourceCode.SourceCodeName ASC;"

        Try
            QueryScheduleGroupSourceCode = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim NewSourceCode As clsSourceCode
        If ObjectIsValidArray(vReturn, 2, 0, 0) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 0) Then
            ReDim SourceCodeArray(UBound(vReturn, 1))
            If IsNothing(pvForm.SourceCodes) Then
                pvForm.SourceCodes = New colSourceCodes
            End If
            For I = 0 To UBound(vReturn, 1)
                NewSourceCode = New clsSourceCode
                Call NewSourceCode.GetItem(modConv.TextToLng(vReturn(I, 0)))
                SourceCodeArray(I) = NewSourceCode
                Call pvForm.SourceCodes.AddItem(SourceCodeArray(I))
                NewSourceCode = Nothing
            Next I
            Call pvForm.SourceCodes.FillListView2(pvForm.LstViewSourceCodes)
        End If

    End Function



    Public Function QueryCriteriaSourceCode(ByRef pvForm As FrmCriteria) As Short

        Dim vQuery As String
        Dim vReturn As New Object
        Dim vCriteriaId As Integer
        Dim I As Short
        'Dim SourceCodeArray As New Object


        'Get the Criteria group ID
        vCriteriaId = pvForm.CriteriaID

        vQuery = "SELECT DISTINCT SourceCode.SourceCodeID, SourceCode.SourceCodeName FROM SourceCode JOIN CriteriaSourceCode ON CriteriaSourceCode.SourceCodeID = SourceCode.SourceCodeID WHERE CriteriaSourceCode.CriteriaID = " & vCriteriaId & " ORDER BY SourceCode.SourceCodeName ASC;"

        Try
            QueryCriteriaSourceCode = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim NewSourceCode As clsSourceCode
        If IsNothing(pvForm.SourceCodes) Then
            pvForm.SourceCodes = New colSourceCodes
        End If
        If ObjectIsValidArray(vReturn, 2, 0, 0) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 0) Then
            ' ReDim SourceCodeArray(UBound(vReturn, 1))
            If IsNothing(pvForm.SourceCodes) Then
                pvForm.SourceCodes = New colSourceCodes
            End If
            For I = 0 To UBound(vReturn, 1)
                NewSourceCode = New clsSourceCode
                Call NewSourceCode.GetItem(modConv.TextToLng(vReturn(I, 0)))
                'SourceCodeArray(I) = NewSourceCode
                pvForm.SourceCodes.AddItem(NewSourceCode)

                NewSourceCode = Nothing
            Next I

            Call pvForm.SourceCodes.FillListView2(pvForm.LstViewSourceCodes)
        End If

    End Function
    Public Function QueryServiceLevelAutoBillable(ByRef pvForm As FrmReferralView) As Short

        Dim vQuery As String = ""
        Dim vResults As New Object
        Dim vReturnCode As Short

        'ccarroll 05/29/2007 StatTrac 8.4 - Get servicelevel for referral and either enable
        'or disable the AutoBill functionallity
        'ccarroll 06/17/2008 StatTrac 8.4.6
        '  Added BillApproachOnly to disable Secondary Billable checkbox when ME/Coroner case

        vQuery = "sps_ServiceLevelAutoBillable " & pvForm.CallerOrg.ServiceLevel.ID & ";"

        Try
            QueryServiceLevelAutoBillable = modODBC.Exec(vQuery, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryServiceLevelAutoBillable = SUCCESS _
            AndAlso ObjectIsValidArray(vResults, 2, 0, 3) _
            AndAlso UBound(vResults, 1) = 0 Then

            'enable/disable manual billing features
            pvForm.BillSecondaryManualEnable = modConv.IntToBool(modConv.TextToInt(vResults(0, 0)), True)
            pvForm.BillFamilyApproachManualEnable = modConv.IntToBool(modConv.TextToInt(vResults(0, 1)), True)
            pvForm.BillMedSocManualEnable = modConv.IntToBool(modConv.TextToInt(vResults(0, 2)), True)
            pvForm.BillApproachOnly = modConv.IntToBool(modConv.TextToInt(vResults(0, 3)), True)

        Else

            'If there is no match
            'then set the query to false
            QueryServiceLevelAutoBillable = NO_DATA

        End If

    End Function

    Public Function QueryServiceLevelSourceCode(ByRef pvForm As FrmServiceLevel) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vServiceLevelId As Integer
        Dim I As Short
        Dim SourceCodeArray As New Object


        'Get the ServiceLevel group ID
        vServiceLevelId = pvForm.ServiceLevel.ID

        vQuery = "SELECT DISTINCT SourceCode.SourceCodeID, SourceCode.SourceCodeName " & "FROM SourceCode " & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.SourceCodeID = SourceCode.SourceCodeID " & "WHERE ServiceLevelSourceCode.ServiceLevelID = " & vServiceLevelId & " " & "ORDER BY SourceCode.SourceCodeName ASC;"

        Try
            QueryServiceLevelSourceCode = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim NewSourceCode As clsSourceCode
        If IsNothing(pvForm.SourceCodes) Then
            pvForm.SourceCodes = New colSourceCodes()
        End If
        If ObjectIsValidArray(vReturn, 2, 0, 0) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 0) Then
            ReDim SourceCodeArray(UBound(vReturn, 1))
            If IsNothing(pvForm.SourceCodes) Then
                pvForm.SourceCodes = New colSourceCodes
            End If
            For I = 0 To UBound(vReturn, 1)
                NewSourceCode = New clsSourceCode
                Call NewSourceCode.GetItem(modConv.TextToLng(vReturn(I, 0)))
                SourceCodeArray(I) = NewSourceCode
                Call pvForm.SourceCodes.AddItem(SourceCodeArray(I))
                NewSourceCode = Nothing
            Next I
            Call pvForm.SourceCodes.FillListView2(pvForm.LstViewSourceCodes)
        End If

    End Function

    Public Function QueryAlertOrganizations(ByRef pvOrganizationId As Integer, ByRef pvReturn As Object, ByRef SourceCode As clsSourceCode) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT AlertOrganization.AlertID, AlertOrganization.OrganizationID, Alert.AlertGroupName " & "FROM AlertOrganization " & "JOIN AlertSourceCode ON AlertSourceCode.AlertID = AlertOrganization.AlertID " & "JOIN Alert ON AlertOrganization.AlertId = Alert.AlertId " & "WHERE AlertOrganization.OrganizationID = " & pvOrganizationId & " " & "AND AlertSourceCode.SourceCodeID = " & SourceCode.ID

        Try
            QueryAlertOrganizations = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryAlertOrganizations = SUCCESS Then
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryWebReportOrganization(ByRef pvForm As Object, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReportGroupID As Integer

        If IsNothing(pvParams) Then

            'Get the Report group ID
            vReportGroupID = pvForm.ReportGroupID

            If pvForm.Name = "FrmReport" Then

                vQuery = "SELECT Organization.OrganizationID, Organization.OrganizationName, Organization.OrganizationCity, " & "State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM WebReportGroup " & "JOIN WebReportGroupOrg ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID " & "INNER JOIN ((Organization INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID " & "WHERE WebReportGroup.WebReportGroupID = " & vReportGroupID & "ORDER BY Organization.OrganizationName ASC"

                Try
                    QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If (TypeOf vReturn Is Array) Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
                    pvForm.SelectedGridList = vReturn
                End If

            ElseIf pvForm.Name = "FrmReportParams" Then

                vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM WebReportGroupOrg " & "JOIN Organization ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID " & "WHERE WebReportGroupOrg.WebReportGroupID = " & vReportGroupID & " " & "ORDER BY Organization.OrganizationName ASC;"

                Try
                    QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                Call modControl.SetTextID(pvForm.CboOrganization, vReturn)

            End If

        Else

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, WebReportGroupOrg.WebReportGroupOrgID " & "FROM WebReportGroupOrg INNER JOIN Organization " & "ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID " & "WHERE WebReportGroupOrg.WebReportGroupID = " & pvParams(0) & " " & "AND WebReportGroupOrg.OrganizationID = " & pvParams(1) & ";"

            Try
                QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function
    Public Function QueryCriteriaGroupIndication(ByRef pvForm As Object, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        If IsNothing(pvParams) Then
            'Get all indications for the given criteria group
            vCriteriaGroupID = pvForm.CriteriaGroupID

            vQuery = "SELECT DISTINCT Indication.IndicationID, Indication.IndicationName, " & "Indication.IndicationNote, Indication.IndicationHighRisk " & "FROM CriteriaIndication INNER JOIN Indication " & "ON CriteriaIndication.IndicationID = Indication.IndicationID " & "WHERE CriteriaIndication.CriteriaID = " & vCriteriaGroupID & " " & "ORDER BY Indication.IndicationName ASC;"

            Try
                QueryCriteriaGroupIndication = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If pvForm.Name = "FrmCriteria" Then
                If (TypeOf vReturn Is Array) Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewIndication, False)
                    pvForm.IndicationList = vReturn
                End If
            ElseIf pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralTest" Then
                pvReturn = vReturn
            End If

        Else
            'Get a specific indication row
            vQuery = "SELECT DISTINCT Indication.IndicationID, " & "Indication.IndicationName, Indication.IndicationNote, Indication.IndicationHighRisk " & "FROM CriteriaIndication INNER JOIN Indication " & "ON CriteriaIndication.IndicationID = Indication.IndicationID " & "WHERE CriteriaIndication.CriteriaID = " & pvParams(0) & " " & "AND CriteriaIndication.IndicationID = " & pvParams(1) & ";"

            Try
                QueryCriteriaGroupIndication = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function

    Public Function QueryTemplateConditional(ByRef pvForm As FrmCriteriaTemplate) As Short
        'FSProj drh 5/9/02

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT CriteriaTemplate_ConditionalRO.CriteriaTemplate_ConditionalROID, FSIndication.FSIndicationName, " & "FSAppropriate.FSAppropriateName, 'AUTOMATIC R/O' as FSConditionName, 0 as firstorder " & "From CriteriaTemplate_ConditionalRO " & "INNER JOIN FSIndication ON CriteriaTemplate_ConditionalRO.FSIndicationID = FSIndication.FSIndicationID " & "INNER JOIN FSAppropriate ON CriteriaTemplate_ConditionalRO.FSAppropriateID = FSAppropriate.FSAppropriateID " & "WHERE CriteriaTemplate_ConditionalRO.CriteriaTemplateID = " & pvForm.vCriteriaTemplateId & " And CriteriaTemplate_ConditionalRO.FSConditionID = 0 " & "UNION "

        vQuery = vQuery & "SELECT DISTINCT CriteriaTemplate_ConditionalRO.CriteriaTemplate_ConditionalROID, FSIndication.FSIndicationName, " & "FSAppropriate.FSAppropriateName, FSCondition.FSConditionName, 1 as firstorder " & "FROM CriteriaTemplate_ConditionalRO " & "INNER JOIN FSIndication ON CriteriaTemplate_ConditionalRO.FSIndicationID = FSIndication.FSIndicationID " & "INNER JOIN FSAppropriate ON CriteriaTemplate_ConditionalRO.FSAppropriateID = FSAppropriate.FSAppropriateID " & "INNER JOIN FSCondition ON CriteriaTemplate_ConditionalRO.FSConditionID = FSCondition.FSConditionID " & "WHERE CriteriaTemplate_ConditionalRO.CriteriaTemplateID = " & pvForm.vCriteriaTemplateId & " " & "ORDER BY firstorder, FSIndication.FSIndicationName, FSAppropriate.FSAppropriateName, FSConditionName ASC;"

        Try
            QueryTemplateConditional = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewConditionals, False)
        End If

    End Function

    Public Function QuerySubCriteriaConditional(ByRef pvForm As FrmCriteria) As Short
        'FSProj drh 5/9/02

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vSubCriteriaId As Integer

        vSubCriteriaId = modControl.GetID(pvForm.cboSubtypeProcessor(0))

        vQuery = "SELECT DISTINCT ProcessorCriteria_ConditionalRO.ProcessorCriteria_ConditionalROID, FSIndication.FSIndicationName, " & "FSAppropriate.FSAppropriateName, 'AUTOMATIC R/O' as FSConditionName, 0 as firstorder " & "From ProcessorCriteria_ConditionalRO " & "INNER JOIN FSIndication ON ProcessorCriteria_ConditionalRO.FSIndicationID = FSIndication.FSIndicationID " & "INNER JOIN FSAppropriate ON ProcessorCriteria_ConditionalRO.FSAppropriateID = FSAppropriate.FSAppropriateID " & "Where ProcessorCriteria_ConditionalRO.SubCriteriaID = " & vSubCriteriaId & " And ProcessorCriteria_ConditionalRO.FSConditionID = 0 " & "UNION "

        vQuery = vQuery & "SELECT DISTINCT ProcessorCriteria_ConditionalRO.ProcessorCriteria_ConditionalROID, FSIndication.FSIndicationName, " & "FSAppropriate.FSAppropriateName, FSCondition.FSConditionName, 1 as firstorder " & "FROM ProcessorCriteria_ConditionalRO " & "INNER JOIN FSIndication ON ProcessorCriteria_ConditionalRO.FSIndicationID = FSIndication.FSIndicationID " & "INNER JOIN FSAppropriate ON ProcessorCriteria_ConditionalRO.FSAppropriateID = FSAppropriate.FSAppropriateID " & "INNER JOIN FSCondition ON ProcessorCriteria_ConditionalRO.FSConditionID = FSCondition.FSConditionID " & "WHERE ProcessorCriteria_ConditionalRO.SubCriteriaID = " & vSubCriteriaId & " " & "ORDER BY firstorder, FSIndication.FSIndicationName, FSAppropriate.FSAppropriateName, FSConditionName ASC;"

        Try
            QuerySubCriteriaConditional = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewConditionals, False)
        End If

    End Function

    Public Function QueryFSIndication(ByRef pvForm As FrmConditional, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/9/02

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT FSIndication.FSIndicationId, FSIndication.FSIndicationName " & "FROM FSIndication " & "ORDER BY FSIndication.FSIndicationName ASC;"

        Try
            QueryFSIndication = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewCriteria, False)
        End If

    End Function

    Public Function QueryFSAppropriate(ByRef pvForm As FrmConditional, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/9/02

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT DISTINCT FSAppropriate.FSAppropriateId, FSAppropriate.FSAppropriateName " & "FROM FSAppropriate " & "ORDER BY FSAppropriate.FSAppropriateName ASC;"

        Try
            QueryFSAppropriate = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewReason, False)
        End If

    End Function

    Public Function QueryFSCondition(ByRef pvForm As FrmConditional, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/9/02

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT 0 as FSConditionId, 'AUTOMATIC R/O' as FSConditionName, 0 as firstorder " & "UNION " & "SELECT DISTINCT FSCondition.FSConditionId, FSCondition.FSConditionName, 1 " & "FROM FSCondition " & "ORDER BY firstorder, FSConditionName ASC;"

        Try
            QueryFSCondition = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewCondition, False)
        End If

    End Function

    Public Function QueryCriteriaGroupIndicationSMRO(ByRef pvForm As Object, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'Get all indications for the given criteria group
        vCriteriaGroupID = pvForm.CriteriaGroupID

        vQuery = "SELECT Indication.IndicationID, Indication.IndicationName + ' ' + Indication.IndicationNote " & "FROM CriteriaIndication INNER JOIN Indication " & "ON CriteriaIndication.IndicationID = Indication.IndicationID " & "WHERE CriteriaIndication.CriteriaID = " & vCriteriaGroupID & " " & "AND CriteriaIndication.IndicationStandardMRO = -1 " & "ORDER BY Indication.IndicationName ASC;"

        Try
            QueryCriteriaGroupIndicationSMRO = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Not IsNothing(vReturn) Then
            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralTest" Then
                pvReturn = vReturn
            End If
        End If

    End Function


    Public Function QueryCriteriaReferralOrganization(ByRef pvForm As Object, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'If specific IDs are missing, then return a list
        If IsNothing(pvParams) Then
            'Get the Criteria group ID
            vCriteriaGroupID = pvForm.CriteriaGroupID

            If pvForm.Name = "FrmCriteria" Then
                vQuery = "SELECT DISTINCT CriteriaOrganization.CriteriaOrganizationID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName " & "FROM CriteriaOrganization INNER JOIN ((Organization INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) " & "ON CriteriaOrganization.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaOrganization.CriteriaID = " & vCriteriaGroupID & " " & "ORDER BY Organization.OrganizationName ASC;"
            ElseIf pvForm.Name = "FrmReferralTest" Then
                vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM CriteriaOrganization INNER JOIN Organization " & "ON CriteriaOrganization.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaOrganization.CriteriaID = " & vCriteriaGroupID & " " & "ORDER BY Organization.OrganizationName ASC;"
            End If

            Try
                QueryCriteriaReferralOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                If pvForm.Name = "FrmCriteria" Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
                    pvForm.SelectedGridList = vReturn
                ElseIf pvForm.Name = "FrmReferralTest" Then
                    Call modControl.SetTextID(pvForm.CboOrganization, vReturn)
                End If
            End If

            'Else return a specific record
        Else
            vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationTypeID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName, CriteriaOrganization.CriteriaOrganizationID " & "FROM CriteriaOrganization INNER JOIN ((Organization INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) " & "ON CriteriaOrganization.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaOrganization.CriteriaID = " & pvParams(0) & " " & "AND CriteriaOrganization.OrganizationID = " & pvParams(1) & ";"

            Try
                QueryCriteriaReferralOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If


    End Function

    Public Function QueryCriteriaSubtype(ByRef pvForm As FrmCriteria, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/6/02 - New function to get selected Subtypes for a Criteria

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'If specific IDs are missing, then return a list
        If IsNothing(pvParams) Then
            'Get the Criteria group ID
            vCriteriaGroupID = pvForm.CriteriaGroupID

            vQuery = "SELECT DISTINCT CriteriaSubtype.CriteriaSubtypeID, " & "Subtype.SubtypeName, CriteriaSubtype.SubCriteriaPrecedence, Subtype.SubtypeDescription, CriteriaSubtype.SubtypeId " & "FROM CriteriaSubtype JOIN Subtype " & "ON CriteriaSubtype.SubtypeId = Subtype.SubtypeId " & "WHERE CriteriaSubtype.CriteriaID = " & vCriteriaGroupID & " " & "ORDER BY Subtype.SubtypeName ASC;"

            Try
                QueryCriteriaSubtype = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedSubtypes, False)
                pvForm.SelectedGridList = vReturn
            End If

            'Else return a specific record
        Else
            vQuery = "SELECT DISTINCT CriteriaSubtype.CriteriaSubtypeID, " & "Subtype.SubtypeName, CriteriaSubtype.SubCriteriaPrecedence, Subtype.SubtypeDescription " & "FROM CriteriaSubtype JOIN Subtype " & "ON CriteriaSubtype.SubtypeId = Subtype.SubtypeId " & "WHERE CriteriaSubtype.CriteriaID = " & pvParams(0) & " " & "AND CriteriaSubtype.SubtypeId = " & pvParams(1) & " ORDER BY Subtype.SubtypeName ASC;"

            Try
                QueryCriteriaSubtype = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function

    Public Function QueryAvailableSubtype(ByRef pvForm As FrmCriteria) As Short
        'FSProj drh 5/6/02 - New function to get available Subtypes for a Criteria

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'Get the Criteria group ID
        vCriteriaGroupID = pvForm.CriteriaGroupID

        vQuery = "SELECT DISTINCT SubtypeId, SubtypeName, SubtypeDescription " & "FROM Subtype " & "WHERE SubtypeId NOT IN(SELECT DISTINCT CriteriaSubtype.SubtypeID " & "FROM CriteriaSubtype " & "WHERE CriteriaSubtype.CriteriaID = " & vCriteriaGroupID & ") " & "ORDER BY SubtypeName ASC;"

        Try
            QueryAvailableSubtype = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAvailableSubtypes, False)
            pvForm.SelectedGridList = vReturn
        End If

    End Function

    Public Function QueryCriteriaProcessor(ByRef pvForm As FrmCriteria, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        'FSProj drh 5/6/02 - New function to get selected Processors for a Criteria

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'If specific IDs are missing, then return a list
        If IsNothing(pvParams) Then
            'Get the Criteria group ID
            vCriteriaGroupID = pvForm.CriteriaGroupID

            vQuery = "SELECT DISTINCT CriteriaProcessor.CriteriaProcessorID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName, CriteriaProcessor.OrganizationId " & "FROM CriteriaProcessor INNER JOIN ((Organization INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) " & "ON CriteriaProcessor.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaProcessor.CriteriaID = " & vCriteriaGroupID & " " & "ORDER BY Organization.OrganizationName ASC;"

            Try
                QueryCriteriaProcessor = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If (TypeOf vReturn Is Array) Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedProcessors, False)
                pvForm.SelectedGridList = vReturn
            End If

            'Else return a specific record
        Else
            vQuery = "SELECT DISTINCT CriteriaProcessor.CriteriaProcessorID, " & "Organization.OrganizationName, Organization.OrganizationCity, State.StateAbbrv, " & "OrganizationType.OrganizationTypeName " & "FROM CriteriaProcessor INNER JOIN ((Organization INNER JOIN OrganizationType " & "ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) " & "ON CriteriaProcessor.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaProcessor.CriteriaID = " & pvParams(0) & " " & "AND CriteriaProcessor.OrganizationId = " & pvParams(1) & " " & "ORDER BY Organization.OrganizationName ASC;"

            Try
                QueryCriteriaProcessor = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            pvReturn = vReturn

        End If

    End Function

    Public Function QueryCriteriaTemplate(ByRef pvForm As FrmCriteria) As Short
        'FSProj drh 5/8/02

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaGroupID As Integer

        'Get the Criteria group ID
        vCriteriaGroupID = pvForm.CriteriaGroupID

        vQuery = "(SELECT DISTINCT CriteriaTemplate.CriteriaTemplateID, " & "Organization.OrganizationName, CriteriaTemplate.CriteriaTemplateName, CriteriaProcessor.OrganizationId " & "FROM CriteriaProcessor INNER JOIN Organization " & "ON CriteriaProcessor.OrganizationID = Organization.OrganizationID " & "INNER JOIN CriteriaTemplate " & "ON CriteriaTemplate.ProcessorID = Organization.OrganizationID " & "WHERE CriteriaProcessor.CriteriaID = " & vCriteriaGroupID & " " & "UNION " & "SELECT DISTINCT 0, Organization.OrganizationName,'BLANK TEMPLATE',CriteriaProcessor.OrganizationId " & "From CriteriaProcessor " & "INNER JOIN Organization ON CriteriaProcessor.OrganizationID = Organization.OrganizationID " & "WHERE CriteriaProcessor.CriteriaID = " & vCriteriaGroupID & ") " & "ORDER BY Organization.OrganizationName, CriteriaTemplate.CriteriaTemplateName ASC;"

        Try
            QueryCriteriaTemplate = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewCriteriaTemplates, False)
            pvForm.SelectedGridList = vReturn
        End If

    End Function




    Public Function QueryScheduleOrganizationsOnCall(ByRef pvForm As Object, Optional ByRef pvReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReferralOrganizationID As Integer

        'Get the organization ID
        'FSProj drh 6/28/02 Added FrmReferralView
        If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralView" Then
            vReferralOrganizationID = pvForm.OrganizationId
        Else
            vReferralOrganizationID = pvForm.ReferralOrganizationID
        End If

        'Find the beginning ID
        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization " & "JOIN ScheduleGroup ON ScheduleGroup.OrganizationID = Organization.OrganizationID " & "JOIN ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID " & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID " & "WHERE ScheduleGroupOrganization.OrganizationID = " & vReferralOrganizationID & " " & "AND ScheduleGroupSourceCode.SourceCodeID = " & pvForm.SourceCode.ID & " " & "ORDER BY Organization.OrganizationName ASC;"

        Try
            QueryScheduleOrganizationsOnCall = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 6/20/02 - Added "FrmReferralView"
        'Release 8.0 c.chaput 05/13/05 - Added "FrmNew"
        If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralView" Or pvForm.Name = "FrmNew" Then
            pvReturn = vReturn
        Else
            Call modControl.SetTextID(pvForm.CboOrganization, vReturn)
        End If

    End Function
    Public Function QueryStatlineConsent(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        'Find any IDs
        'FSProj drh 5/1/02 - Added Criteria JOIN so we can add CriteriaStatus WHERE clause in logic below
        vQuery = "SELECT DISTINCT CriteriaOrganization.CriteriaID " & "FROM CriteriaOrganization " & "JOIN Criteria ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID " & "JOIN CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = CriteriaOrganization.CriteriaID " & "JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = CriteriaOrganization.CriteriaID " & "WHERE CriteriaOrganization.OrganizationID = " & pvForm.OrganizationId & " " & "AND CriteriaSourceCode.SourceCodeID = " & pvForm.SourceCode.ID & " " & "AND CriteriaScheduleContactOnStatCnsnt = 1 "

        'FSProj drh 4/29/02 - Set CriteriaStatus/ID so we can get the correct Historical Criteria Type (CriteriaStatus)
        '*************************************************************************************
        Dim vCriteriaStatus As Short
        Dim I As Integer
        If pvForm.HistoricalReferral Then
            vQuery = vQuery & "AND CriteriaStatus = " & ORIGINAL_CRITERIA
        Else
            vQuery = vQuery & "AND CriteriaStatus = " & CURRENT_CRITERIA

            If pvForm.FormState = EXISTING_RECORD And pvForm.ReferralTriageCriteria.Count = 7 Then
                vQuery = vQuery & " AND CriteriaOrganization.CriteriaID IN("
                For I = ORGAN To RESEARCH
                    vQuery = vQuery & pvForm.ReferralTriageCriteria.Item(CStr(I))
                    If I <> RESEARCH Then
                        vQuery = vQuery & ","
                    End If
                Next I
                vQuery = vQuery & ")"
            End If
        End If
        '*************************************************************************************


        Try
            QueryStatlineConsent = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function QueryScheduleGroupsOnCall(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReferralOrganizationID As Integer
        Dim vOrganizationId As Integer

        'Get the schedule group ID
        vReferralOrganizationID = pvForm.ReferralOrganizationID
        vOrganizationId = pvForm.OrganizationId

        'Find the beginning ID
        vQuery = "SELECT DISTINCT ScheduleGroupOrganization.ScheduleGroupID, ScheduleGroup.ScheduleGroupName " & "FROM ScheduleGroup " & "JOIN ScheduleGroupOrganization ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID " & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroup.ScheduleGroupID " & "JOIN SourceCode ON SourceCode.SourceCodeID = ScheduleGroupSourceCode.SourceCodeID " & "WHERE ScheduleGroupOrganization.OrganizationID = " & vReferralOrganizationID & " " & "AND ScheduleGroup.OrganizationID = " & vOrganizationId & " " & "AND SourceCodeType = " & pvForm.SourceCode.CodeType & " " & "ORDER BY ScheduleGroup.ScheduleGroupName ASC "

        Try
            QueryScheduleGroupsOnCall = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryScheduleGroupsOnCall = SUCCESS Then
            Call modControl.SetTextID(pvForm.CboScheduleGroup, vReturn)

            'If there is only one item, select and display it.
            If UBound(vReturn, 1) = 0 Then
                Call modControl.SelectFirst(pvForm.CboScheduleGroup)
            End If
        End If

    End Function
    Public Function QueryScheduleGroupsOnCallAll(ByRef pvForm As FrmReferral, ByRef pvResultsArray As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReferralOrganizationID As Integer

        'Get the schedule group ID
        vReferralOrganizationID = pvForm.OrganizationId

        'Find the beginning ID
        vQuery = "SELECT DISTINCT ScheduleGroupOrganization.ScheduleGroupID, ScheduleGroup.ScheduleGroupName " & "FROM ScheduleGroup " & "JOIN ScheduleGroupOrganization " & "ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID " & "WHERE ScheduleGroupOrganization.OrganizationID = " & vReferralOrganizationID & " " & "ORDER BY ScheduleGroup.ScheduleGroupName ASC;"

        Try
            QueryScheduleGroupsOnCallAll = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryScheduleGroupsOnCallAll = SUCCESS Then
            pvResultsArray = VB6.CopyArray(vReturn)
        End If

    End Function

    Public Function QuerySearchOrganizations(ByRef pvForm As FrmQuickLook) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vOrganizationText As String = ""
        Dim vLength As Short

        'Get the schedule group ID
        vOrganizationText = pvForm.TxtOrganization.Text
        vLength = Len(vOrganizationText) + 1

        'Find the beginning ID
        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName + '  ' + State.StateAbbrv " & "FROM Organization " & "JOIN State ON State.StateID = Organization.StateID "

        'Added bjk 06/2001: Lease Organization
        'Check if LO add join statment if it is.
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID "

        End If

        vQuery = vQuery & "WHERE Organization.OrganizationName LIKE " & Left(modODBC.BuildField(vOrganizationText), vLength) & "%' "

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "AND " & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & "); "
        End If


        Try
            QuerySearchOrganizations = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySearchOrganizations = SUCCESS Then
            Call modControl.SetTextID(pvForm.LstOrganization, vReturn)
        End If

    End Function
    Public Function QueryPersonOrganization(ByRef pvForm As FrmQuickLook) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vPersonID As Integer

        vPersonID = modControl.GetID(pvForm.LstPerson)

        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization, Person " & "WHERE Organization.OrganizationID = Person.OrganizationID " & "AND Person.PersonID = " & vPersonID & ";"

        Try
            QueryPersonOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPersonOrganization = SUCCESS Then
            Call modControl.SetTextID(pvForm.LstOrganization, vReturn)
        End If

    End Function

    Public Function QuerySearchPerson(ByRef pvForm As FrmQuickLook) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vPersonFirstText As String = ""
        Dim vPersonLastText As String = ""
        Dim vFirstLength As Short
        Dim vLastLength As Short

        'Get the schedule group ID
        vPersonFirstText = pvForm.TxtPersonFirst.Text
        vPersonLastText = pvForm.TxtPersonLast.Text
        vFirstLength = Len(vPersonFirstText) + 1
        vLastLength = Len(vPersonLastText) + 1

        'Find the beginning ID
        vQuery = "SELECT DISTINCT Person.PersonID, ISNULL(Person.PersonFirst,'')+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+ISNULL(PersonLast,'') "

        vQuery = vQuery & "FROM Person "

        'Added bjk 06/2001: Lease Organization
        'Check if LO add join statment if it is.
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.OrganizationID = Person.OrganizationID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID "
        End If


        If vFirstLength = 1 Then
            vQuery = vQuery & "WHERE Person.PersonLast LIKE " & Left(modODBC.BuildField(vPersonLastText), vLastLength) & "%' "
        ElseIf vLastLength = 1 Then
            vQuery = vQuery & "WHERE Person.PersonFirst LIKE " & Left(modODBC.BuildField(vPersonFirstText), vFirstLength) & "%' "
        Else
            vQuery = vQuery & "WHERE Person.PersonFirst LIKE " & Left(modODBC.BuildField(vPersonFirstText), vFirstLength) & "%' " & "AND Person.PersonLast LIKE " & Left(modODBC.BuildField(vPersonLastText), vLastLength) & "%' "
        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "AND " & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & "); "
        End If

        Try
            QuerySearchPerson = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySearchPerson = SUCCESS Then
            Call modControl.SetTextID(pvForm.LstPerson, vReturn)
        End If

    End Function

#Region "Dashboard"
    Public Function QueryIncompletes(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QueryIncompletes%
        'Date Created: Unknown                          Created by: Unknown
        'Release: unknown                               Task: unknown
        'Description: Queries Incomplete Referrals
        'Returns: N/A
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: replaced sps_IncompleteCalls6v with sps_IncompleteCalls
        '   and sps_IncompleteCallsLO6v with sps_IncompleteCallsLO
        '
        '====================================================================================
        'Date Changed: 6/29/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: move the ClearListView statment from first statement to after the query is returned
        '                sucessfully.
        '
        '====================================================================================

        Dim vQuery As String = ""
        Dim vTempCallList As New Object
        Dim vPageReturn As Short
        Dim vTempReturn As Short



        'Get the temporary calls
        '7/9/01 drh Changed to sps_IncompleteCalls4 from sps_IncompleteCalls2
        '12/19/03 bjk seperating the LO and regular Statline queries
        '  Changing sps_IncompleteCalls5 to sps_IncompleteCalls6v and sps_IncompleteCallsLO6v
        If AppMain.ParentForm.LeaseOrganization = 0 Then
            vQuery = "sps_IncompleteCalls " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "
        Else
            vQuery = "sps_IncompleteCallsLO " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "
        End If

        Try
            QueryIncompletes = modODBC.Exec(vQuery, vTempCallList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '6/29/07 bret 8.4.3.3 this code must run regarless of return status
        Call modControl.ClearListView(pvForm.LstViewIncompletes)

        If QueryIncompletes = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vTempCallList, 3)

            Call modControl.SetListViewRows(vTempCallList, True, pvForm.LstViewIncompletes, False, True, pvForm, INCOMPLETES)

        End If

    End Function
    Public Function QueryLogEventCall(ByRef pvLogEventId As Integer, ByRef prReturn As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object

        vQuery = "SELECT * FROM Call " & "INNER JOIN LogEvent ON Call.CallID = LogEvent.CallID " & "WHERE LogEventID = " & pvLogEventId & ";"

        Try
            QueryLogEventCall = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        prReturn = VB6.CopyArray(vParams)

    End Function
    Public Function QueryOpenMessage(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "", Optional ByRef TC As Short = 0) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As New Object
        Dim vReturn2 As New Object
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short
        Dim vTCMessageID As String = ""
        Dim vLeaseOrg As Integer
        Dim vpLease As String = ""
        modUtility.Work()

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vStartPeriod = CDate(pvForm.TxtFromDateMsg.Text & " 00:00")
        vEndPeriod = CDate(pvForm.TxtToDateMsg.Text & " 23:59")
        vLeaseOrg = AppMain.ParentForm.LeaseOrganization

        If TC = 1 Then 'show transplant centers message
            vTCMessageID = "2"
        Else
            vTCMessageID = "null"
        End If

        If vLeaseOrg = 0 Then 'check for lease org
            vpLease = "null"
        Else
            vpLease = Str(vLeaseOrg)
        End If

        'ccarroll 12/18/2006 - moved queries to the following sprocs:
        '   1. sps_QueryOpenMessageLO       - for lease organizations, transplant centers, no filters
        '   2. sps_QueryOpenMessage         - for transplant centers, no lease organizations, no filters
        '   3. sps_QueryOpenMessageParam    - for lease organizations, transplant centers with filters

        If pvAnd <> "" Then ' This is a filtered search
            pvAnd = Replace(pvAnd, "'", "''")
            vQuery = " exec sps_QueryOpenMessageParam " & Chr(39) & vStartPeriod & Chr(39) & ", " & Chr(39) & vEndPeriod & Chr(39) & ", " & vTimeZoneDif & ", " & vTCMessageID & ", " & vpLease & ", '" & pvAnd & "' "
        Else
            'Get all non import offers if Lease org. non- filtered search
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = " exec sps_QueryOpenMessageLO " & Chr(39) & vStartPeriod & Chr(39) & ", " & Chr(39) & vEndPeriod & Chr(39) & ", " & vTimeZoneDif & ", " & vTCMessageID & ", " & vpLease
            Else
                'non lease organization, non filtered search
                vQuery = " exec sps_QueryOpenMessage " & Chr(39) & vStartPeriod & Chr(39) & ", " & Chr(39) & vEndPeriod & Chr(39) & ", " & vTimeZoneDif & ", " & vTCMessageID
            End If

        End If

        'execute query
        Try
            QueryOpenMessage = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If QueryOpenMessage = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenMessage)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenMessage, False, , pvForm)
            'Call modControl.SetListViewRows(vReturn, True, pvForm, False)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenMessage)
        End If

        pvForm.LblCountMsg.Text = VB6.Format(pvForm.LstViewOpenMessage.Items.Count, "000#")

        modUtility.Done()

    End Function


    Public Function QueryOpenInformation(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "") As Short

        'mds 10/21/03 Added to open up existing Information (COD) calls

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        'Dim vOrganizationId&
        'Dim vStateID&
        Dim vTimeZoneDif As Short

        modUtility.Work()

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vStartPeriod = CDate(pvForm.TxtFromDateInfo.Text & " 00:00")
        vEndPeriod = CDate(pvForm.TxtToDateInfo.Text & " 23:59")

        'Get all COD information calls
        vQuery = "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",Call.CallDateTime) AS 'CallDateTime', " & "CODCaller.CODCallerFirst + ' ' + CODCaller.CODCallerLast, " & "State.StateAbbrv, Organization.OrganizationName, SourceCode.SourceCodeName " & "FROM CODCaller " & "LEFT JOIN Call ON Call.CallID = CODCaller.CallID " & "LEFT JOIN Organization ON Organization.OrganizationID = CODCaller.OrganizationID " & "LEFT JOIN State ON State.StateID = CODCaller.StateID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "


        vQuery = vQuery & "WHERE CallDateTime <= " & modODBC.BuildField(vEndPeriod) & " " & "AND CallDateTime >= " & modODBC.BuildField(vStartPeriod) & " " & pvAnd

        vQuery = vQuery & " ORDER BY CallDateTime DESC;"

        Try
            QueryOpenInformation = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenInformation = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenInformation)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenInformation, False, , pvForm)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenInformation)
        End If

        pvForm.LblCountMsg.Text = VB6.Format(pvForm.LstViewOpenInformation.Items.Count, "000#")

        modUtility.Done()

    End Function
    Public Function QueryOpenNoCall(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "") As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As Object = New Object()
        Dim vReturn2 As Object = New Object()
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short

        modUtility.Work()

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vStartPeriod = CDate(pvForm.TxtFromDateNC.Text & " 00:00")
        vEndPeriod = CDate(pvForm.TxtToDateNC.Text & " 23:59")

        vQuery = "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",Call.CallDateTime) AS 'CallDateTime', " & "NoCallType.NoCallTypeName, NoCall.NoCallDescription, SourceCodeName, " & "'' as Spacer, '' as Spacer, '' As Spacer, " & "Person.OrganizationID " & "FROM NoCall " & "LEFT JOIN Call ON NoCall.CallID = Call.CallID " & "LEFT JOIN NoCallType ON NoCall.NoCallTypeID = NoCallType.NoCallTypeID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID " & "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "

        vQuery = vQuery & "WHERE CallDateTime <= " & modODBC.BuildField(vEndPeriod) & " " & "AND CallDateTime >= " & modODBC.BuildField(vStartPeriod) & " " & pvAnd & " "

        'Add to Where if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'BJK 2/28/01 added AND SourceCodeOrganizationID
            vQuery = vQuery & "AND Person.Organizationid = " & AppMain.ParentForm.LeaseOrganization & " "
        End If

        vQuery = vQuery & " ORDER BY CallDateTime DESC;"

        Try
            QueryOpenNoCall = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenNoCall = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenNoCall)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenNoCall, False, , pvForm)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenNoCall)
        End If

        pvForm.LblCountNoCall.Text = VB6.Format(pvForm.LstViewOpenNoCall.Items.Count, "000#")

        modUtility.Done()

    End Function
    Public Function QueryOpenMessageRecycle(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "", Optional ByRef TC As Short = 0) As Short
        '************************************************************************************
        'Name: QueryOpenMessageRecycle
        'Date Created: 5/26/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Retrieves Message information from DB for display in Recycle Tab.
        '             Based on QueryOpenMessage.  Recycled calls have a record in
        '             CallRecycle table.
        'Returns: Integer
        'Params: pvForm As Form, Optional pvAnd$, Optional TC%
        'Stored Procedures: None
        '************************************************************************************
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As Object = New Object()
        Dim vReturn2 As Object = New Object()
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short

        modUtility.Work()

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vStartPeriod = CDate(pvForm.txtFromDateMsgRecycle.Text & " 00:00")
        vEndPeriod = CDate(pvForm.txtToDateMsgRecycle.Text & " 23:59")

        'Get all non import offers
        vQuery = "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ", Call.RecycleDateTime) AS 'CallDateTime', " & "Person.PersonFirst+RTRIM(' '+(ISNULL(Person.PersonMI,'')))+' '+Person.PersonLast, "

        vQuery = vQuery & "Organization.OrganizationName, MessageType.MessageTypeName, SourceCodeName, " & "ISNULL(MessageCallerOrganization, '') + ' - ' + MessageCallerName, " & "'' As Spacer, PO.OrganizationID, Call.RecycleDateTime " & "FROM Message " & "LEFT JOIN CallRecycle Call ON Call.CallID = Message.CallID " & "LEFT JOIN Person ON Person.PersonID = Message.PersonID " & "LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID " & "LEFT JOIN State ON State.StateID = Organization.StateID " & "LEFT JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID " & "LEFT JOIN Person PO ON PO.PersonID = StatEmployee.PersonID "

        'Add to Join if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'BJK 4/11/01 This code is to limit Messages and allow an Organization to see messages from all organizations in their
            '
            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID "
        End If

        vQuery = vQuery & "WHERE Call.RecycleDateTime <= " & modODBC.BuildField(vEndPeriod) & " " & "AND Call.RecycleDateTime >= " & modODBC.BuildField(vStartPeriod) & " " & pvAnd & " " & "AND Message.MessageTypeID <> 2 "

        'Add to Where if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'BJK 4/11/01 The following commented out code is used when a organization uses a source code but should not see any
            ' messages but theirs. This code is part of the where statment to limit records by organizationID only
            'vQuery = vQuery & _
            ''"AND Message.Organizationid = " & AppMain.ParentForm.LeaseOrganization & " "

            'BJK 4/11/01 The follwong code is used where organization should see messages from organizations within their source code
            ' This code is part of the where statment to limit records by OrgHierarchyParentID in conjunction with a join
            vQuery = vQuery & "AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & " "

        End If


        'Get all import offers
        vQuery = vQuery & "UNION ALL " & "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",Call.CallDateTime) AS 'CallDateTime', " & "Person.PersonFirst+RTRIM(' '+(ISNULL(Person.PersonMI,'')))+' '+Person.PersonLast, "

        vQuery = vQuery & "Organization.OrganizationName, MessageType.MessageTypeName, SourceCodeName, " & "ISNULL(MessageImportCenter,'') + ' - ' + ISNULL(MessageImportPatient,'') + ' - ' + ISNULL(MessageImportUNOSID,''), " & "'' AS Spacer, PO.OrganizationID, Call.RecycleDateTime " & "FROM Message " & "LEFT JOIN CallRecycle Call ON Call.CallID = Message.CallID " & "LEFT JOIN Person ON Person.PersonID = Message.PersonID " & "LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID " & "LEFT JOIN State ON State.StateID = Organization.StateID " & "LEFT JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID " & "LEFT JOIN Person PO ON PO.PersonID = StatEmployee.PersonID "

        If TC = 1 Then 'T.T 5/19/2004 'If TC = 1' Redefine vQuery to search on Transplant Centers

            vQuery = "SELECT DISTINCT Call.CallID, Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",Call.RecycleDateTime) AS 'CallDateTime', " & "Person.PersonFirst+RTRIM(' '+(ISNULL(Person.PersonMI,'')))+' '+Person.PersonLast, "

            vQuery = vQuery & "Organization.OrganizationName, MessageType.MessageTypeName, SourceCodeName, " & "ISNULL(MessageImportCenter,'') + ' - ' + ISNULL(MessageImportPatient,'') + ' - ' + ISNULL(MessageImportUNOSID,''), " & "'' AS Spacer, PO.OrganizationID, Call.RecycleDateTime " & "FROM Message " & "LEFT JOIN CallRecycle Call ON Call.CallID = Message.CallID " & "LEFT JOIN Person ON Person.PersonID = Message.PersonID " & "LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID " & "LEFT JOIN State ON State.StateID = Organization.StateID " & "LEFT JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID " & "LEFT JOIN Person PO ON PO.PersonID = StatEmployee.PersonID "
        End If
        'Add to Join if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'BJK 4/11/01 This code is to limit Messages and allow an Organization to see messages from all organizations in their
            ' report group.
            vQuery = vQuery & "LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID "
        End If


        vQuery = vQuery & "WHERE Call.RecycleDateTime <= " & modODBC.BuildField(vEndPeriod) & " " & "AND Call.RecycleDateTime >= " & modODBC.BuildField(vStartPeriod) & " " & pvAnd & " " & "AND Message.MessageTypeID = 2 "

        'Add to Where if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'BJK 4/11/01 The following commented out code is used when a organization uses a source code but should not see any
            ' messages but theirs. This code is part of the where statment to limit records by organizationID only
            'vQuery = vQuery & _
            ''"AND Message.Organizationid = " & AppMain.ParentForm.LeaseOrganization & " "

            'BJK 4/11/01 The follwong code is used where organization should see messages from organizations within their source code
            ' This code is part of the where statment to limit records by OrgHierarchyParentID in conjunction with a join
            vQuery = vQuery & "AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & " "
        End If

        vQuery = vQuery & " ORDER BY CallDateTime DESC;"

        Try
            QueryOpenMessageRecycle = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenMessageRecycle = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenMsgRecycle)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenMsgRecycle, False, , pvForm)
            'Call modControl.SetListViewRows(vReturn, True, pvForm, False)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenMsgRecycle)
        End If

        modUtility.Done()

    End Function
    Public Function QueryOpenReferral(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "", Optional ByRef pvTop As Short = 0) As Short
        '************************************************************************************
        'Name: QueryOpenReferral%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Retrieves Referral information from DB for display in
        'Returns: Integer
        'Params: pvForm As Form, Optional pvAnd$, Optional pvTop%
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/23/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added previous referral type and TC name to list of data returned.
        '====================================================================================
        'Date Changed: 6/19/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description:  replaced all dynamic code with GetReferralList and GetReferralListLO
        '====================================================================================
        '************************************************************************************
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As Object = New Object()
        Dim vReturn2 As Object = New Object()
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short
        'bret 06/15/07 8.4.3.3 prevent timeouts add dbParams and dbFields
        Dim dbParams(12) As Object
        Dim dbFields(12) As Object
        Dim dbString As String = ""

        dbParams(0) = pvForm.TxtFromDateRef.Text & " " & pvForm.TxtFromTimeRef.Text
        dbParams(1) = pvForm.TxtToDateRef.Text & " " & pvForm.TxtToTimeRef.Text
        dbParams(2) = AppMain.ParentForm.TimeZone
        dbParams(3) = IIf(pvForm.TxtCallNumberRef.Text = "", System.DBNull.Value, pvForm.TxtCallNumberRef.Text)

        dbParams(4) = IIf(pvForm.TxtLocationRef.Text = "", System.DBNull.Value, pvForm.TxtLocationRef.Text)
        dbParams(5) = IIf(pvForm.TxtStateRef.Text = "", System.DBNull.Value, pvForm.TxtStateRef.Text)

        dbParams(6) = IIf(pvForm.TxtPatientFirstRef.Text = "", System.DBNull.Value, pvForm.TxtPatientFirstRef.Text)

        dbParams(7) = IIf(pvForm.TxtPatientLastRef.Text = "", System.DBNull.Value, pvForm.TxtPatientLastRef.Text)
        dbParams(8) = IIf(pvForm.TxtReferralType.Text = "", System.DBNull.Value, pvForm.TxtReferralType.Text)
        dbParams(9) = IIf(pvForm.txtPreRefType.Text = "", System.DBNull.Value, pvForm.txtPreRefType.Text)
        dbParams(10) = IIf(pvForm.TxtRefSource.Text = "", System.DBNull.Value, pvForm.TxtRefSource.Text)
        dbParams(11) = IIf(pvForm.txtTcNameRef.Text = "", System.DBNull.Value, pvForm.txtTcNameRef.Text)

        dbParams(12) = IIf(AppMain.ParentForm.LeaseOrganization = 0, System.DBNull.Value, AppMain.ParentForm.LeaseOrganization)

        dbFields(0) = "@startDateTime"
        dbFields(1) = "@endDatetime"
        dbFields(2) = "@timeZone"
        dbFields(3) = "@callNumber"
        dbFields(4) = "@organizationName"
        dbFields(5) = "@statAbbreviation"
        dbFields(6) = "@referralDonorFirstName"
        dbFields(7) = "@referralDonorLastName"
        dbFields(8) = "@currentReferralTypeName"
        dbFields(9) = "@previousReferralTypeName"
        dbFields(10) = "@sourceCodeName"
        dbFields(11) = "@statEmployeeFirstName"
        dbFields(12) = "@userOrganizationID"


        dbString = modODBC.BuildSQL(QUERY_STOREDPROCEDURE, dbParams, dbFields)

        'QUERY_STOREDPROCEDURE
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = "EXEC GetReferralListLO " & dbString
        Else
            vQuery = "EXEC GetReferralList " & dbString
        End If

        Try
            QueryOpenReferral = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'if success or results were returned
        If QueryOpenReferral = SUCCESS Then '10/8/07 bret removed Or UBound(vReturn) > 0 Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenReferral)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenReferral, False, , pvForm)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenReferral)
        End If

        pvForm.LblCountRef.Text = VB6.Format(pvForm.LstViewOpenReferral.Items.Count, "000#")


        modUtility.Done()


    End Function
    Public Function QueryOpenUpdate(ByRef pvForm As FrmOpenAll, Optional ByRef pvTop As Short = 0) As Short
        '************************************************************************************
        'Name: QueryOpenUpdate
        'Date Created: 5/24/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Retrieves Referral information from DB for display in Update Tab.
        '             Based on QueryOpenReferral
        'Returns: Integer
        'Params: pvForm As Form, Optional pvAnd$, Optional pvTop%
        'Stored Procedures: None
        '************************************************************************************
        'ccarroll 06/14/2006 added new WHERE clause items for 8.0 Update tab
        ' - Logevents
        ' - QA Review Complete
        '************************************************************************************
        '************************************************************************************
        'ccarroll 07/17/2007 8.4.0 release Update Tab
        ' - Changed Joins and Where clause to improve performance
        ' - Added exclusion for online updates to where clause
        ' - Corrected sproc spelling: sps_UpdatedReferralEventsLO
        '************************************************************************************
        'Name: ccarroll
        'Change date: 10/03/2007
        'Release: 8.4.3
        'Description: Removed dynamic SQL code including vAnd parameters. Parameters are now passed directly to
        '             the sproc.
        '************************************************************************************


        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As Object = New Object()
        Dim vReturn2 As Object = New Object()
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short

        'ccarroll 10/03/2007 - 8.4.3, added the following sproc parameters:
        Dim vCallNumber As String = ""
        Dim vLocation As String = ""
        Dim vState As String = ""
        Dim vPatientFirst As String = ""
        Dim vPatientLast As String = ""
        Dim vReferralType As String = ""
        Dim vPreReferralType As String = ""
        Dim vSourceCodeName As String = ""
        Dim vTcName As String = ""

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'ccarroll 10/03/2007 - 8.4.3, added following sproc parameters
        vCallNumber = modODBC.BuildField(pvForm.txtCallNumberUpdate.Text)
        vLocation = modODBC.BuildField(pvForm.txtLocationUpdate.Text)
        vState = modODBC.BuildField(pvForm.txtStateUpdate.Text)
        vPatientFirst = modODBC.BuildField(pvForm.txtPatientFirstUpdate.Text)
        vPatientLast = modODBC.BuildField(pvForm.txtPatientLastUpdate.Text)
        vReferralType = modODBC.BuildField(pvForm.txtReferralTypeUpdate.Text)
        vPreReferralType = modODBC.BuildField(pvForm.txtPreRefTypeUpdate.Text)
        vSourceCodeName = modODBC.BuildField(pvForm.txtRefSourceUpdate.Text)
        vTcName = modODBC.BuildField(pvForm.txtTcNameUpdate.Text)

        modUtility.Work()

        vStartPeriod = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.txtFromDateUpdate.Text & " " & pvForm.txtFromTimeUpdate.Text))
        vEndPeriod = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.txtToDateUpdate.Text & " " & pvForm.txtToTimeUpdate.Text))


        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = "sps_UpdatedReferralEventsLO " & modODBC.BuildField(vStartPeriod) & ", " & modODBC.BuildField(vEndPeriod) & ", " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & ", " & vCallNumber & ", " & vLocation & ", " & vState & ", " & vPatientFirst & ", " & vPatientLast & ", " & vReferralType & ", " & vPreReferralType & ", " & vSourceCodeName & ", " & vTcName & ", " & pvTop & "; "
        Else
            vQuery = "sps_UpdatedReferralEvents " & modODBC.BuildField(vStartPeriod) & ", " & modODBC.BuildField(vEndPeriod) & ", " & AppMain.ParentForm.TimeZone & ", " & vCallNumber & ", " & vLocation & ", " & vState & ", " & vPatientFirst & ", " & vPatientLast & ", " & vReferralType & ", " & vPreReferralType & ", " & vSourceCodeName & ", " & vTcName & ", " & pvTop & "; "
        End If

        Try
            QueryOpenUpdate = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenUpdate = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenUpdate)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenUpdate, False, , pvForm)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenUpdate)
        End If

        modUtility.Done()

    End Function

    Public Function QueryOpenRecycle(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "", Optional ByRef pvTop As Short = 0) As Short
        '************************************************************************************
        'Name: QueryOpenRecycle
        'Date Created: 5/24/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Retrieves Referral information from DB for display in Recycle Tab.
        '             Based on QueryOpenReferral.  Recycled calls have a record in
        '             CallRecycle table.
        'Returns: Integer
        'Params: pvForm As Form, Optional pvAnd$, Optional pvTop%
        'Stored Procedures: None
        '************************************************************************************
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vReturn1 As Object = New Object()
        Dim vReturn2 As Object = New Object()
        Dim vJoinedReturn() As String
        Dim vStartPeriod As Date
        Dim vEndPeriod As Date
        Dim vQueryMI As String = ""
        Dim vQueryMIResult As Short
        Dim vOrganizationId As Integer
        Dim vStateID As Integer
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        modUtility.Work()

        vStartPeriod = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.txtFromDateRecycle.Text & " " & pvForm.txtFromTimeRecycle.Text))
        vEndPeriod = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.txtToDateRecycle.Text & " " & pvForm.txtToTimeRecycle.Text))

        If pvAnd = "" Then
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = "sps_QueryOpenRecycleLO " & modODBC.BuildField(vStartPeriod) & ", " & modODBC.BuildField(vEndPeriod) & ", " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & ", " & pvTop & "; "
            Else

                vQuery = "sps_QueryOpenRecycle " & modODBC.BuildField(vStartPeriod) & ", " & modODBC.BuildField(vEndPeriod) & ", " & AppMain.ParentForm.TimeZone & ", " & pvTop & "; "
            End If
        Else
            If pvTop > 0 Then
                vQuery = "SELECT DISTINCT TOP " & pvTop & " CallRecycle.CallID, "
            Else
                vQuery = "SELECT DISTINCT CallRecycle.CallID, "
            End If
            vQuery = vQuery & "CallRecycle.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ",CallRecycle.RecycleDateTime) AS 'CallDateTime', " & "Referral.ReferralDonorName, Organization.OrganizationName, " & "PrevRefType.ReferralTypeName AS PrevReferralTypeName, " & "ReferralType.ReferralTypeName, SourceCodeName, " & "StatEmployeeFirstName + ' ' + StatEmployeeLastName AS StatEmployee, " & "Person.OrganizationID, CallRecycle.RecycleDateTime " & "FROM Referral " & "LEFT JOIN CallRecycle ON CallRecycle.CallID = Referral.CallID " & "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID " & "LEFT JOIN State ON State.StateID = Organization.StateID " & "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID " & "LEFT JOIN ReferralType PrevRefType ON Referral.ReferralTypeId = PrevRefType.ReferralTypeId " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = CallRecycle.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = CallRecycle.StatEmployeeID " & "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "

            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = vQuery & "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID " & "LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID " & "LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID " & "AND WebReportGroupOrg.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID "
            End If

            ' Use RecycleDateTime as the time param.  5/24/05 - SAP
            vQuery = vQuery & "WHERE CallRecycle.RecycleDateTime <= " & modODBC.BuildField(vEndPeriod) & " " & "AND CallRecycle.RecycleDateTime >= " & modODBC.BuildField(vStartPeriod) & " " & pvAnd & " "

            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = vQuery & "AND WebReportGroup.OrgHierarchyParentID = " & AppMain.ParentForm.LeaseOrganization & " "
            End If

            vQuery = vQuery & " ORDER BY CallDateTime DESC;"
        End If
        Try
            QueryOpenRecycle = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOpenRecycle = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 2)

            Call modControl.ClearListView(pvForm.LstViewOpenRecycle)

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewOpenRecycle, False, , pvForm)

        Else
            Call modControl.ClearListView(pvForm.LstViewOpenRecycle)
        End If

        modUtility.Done()


    End Function
    Public Function QueryPendingPage(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QueryPendingPage%
        'Date Created: Unknown                          Created by: Unknown
        'Release: unknown                               Task: unknown
        'Description: Queries Pending Pages
        'Returns: N/A
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: replaced sps_PendingPage5v with sps_PendingPage
        '
        '====================================================================================
        'Date Changed: 6/29/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: move the ClearListView statment from first statement to after the query is returned
        '                sucessfully.
        '
        '====================================================================================

        Dim vQuery As String = ""
        Dim vPendingList As New Object


        '7/9/01 drh Changed to sps_PendingPage4 from sps_PendingPage2
        '05/07/02 bjk change to sps_PendingPage 5 from sps_PendingPage4


        vQuery = "sps_PendingPage " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "

        Try
            QueryPendingPage = modODBC.Exec(vQuery, vPendingList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '6/29/07 bret this statement must be called regardless if the return was SUCCESS
        Call modControl.ClearListView(pvForm.LstViewPendingPage)

        If QueryPendingPage = SUCCESS Then

            'Format the date column
            Call modMask.TimeColumn(vPendingList, 3)

            Call modControl.SetListViewRows(vPendingList, True, pvForm.LstViewPendingPage, False, True, pvForm, PAGE_PENDING)

        End If

    End Function
    Public Function QueryPageInterval(ByRef pvOrganizationName As Object, ByRef prReturn As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT OrganizationPageInterval FROM Organization " & "WHERE OrganizationName = " & modODBC.BuildField(pvOrganizationName) & ";"

        Try
            QueryPageInterval = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPageInterval = SUCCESS Then
            prReturn = vParams
        End If

    End Function

    Public Function QueryConsentInterval(ByRef pvOrganizationName As Object, ByRef prReturn As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        pvOrganizationName = pvOrganizationName & "%"

        vQuery = "SELECT OrganizationConsentInterval FROM Organization " & "WHERE OrganizationName LIKE " & modODBC.BuildField(pvOrganizationName)

        Try
            QueryConsentInterval = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryConsentInterval = SUCCESS Then
            prReturn = vParams
        End If

    End Function
    Public Function QueryPendingCallout(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QueryPendingCallout%
        'Date Created: Unknown                          Created by: Unknown
        'Release: unknown                               Task: unknown
        'Description: Queries Pending Secondary Call Outs
        'Returns: N/A
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: replaced sps_PendingSecondaryActivity2v with sps_PendingSecondaryActivity
        '
        '====================================================================================
        'Date Changed: 6/29/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: move the ClearListView statment from first statement to after the query is returned
        '                sucessfully.
        '
        '====================================================================================

        Dim vQuery As String = ""
        Dim vCalloutList As New Object

        vQuery = "sps_PendingSecondaryActivity " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "

        Try
            QueryPendingCallout = modODBC.Exec(vQuery, vCalloutList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '6/29/07 bret 8.4.3.3 This code must run regardless of return of Success
        Call modControl.ClearListView(pvForm.LstViewCallouts)

        If QueryPendingCallout = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vCalloutList, 3)

            Call modControl.SetListViewRows(vCalloutList, True, pvForm.LstViewCallouts, False, True, pvForm, SECONDARY_ACTIVITY)

        End If

    End Function
    Public Function QueryPendingConsent(ByRef pvForm As FrmOpenAll, Optional ByRef pvAnd As String = "") As Short

        Dim vQuery As String = ""
        Dim vPendingList As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)


        'Get the pending referral events
        '02/11/03 BJK MODIFY JOIN FOR STATE FROM JOIN TO LEFT JOIN
        '02/11/03 BJK added DISTINCT
        vQuery = "SELECT DISTINCT LogEvent.LogEventID, LogOrg.OrganizationTypeID, " & "Call.CallNumber, " & "DATEADD(hh, " & vTimeZoneDif & ", LogEventDateTime), " & "Organization.OrganizationName, Referral.ReferralDonorName, " & "LogEvent.LogEventOrg, LogEvent.LogEventName, SourceCodeName, " & "Person.OrganizationID " & "FROM LogEvent " & "JOIN Referral ON LogEvent.CallID = Referral.CallID " & "JOIN Call ON Referral.CallID = Call.CallID " & "JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID " & "LEFT JOIN Organization AS LogOrg ON LogOrg.OrganizationID = LogEvent.OrganizationID " & "LEFT JOIN State ON State.StateID = Organization.StateID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID " & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call. StatEmployeeID " & "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "

        'Add Join if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            '02/21/2003 bjk combined the two fixes
            vQuery = vQuery & "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID " & "LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID " & "LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID " & "AND WebReportGroupOrg.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID "

            '02/21/2003 BJK removed
            '"Left JOIN    WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID " & _
            ''"Left JOIN    WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "

        End If

        vQuery = vQuery & "WHERE LogEvent.LogEventCallbackPending = -1 " & "AND LogEvent.LogEventTypeID = " & CONSENT_PENDING & " " & pvAnd & " "

        'Add to Where if LeaseOrganization
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            'bjk 02/28/2002
            vQuery = vQuery & "AND WebReportGroup.OrgHierarchyParentID = " & AppMain.ParentForm.LeaseOrganization & " "

        End If

        '7/9/01 drh Do not list Family Services Cases
        vQuery = vQuery & "AND Call.CallID NOT IN(SELECT CallId FROM FSCase) "

        '02/11/03 bjk modified LogEventDateTime in order by
        vQuery = vQuery & "ORDER BY LogEvent.LogEventOrg, DATEADD(hh, " & vTimeZoneDif & ", LogEventDateTime) DESC "

        Try
            QueryPendingConsent = modODBC.Exec(vQuery, vPendingList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPendingConsent = SUCCESS Then

            Call modControl.ClearListView(pvForm.LstViewPendingConsent)

            'Format the date column
            Call modMask.DateTimeColumn(vPendingList, 3)

            Call modControl.SetListViewRows(vPendingList, True, pvForm.LstViewPendingConsent, False, True, pvForm, CONSENT_PENDING)

        ElseIf QueryPendingConsent = NO_DATA Then

            Call modControl.ClearListView(pvForm.LstViewPendingConsent)

        End If

    End Function
    Public Function QueryPendingSecondary(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QueryPendingSecondary%
        'Date Created: Unknown                          Created by: Unknown
        'Release: unknown                               Task: unknown
        'Description: Queries Pending Secondaries
        'Returns: N/A
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: replaced sps_PendingSecondaryWIP2v with sps_PendingSecondaryWIP
        '   and sps_PendingSecondaryWIPLO2v with sps_PendingSecondaryWIPLO
        '
        '====================================================================================
        'Date Changed: 6/29/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: move the ClearListView statment from first statement to after the query is returned
        '                sucessfully.
        '
        '====================================================================================

        Dim vQuery As String = ""
        Dim vSecondaryList As New Object


        'user is not lease org
        vQuery = "sps_PendingSecondaryWIP " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "

        Try
            QueryPendingSecondary = modODBC.Exec(vQuery, vSecondaryList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        '6/29/07 bret This code must run regardless of return SUCESS
        Call modControl.ClearListView(pvForm.LstViewSecondary)

        If QueryPendingSecondary = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vSecondaryList, 3)

            Call modControl.SetListViewRows(vSecondaryList, True, pvForm.LstViewSecondary, False, True, pvForm, SECONDARY_WIP)

        End If

    End Function

    Public Function QueryPendingSecondaryAlert(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QueryPendingSecondaryAlert%
        'Date Created: Unknown                          Created by: Unknown
        'Release: unknown                               Task: unknown
        'Description: Queries Pending Secondary Alerts
        'Returns: N/A
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: replaced sps_PendingSecondaryAlert6v with sps_PendingSecondaryAlert
        '
        '====================================================================================
        'Date Changed: 6/29/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description: move the ClearListView statment from first statement to after the query is returned
        '                sucessfully.
        '
        '====================================================================================
        Dim vQuery As String = ""
        Dim vSecondaryAlertList As New Object

        vQuery = "sps_PendingSecondaryAlert " & AppMain.ParentForm.LeaseOrganization & ", " & AppMain.ParentForm.TimeZone & "; "

        Try
            QueryPendingSecondaryAlert = modODBC.Exec(vQuery, vSecondaryAlertList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '6/29/07 bret 8.4.3.3 This code must run regardless of return of Success
        Call modControl.ClearListView(pvForm.LstViewSecondaryAlert)

        If QueryPendingSecondaryAlert = SUCCESS Then

            'Format the date column
            Call modMask.DateTimeColumn(vSecondaryAlertList, 3)

            Call modControl.SetListViewRows(vSecondaryAlertList, True, pvForm.LstViewSecondaryAlert, False, True, pvForm, SECONDARY_ALERT)

        End If

    End Function
    Public Function QuerySearchOpenReferral(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QuerySearchOpenReferral%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Refreshes data in listview on tab
        'Returns: Nothing
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/24/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added new search params for preliminary referral type and tc name.
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/14/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description:
        '   remove 200 record limit
        '   improve query
        '   replace query with sproc
        '====================================================================================
        '************************************************************************************

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""

        Dim vSearchDays As Short
        Dim vLimitQuery As Short

        vLimitQuery = 0

        vSearchDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(pvForm.TxtFromDateRef.Text), CDate(pvForm.TxtToDateRef.Text))


        vAnd = ""
        If pvForm.TxtCallNumberRef.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.TxtCallNumberRef.Text), Len(modODBC.BuildField(pvForm.TxtCallNumberRef.Text)) - 1) & "%' "
        End If

        If pvForm.TxtLocationRef.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.TxtLocationRef.Text), Len(modODBC.BuildField(pvForm.TxtLocationRef.Text)) - 1) & "%' "
        End If

        If pvForm.TxtStateRef.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.TxtStateRef.Text), Len(modODBC.BuildField(pvForm.TxtStateRef.Text)) - 1) & "%' "
        End If

        If pvForm.TxtPatientFirstRef.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorFirstName LIKE " & Left(modODBC.BuildField(pvForm.TxtPatientFirstRef.Text), Len(modODBC.BuildField(pvForm.TxtPatientFirstRef.Text)) - 1) & "%'"
        End If
        If pvForm.TxtPatientLastRef.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorLastName LIKE " & Left(modODBC.BuildField(pvForm.TxtPatientLastRef.Text), Len(modODBC.BuildField(pvForm.TxtPatientLastRef.Text)) - 1) & "%'"
        End If

        ' Changed to look at Current Referral Type.  5/24/05 - SAP
        If pvForm.TxtReferralType.Text <> "" Then
            vAnd = vAnd & "AND ReferralType.ReferralTypeName LIKE " & Left(modODBC.BuildField(pvForm.TxtReferralType.Text), Len(modODBC.BuildField(pvForm.TxtReferralType.Text)) - 1) & "%'"
        End If
        ' Added new Previous Referral Type search.  5/24/05 - SAP
        If pvForm.txtPreRefType.Text <> "" Then
            vAnd = vAnd & "AND PrevRefType.ReferralTypeName LIKE " & Left(modODBC.BuildField(pvForm.txtPreRefType.Text), Len(modODBC.BuildField(pvForm.txtPreRefType.Text)) - 1) & "%'"
        End If

        If pvForm.TxtRefSource.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.TxtRefSource.Text), Len(modODBC.BuildField(pvForm.TxtRefSource.Text)) - 1) & "%'"
        End If

        ' Added new Triage Coordinator search.  5/24/05 - SAP
        If pvForm.txtTcNameRef.Text <> "" Then
            vAnd = vAnd & "AND StatEmployee.StatEmployeeFirstName LIKE " & Left(modODBC.BuildField(pvForm.txtTcNameRef.Text), Len(modODBC.BuildField(pvForm.txtTcNameRef.Text)) - 1) & "%'"
        End If

        'Build and execute
        Call QueryOpenReferral(pvForm, vAnd, vLimitQuery)

    End Function


    Public Function QuerySearchOpenUpdate(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QuerySearchOpenUpdate
        'Date Created: 5/24/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Refreshes data in listview on Update tab in dashboard.  Based on
        '             QuerySearchOpenReferral
        'Returns: Nothing
        'Params: pvForm
        'Stored Procedures: None
        '************************************************************************************
        'ISE: ccarroll
        'Change date: 10/03/2007
        'Release: 8.4.3
        'Description: Removed code for vAnd parameters. Parameters are now passed directly to
        '             the sprocs. See QueryOpenUpdate for further details
        '************************************************************************************

        Dim vQuery As New Object
        Dim vReturn As New Object

        Dim vSearchDays As Short
        Dim vLimitQuery As Short
        Const MAX_DAYS As Short = 10
        Const MAX_LIMITED_ROWS As Short = 200

        vLimitQuery = 0

        vSearchDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(pvForm.txtFromDateUpdate.Text), CDate(pvForm.txtToDateUpdate.Text))

        ' Determine whether there are enough additional parameters available to make this a reasonable query,
        ' otherwise, limit the query's rows returned
        If vSearchDays > MAX_DAYS Then
            If Len(pvForm.txtCallNumberUpdate.Text) > 2 Then
                vSearchDays = vSearchDays * 0.5
                If Len(pvForm.txtCallNumberUpdate.Text) > 3 Then
                    vSearchDays = vSearchDays * 0.75
                End If
                If Len(pvForm.txtCallNumberUpdate.Text) > 4 Then
                    vSearchDays = vSearchDays * 0.75
                End If
            End If
            If Len(pvForm.txtLocationUpdate.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtLocationUpdate.Text) * 0.1))
            End If
            If Len(pvForm.txtPatientLastUpdate.Text) > 0 Then
                If Len(pvForm.txtPatientFirstUpdate.Text) > 0 Then ' Triple the reduction created by the last name score
                    vSearchDays = vSearchDays * (1 - (3 * Len(pvForm.txtPatientLastUpdate.Text) * 0.1))
                Else
                    vSearchDays = vSearchDays * (1 - (Len(pvForm.txtPatientLastUpdate.Text) * 0.1))
                End If
            End If
            If Len(pvForm.txtPatientLastUpdate.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtPatientLastUpdate.Text) * 0.1))
            End If
            If Len(pvForm.txtStateUpdate.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtStateUpdate.Text) * 0.25))
            End If
            If Len(pvForm.txtRefSourceUpdate.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtRefSourceUpdate.Text) * 0.2))
            End If

        End If

        ' If the search days number is still greater than 10
        If vSearchDays > MAX_DAYS Then
            vLimitQuery = MAX_LIMITED_ROWS
        End If

        'Build and execute
        Call QueryOpenUpdate(pvForm, vLimitQuery)

    End Function

    Public Function QuerySearchOpenRecycle(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QuerySearchOpenRecycle
        'Date Created: 5/24/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Refreshes data in listview on Recycle tab in dashboard.  Based on
        '             QuerySearchOpenReferral
        'Returns: Nothing
        'Params: pvForm
        'Stored Procedures: None
        '************************************************************************************

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""

        Dim vSearchDays As Short
        Dim vLimitQuery As Short
        Const MAX_DAYS As Short = 10
        Const MAX_LIMITED_ROWS As Short = 200

        vLimitQuery = 0

        vSearchDays = DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(pvForm.txtFromDateRecycle.Text), CDate(pvForm.txtToDateRecycle.Text))

        ' Determine whether there are enough additional parameters available to make this a reasonable query,
        ' otherwise, limit the query's rows returned
        If vSearchDays > MAX_DAYS Then
            If Len(pvForm.txtCallNumberRecycle.Text) > 2 Then
                vSearchDays = vSearchDays * 0.5
                If Len(pvForm.txtCallNumberRecycle.Text) > 3 Then
                    vSearchDays = vSearchDays * 0.75
                End If
                If Len(pvForm.txtCallNumberRecycle.Text) > 4 Then
                    vSearchDays = vSearchDays * 0.75
                End If
            End If
            If Len(pvForm.txtLocationRecycle.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtLocationRecycle.Text) * 0.1))
            End If
            If Len(pvForm.txtPatientLastRecycle.Text) > 0 Then
                If Len(pvForm.txtPatientFirstRecycle.Text) > 0 Then ' Triple the reduction created by the last name score
                    vSearchDays = vSearchDays * (1 - (3 * Len(pvForm.txtPatientLastRecycle.Text) * 0.1))
                Else
                    vSearchDays = vSearchDays * (1 - (Len(pvForm.txtPatientLastRecycle.Text) * 0.1))
                End If
            End If
            If Len(pvForm.txtPatientLastRecycle.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtPatientLastRecycle.Text) * 0.1))
            End If
            If Len(pvForm.txtStateRecycle.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtStateRecycle.Text) * 0.25))
            End If
            If Len(pvForm.txtRefSourceRecycle.Text) > 0 Then
                vSearchDays = vSearchDays * (1 - (Len(pvForm.txtRefSourceRecycle.Text) * 0.2))
            End If

        End If

        ' If the search days number is still greater than 10
        If vSearchDays > MAX_DAYS Then
            vLimitQuery = MAX_LIMITED_ROWS
        End If

        vAnd = ""
        If pvForm.txtCallNumberRecycle.Text <> "" Then
            vAnd = "AND CallRecycle.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.txtCallNumberRecycle.Text), Len(modODBC.BuildField(pvForm.txtCallNumberRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtLocationRecycle.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.txtLocationRecycle.Text), Len(modODBC.BuildField(pvForm.txtLocationRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtStateRecycle.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.txtStateRecycle.Text), Len(modODBC.BuildField(pvForm.txtStateRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtPatientFirstRecycle.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorFirstName LIKE " & Left(modODBC.BuildField(pvForm.txtPatientFirstRecycle.Text), Len(modODBC.BuildField(pvForm.txtPatientFirstRecycle.Text)) - 1) & "%'"
        End If
        If pvForm.txtPatientLastRecycle.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorLastName LIKE " & Left(modODBC.BuildField(pvForm.txtPatientLastRecycle.Text), Len(modODBC.BuildField(pvForm.txtPatientLastRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtReferralTypeRecycle.Text <> "" Then
            vAnd = vAnd & "AND ReferralType.ReferralTypeName LIKE " & Left(modODBC.BuildField(pvForm.txtReferralTypeRecycle.Text), Len(modODBC.BuildField(pvForm.txtReferralTypeRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtPreRefTypeRecycle.Text <> "" Then
            vAnd = vAnd & "AND PrevRefType.ReferralTypeName LIKE " & Left(modODBC.BuildField(pvForm.txtPreRefTypeRecycle.Text), Len(modODBC.BuildField(pvForm.txtPreRefTypeRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtRefSourceRecycle.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.txtRefSourceRecycle.Text), Len(modODBC.BuildField(pvForm.txtRefSourceRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtTcNameRecycle.Text <> "" Then
            vAnd = vAnd & "AND StatEmployee.StatEmployeeFirstName LIKE " & Left(modODBC.BuildField(pvForm.txtTcNameRecycle.Text), Len(modODBC.BuildField(pvForm.txtTcNameRecycle.Text)) - 1) & "%'"
        End If

        'Build and execute
        Call QueryOpenRecycle(pvForm, vAnd, vLimitQuery)

    End Function

    Public Function QuerySearchOpenMessage(ByRef pvForm As FrmOpenAll) As Short

        Dim vAnd As String = ""
        Dim vTC As Short 'T.T Variable for trigger of Query on Transplant Center see task #264 *CodeReview

        vAnd = ""
        vTC = 0
        If pvForm.TxtCallNumberMsg.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.TxtCallNumberMsg.Text), Len(modODBC.BuildField(pvForm.TxtCallNumberMsg.Text)) - 1) & "%' "
        End If

        If pvForm.TxtLocationMsg.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.TxtLocationMsg.Text), Len(modODBC.BuildField(pvForm.TxtLocationMsg.Text)) - 1) & "%' "
        End If

        If pvForm.TxtStateMsg.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.TxtStateMsg.Text), Len(modODBC.BuildField(pvForm.TxtStateMsg.Text)) - 1) & "%' "
        End If

        If pvForm.TxtForPersonFirst.Text <> "" Then
            vAnd = vAnd & "AND Person.PersonFirst LIKE " & Left(modODBC.BuildField(pvForm.TxtForPersonFirst.Text), Len(modODBC.BuildField(pvForm.TxtForPersonFirst.Text)) - 1) & "%'"
        End If

        If pvForm.TxtForPersonLast.Text <> "" Then
            vAnd = vAnd & "AND Person.PersonLast LIKE " & Left(modODBC.BuildField(pvForm.TxtForPersonLast.Text), Len(modODBC.BuildField(pvForm.TxtForPersonLast.Text)) - 1) & "%'"
        End If

        If pvForm.TxtMessageType.Text <> "" Then
            vAnd = vAnd & "AND MessageType.MessageTypeName LIKE " & Left(modODBC.BuildField(pvForm.TxtMessageType.Text), Len(modODBC.BuildField(pvForm.TxtMessageType.Text)) - 1) & "%'"
        End If

        If pvForm.TxtMsgSource.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.TxtMsgSource.Text), Len(modODBC.BuildField(pvForm.TxtMsgSource.Text)) - 1) & "%'"
        End If

        If pvForm.TxtMsgFrom.Text <> "" Then
            vAnd = vAnd & "AND Message.MessageCallerOrganization LIKE " & Left(modODBC.BuildField(pvForm.TxtMsgFrom.Text), Len(modODBC.BuildField(pvForm.TxtMsgFrom.Text)) - 1) & "%'"
        End If

        If pvForm.TxtMsgTx.Text <> "" Then 'T.T 05/20/2004 added for GOLM to do a search on Transplant Center see task #264 *CodeReview
            vAnd = vAnd & "AND Message.MessageImportCenter LIKE " & Left(modODBC.BuildField(pvForm.TxtMsgTx.Text), Len(modODBC.BuildField(pvForm.TxtMsgTx.Text)) - 1) & "%'"
            vTC = 1
        End If

        'Build and execute
        Call QueryOpenMessage(pvForm, vAnd, vTC)

    End Function

    Public Function QuerySearchOpenMsgRecycle(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: QuerySearchOpenMsgRecycle
        'Date Created: 5/26/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Refreshes Message data in listview on Recycle tab in dashboard.  Based on
        '             QuerySearchOpenMessage
        'Returns: Nothing
        'Params: pvForm
        'Stored Procedures: None
        '************************************************************************************
        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""
        Dim vTC As Short 'T.T Variable for trigger of Query on Transplant Center see task #264 *CodeReview

        vAnd = ""
        vTC = 0
        If pvForm.txtCallNumberMsgRecycle.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.txtCallNumberMsgRecycle.Text), Len(modODBC.BuildField(pvForm.txtCallNumberMsgRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtLocationMsgRecycle.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.txtLocationMsgRecycle.Text), Len(modODBC.BuildField(pvForm.txtLocationMsgRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtStateMsgRecycle.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.txtStateMsgRecycle.Text), Len(modODBC.BuildField(pvForm.txtStateMsgRecycle.Text)) - 1) & "%' "
        End If

        If pvForm.txtForPersonFirstRecycle.Text <> "" Then
            vAnd = vAnd & "AND Person.PersonFirst LIKE " & Left(modODBC.BuildField(pvForm.txtForPersonFirstRecycle.Text), Len(modODBC.BuildField(pvForm.txtForPersonFirstRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtForPersonLastRecycle.Text <> "" Then
            vAnd = vAnd & "AND Person.PersonLast LIKE " & Left(modODBC.BuildField(pvForm.txtForPersonLastRecycle.Text), Len(modODBC.BuildField(pvForm.txtForPersonLastRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtMessageTypeRecycle.Text <> "" Then
            vAnd = vAnd & "AND MessageType.MessageTypeName LIKE " & Left(modODBC.BuildField(pvForm.txtMessageTypeRecycle.Text), Len(modODBC.BuildField(pvForm.txtMessageTypeRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtMsgSourceRecycle.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.txtMsgSourceRecycle.Text), Len(modODBC.BuildField(pvForm.txtMsgSourceRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtMsgFromRecycle.Text <> "" Then
            vAnd = vAnd & "AND Message.MessageCallerOrganization LIKE " & Left(modODBC.BuildField(pvForm.txtMsgFromRecycle.Text), Len(modODBC.BuildField(pvForm.txtMsgFromRecycle.Text)) - 1) & "%'"
        End If

        If pvForm.txtMsgTxRecycle.Text <> "" Then 'T.T 05/20/2004 added for GOLM to do a search on Transplant Center see task #264 *CodeReview
            vAnd = vAnd & "AND Message.MessageImportCenter LIKE " & Left(modODBC.BuildField(pvForm.TxtMsgTx), Len(modODBC.BuildField(pvForm.TxtMsgTx)) - 1) & "%'"
            vTC = 1
        End If

        'Build and execute
        Call QueryOpenMessageRecycle(pvForm, vAnd, vTC)

    End Function

    Public Function QuerySearchOpenInformation(ByRef pvForm As FrmOpenAll) As Short

        'mds 10/21/03 Added for information call lookups on dashboard

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""

        vAnd = ""

        If pvForm.TxtCallNumberInfo.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.TxtCallNumberInfo.Text), Len(modODBC.BuildField(pvForm.TxtCallNumberInfo.Text)) - 1) & "%' "
        End If

        If pvForm.TxtCoalitionInfo.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.TxtCoalitionInfo.Text), Len(modODBC.BuildField(pvForm.TxtCoalitionInfo.Text)) - 1) & "%' "
        End If

        If pvForm.TxtStateInfo.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.TxtStateInfo.Text), Len(modODBC.BuildField(pvForm.TxtStateInfo.Text)) - 1) & "%' "
        End If

        If pvForm.TxtFirstNameInfo.Text <> "" Then
            vAnd = vAnd & "AND CODCaller.CODCallerFirst LIKE " & Left(modODBC.BuildField(pvForm.TxtFirstNameInfo.Text), Len(modODBC.BuildField(pvForm.TxtFirstNameInfo.Text)) - 1) & "%'"
        End If

        If pvForm.TxtLastNameInfo.Text <> "" Then
            vAnd = vAnd & "AND CODCaller.CODCallerLast LIKE " & Left(modODBC.BuildField(pvForm.TxtLastNameInfo.Text), Len(modODBC.BuildField(pvForm.TxtLastNameInfo.Text)) - 1) & "%'"
        End If

        If pvForm.TxtSourceInfo.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.TxtSourceInfo.Text), Len(modODBC.BuildField(pvForm.TxtSourceInfo.Text)) - 1) & "%'"
        End If

        'Build and execute
        Call QueryOpenInformation(pvForm, vAnd)

    End Function

    Public Function QuerySearchOpenNoCall(ByRef pvForm As FrmOpenAll) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""

        vAnd = ""

        If pvForm.TxtCallNumberNC.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.TxtCallNumberNC.Text), Len(modODBC.BuildField(pvForm.TxtCallNumberNC.Text)) - 1) & "%' "
        End If

        If pvForm.TxtDescription.Text <> "" Then
            vAnd = vAnd & "AND NoCall.NoCallDescription LIKE '%" & Mid(modODBC.BuildField(pvForm.TxtDescription.Text), 2, Len(pvForm.TxtDescription.Text)) & "%' "
        End If

        If pvForm.TxtNoCallType.Text <> "" Then
            vAnd = vAnd & "AND NoCallType.NoCallTypeName LIKE " & Left(modODBC.BuildField(pvForm.TxtNoCallType.Text), Len(modODBC.BuildField(pvForm.TxtNoCallType.Text)) - 1) & "%'"
        End If

        If pvForm.TxtNoCallSource.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.TxtNoCallSource.Text), Len(modODBC.BuildField(pvForm.TxtNoCallSource.Text)) - 1) & "%'"
        End If

        'Build and execute
        Call QueryOpenNoCall(pvForm, vAnd)

    End Function

    Public Function QuerySearchConsentPending(ByRef pvForm As FrmOpenAll) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAnd As String = ""
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vAnd = ""

        If pvForm.TxtCallNumber.Text <> "" Then
            vAnd = "AND Call.CallNumber LIKE " & Left(modODBC.BuildField(pvForm.TxtCallNumber.Text), Len(pvForm.TxtCallNumber.Text) + 1) & "%' "
        End If

        If pvForm.TxtFromDate.Text <> "" Then
            vAnd = vAnd & "AND LogEventDateTime >= " & modODBC.BuildField(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtFromDate.Text))) & " "
        End If

        If pvForm.TxtToDate.Text <> "" Then
            vAnd = vAnd & "AND LogEventDateTime <= " & modODBC.BuildField(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtToDate.Text))) & " "
        End If

        If pvForm.TxtLocation.Text <> "" Then
            vAnd = vAnd & "AND Organization.OrganizationName LIKE " & Left(modODBC.BuildField(pvForm.TxtLocation.Text), Len(pvForm.TxtLocation.Text) + 1) & "%' "
        End If

        If pvForm.TxtState.Text <> "" Then
            vAnd = vAnd & "AND State.StateAbbrv LIKE " & Left(modODBC.BuildField(pvForm.TxtState.Text), Len(pvForm.TxtState.Text) + 1) & "%' "
        End If

        If pvForm.TxtPatientFirst.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorFirstName LIKE " & Left(modODBC.BuildField(pvForm.TxtPatientFirst.Text), Len(pvForm.TxtPatientFirst.Text) + 1) & "%'"
        End If

        If pvForm.TxtPatientLast.Text <> "" Then
            vAnd = vAnd & "AND Referral.ReferralDonorLastName LIKE " & Left(modODBC.BuildField(pvForm.TxtPatientLast.Text), Len(pvForm.TxtPatientLast.Text) + 1) & "%'"
        End If

        If pvForm.TxtOrg.Text <> "" Then
            vAnd = vAnd & "AND LogEvent.LogEventOrg LIKE " & Left(modODBC.BuildField(pvForm.TxtOrg.Text), Len(pvForm.TxtOrg.Text) + 1) & "%'"
        End If

        If pvForm.TxtOrgPerson.Text <> "" Then
            vAnd = vAnd & "AND LogEvent.LogEventName LIKE " & Left(modODBC.BuildField(pvForm.TxtOrgPerson.Text), Len(pvForm.TxtOrgPerson.Text) + 1) & "%'"
        End If

        If pvForm.TxtConsentSource.Text <> "" Then
            vAnd = vAnd & "AND SourceCode.SourceCodeName LIKE " & Left(modODBC.BuildField(pvForm.TxtConsentSource.Text), Len(pvForm.TxtConsentSource.Text) + 1) & "%'"
        End If

        'Build and execute
        Call QueryPendingConsent(pvForm, vAnd)

        pvForm.LblCountConsent.Text = VB6.Format(pvForm.LstViewPendingConsent.Items.Count, "000#")

    End Function
    Public Function QuerySecondaryExists(ByRef pvCallId As Integer) As Short
        'FSProj drh 6/15/02 See if Secondary records exist for this Call

        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Does the Secondary already exist?
        vQuery = "SELECT CallID from Secondary WHERE CallID = " & pvCallId
        Try
            QuerySecondaryExists = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
#End Region

    Public Function QueryCategoryGroupsApplicable(ByRef pvForm As Object, Optional ByRef pvCriteriaStatusID As Object = Nothing, Optional ByRef pvCriteriaId As Object = Nothing) As Short

        'FSProj drh 4/29/02 - Added pvCriteriaStatusID parameter so we can get the correct Historical Criteria type

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vDonorCategoryId As Integer
        Dim vOrganizationId As Integer

        'Get the lookup IDs
        vDonorCategoryId = pvForm.DonorCategoryID
        If pvForm.Name = "FrmCriteria" Then
            vOrganizationId = pvForm.ReferralOrganizationID
        ElseIf pvForm.Name = "FrmReferral" Then
            vOrganizationId = pvForm.OrganizationId
        End If

        'FSProj drh 5/1/02 - Added entire IF statement (note: code under ELSE already existed)
        If Not IsNothing(pvCriteriaId) Then
            vQuery = String.Format("EXEC GetCriteriaData @CriteriaID = {0};", pvCriteriaId)
        Else
            'FSProj drh 4/30/02 - Split ORDER BY out so we can add another WHERE clause for Criteria Status Type
            vQuery = String.Format("EXEC GetCriteriaData @OrganizationID = {0}, @DonorCategoryID = {1}, @SourceCodeID = {2}, @CriteriaStatusID = {3};", vOrganizationId, vDonorCategoryId, pvForm.SourceCode.ID, pvCriteriaStatusID)
        End If

        Try
            QueryCategoryGroupsApplicable = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCategoryGroupsApplicable = SUCCESS Then

            'If there is only one item, select and display it.
            If pvForm.Name = "FrmCriteria" Then
                Call modControl.SetTextID(pvForm.CboCriteriaGroup, vReturn)
                Call modControl.SelectFirst(pvForm.CboCriteriaGroup)
            ElseIf pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralTest" Then
                pvForm.CriteriaGroupID = vReturn(0, 0)
            End If
        End If
        Exit Function
    End Function


    Public Function QueryCounty(ByRef pvForm As FrmCounty) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectCounty @CountyID = " & pvForm.CountyID & ";"

        Try
            QueryCounty = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 3) Then
            'Set the call data
            pvForm.CountyID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            Call modControl.SelectID(pvForm.CboState, CInt(vParams(0, 2)))
            pvForm.Verified = vParams(0, 3)
        End If

    End Function




    Public Function QueryScheduleShift3(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vParams2 As New Object
        Dim I As Short
        Dim j As Short
        Dim vStartTime As String = ""
        Dim vEndTime As String = ""
        Dim CurrentDateTime As Date
        Dim CurrentDate As String = ""
        Dim vTimeZoneDif As Short
        Dim vQueryStartTime As String = ""
        Dim vQueryEndTime As New Object


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vQueryStartTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftStartTime)) as varchar(2))) " & "END AS ScheduleShiftStartTime, "
        vQueryEndTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShiftEndTime)) as varchar(2))) " & " End AS ScheduleShiftEndTime "

        If pvForm.Name = "FrmScheduleShift" Then

            vQuery = "SELECT " & "ScheduleShiftID, ScheduleGroupID, ScheduleShiftName, " & "WeekdayID, " & vQueryStartTime & " " & vQueryEndTime & " " & "LastModified , ScheduleShiftDate, UpdatedFlag " & "FROM ScheduleShift " & "WHERE ScheduleShiftID = " & pvForm.ScheduleShiftID & ";"

            Try
                QueryScheduleShift3 = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If ObjectIsValidArray(vParams, 2, 0, 5) Then
                'Set the call data
                pvForm.ScheduleShiftID = vParams(0, 0)
                pvForm.ScheduleGroupID = vParams(0, 1)
                pvForm.TxtName.Text = vParams(0, 2)
                Call modControl.SelectID(pvForm.CboDay, vParams(0, 3))
                pvForm.TxtStart = vParams(0, 4)
                pvForm.TxtEnd = vParams(0, 5)
            End If

        ElseIf pvForm.Name = "FrmOnCall" Or pvForm.Name = "FrmOnCallEvent" Then



            vQuery = "SELECT ScheduleShift.ScheduleShiftID, ScheduleShift.ScheduleGroupID,'','', " & vQueryStartTime & " " & vQueryEndTime & " " & "FROM ScheduleShift " & "JOIN Schedule ON Schedule.ScheduleShiftID = ScheduleShift.ScheduleShiftID " & "WHERE ScheduleShift.ScheduleGroupID = " & pvForm.ScheduleGroupID & " " & "AND Schedule.OrganizationID = " & pvForm.OrganizationId & " " & "AND Schedule.ScheduleDate = " & modODBC.BuildField(VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Today), "mm/dd/yy")) & "  ORDER BY ScheduleShiftStartTime ASC "

            Try
                QueryScheduleShift3 = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryScheduleShift3 <> SUCCESS Then
                Exit Function
            End If

            CurrentDate = CStr(VB6.Format(Now, "mm/dd/yy"))
            CurrentDateTime = CDate(VB6.Format(Now, "mm/dd/yy hh:nn"))


            'See if we need to go back to the previous day's shifts
            If ObjectIsValidArray(vParams, 2, 0, 4) _
                AndAlso ObjectIsValidArray(vParams, 2, UBound(vParams, 1), 5) _
                AndAlso Now < CDate(CurrentDate & " " & vParams(0, 4)) Then

                'Go back one day
                vQuery = "SELECT ScheduleShift.ScheduleShiftID, ScheduleShift.ScheduleGroupID,'','', " & vQueryStartTime & " " & vQueryEndTime & " " & "FROM ScheduleShift " & "JOIN Schedule ON Schedule.ScheduleShiftID = ScheduleShift.ScheduleShiftID " & "WHERE ScheduleShift.ScheduleGroupID = " & pvForm.ScheduleGroupID & " " & "AND Schedule.ScheduleDate = " & modODBC.BuildField(VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today)), "mm/dd/yy")) & " ORDER BY ScheduleShiftStartTime ASC "

                Try
                    QueryScheduleShift3 = modODBC.Exec(vQuery, vParams)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If QueryScheduleShift3 <> SUCCESS Then
                    Exit Function
                End If

                'Find the last shift of the day by finding the shift that
                'crosses midnight.
                For I = 0 To UBound(vParams, 1)

                    If VB6.Format(vParams(I, 5), "hh:mm") <= VB6.Format(vParams(I, 4), "hh:mm") Then
                        'This shift crosses midnight so set the data
                        pvForm.CurrentDate = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Today)
                        pvForm.ScheduleShiftID = vParams(I, 0)
                        pvForm.ScheduleGroupID = vParams(I, 1)
                        pvForm.LblShift.Text = vParams(I, 4) & " - " & vParams(I, 5)
                        Exit Function
                    End If

                Next I

            ElseIf ObjectIsValidArray(vParams, 2, 0, 4) _
                AndAlso ObjectIsValidArray(vParams, 2, UBound(vParams, 1), 5) Then

                'Find the correct shift for the current date.
                For I = 0 To UBound(vParams, 1)

                    'See if the current end crosses midnight
                    If CDate(CurrentDate & " " & vParams(I, 5)) <= CDate(CurrentDate & " " & vParams(I, 4)) Then
                        'The end time crosses midnight, then we are at the
                        'correct shift so set the data
                        pvForm.CurrentDate = Now
                        pvForm.ScheduleShiftID = vParams(I, 0)
                        pvForm.ScheduleGroupID = vParams(I, 1)
                        pvForm.LblShift.Text = vParams(I, 4) & " - " & vParams(I, 5)
                        Exit Function
                    Else
                        'See if now is before the current end time
                        If Now <= CDate(CurrentDate & " " & vParams(I, 5)) Then
                            'If now is before the current end time, then we are at the
                            'correct shift so set the data
                            pvForm.CurrentDate = Now
                            pvForm.ScheduleShiftID = vParams(I, 0)
                            pvForm.ScheduleGroupID = vParams(I, 1)
                            pvForm.LblShift.Text = vParams(I, 4) & " - " & vParams(I, 5)
                            Exit Function
                        End If
                    End If

                Next I

            End If

        End If

    End Function

    Public Function QueryScheduleShift(ByRef pvForm As Object, ByRef pvUseOldSchedule As Boolean) As Short

        Dim vQuery As String = ""
        Dim vData As New Object
        Dim vResult As Short = SQL_ERROR
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)
        vQuery = $"EXEC GetScheduleItemData  @ScheduleGroupID = {pvForm.ScheduleGroupID}, @TimeZoneDif = {vTimeZoneDif};"

        Try
            vResult = modODBC.Exec(vQuery, vData)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vData, 2, 0, 8) Then
            pvForm.CurrentDate = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)
            pvForm.ScheduleShiftID = vData(0, 0)
            pvForm.ScheduleGroupID = vData(0, 1)
            pvForm.LblShift.Text = VB6.Format(vData(0, 5), "mm/dd ddd hh:nn") & " - " & VB6.Format(vData(0, 8), "mm/dd ddd hh:nn")
        Else
            'bjk 12/29/03 if query not successful set
            pvForm.CurrentDate = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)
            pvForm.ScheduleShiftID = 0
            pvForm.ScheduleGroupID = 0
            pvForm.LblShift.Text = "No schedule for Schedule Group"
        End If

    End Function

    Public Function QueryScheduleShiftItem(ByRef pvForm As FrmScheduleShiftItem) As Short

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vTimeZoneDif As Short
        Dim vQueryStartTime As String = ""
        Dim vQueryEndTime As String = ""


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vQueryStartTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemStartTime)) as varchar(2))) " & "END AS 'ScheduleItemStartTime'"
        vQueryEndTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleItemEndTime)) as varchar(2))) " & " End AS 'ScheduleItemEndTime' "
        'CONVERT(CHAR,DATEADD(hh,2, ScheduleItemStartDate + ' ' + ScheduleItemStartTime), 101 ),
        vQuery = "SELECT " & "ScheduleItemID, ScheduleGroupID, ScheduleItemName, " & "CONVERT(CHAR, DATEADD(hh," & vTimeZoneDif & ", ScheduleItemStartDate + ' ' + ScheduleItemStartTime ), 101) AS 'ScheduleItemStartDate', " & vQueryStartTime & ", " & "CONVERT(CHAR, DATEADD(hh, " & vTimeZoneDif & ", ScheduleItemEndDate + ' ' + ScheduleItemEndTime), 101) AS 'ScheduleItemEndDate', " & vQueryEndTime & ", " & "LastModified " & "FROM ScheduleItem " & "WHERE ScheduleItemID = " & pvForm.ScheduleItemID

        Try
            QueryScheduleShiftItem = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryScheduleShiftItem = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 6) Then
            'Set the call data
            ''' is this needed 
            '''pvForm.ScheduleShiftID = vParams(0, 0)

            pvForm.ScheduleGroupID = vParams(0, 1)
            pvForm.TxtName.Text = vParams(0, 2)
            pvForm.CboStartDate.Value = VB6.Format(vParams(0, 3), "mm/dd/yy")
            Call modControl.SelectText(pvForm.CboStartTime, vParams(0, 4))
            pvForm.CboEndDate.Value = VB6.Format(vParams(0, 5), "mm/dd/yy")
            Call modControl.SelectText(pvForm.CboEndTime, vParams(0, 6))
        End If

    End Function

    Public Function QueryScheduleShifts(ByRef pvForm As FrmSchedule) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vScheduleGroupID As Integer
        Dim vTimeZoneDif As Short
        Dim vQueryStartTime As String = ""
        Dim vQueryEndTime As String = ""


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vQueryStartTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftStartTime)) as varchar(2))) " & "END "
        vQueryEndTime = "CASE WHEN CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as char(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as char(2)) AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(hh,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as char(2))) " & "End + ':' + " & "CASE WHEN CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as varchar(2)) <10 " & "THEN '0' + RTRIM(CAST(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as varchar(2))AS VARCHAR(2))) " & "ELSE RTRIM(CAST(DATEPART(n,DATEADD(hh," & vTimeZoneDif & ", RTRIM(CAST(DATEPART(m,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(d,getdate()) as char)) + '/' + RTRIM(CAST(DATEPART(yyyy,getdate()) as char))+ ' ' + ScheduleShift.ScheduleShiftEndTime)) as varchar(2))) " & " End "

        'Get the schedule group ID
        vScheduleGroupID = pvForm.ScheduleGroupID

        vQuery = "SELECT DISTINCT ScheduleShift.ScheduleShiftID, ScheduleShift.ScheduleShiftName, " & "Weekday.WeekdayName, " & vQueryStartTime & " AS 'ScheduleShiftStartTime', " & vQueryEndTime & " AS 'ScheduleShiftEndTime'" & "FROM ScheduleShift " & "JOIN Weekday ON ScheduleShift.WeekdayID = Weekday.WeekdayID " & "WHERE ScheduleShift.ScheduleGroupID = " & vScheduleGroupID & " " & "ORDER BY ScheduleShift.ScheduleShiftName ASC, ScheduleShiftStartTime ASC;"

        Try
            QueryScheduleShifts = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If (TypeOf vReturn Is Array) Then
            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewShifts, False)
        End If


    End Function

    Public Function QueryIndication(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object

        If pvForm.Name = "FrmIndication" Then
            vQuery = "EXEC SelectIndication @IndicationID = " & pvForm.IndicationID & ";"

            Try
                QueryIndication = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If ObjectIsValidArray(vParams, 2, 0, 6) Then
                'Set the call data
                pvForm.IndicationID = vParams(0, 0)
                pvForm.TxtName.Text = vParams(0, 1)
                pvForm.TxtNote.Text = vParams(0, 2)
                pvForm.Verified = vParams(0, 3)
                pvForm.ChkHighRisk.Checked = modConv.DBTrueValueToChkValue(vParams(0, 6))
            End If
        ElseIf pvForm.Name = "FrmIndicationSelect" Then
            vQuery = "SELECT IndicationID, IndicationName, IndicationNote " & "FROM Indication ORDER BY IndicationName;"

            Try
                QueryIndication = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.SetListViewRows(vParams, True, pvForm.LstViewIndication, False)
        End If

    End Function
    Public Function QueryKeyCode(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object

        If pvForm.Name = "FrmKeyCode" Then
            vQuery = "EXEC SelectKeyCode @KeyCodeID = " & pvForm.KeyCodeID & ";"

            Try
                QueryKeyCode = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If ObjectIsValidArray(vParams, 2, 0, 3) Then
                'Set the call data
                pvForm.KeyCodeID = vParams(0, 0)
                pvForm.TxtName.Text = vParams(0, 1)
                pvForm.TxtNote.Text = vParams(0, 2)
                pvForm.Verified = vParams(0, 3)
            End If
        ElseIf pvForm.Name = "FrmKeyCodeSelect" Then
            vQuery = "SELECT KeyCodeID, KeyCodeName, KeyCodeNote " & "FROM KeyCode ORDER BY KeyCodeName;"

            Try
                QueryKeyCode = modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Call modControl.SetListViewRows(vParams, True, pvForm.LstViewKeyCode, False)
        End If

    End Function

    Public Function QueryDictionaryItem(ByRef pvForm As FrmDictionaryItem) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectDictionaryItem @DictionaryItemID = " & pvForm.DictionaryItemID & ";"

        Try
            QueryDictionaryItem = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 3) Then
            'Set the call data
            pvForm.DictionaryItemID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 3)
        End If

    End Function

    Public Function QueryDictionaryItemMisspelling(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vReturn As New Object

        If pvForm.Name = "FrmDictionaryItem" Then

            vQuery = "SELECT DictionaryItemMisspellingID, DictionaryItemMisspellingName " & "FROM DictionaryItemMisspelling " & "WHERE DictionaryItemID = " & pvForm.DictionaryItemID & ";"

            Try
                QueryDictionaryItemMisspelling = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Set the data
            Call modControl.SetTextID(pvForm.LstMisspellings, vReturn)

        ElseIf pvForm.Name = "FrmMisspelling" Then

            vQuery = "SELECT DictionaryItemMisspellingID, DictionaryItemMisspellingName " & "FROM DictionaryItemMisspelling " & "WHERE DictionaryItemMisspellingID = " & pvForm.DictionaryItemMisspellingID & ";"

            Try
                QueryDictionaryItemMisspelling = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If ObjectIsValidArray(vReturn, 2, 0, 1) Then
                'Set the data
                pvForm.TxtName.Text = vReturn(0, 1)
            End If
        End If

    End Function
    Public Function QueryMisspellingDictionaryItems(ByRef pvResults As Object) As Short

        Dim vQuery As New Object
        Dim RS As New Object
        Static vReturn As Object

        If IsNothing(vReturn) Then

            vReturn = New Object
            vQuery = "SELECT DictionaryItemMisspelling.DictionaryItemMisspellingName, DictionaryItem.DictionaryItemName FROM DictionaryItem JOIN DictionaryItemMisspelling ON DictionaryItemMisspelling.DictionaryItemID = DictionaryItem.DictionaryItemID ORDER BY DictionaryItem.DictionaryItemName "

            Try
                QueryMisspellingDictionaryItems = modODBC.Exec(vQuery, vReturn, , True, RS)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryMisspellingDictionaryItems = SUCCESS Then
                vReturn = RS.GetRows
                pvResults = vReturn
            End If

        Else
            pvResults = vReturn
        End If

    End Function

    Public Function QueryOrganizationType(ByRef pvForm As FrmOrganizationType) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectOrganizationType @OrganizationTypeID = " & pvForm.OrganizationTypeID & ";"

        Try
            QueryOrganizationType = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 2) Then
            'Set the call data
            pvForm.OrganizationTypeID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 2)
        End If

    End Function

    Public Function QueryMessageType(ByRef pvForm As FrmMessageType) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectMessageType @MessageTypeID = " & pvForm.MessageTypeID & ";"

        Try
            QueryMessageType = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 2) Then
            'Set the call data
            pvForm.MessageTypeID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 2)
        End If

    End Function
    Public Function QueryLogEventTypeID(ByRef pvLogEventId As Integer, ByRef prLogEventTypeID As Integer) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT LogEventTypeID FROM LogEvent " & "WHERE LogEventID = " & pvLogEventId & ";"

        Try
            QueryLogEventTypeID = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryLogEventTypeID = SQL_ERROR
        End Try

        'Set the call data
        If QueryLogEventTypeID = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            prLogEventTypeID = CInt(vParams(0, 0))
        End If

    End Function
    Public Function QueryReference(ByRef pvForm As FrmReference) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectReference @ReferenceID = " & pvForm.ReferenceID & ";"

        Try
            QueryReference = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 3) Then
            'Set the call data
            pvForm.ReferenceID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.ReferenceTypeID = vParams(0, 2)
            pvForm.Verified = vParams(0, 3)
        End If

    End Function
    Public Function QueryNoCallType(ByRef pvForm As FrmNoCallType) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectNoCallType @NoCallTypeID = " & pvForm.NoCallTypeID & ";"

        Try
            QueryNoCallType = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 2) Then
            'Set the call data
            pvForm.NoCallTypeID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 2)
        End If

    End Function

    Public Function QueryPersonNotes(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vResult As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vQuery = "SELECT Person.PersonNotes, Person.PersonTempNoteActive, " & "DATEADD(hh, " & vTimeZoneDif & ", Person.PersonTempNoteExpires), " & "Person.PersonTempNote " & ", PersonFirst " & ",PersonLast " & "FROM Person " & "WHERE Person.PersonID = " & modConv.TextToLng(pvForm.PersonID)

        Try
            QueryPersonNotes = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryPersonNotes = SUCCESS _
            AndAlso ObjectIsValidArray(vResult, 2, 0, 5) Then

            If vResult(0, 1) = "1" Then
                If CDate(vResult(0, 2)) > Now Then '02/25/03 removed DateAdd("h", vTimeZoneDif, Now) Then
                    pvForm.TxtPersonNotes.Text = vResult(0, 3)
                    pvForm.lblBusy.Visible = True
                    pvForm.lblBusy.Text = "**Busy**" & vResult(0, 4) & " " & vResult(0, 5) & " **Busy**"
                Else
                    vQuery = "UPDATE Person SET PersonTempNoteActive = 0, PersonTempNoteExpires = Null, PersonTempNote = '' " & "WHERE PersonID = " & modConv.TextToLng(pvForm.PersonID)
                    'TODO: remove this query. The previous update does not change data in vResult(0,0). Waisted resource query.
                    Try
                        QueryPersonNotes = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    pvForm.TxtPersonNotes.Text = vResult(0, 0)
                End If
            Else
                pvForm.TxtPersonNotes.Text = vResult(0, 0)
            End If

        End If


    End Function

    Public Function QueryOrganizationNotes(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Modified select to convert ntext fields to varchar
        'to display as rtf. Also had to set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************


        Dim vQuery As New Object
        Dim vParams() As String
        Dim vResult As New Object

        vQuery = "SELECT CAST(OrganizationReferralNotes  AS varchar(8000)), CAST(OrganizationMessageNotes  AS varchar(8000))" & "FROM Organization " & "WHERE Organization.OrganizationID = " & pvForm.OrganizationId & ";"

        Try
            QueryOrganizationNotes = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryOrganizationNotes = SUCCESS _
            AndAlso ObjectIsValidArray(vResult, 2, 0, 1) Then
            modControl.SetRTFText(pvForm.TxtReferralNotes, vResult(0, 0))
            modControl.SetRTFText(pvForm.txtMessageNotes, vResult(0, 1))
        End If

    End Function
    Public Function QueryScheduleGroupNotes(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Modified select to convert ntext fields to varchar
        'to display as rtf. Also had to set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************


        Dim vQuery As New Object
        Dim vResult As New Object

        vQuery = "SELECT CAST(ScheduleGroupReferralNotes AS varchar(8000)),  CAST(ScheduleGroupMessageNotes AS varchar(8000)), UseNewSchedule " & "FROM ScheduleGroup " & "WHERE ScheduleGroupID = " & pvForm.ScheduleGroupID

        Try
            QueryScheduleGroupNotes = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryScheduleGroupNotes = SUCCESS _
            AndAlso ObjectIsValidArray(vResult, 2, 0, 2) Then
            pvForm.txtScheduleReferralNotes.RTF = vResult(0, 0)
            pvForm.txtScheduleMessageNotes.RTF = vResult(0, 1)
            pvForm.ChkActive.Checked = vResult(0, 2)
        End If

    End Function


    Public Function QueryOrganizationTimeZone(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vResult As New Object

        vQuery = String.Format("SELECT TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone' FROM Organization LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID WHERE Organization.OrganizationID = {0} ;", pvForm.OrganizationId)

        Try
            QueryOrganizationTimeZone = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If ObjectIsValidArray(vResult, 2, 0, 0) Then
            pvForm.OrganizationTimeZone = vResult(0, 0)
        End If

        Exit Function
    End Function

    Public Function QueryOrganizationCountyID(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object

        vQuery = "SELECT Organization.CountyID, Organization.StateID " & "FROM Organization " & "WHERE Organization.OrganizationID = " & pvForm.OrganizationId

        Try
            QueryOrganizationCountyID = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If QueryOrganizationCountyID = SUCCESS _
            AndAlso ObjectIsValidArray(vResult, 2, 0, 1) Then
            pvForm.OrganizationCountyID = vResult(0, 0)
            pvForm.OrganizationStateID = vResult(0, 1)
        End If
        Exit Function
    End Function

    Public Function QueryCauseOfDeath(ByRef pvForm As FrmCauseOfDeath) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectCauseOfDeath @CauseOfDeathID = " & pvForm.CauseOfDeathID & ";"

        Try
            QueryCauseOfDeath = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 3) Then
            'Set the call data
            pvForm.CauseOfDeathID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.ChkPotential.Checked = modConv.DBTrueValueToChkValue(vParams(0, 2))
            pvForm.ChkCoronerCase.Checked = modConv.DBTrueValueToChkValue(vParams(0, 3))
            pvForm.Verified = vParams(0, 3)
        End If

    End Function

    Public Function QueryCriteriaGroupOrganization(ByRef pvOrganizationId As Integer, ByRef pvReturn As Object, ByRef SourceCode As clsSourceCode, ByRef pvCriteriaStatusID As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        'FSProj drh 5/3/02 - Added JOIN for Criteria table and AND clause for CriteriaStatusId
        vQuery = "SELECT CriteriaOrganization.CriteriaID, CriteriaOrganization.OrganizationID, DonorCategory.DonorCategoryName, Criteria.CriteriaGroupName " & "FROM CriteriaOrganization " & "JOIN Criteria ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID " & "JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = CriteriaOrganization.CriteriaID " & "JOIN DonorCategory ON Criteria.DonorCategoryId = DonorCategory.DonorCategoryId " & "WHERE CriteriaOrganization.OrganizationID = " & pvOrganizationId & " " & "AND CriteriaSourceCode.SourceCodeID = " & SourceCode.ID & "AND Criteria.CriteriaStatus = " & pvCriteriaStatusID

        Try
            QueryCriteriaGroupOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCriteriaGroupOrganization = SUCCESS Then
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryCriteriaScheduleGroup(ByRef pvForm As Object, Optional ByRef prReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vCriteriaId As Integer

        If IsNothing(prReturn) Then
            vCriteriaId = modControl.GetID(pvForm.CboCriteriaGroup)
        Else
            vCriteriaId = pvForm.CriteriaGroupID
        End If

        vQuery = "SELECT CriteriaScheduleGroup.ScheduleGroupID, Organization.OrganizationName, ScheduleGroup.ScheduleGroupName, " & "CriteriaScheduleGroupOrgan, CriteriaScheduleGroupBone, CriteriaScheduleGroupTissue, " & "CriteriaScheduleGroupSkin, CriteriaScheduleGroupValves, CriteriaScheduleGroupEyes, CriteriaScheduleGroupResearch, Organization.OrganizationID,  " & "CriteriaScheduleNoContactOnDny, CriteriaScheduleContactOnCnsnt, CriteriaScheduleContactOnAprch, CriteriaScheduleContactOnCrnr, CriteriaScheduleContactOnStatSec, CriteriaScheduleContactOnStatCnsnt, COALESCE(CriteriaScheduleContactOnCoronerOnly, 0) AS CriteriaScheduleContactOnCoronerOnly " & "FROM CriteriaScheduleGroup " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID " & "JOIN Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID " & "WHERE CriteriaScheduleGroup.CriteriaID = " & vCriteriaId

        Try
            QueryCriteriaScheduleGroup = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCriteriaScheduleGroup = SUCCESS Then

            If (TypeOf vReturn Is Array) And pvForm.Name = "FrmCriteria" Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSchedule, False)
            Else
                prReturn = vReturn
            End If
        End If

    End Function

    Public Function QuerySubCriteriaScheduleGroup(ByRef pvForm As FrmCriteria, Optional ByRef prReturn As Object = Nothing) As Short
        'FSProj drh 5/17/02

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vSubCriteriaId As Integer

        If IsNothing(prReturn) Then
            vSubCriteriaId = modControl.GetID(pvForm.cboSubtypeProcessor(1))
        Else
            vSubCriteriaId = modControl.GetID(pvForm.cboSubtypeProcessor(1))
        End If

        vQuery = "SELECT SCScheduleGroup.ScheduleGroupID, Organization.OrganizationName, ScheduleGroup.ScheduleGroupName, " & "SCScheduleGroupOrgan, SCScheduleGroupBone, SCScheduleGroupTissue, " & "SCScheduleGroupSkin, SCScheduleGroupValves, SCScheduleGroupEyes, SCScheduleGroupResearch, Organization.OrganizationID,  " & "SCScheduleNoContactOnDny, SCScheduleContactOnCnsnt, SCScheduleContactOnAprch, SCScheduleContactOnCrnr, SCScheduleContactOnStatSec, SCScheduleContactOnStatCnsnt, SCScheduleContactOnCoronerOnly " & "FROM SCScheduleGroup " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = SCScheduleGroup.ScheduleGroupID " & "JOIN Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID " & "WHERE SCScheduleGroup.SubCriteriaID = " & vSubCriteriaId

        Try
            QuerySubCriteriaScheduleGroup = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySubCriteriaScheduleGroup = SUCCESS Then

            If (TypeOf vReturn Is Array) Then
                Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewScheduleSub, False)
            Else
                prReturn = vReturn
            End If
        End If

    End Function
    Public Function QueryCriteriaScheduleGroupOptions(ByVal pvCriteriaId As Integer, ByVal pvScheduleGroupID As Integer, ByRef prReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT CriteriaScheduleGroupOrgan, CriteriaScheduleGroupBone, CriteriaScheduleGroupTissue, " & "CriteriaScheduleGroupSkin, CriteriaScheduleGroupValves, CriteriaScheduleGroupEyes, CriteriaScheduleGroupResearch,  " & "CriteriaScheduleNoContactOnDny, CriteriaScheduleContactOnCnsnt, CriteriaScheduleContactOnAprch, CriteriaScheduleContactOnCrnr, " & "CriteriaScheduleContactOnStatSec, CriteriaScheduleContactOnStatCnsnt, CriteriaScheduleContactOnCoronerOnly " & "FROM CriteriaScheduleGroup " & "WHERE CriteriaScheduleGroup.CriteriaID = " & pvCriteriaId & " " & "AND CriteriaScheduleGroup.ScheduleGroupID = " & pvScheduleGroupID

        Try
            QueryCriteriaScheduleGroupOptions = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCriteriaScheduleGroupOptions = SUCCESS Then
            prReturn = vReturn
        End If

    End Function

    Public Function QuerySubCriteriaScheduleGroupOptions(ByVal pvSubCriteriaId As Integer, ByVal pvSCScheduleGroupID As Integer, ByRef prReturn As Object) As Short
        'FSProj drh 5/17/02

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT SCScheduleGroupOrgan, SCScheduleGroupBone, SCScheduleGroupTissue, " & "SCScheduleGroupSkin, SCScheduleGroupValves, SCScheduleGroupEyes, SCScheduleGroupResearch,  " & "SCScheduleNoContactOnDny, SCScheduleContactOnCnsnt, SCScheduleContactOnAprch, SCScheduleContactOnCrnr, " & "SCScheduleContactOnStatSec, SCScheduleContactOnStatCnsnt, SCScheduleContactOnCoronerOnly " & "FROM SCScheduleGroup " & "WHERE SCScheduleGroup.SubCriteriaID = " & pvSubCriteriaId & " " & "AND SCScheduleGroup.ScheduleGroupID = " & pvSCScheduleGroupID

        Try
            QuerySubCriteriaScheduleGroupOptions = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySubCriteriaScheduleGroupOptions = SUCCESS Then
            prReturn = vReturn
        End If

    End Function
    Public Function QueryScheduleGroupOrganization(ByRef pvOrganizationId As Integer, ByRef pvReturn As Object, ByRef SourceCode As clsSourceCode) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object


        vQuery = "SELECT ScheduleGroupOrganization.ScheduleGroupID, ScheduleGroupOrganization.OrganizationID " & "FROM ScheduleGroupOrganization " & "JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID " & "WHERE ScheduleGroupOrganization.OrganizationID = " & pvOrganizationId & " " & "AND ScheduleGroupSourceCode.SourceCodeID = " & SourceCode.ID

        Try
            QueryScheduleGroupOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryScheduleGroupOrganization = SUCCESS Then
            pvReturn = vReturn
        End If

    End Function



    Public Function QueryWebReportGroupOrganization(ByRef pvOrganizationId As Integer, ByRef pvReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT WebReportGroupID, OrganizationID FROM WebReportGroupOrg " & "WHERE OrganizationID = " & pvOrganizationId & ";"

        Try
            QueryWebReportGroupOrganization = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryWebReportGroupOrganization = SUCCESS Then
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryCountyCoroner(ByRef pvCountyID As Object, ByRef pvReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim organizationTypeID As Int32 = 3

        vQuery = String.Format("SELECT coalesce(PersonID, 0), coalesce(Person.PersonFirst,'') +' '+ coalesce(PersonLast, ''), Organization.OrganizationName, ('(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'')), Organization.OrganizationID FROM Organization JOIN Person ON Organization.OrganizationID = Person.OrganizationID LEFT JOIN OrganizationPhone ON Organization.OrganizationId = OrganizationPhone.OrganizationId LEFT JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID WHERE Organization.OrganizationTypeID = {0} AND Organization.CountyID = {1}", organizationTypeID, pvCountyID)

        Try
            QueryCountyCoroner = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCountyCoroner = SUCCESS Then
            'Set the return set
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryCoroner(ByRef pvOrgID As Object, ByRef pvReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object


        vQuery = String.Format("SELECT coalesce(PersonID, 0), coalesce(Person.PersonFirst,'') + ' ' + coalesce(PersonLast, ''), Organization.OrganizationName, " & "('(' + ISNULL(Phone.PhoneAreaCode,'') + ') ' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'')), Organization.OrganizationID FROM Organization JOIN Person ON Organization.OrganizationID = Person.OrganizationID LEFT JOIN OrganizationPhone ON Organization.OrganizationId = OrganizationPhone.OrganizationId LEFT JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID WHERE Organization.OrganizationID = {0}", pvOrgID)

        Try
            QueryCoroner = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryCoroner = SQL_ERROR
        End Try

        If QueryCoroner = SUCCESS Then
            'Set the return set
            pvReturn = vReturn
        End If

    End Function

    Public Function QueryStateCoroners(ByRef pvStateID As Object, ByRef pvReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT OrganizationID, OrganizationName " & "FROM Organization " & "WHERE Organization.OrganizationTypeID = 3 " & "AND Organization.StateID = " & pvStateID & " Order by OrganizationName"

        Try
            QueryStateCoroners = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryStateCoroners = SQL_ERROR
        End Try

        If QueryStateCoroners = SUCCESS Then
            'Set the return set
            pvReturn = vReturn
        End If

    End Function
    Public Function QueryCoronerState(ByVal pvCoronerName As Object, ByRef pvReturn As Object) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT State.StateID, StateAbbrv " & "FROM State " & "JOIN Organization ON Organization.StateID = State.StateID " & "WHERE OrganizationName = " & modODBC.BuildField(pvCoronerName)

        Try
            QueryCoronerState = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryCoronerState = SUCCESS Then
            'Set the return set
            pvReturn = vReturn
        End If
        Return QueryCoronerState
    End Function
    Public Function QueryWebReportParent(ByRef pvForm As FrmReport) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object


        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization " & "JOIN WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID " & "ORDER BY Organization.OrganizationName "

        Try
            QueryWebReportParent = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryWebReportParent = SUCCESS Then

            'Set the return set
            Call modControl.SetTextID(pvForm.CboReportParent, vReturn, True)

        End If

    End Function
    Public Function QuerySourceCodeDefaultCallType(ByVal sourceCodeName As String) As Integer
        Dim vQuery As String
        Dim VResultArray As New Object
        Dim result As Integer
        QuerySourceCodeDefaultCallType = 0

        'bret 3/8/2011 determine defaultSourceCode for SourceCode. 
        vQuery = String.Format("EXEC SourceCodeDefaultCallTypeBySourceCode @sourceCode = '{0}'", sourceCodeName)

        Try
            result = modODBC.Exec(vQuery, VResultArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If ObjectIsValidArray(VResultArray, 2, 0, 0) Then
            QuerySourceCodeDefaultCallType = VResultArray(0, 0)
        End If


    End Function
    Public Function QuerySourceCodeOrganizations(ByRef pvForm As FrmSourceCode, ByRef SourceCodeID As Short) As Short
        '*********************************************************************************
        'Name: QuerySourceCodeOrganizations
        'Date Created: 04/15/2007                          Created By: T.T  04/15/2007
        'Release #: [Release Sub Was Created For  ex: 8.3.5]    Task: [Task created for]
        'Description: This Query is to determine the sourceCode and organization list
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================
        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT Organization.OrganizationID, " & " Organization.OrganizationName " & " From SourceCodeOrganization " & " JOIN Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID " & " JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID " & " JOIN County ON Organization.CountyID = County.CountyID " & " JOIN State ON Organization.StateID = State.StateID " & " WHERE SourceCodeOrganization.SourceCodeID = " & SourceCodeID & " Order By Organization.OrganizationName ASC"

        Try
            QuerySourceCodeOrganizations = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySourceCodeOrganizations = SUCCESS Then

            'Set the return set
            Call modControl.SetTextID(pvForm.cboTcOrganizations, vReturn, True)

        End If

    End Function
    Public Function QuerySourceCodeTxCenter(ByRef pvForm As FrmSourceCode, ByRef SourceCodeID As Short) As Short
        '*********************************************************************************
        'Name: QuerySourceCodeTxCenter
        'Date Created: 04/15/2007                         Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 8.3.4]    Task: [Task created for]
        'Description: This Query is to determine the TxCenter list for a SourceCode
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================
        Dim vQuery As String = ""
        Dim vQuery2 As String = ""
        Dim vReturn As New Object
        Dim vParams As New Object
        Dim vParams2 As Object = New Object
        Dim TxCenterCount As New Object

        vQuery = " select SourceCodeTransplantCenterID,SourceCodeID,OG.OrganizationName,OG.OrganizationID,TransplantCode " & " from sourcecodetransplantcenter Join Organization OG ON OG.OrganizationID = sourcecodetransplantcenter.OrganizationID " & " Where SourceCodeID = " & SourceCodeID

        vQuery2 = " select count(*)  from sourcecodetransplantcenter Join Organization OG ON OG.OrganizationID = sourcecodetransplantcenter.OrganizationID " & " Where SourceCodeID = " & SourceCodeID

        Try
            TxCenterCount = modODBC.Exec(vQuery2, vParams2)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Try
            QuerySourceCodeTxCenter = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QuerySourceCodeTxCenter = SUCCESS Then

            'Set the return set
            Call modControl.FillListView3(pvForm.LstViewTxCenter, vParams, vParams2)

        End If

    End Function
    Public Function QueryRotationOrganization(ByRef pvForm As FrmRotateOrganization, ByRef RotationGroupID As Short, ByRef OrgID As Short, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short
        '*********************************************************************************
        'Name: QueryWebReportParentRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function checks to see if the Organization already exists in the Rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vAlertID As Integer

        If IsNothing(pvParams) Then

            vQuery = "EXEC SelectRotationOrganization @RotationGroupID = " & RotationGroupID & ", @OrganizationID = " & OrgID & ";"
            Try
                QueryRotationOrganization = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

    End Function
    Public Function QueryRotationDeleteSelection(ByRef pvForm As FrmRotateOrganization, ByRef pvGridList As Object) As Short
        '*********************************************************************************
        'Name: QueryRotationDeleteSelection
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will delete an organization from the Rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim I As New Object

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = "Delete from RotationOrganization where RotationGroupID = " & pvForm.RotationGroupID & " and OrganizationID = " & pvGridList(I, 0)
            Try
                QueryRotationDeleteSelection = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Next I




    End Function
    Public Function QueryWebReportParentRotation(ByRef pvForm As FrmRotateOrganization, ByRef setbox As Short) As Short

        '*********************************************************************************
        'Name: QueryWebReportParentRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub Reloads the Report cbo box
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object


        vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM Organization " & "JOIN WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID " & "ORDER BY Organization.OrganizationName "

        Try
            QueryWebReportParentRotation = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryWebReportParentRotation = SUCCESS Then

            'Set the return set
            If setbox = 0 Then
                Call modControl.SetTextID(pvForm.CboReportParent, vReturn, True)
            Else
                Call modControl.SetTextID(pvForm.CboReportParent2, vReturn, True)
            End If
        End If

    End Function
    Public Function QueryRotationServiceLevel(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationServiceLevel
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the ServiceLevel for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotation @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationServiceLevel = vRS
    End Function
    Public Function QueryGroupRotationSave(ByRef RotationGroupID As Short, ByRef RotationID As Short, ByRef RotationNextRun As String, ByRef RotationLastRun As String, ByRef sequence As Short) As Short


        '*********************************************************************************
        'Name: QueryGroupRotationFreq
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function saves the frequency of the Rotation group
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "Update Rotation  set RotationSequence = " & sequence & ", RotationNextRun = '" & RotationNextRun & "',RotationLastRun = '" & RotationLastRun & "' where RotationGroupID = " & RotationGroupID & " and RotationID = " & RotationID
        Try
            vReturn = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        QueryGroupRotationSave = vReturn
    End Function

    Public Function QueryGroupRotationFreqSave(ByRef RotationGroupID As Short, ByRef RotationTime As Short, ByRef vZone As Short) As Short
        '*********************************************************************************
        'Name: QueryGroupRotationFreq
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the frequency of the Rotation group
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "Update RotationGroupName  set RotationFrequency = " & RotationTime & ",RotationTimeZone = '" & vZone & "' where RotationGroupID = " & RotationGroupID
        Try
            vReturn = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        QueryGroupRotationFreqSave = vReturn
    End Function
    Public Function QueryGroupRotationFreq(ByRef RotationGroupID As Short) As Short
        '*********************************************************************************
        'Name: QueryGroupRotationFreq
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the frequency of the Rotation group
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "Select RotationFrequency from RotationGroupName where RotationGroupID = " & RotationGroupID

        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If vRS.EOF = False And IsDBNull(vRS.Fields(0).Value) = False Then
            QueryGroupRotationFreq = vRS.Fields(0).Value
        End If
        vRS = Nothing
    End Function
    Public Function QueryGroupRotationTimeZone(ByRef RotationGroupID As Short) As Short
        '*********************************************************************************
        'Name: QueryGroupRotationTimeZone
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the frequency of the Rotation group TimeZone
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "Select RotationTimeZone from RotationGroupName where RotationGroupID = " & RotationGroupID

        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If vRS.EOF = False And IsDBNull(vRS.Fields(0).Value) = False Then
            QueryGroupRotationTimeZone = vRS.Fields(0).Value
        End If
        vRS = Nothing
    End Function
    Public Function QueryGroupRotationcount(ByRef RotationGroupID As Short) As Short
        '*********************************************************************************
        'Name: QueryGroupRotationcount
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns how many rotations exist in the current group
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "Select Max(RotationID) from Rotation where RotationGroupID = " & RotationGroupID

        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If vRS.EOF = False Then
            QueryGroupRotationcount = vRS.Fields(0).Value
        End If

    End Function
    Public Function QueryRotationAlerts(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationAlerts
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the alerts for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotationAlerts @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationAlerts = vRS
    End Function
    Public Function QueryRotationScheduleGroups(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationScheduleGroups
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the scheduleGroups for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotationScheduleGroup @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationScheduleGroups = vRS
    End Function
    Public Function QueryRotationReportGroups(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationReportGroups
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the ReportGroups for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotationReportGroup @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationReportGroups = vRS
    End Function
    Public Function QueryRotationSourceCodes(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationSourceCodes
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the sourceCodes for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotationSourceCode @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationSourceCodes = vRS
    End Function
    Public Function QueryRotationCriteria(ByRef RotationGroupID As Short, ByRef RotationID As Short) As ADODB.Recordset
        '*********************************************************************************
        'Name: QueryGroupRotationCriteria
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function returns the Criteria for a given rotation
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vRS As ADODB.Recordset
        vQuery = "EXEC SelectRotationCriteria @RotationGroupID = " & RotationGroupID & ", @RotationID = " & RotationID & ";"
        'vQuery = "Select * from Rotation where RotationGroupID = " & RotationGroupID
        Try
            Call modODBC.Exec(vQuery, vReturn, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        QueryRotationCriteria = vRS
    End Function

    Public Function QueryWebParentReportGroupsRotation(ByRef pvForm As FrmRotateOrganization, ByRef setbox As Short) As Short

        '*********************************************************************************
        'Name: QueryWebParentReportGroupsRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This Sub Reloads the ReportGroups cbo box
        'Returns: N/A
        'Params: pvForm - Calling Form
        'Stored Procedures: N/A
        '=================================================================================

        Dim vQuery As New Object
        Dim vReturn As New Object
        If setbox = 0 Then
            If modControl.GetID(pvForm.CboReportParent) = 194 Then
                vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName AS ReportGroupName " & "INTO #TempReportGroup1 " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportType) & " "

                Try
                    QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If QueryWebParentReportGroupsRotation <> SUCCESS And QueryWebParentReportGroupsRotation <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup1 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Exit Function
                End If

                vQuery = "SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName " & "INTO #TempReportGroup2 " & "FROM WebReportGroup " & "JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID " & "WHERE WebReportGroupMaster = 1 "

                Try
                    QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If QueryWebParentReportGroupsRotation <> SUCCESS And QueryWebParentReportGroupsRotation <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup2 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Exit Function
                End If

                vQuery = "SELECT * " & "FROM #TempReportGroup1 " & "UNION " & "SELECT * " & "FROM #TempReportGroup2 " & "ORDER BY ReportGroupName "

            Else
                vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " " & "ORDER BY WebReportGroupName "
            End If


            Try
                QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryWebParentReportGroupsRotation = SUCCESS Then

                'Set the return set
                Call modControl.SetTextID(pvForm.CboReportType, vReturn, True)

                If modControl.GetID(pvForm.CboReportParent) = 194 Then
                    vQuery = "DROP TABLE #TempReportGroup1 " & "DROP TABLE #TempReportGroup2 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try

                End If
            End If
        Else
            If modControl.GetID(pvForm.CboReportParent2) = 194 Then
                vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName AS ReportGroupName " & "INTO #TempReportGroup1 " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent2) & " "

                Try
                    QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If QueryWebParentReportGroupsRotation <> SUCCESS And QueryWebParentReportGroupsRotation <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup1 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Exit Function
                End If

                vQuery = "SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName " & "INTO #TempReportGroup2 " & "FROM WebReportGroup " & "JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID " & "WHERE WebReportGroupMaster = 1 "

                Try
                    QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If QueryWebParentReportGroupsRotation <> SUCCESS And QueryWebParentReportGroupsRotation <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup2 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    Exit Function
                End If

                vQuery = "SELECT * " & "FROM #TempReportGroup1 " & "UNION " & "SELECT * " & "FROM #TempReportGroup2 " & "ORDER BY ReportGroupName "

            Else
                vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent2) & " " & "ORDER BY WebReportGroupName "
            End If


            Try
                QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryWebParentReportGroupsRotation = SUCCESS Then

                'Set the return set
                Call modControl.SetTextID(pvForm.CboReportType2, vReturn, True)

                If modControl.GetID(pvForm.CboReportParent2) = 194 Then
                    vQuery = "DROP TABLE #TempReportGroup1 " & "DROP TABLE #TempReportGroup2 "

                    Try
                        QueryWebParentReportGroupsRotation = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try

                End If
            End If
        End If

    End Function
    Public Function QueryWebParentReportGroups(ByRef pvForm As FrmReport) As Short

        Dim vQuery As New Object
        Dim vQuery1 As New Object
        Dim vReturn As New Object

        If modControl.GetID(pvForm.CboReportParent) = 194 Then
            'vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName AS ReportGroupName " & "INTO #TempReportGroup1 " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName AS ReportGroupName " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " "
            Try
                QueryWebParentReportGroups = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryWebParentReportGroups <> SUCCESS And QueryWebParentReportGroups <> NO_DATA Then
                vQuery = "DROP TABLE #TempReportGroup1 "

                Try
                    QueryWebParentReportGroups = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Exit Function
            End If

            'vQuery1 = "SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName " & "INTO #TempReportGroup2 " & "FROM WebReportGroup " & "JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID " & "WHERE WebReportGroupMaster = 1 "
            vQuery1 = "SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName " & "FROM WebReportGroup " & "JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID " & "WHERE WebReportGroupMaster = 1 "
            Try
                QueryWebParentReportGroups = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If QueryWebParentReportGroups <> SUCCESS And QueryWebParentReportGroups <> NO_DATA Then
                vQuery = "DROP TABLE #TempReportGroup2 "

                Try
                    QueryWebParentReportGroups = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Exit Function
            End If

            'vQuery = "SELECT * " & "FROM #TempReportGroup1 " & "UNION " & "SELECT * " & "FROM #TempReportGroup2 " & "ORDER BY ReportGroupName "
            vQuery = vQuery & "UNION " & vQuery1
        Else
            vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " " & "ORDER BY WebReportGroupName "
        End If


        Try
            QueryWebParentReportGroups = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryWebParentReportGroups = SUCCESS Then

            'Set the return set
            Call modControl.SetTextID(pvForm.CboReportGroup, vReturn, True)

            If modControl.GetID(pvForm.CboReportParent) = 194 Then
                'vQuery = "DROP TABLE #TempReportGroup1 " & "DROP TABLE #TempReportGroup2 "

                Try
                    QueryWebParentReportGroups = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            End If
        End If

    End Function

    Public Function QueryLogEventType(ByRef pvForm As Object) As Short
        '************************************************************************************
        'Name: QueryLogEventType%
        'Date Created: Unknown                          Created by: unknown
        'Release: Unknown                               Task: Unknown
        'Description: Queries LogEventTypes
        'Returns: N/A
        'Params: pvForm = calling form,
        '
        'Stored Procedures: N/A
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9
        'Description:
        '   Added 33 = DELETED EVENT to list of events not to query.
        '====================================================================================
        Dim vQuery As New Object
        Dim vResults As New Object
        Dim vWhere As String = ""
        Dim vEventTypeList As Object()
        Dim I As Short
        Dim j As Short

        'Get the event type list
        vEventTypeList = pvForm.LogEventTypeList

        If vEventTypeList(0) = ALL_TYPES Then

            Dim globalExcludeTypes = New Object() {QA_Note, 33} ' 33 = DELETED EVENT
            ' Treat all items with index > 0 in the event type list 
            ' as types to exclude.
            ' I don't like such implicit API interface, but 
            ' it's already quite implicit with passing event types as a form field.
            Dim excludeTypes As IEnumerable(Of Object) = vEventTypeList.Skip(1).Concat(globalExcludeTypes)

            'Set the query statement
            vQuery =
                "SELECT LogEventTypeID, LogEventTypeName FROM LogEventType " &
                "WHERE LogEventTypeID NOT IN " &
                $"({String.Join(", ", excludeTypes)});"

        Else

            'Build the where clause
            vWhere = "WHERE LogEventTypeID = "
            If UBound(vEventTypeList) = 0 Then
                vWhere = vWhere & vEventTypeList(0) & ";"
            Else
                For I = 0 To UBound(vEventTypeList) - 1
                    vWhere = vWhere & vEventTypeList(I) & " OR LogEventTypeID = "
                    j = I
                Next I
                vWhere = vWhere & vEventTypeList(j + 1) & " ORDER BY LogEventTypeName;"
            End If


            'Set the query statement
            vQuery = "SELECT LogEventTypeID, LogEventTypeName FROM LogEventType " & vWhere

        End If

        'Execute the query
        Try
            QueryLogEventType = modODBC.Exec(vQuery, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the data
        Call modControl.SetTextID(pvForm.CboContactEventType, vResults)

    End Function

    Public Function QueryScheduleGroup(ByRef pvForm As FrmScheduleGroup) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectScheduleGroup @ScheduleGroupID = " & pvForm.ScheduleGroupID & ";"

        Try
            QueryScheduleGroup = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 8) Then
            'Set the call data
            pvForm.ScheduleGroupID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 2)
            pvForm.Verified = vParams(0, 3)
            pvForm.TxtCode.Text = vParams(0, 8)
        End If

    End Function


    Public Function QueryCriteriaGroup(ByRef pvForm As FrmCriteriaGroup) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectCriteria @CriteriaID = " & pvForm.CriteriaGroupID & ";"

        Try
            QueryCriteriaGroup = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 1) Then
            'Set the call data
            pvForm.CriteriaGroupID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
        End If

    End Function

    Public Function QueryCriteriaTemplateId(ByRef pvForm As FrmCriteriaTemplate) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT max(CriteriaTemplateId) FROM CriteriaTemplate" & ";"

        Try
            QueryCriteriaTemplateId = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 0) Then
            'Set the call data
            pvForm.vCriteriaTemplateId = vParams(0, 0)
        End If

    End Function
    Public Function QueryDynamicDonorCriteriaGroup(ByRef pvForm As FrmEditDynamicDonorCategory) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectDynamicDonorCategory @DynamicDonorCategoryID = " & pvForm.DynamicDonorCategoryID & ";"

        Try
            QueryDynamicDonorCriteriaGroup = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 1) Then
            'Set the call data
            pvForm.DynamicDonorCategoryID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
        End If

    End Function
    Public Function QueryDynamicDonorCategory(ByRef pvParams As Object, ByRef pvOrganizationId As Integer, ByRef pvSourceCodeName As String) As Short

        Dim vQuery As New Object

        If IsNothing(pvSourceCodeName) Then
            pvSourceCodeName = "NULL"
        End If
        'T.T 5/18/2004 changed sps_dynamicdonorCategorybyorg2 from ..Org1 *CodeReview
        vQuery = "EXEC sps_DynamicDonorCategoryByOrg2 " & pvOrganizationId & ", " & pvSourceCodeName & ";"

        Try
            QueryDynamicDonorCategory = modODBC.Exec(vQuery, pvParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function QuerySystemAlert(ByRef pvForm As FrmSystemAlert) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        'drh 12/16/03 - Changed to a Long
        Dim I As Integer

        Call modUtility.Work()

        vQuery = "SELECT SystemAlertID, SystemAlertDate, " & "PersonFirst + ' ' + PersonLast, SystemAlertMessage, SystemAlertResolved " & "FROM SystemAlert " & "JOIN StatEmployee ON StatEmployee.StatEmployeeID = SystemAlert.StatEmployeeID " & "JOIN Person ON Person.PersonID = StatEmployee.PersonID "

        Select Case pvForm.AlertState

            Case ALL_ALERTS
                'Add no filters
            Case UNRESOLVED_ALERTS
                vQuery = vQuery & "WHERE SystemAlertResolved = 1"
            Case RESOLVED_ALERTS
                vQuery = vQuery & "WHERE SystemAlertResolved = -1"
        End Select

        Try
            QuerySystemAlert = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the call data
        Call modControl.ClearListView(pvForm.LstViewAlerts)
        pvForm.TxtAlertMessage.Text = ""

        If QuerySystemAlert = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 1) _
            AndAlso ObjectIsValidArray(vReturn, 2, UBound(vReturn, 1), 5) Then

            'Format the date column
            Call modMask.DateTimeColumn(vReturn, 1)

            For I = 0 To UBound(vReturn, 1)
                vReturn(I, 4) = IIf(vReturn(I, 4) = 1, "", "XXXXXX")
            Next I

            Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewAlerts, True)

        End If

        Call modUtility.Done()

    End Function
    Public Function QueryPersonType(ByRef pvForm As Object) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectPersonType @PersonTypeID = " & pvForm.PersonTypeID & ";"

        Try
            QueryPersonType = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 2) Then
            'Set the call data
            pvForm.PersonTypeID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 2)
        End If

    End Function

    Public Function QuerySubLocation(ByRef pvForm As FrmSubLocation) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "EXEC SelectSubLocation @SubLocationID = " & pvForm.SubLocationID & ";"

        Try
            QuerySubLocation = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 2) Then
            'Set the call data
            pvForm.SubLocationID = vParams(0, 0)
            pvForm.TxtName.Text = vParams(0, 1)
            pvForm.Verified = vParams(0, 2)
        End If

    End Function
    Public Function QueryLogEventList(ByRef vReturn As Object, ByVal callId As Integer, ByVal viewLogEventDeleted As Boolean) As Short
        '************************************************************************************
        'Name: QueryLogEventList%
        'Date Created: 03/28/11             Created by: Bret Knoll
        'Description: Queries the LogEvents for the current referral
        'Returns: N/A
        'Params: pvForm = calling form,
        '
        'Stored Procedures: QueryLogEventList
        '====================================================================================


        Dim vQuery As String = ""

        vQuery = String.Format("EXEC GetLogEventList @CallID = {0}, @TimeZone = {1}, @ViewLogEventDeleted = {2}", callId, AppMain.ParentForm.TimeZone, viewLogEventDeleted)

        Try
            QueryLogEventList = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function QueryLogEvent(ByRef pvForm As Object, Optional ByRef frmLogEvent As FrmLogEvent = Nothing) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        If pvForm.Name = "FrmLogEvent" Then

            'Get the record that matches the passed in log event ID
            vQuery = "SELECT LogEvent.LogEventID, " & "DATEADD(hh, " & vTimeZoneDif & ", LogEventDateTime) AS 'LogEventDateTime', " & "LogEvent.LogEventTypeID, " & "LogEvent.LogEventName, LogEvent.LogEventPhone, LogEvent.LogEventOrg, LogEvent.LogEventDesc, " & "StatEmployee.StatEmployeeID, LogEvent.LogEventCallbackPending, LogEvent.OrganizationID, " & "LogEvent.ScheduleGroupID, LogEvent.PersonID, LogEvent.PhoneID, LogEventContactConfirmed, " & "DATEADD(hh, " & vTimeZoneDif & ", LogEventCalloutDateTime) AS 'LogeEventCalloutDateTime' " & "FROM LogEvent " & "JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID " & "JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID " & "WHERE LogEvent.LogEventID = " & pvForm.LogEventID & " "

            Try
                Call modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If ObjectIsValidArray(vParams, 2, 0, 14) Then

                'Set the event data
                pvForm.ContactLogEventID = vParams(0, 0)
                pvForm.ContactLogEventDate = vParams(0, 1)
                pvForm.TxtContactDate.Text = VB6.Format(pvForm.ContactLogEventDate, "mm/dd/yy  hh:mm")

                If pvForm.UpdatePendingEvent = False Then
                    pvForm.DefaultContactType = vParams(0, 2)
                End If

                'BJK 3/31/09 moved line above LogEvenTypeID
                pvForm.OrganizationId = vParams(0, 9)
                pvForm.DefaultContactName = vParams(0, 3)

                'load Location People and page pending person and sets text
                Try
                    Call modStatQuery.QueryLocationPerson(pvForm)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                pvForm.ContactLogEventTypeID = pvForm.DefaultContactType
                Call modControl.SelectID(pvForm.CboContactEventType, pvForm.ContactLogEventTypeID)

                'TODO: Check to if pending page person is in location list.
                DirectCast(pvForm.CboName, ComboBox).Items.Add(New ValueDescriptionPair(-999, pvForm.DefaultContactName))
                Call modControl.SelectText(pvForm.CboName, pvForm.DefaultContactName)

                pvForm.DefaultContactPhone = vParams(0, 4)
                pvForm.TxtContactPhone.Text = pvForm.DefaultContactPhone
                pvForm.DefaultOrganization = vParams(0, 5)
                pvForm.TxtContactOrg.Text = pvForm.DefaultOrganization
                pvForm.TxtContactDesc.Text = vParams(0, 6)
                If pvForm.UpdatePendingEvent = False Then
                    pvForm.ContactEmployeeID = vParams(0, 7)
                Else
                    pvForm.ContactEmployeeID = AppMain.ParentForm.StatEmployeeID
                End If

                pvForm.CallbackPending = vParams(0, 8)


                pvForm.ScheduleGroupID = IIf(vParams(0, 10) = "", 0, vParams(0, 10))
                pvForm.PersonID = IIf(vParams(0, 11) = "", 0, vParams(0, 11))
                pvForm.PhoneID = IIf(vParams(0, 12) = "", 0, vParams(0, 12))
                pvForm.ChkConfirmed.Checked = IIf(vParams(0, 13) = "", 0, vParams(0, 13))

                pvForm.TxtCalloutDate.Text = VB6.Format(vParams(0, 14), "mm/dd/yy  hh:mm")

                If Len(pvForm.TxtCalloutDate.Text) Then
                    pvForm.TxtCalloutMins.Text = DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(pvForm.TxtContactDate.Text), CDate(pvForm.TxtCalloutDate.Text))
                End If

            End If


        ElseIf pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmReferralView" Or pvForm.Name = "FrmMessage" Then

            'This query is used to provide a new event that defaults the data
            'of an event the user wishes to duplicate.
            vQuery = "SELECT LogEvent.LogEventTypeID, " & "LogEvent.LogEventName, LogEvent.LogEventPhone, LogEvent.LogEventOrg, LogEvent.OrganizationID, " & "LogEvent.ScheduleGroupID, LogEvent.PersonID, LogEvent.PhoneID " & "FROM LogEvent " & "WHERE LogEvent.LogEventID = " & pvForm.CurrentLogEventID & " "

            Try
                Call modODBC.Exec(vQuery, vParams)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


            If ObjectIsValidArray(vParams, 2, 0, 7) Then
                'Set the event data
                ' ''why would this need to be done.
                frmLogEvent.DefaultContactType = CShort(vParams(0, 0))
                frmLogEvent.DefaultContactName = vParams(0, 1)
                frmLogEvent.DefaultContactPhone = vParams(0, 2)
                frmLogEvent.DefaultOrganization = vParams(0, 3)

                frmLogEvent.OrganizationId = CInt(vParams(0, 4))
                frmLogEvent.ScheduleGroupID = CInt(vParams(0, 5))
                frmLogEvent.PersonID = CInt(vParams(0, 6))
                frmLogEvent.PhoneID = CInt(vParams(0, 7))
            End If

        End If
        Exit Function
    End Function

    Public Function ChangeQueryLogEvent(ByVal pvEventID As Integer) As String
        '***********************************************************************
        'T.T 10/05/2004
        'Module:modStatQuery.changeQueryLogEvent
        'Parameters:    pvEventID - Log event ID
        'Definition:    This function accepts the event ID for a registry note
        '               and returns the parameters of that note
        '***********************************************************************
        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'Get the record that matches the passed in log event ID
        vQuery = "SELECT LogEvent.LogEventID, " & "DATEADD(hh, " & vTimeZoneDif & ", LogEventDateTime) AS 'LogEventDateTime', " & "LogEvent.LogEventTypeID, " & "LogEvent.LogEventName, LogEvent.LogEventPhone, LogEvent.LogEventOrg, LogEvent.LogEventDesc, " & "StatEmployee.StatEmployeeID, LogEvent.LogEventCallbackPending, LogEvent.OrganizationID, " & "LogEvent.ScheduleGroupID, LogEvent.PersonID, LogEvent.PhoneID, LogEventContactConfirmed, " & "DATEADD(hh, " & vTimeZoneDif & ", LogEventCalloutDateTime) AS 'LogeEventCalloutDateTime' " & "FROM LogEvent " & "JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID " & "JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID " & "WHERE LogEvent.LogEventID = " & pvEventID & " "

        Try
            Call modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 7) Then
            ChangeQueryLogEvent = vParams(0, 7)
        End If

    End Function
    Public Function QueryLogEventDesc(ByRef pvLogEventId As Object, ByRef prLogEventDesc As Object) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vReturn As Short

        'The selected record is a non-response event type so get the record
        'that matches the passed in log event ID
        vQuery = "SELECT LogEvent.LogEventDesc " & "FROM LogEvent " & "WHERE LogEvent.LogEventID = " & pvLogEventId & ";"

        Try
            If modODBC.Exec(vQuery, vParams) = SUCCESS Then
                'Set the event data
                prLogEventDesc = vParams(0, 0)
            End If
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function QueryReferral(ByRef pvForm As Object) As Short

        '************************************************************************************
        'Name: QueryReferral%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: None
        'Description: Queries the database for Referral information.
        'Returns: Return value of executed query.
        'Params: pvForm = calling form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/20/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Changed the ReferralType to be retrieved from CurrentReferralType.
        '====================================================================================
        'Date Changed: 5/25/05                          Changed by: Char Chaput
        'Release #: 8.0                               Task: 400
        'Description:  Modified setting referral screen fields due to referral screen redesign
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/17/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Added new referral screen fields. MD Phone, Brain Death Date/time,
        '              Specific COD, Patient MI
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/2/06                          Changed by: Christopher Carroll
        'Release #: 8.0                               Release 8.0
        'Description:  Added field for QA Review Complete (Req.# 4.9.2)
        '====================================================================================
        '************************************************************************************
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vSubLocResults As New Object
        Dim vPersonResults As New Object
        Dim RS As New Object

        vQuery = "EXEC ReferralSelect @CallID = " & pvForm.CallId & ";"

        Try
            QueryReferral = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Make sure we had a successful query result
        If QueryReferral = SQL_ERROR Then
            Dim msg As String = "We were unable to load referral information..." & Environment.NewLine & Environment.NewLine
            msg = msg & "Please click OK here and then click Yes to confirm closing the screen " & Environment.NewLine
            msg = msg & "(knowing that any unsaved data will be lost at this point)." & Environment.NewLine & Environment.NewLine
            msg = msg & "After closing, please try opening the referral once again."
            MsgBox(msg, MsgBoxStyle.OkOnly, "Error Loading Referral")
            pvForm.Close()
        End If

        'Call Info
        If Not IsDBNull(RS("ReferralCallerPhoneID").Value) Then
            pvForm.CallPhoneNumberID = modConv.NullToText(RS("ReferralCallerPhoneID").Value)
        End If

        'Get the phone number based on the ID only if a phone number has been entered.
        If pvForm.CallPhoneNumberID.ToString() <> "" Then
            Call modStatRefQuery.RefQueryPhone(vReturn, pvForm.CallPhoneNumberID)
            If ObjectIsValidArray(vReturn, 2, 0, 3) Then
                If vReturn(0, 1) & vReturn(0, 2) & vReturn(0, 3) <> "" Then
                    pvForm.LblPhone.Text = modUtility.BuildPhone(vReturn)
                End If
            End If
        End If

        If Not IsDBNull(RS("IsERferralCase").Value) AndAlso RS("IsERferralCase").Value Then
            pvForm.LabelEReferral.Visible = True
        Else
            pvForm.LabelEReferral.Visible = False
        End If


        pvForm.LblExtension.Text = modConv.NullToText(RS("ReferralCallerExtension").Value)
        If Not IsDBNull(RS("ReferralCallerOrganizationID").Value) Then
            pvForm.OrganizationId = modConv.NullToText(RS("ReferralCallerOrganizationID").Value)
        End If

        'Get the organization name
        Call modStatRefQuery.RefQueryOrganization(vResultArray, pvForm.OrganizationId)
        If ObjectIsValidArray(vResultArray, 2, 0, 1) Then
            pvForm.LblOrganization.Text = modConv.NullToText(vResultArray(0, 1))
            pvForm.OrganizationName = modConv.NullToText(vResultArray(0, 1))
        End If

        'Set the Location combo box
        'Call modControl.SetTextID(pvForm.CboOrganization, vResultArray, True)
        'Call modControl.SelectID(pvForm.CboOrganization, pvForm.OrganizationId)

        If Not IsDBNull(RS("ReferralCallerOrganizationID").Value) Then
            pvForm.CallerOrg.ID = modConv.NullToText(RS("ReferralCallerOrganizationID").Value)
        End If

        Call modStatQuery.QueryOrganizationCountyID(pvForm)

        Call modControl.SelectText(pvForm.CboVent, modConv.NullToText(RS("ReferralDonorOnVentilator").Value))
        Call modControl.SelectIDFromObject(pvForm.CboHeartBeat, RS("ReferralDonorHeartBeat").Value)

        'Check the service level of the organization
        Call pvForm.SetServiceLevel(pvForm)

        'Check the properties of the location
        Call modStatQuery.QueryOrganizationProperties(pvForm)

        If Not IsDBNull(RS("ReferralCallerSubLocationID").Value) Then
            pvForm.SubLocationID = modConv.NullToText(RS("ReferralCallerSubLocationID").Value)
        End If
        If pvForm.SubLocationID > 0 Then
            Call modStatRefQuery.RefQuerySubLocation(vParams, pvForm.SubLocationID)
            If ObjectIsValidArray(vParams, 2, 0, 1) Then
                pvForm.LblSubLocation.Text = modConv.NullToText(vParams(0, 1))
            End If
            'Else
            'pvForm.LblSubLocation.Text = modConv.NullToText(vParams(0, 1))
        End If

        'Set the Sub Location Level combo box
        'Call modControl.SelectText(pvForm.LblLevel.Text, modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value))
        pvForm.LblLevel.Text = modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value)
        pvForm.SubLocationLevel = modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value)

        If Not IsDBNull(RS("ReferralCallerPersonID").Value) Then
            pvForm.PersonID = modConv.NullToText(RS("ReferralCallerPersonID").Value)
        End If
        If pvForm.PersonID > 0 Then

            'Fill the person combo box based on the location ID
            'Call modStatQuery.QueryLocationPerson(pvForm)
            Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.PersonID)
            If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                pvForm.LblName.Text = modConv.NullToText(vPersonResults(0, 1))
            End If

            Call modStatQuery.QueryPersonPersonType(pvForm)

        End If

        'Donor Info
        pvForm.TxtDonorLastName.Text = modConv.NullToText(RS("ReferralDonorLastName").Value)
        pvForm.TxtDonorFirstName.Text = modConv.NullToText(RS("ReferralDonorFirstName").Value)
        pvForm.TxtDonorMI.Text = modConv.NullToText(RS("ReferralDonorNameMI").Value)

        pvForm.TxtRecNum.Text = modConv.NullToText(RS("ReferralDonorRecNumber").Value)
        pvForm.TxtSSN.Text = modConv.NullToText(RS("ReferralDonorSSN").Value)
        pvForm.TxtAge.Text = modConv.NullToText(RS("ReferralDonorAge").Value)
        Call modControl.SelectText(pvForm.CboAgeUnit, modConv.NullToText(RS("ReferralDonorAgeUnit").Value))
        Call modControl.SelectIDFromObject(pvForm.CboRace, RS("ReferralDonorRaceID").Value)

        Call modControl.SelectText(pvForm.CboGender, modConv.NullToText(RS("ReferralDonorGender").Value))
        pvForm.TxtWeight.Text = modConv.NullToText(RS("ReferralDonorWeight").Value)
        pvForm.TxtAdmitDate.Text = VB6.Format(modConv.NullToText(RS("ReferralDonorAdmitDate").Value), "mm/dd/yy")
        pvForm.TxtAdmitTime.Text = modConv.NullToText(RS("ReferralDonorAdmitTime").Value)
        pvForm.TxtDeathDate.Text = VB6.Format(modConv.NullToText(RS("ReferralDonorDeathDate").Value), "mm/dd/yy")
        pvForm.TxtDeathTime.Text = modConv.NullToText(RS("ReferralDonorDeathTime").Value)

        pvForm.TxtLSADate.Text = VB6.Format(modConv.NullToText(RS("ReferralDonorLSADate").Value), "mm/dd/yy")
        pvForm.TxtLSATime.Text = modConv.NullToText(RS("ReferralDonorLSATime").Value)

        pvForm.TxtBrainDeathDate.Text = VB6.Format(modConv.NullToText(RS("ReferralDonorBrainDeathDate").Value), "mm/dd/yy")
        pvForm.TxtBrainDeathTime.Text = modConv.NullToText(RS("ReferralDonorBrainDeathTime").Value)
        Call modControl.SelectIDFromObject(pvForm.CboCauseOfDeath, RS("ReferralDonorCauseOfDeathID").Value)
        pvForm.TxtSpecificCOD.Text = modConv.NullToText(RS("ReferralDonorSpecificCOD").Value)
        pvForm.ChkDOB.Checked = modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralDOB_ILB").Value))

        'Call modControl.SelectText(pvForm.CboVent, modConv.NullToText(RS("ReferralDonorOnVentilator").Value))
        '01/07/04 mds populate HeartBeat Field
        'Call modControl.SelectID(pvForm.CboHeartBeat, modConv.NullToText(RS("ReferralDonorHeartBeat").Value))
        pvForm.TxtExtubated.Text = modConv.NullToText(RS("ReferralExtubated").Value)
        pvForm.TxtDOB.Text = VB6.Format(modConv.NullToText(RS("ReferralDOB").Value), "mm/dd/yyyy")
        pvForm.ChkDOA.Checked = modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralDOA").Value))
        pvForm.TxtNotesCase.Text = modConv.NullToText(RS("ReferralNotesCase").Value)

        'ccarroll 06/2/06 Added QA Review Complete status
        pvForm.ChkQAReview.Checked = 0 'reset Iif(RS("ReferralQAReviewComplete").Value > 0, 0 'modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralQAReviewComplete").Value))

        'ccarroll 08/27/2008 HS14870, QA Review Referrals disappear from update tab when opened and then saved
        'load QA status switch values into referral
        If Not IsDBNull(RS("ReferralQAReviewComplete").Value) Then
            vQAResetSwitch = modConv.TextToInt(RS("ReferralQAReviewComplete").Value)
        End If


        'T.T 10/05/2004 added for initial load of referral
        pvForm.DonorFirstName = pvForm.TxtDonorFirstName.Text
        pvForm.DonorLastName = pvForm.TxtDonorLastName.Text
        pvForm.DonorDOB = pvForm.TxtDOB.Text

        'ccarroll 09/12/2006 added fs Approach info
        Call QueryReferralFinalApproachInfo(pvForm)

        'Type and Approach Info
        ' Changed the ReferralType to be retrieved from CurrentReferralType.  v. 8.0 5/18/05 - SAP
        Call modControl.SelectIDFromObject(pvForm.CboReferralType, RS("CurrentReferralTypeID").Value)
        ' Store the preliminary and current ReferralTypes in form variables. v. 8.0, 6/13/05 - SAP
        If (pvForm.Name = "FrmReferral") Then
            If Not IsDBNull(RS("ReferralTypeId").Value) Then
                DirectCast(pvForm, FrmReferral).pvPrelimReferralType = RS("ReferralTypeId").Value
            End If
            If Not IsDBNull(RS("CurrentReferralTypeId").Value) Then
                DirectCast(pvForm, FrmReferral).pvCurrentReferralType = RS("CurrentReferralTypeId").Value
            End If
        End If
        Call modControl.SelectIDFromObject(pvForm.CboApproachType, RS("ReferralApproachTypeID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboGeneralConsent, RS("ReferralGeneralConsent").Value)

        If Not IsDBNull(RS("ReferralApproachedByPersonID").Value) Then
            pvForm.ApproachedByID = modConv.TextToLng(RS("ReferralApproachedByPersonID").Value)
        End If

        'Fill the approached by combo box based on the location ID and opo region
        If pvForm.CallerOrg.ServiceLevel.ApproachMethod Then
            Call modStatQuery.QueryLocationApproachPerson(pvForm)
        End If

        If modControl.SelectID(pvForm.CboApproachedBy, pvForm.ApproachedByID) = False And pvForm.ApproachedByID <> -1 And pvForm.ApproachedByID <> 0 Then
            'There is a person ID, but it is not in the person list because
            'the person has been inactivated. Add the person to the list

            'First get the name of the person
            Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.ApproachedByID)

            If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                'Next add the person to the list
                Call modControl.SetTextIDItem(pvForm.CboApproachedBy, vPersonResults(0, 0), vPersonResults(0, 1))
            End If

            'Last, select the newly added id
            Call modControl.SelectID(pvForm.CboApproachedBy, pvForm.ApproachedByID)
        End If

        'C.Chaput 07/01/05 Moved NOK to function QueryNOK for Release8.0
        pvForm.NOK = modConv.NullToText(RS("ReferralApproachNOK").Value)
        pvForm.NOKRelation = modConv.NullToText(RS("ReferralApproachRelation").Value)
        'pvForm.LblSubLocation.Text = modConv.NullToText(vParams(0, 1))
        pvForm.NOKPhone = modConv.NullToText(RS("ReferralNOKPhone").Value)
        pvForm.NOKRefAddress = modConv.NullToText(RS("ReferralNOKAddress").Value)
        If Not IsDBNull(RS("ReferralNOKID").Value) Then
            pvForm.NOKID = modConv.TextToLng(modConv.NullToText(RS("ReferralNOKID").Value))
        End If


        pvForm.ChkCoronerCase.Checked = modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralCoronersCase").Value))
        Call modControl.SelectText(pvForm.CboCoronerOrg, modConv.NullToText(RS("ReferralCoronerOrganization").Value))

        If Not IsDBNull(RS("ReferralCoronerOrganization").Value) And pvForm.CboCoronerOrg.Text = "" Then
            'The selected coroner is not currently in the coroner list
            'First get the state of the selected coroner, then selected in the state list
            If modStatQuery.QueryCoronerState(RS("ReferralCoronerOrganization").Value, vCoronerState) = SUCCESS _
                AndAlso ObjectIsValidArray(vCoronerState, 2, 0, 0) Then
                Call modControl.SelectID(pvForm.CboState, vCoronerState(0, 0))
            End If
            'Reset the coroner selection
            Call modControl.SelectText(pvForm.CboCoronerOrg, modConv.NullToText(RS("ReferralCoronerOrganization").Value))
        End If

        If pvForm.CboCoronerOrg.Text <> "" Then
            'Fill the list with coroner names from the selected coroner
            pvForm.CboCoronerName.Items.Clear()

            If modStatQuery.QueryCoroner(modControl.GetID(pvForm.CboCoronerOrg), vCoronerReturn) = SUCCESS Then
                Call modControl.SetTextID(pvForm.CboCoronerName, vCoronerReturn)
                pvForm.CboCoronerName.items.Add(New ValueDescriptionPair(-1, "Not Available"))
                Call modControl.SelectText(pvForm.CboCoronerName, modConv.NullToText(RS("ReferralCoronerName").Value))
            End If

        End If
        pvForm.TxtCoronerPhone.Text = modConv.NullToText(RS("ReferralCoronerPhone").Value)
        pvForm.TxtCoronerNote.Text = modConv.NullToText(RS("ReferralCoronerNote").Value)

        'Physician Info
        If pvForm.CallerOrg.ServiceLevel.PronouncingMD Or pvForm.CallerOrg.ServiceLevel.AttendingMD Then
            Call modStatQuery.QueryLocationPhysicians(pvForm)
        End If

        'Registry Status info
        'T.T 9/14/2004 added to get the RegistryStatus Info
        Call modStatQuery.QueryRegistryStatus(pvForm.CallId)


        'Added 07/2001 bjk: This will enable the Pronouncing or attending box
        Call pvForm.InitializePhysician(pvForm)

        If Not IsDBNull(RS("ReferralPronouncingMD").Value) Then
            pvForm.PronouncingMDID = modConv.TextToLng(RS("ReferralPronouncingMD").Value)
        End If

        If pvForm.PronouncingMDID <> 0 And pvForm.PronouncingMDID <> -1 Then
            'Fill the approached by combo box based on the location ID and opo region
            If modControl.SelectID(pvForm.CboPhysician(1), pvForm.PronouncingMDID) = False And pvForm.PronouncingMDID <> -1 Then
                'There is a person ID, but it is not in the person list because
                'the person has been inactivated. Add the person to the list

                'First get the name of the person
                Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.PronouncingMDID)

                If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                    'Next add the person to the list
                    Call modControl.SetTextIDItem(pvForm.CboPhysician(1), vPersonResults(0, 0), vPersonResults(0, 1))
                End If

                'Last, select the newly added id
                Call modControl.SelectID(pvForm.CboPhysician(1), pvForm.PronouncingMDID)
            End If
            pvForm.TxtPronouncingPhone.Text = modConv.NullToText(RS("ReferralPronouncingMDPhone").Value)
        End If

        If Not IsDBNull(RS("ReferralAttendingMD").Value) Then
            pvForm.AttendingMDID = modConv.TextToLng(RS("ReferralAttendingMD").Value)
        End If

        If pvForm.AttendingMDID <> 0 And pvForm.AttendingMDID <> -1 Then
            'Fill the approached by combo box based on the location ID and opo region
            Call modControl.SelectID(pvForm.CboPhysician(0), pvForm.AttendingMDID)
            If modControl.SelectID(pvForm.CboPhysician(0), pvForm.AttendingMDID) = False And pvForm.AttendingMDID <> -1 Then
                'There is a person ID, but it is not in the person list because
                'the person has been inactivated. Add the person to the list

                'First get the name of the person
                Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.AttendingMDID)

                If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                    'Next add the person to the list
                    Call modControl.SetTextIDItem(pvForm.CboPhysician(0), vPersonResults(0, 0), vPersonResults(0, 1))
                End If

                'Last, select the newly added id
                Call modControl.SelectID(pvForm.CboPhysician(0), pvForm.AttendingMDID)
            End If
            pvForm.TxtAttendingPhone.Text = modConv.NullToText(RS("ReferralAttendingMDPhone").Value)
        End If


        'Options Info
        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(ORGAN), RS("ReferralOrganAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(ORGAN), RS("ReferralOrganApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(ORGAN), RS("ReferralOrganConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(ORGAN), RS("ReferralOrganConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(BONE), RS("ReferralBoneAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(BONE), RS("ReferralBoneApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(BONE), RS("ReferralBoneConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(BONE), RS("ReferralBoneConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(TISSUE), RS("ReferralTissueAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(TISSUE), RS("ReferralTissueApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(TISSUE), RS("ReferralTissueConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(TISSUE), RS("ReferralTissueConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(SKIN), RS("ReferralSkinAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(SKIN), RS("ReferralSkinApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(SKIN), RS("ReferralSkinConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(SKIN), RS("ReferralSkinConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(VALVES), RS("ReferralValvesAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(VALVES), RS("ReferralValvesApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(VALVES), RS("ReferralValvesConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(VALVES), RS("ReferralValvesConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(EYES), RS("ReferralEyesTransAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(EYES), RS("ReferralEyesTransApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(EYES), RS("ReferralEyesTransConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(EYES), RS("ReferralEyesTransConversionID").Value)

        Call modControl.SelectIDFromObject(pvForm.CboAppropriate(RESEARCH), RS("ReferralEyesRschAppropriateID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboApproach(RESEARCH), RS("ReferralEyesRschApproachID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboConsent(RESEARCH), RS("ReferralEyesRschConsentID").Value)
        Call modControl.SelectIDFromObject(pvForm.CboRecovery(RESEARCH), RS("ReferralEyesRschConversionID").Value)

        '???? bjk 08/23/02 review removing following 8 fields from updating  during saveReferral
        pvForm.OrganDispositionID = modConv.NullToText(RS("ReferralOrganDispositionID").Value)
        pvForm.BoneDispositionID = modConv.NullToText(RS("ReferralBoneDispositionID").Value)
        pvForm.TissueDispositionID = modConv.NullToText(RS("ReferralTissueDispositionID").Value)
        pvForm.SkinDispositionID = modConv.NullToText(RS("ReferralSkinDispositionID").Value)
        pvForm.ValvesDispositionID = modConv.NullToText(RS("ReferralValvesDispositionID").Value)
        pvForm.EyesDispositionID = modConv.NullToText(RS("ReferralEyesDispositionID").Value)
        pvForm.RschDispositionID = modConv.NullToText(RS("ReferralRschDispositionID").Value)
        pvForm.AllTissueDispositionID = modConv.NullToText(RS("ReferralAllTissueDispositionID").Value)

        If pvForm.CallerOrg.ServiceLevel.SecondaryOn = True Then
            pvForm.ReferralSecondary.ID = RS("ReferralID").Value
            pvForm.ReferralSecondary.GetData()
            pvForm.TxtSecondaryNote.Text = pvForm.ReferralSecondary.SecondaryNote
        End If

        If Not IsDBNull(RS("DonorRegistryType").Value) _
            And Not IsDBNull(RS("DonorRegId").Value) _
            And Not IsDBNull(RS("DonorDMVId").Value) _
            And Not IsDBNull(RS("DonorDSNID").Value) Then
            pvForm.DonorSearchState = DonorSearchFormState.CreateFromPersistedState(
                    donorRegistryTypeSelection:=modConv.TextToInt(modConv.NullToText(RS("DonorRegistryType").Value)),
                    donorRegId:=modConv.TextToLng(modConv.NullToText(RS("DonorRegId").Value)),
                    donorDmvId:=modConv.TextToLng(modConv.NullToText(RS("DonorDMVId").Value)),
                    donorDsnId:=modConv.TextToInt(modConv.NullToText(RS("DonorDSNID").Value)))
        End If

        If Not IsDBNull(RS("DonorIntentDone").Value) Then
            pvForm.DonorIntentDone = modConv.TextToInt(modConv.NullToText(RS("DonorIntentDone").Value))
        End If
        If Not IsDBNull(RS("DonorFaxSent").Value) Then
            pvForm.DonorFaxSent = modConv.TextToInt(modConv.NullToText(RS("DonorFaxSent").Value))
        End If
        '03/11/03 bjk add new fields DonorRegistry II

        If pvForm.CallerOrg.ServiceLevel.PendingCase Then
            pvForm.ChkPendingCase.Checked = modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralPendingCase").Value))
            Call modControl.SelectIDFromObject(pvForm.CboPendingCaseCoordinator, RS("ReferralPendingCaseCoordinator").Value)
            pvForm.TxtPendingCaseComment.Text = modConv.NullToText(RS("ReferralPendingCaseComment").Value)
        End If

        If (pvForm.Name = "FrmReferral" AndAlso String.IsNullOrEmpty(pvForm.cboDCDPotential.Text)) Then
            Call modControl.SelectIDFromObject(pvForm.cboDCDPotential, RS("ReferralDCDPotential").Value)
        End If

    End Function
    Public Function QueryReferralFinalApproachInfo(ByRef pvForm As FrmReferral) As Short
        '************************************************************************************
        'Name: QueryReferralFinalApproachInfo%
        'Date Created: 09/13/06                         Created by: Christopher Carroll
        'Release: 8.0   Iteration 2                           Task: None
        'Description: Queries SecondaryApproach table in FS and returns Approach information
        'in text readable to the calling form's listbox
        'Returns: Return value of executed query.
        'Params: pvForm.CallId = CallID from calling form
        'Stored Procedures: sps_GetFSApproachInfo
        '************************************************************************************
        Dim vQuery As String
        Dim vResult As New Object


        vQuery = "sps_GetFSApproachInfo " & pvForm.CallId & " ;"

        Try
            QueryReferralFinalApproachInfo = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If QueryReferralFinalApproachInfo = SUCCESS _
            AndAlso ObjectIsValidArray(vResult, 2, 0, 2) Then
            pvForm.LblFSApproacher.Text = vResult(0, 0)
            pvForm.LblFSApproach.Text = vResult(0, 1)
            pvForm.LblFSConsent.Text = vResult(0, 2)
        Else
            pvForm.LblFSApproacher.Text = ""
            pvForm.LblFSApproach.Text = ""
            pvForm.LblFSConsent.Text = ""
        End If

    End Function
    Public Function QueryRecycledNC(ByRef pvForm As Object) As Short

        '************************************************************************************
        'Name: QueryReferral%
        'Date Created: 4/25/06                          Created by: Char Chaput
        'Release: 8.0                               Task: None
        'Description: Queries the database for a Recycled New Call Referral information.
        'You will have only limited fields set
        'Returns: Return value of executed query.
        'Params: pvForm = calling form
        'Stored Procedures: None
        '************************************************************************************
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vSubLocResults As New Object
        Dim vPersonResults As New Object
        Dim RS As New Object

        vQuery = "EXEC ReferralSelect @CallID = " & pvForm.CallId & ";"

        Try
            QueryRecycledNC = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the referral information

        'Call Info
        pvForm.CallPhoneNumberID = modConv.NullToText(RS("ReferralCallerPhoneID").Value)
        If pvForm.CallPhoneNumberID > 0 Then

            'Get the phone number based on the ID only if a phone number has been entered.
            If pvForm.CallPhoneNumberID <> "" Then
                Try
                    Call modStatRefQuery.RefQueryPhone(vReturn, pvForm.CallPhoneNumberID)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                If ObjectIsValidArray(vReturn, 2, 0, 3) _
                    AndAlso vReturn(0, 1) & vReturn(0, 2) & vReturn(0, 3) <> "" Then
                    pvForm.LblPhone.Text = modUtility.BuildPhone(vReturn)
                End If
            End If
        End If


        pvForm.LblExtension.Text = modConv.NullToText(RS("ReferralCallerExtension").Value)
        pvForm.OrganizationId = modConv.NullToText(RS("ReferralCallerOrganizationID").Value)
        If pvForm.OrganizationId > 0 Then

            'Get the organization name
            Try
                Call modStatRefQuery.RefQueryOrganization(vResultArray, pvForm.OrganizationId)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            If ObjectIsValidArray(vResultArray, 2, 0, 1) Then
                pvForm.LblOrganization.Text = modConv.NullToText(vResultArray(0, 1))
            End If
            'Set the Location combo box
            'Call modControl.SetTextID(pvForm.CboOrganization, vResultArray, True)
            'Call modControl.SelectID(pvForm.CboOrganization, pvForm.OrganizationId)

            pvForm.CallerOrg.ID = modConv.NullToText(RS("ReferralCallerOrganizationID").Value)

            Try
                Call modStatQuery.QueryOrganizationCountyID(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Check the service level of the organization
            Call pvForm.SetServiceLevel(pvForm)

            'Check the properties of the location
            Try
                Call modStatQuery.QueryOrganizationProperties(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        pvForm.SubLocationID = modConv.NullToText(RS("ReferralCallerSubLocationID").Value)
        If pvForm.SubLocationID > 0 Then

            'Set the Sub Location combo box
            'Call modControl.SelectID(pvForm.CboSubLocation, pvForm.SubLocationID)
            Try
                Call modStatRefQuery.RefQuerySubLocation(vParams, pvForm.SubLocationID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            If ObjectIsValidArray(vParams, 2, 0, 1) Then
                pvForm.LblSubLocation.Text = modConv.NullToText(vParams(0, 1))
            End If
        End If

        'Set the Sub Location Level combo box
        'Call modControl.SelectText(pvForm.LblLevel.Text, modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value))
        pvForm.LblLevel.Text = modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value)

        pvForm.PersonID = modConv.NullToText(RS("ReferralCallerPersonID").Value)
        If pvForm.PersonID > 0 Then

            'Fill the person combo box based on the location ID
            'Call modStatQuery.QueryLocationPerson(pvForm)
            Try
                Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.PersonID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                pvForm.LblName.Text = modConv.NullToText(vPersonResults(0, 1))
            End If

            Try
                Call modStatQuery.QueryPersonPersonType(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If modControl.SelectID(pvForm.LblName, pvForm.PersonID) = False And pvForm.PersonID <> -1 And pvForm.PersonID <> 0 Then
                'There is a person ID, but it is not in the person list because
                'the person has been inactivated. Add the person to the list

                'First get the name of the person
                Try
                    Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.PersonID)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If ObjectIsValidArray(vPersonResults, 2, 0, 1) Then
                    'Next add the person to the list
                    Call modControl.SetTextIDItem(pvForm.LblName, vPersonResults(0, 0), vPersonResults(0, 1))
                End If

                'Last, select the newly added id
                Call modControl.SelectID(pvForm.LblName, pvForm.PersonID)
            End If
        End If

        Exit Function

    End Function


    Public Function QuerySecondaryTriageData(ByRef pvForm As FrmReferralView, ByRef CtlList As Object) As Short
        'FSProj drh 6/15/02 - Get Triage Data for Secondary Referral View

10:     Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vPersonResults As New Object
        Dim RS As New Object
        Dim I As Integer
        Dim j As Integer

        Dim ResultsArray As New Object
        Dim Result As New Object

20:     pvForm.FormLoad = True

        'drh FSMod 06/23/03 - Added Org Join so we can get Org Notes
30:     vQuery = "EXEC ReferralSelect @CallID = " & pvForm.CallId & ";"

        Try
            QuerySecondaryTriageData = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

50:     pvForm.NOKID = modConv.NullToZero(RS("ReferralNOKID").Value) 'T.T 03/06/2007 added Null to Zero because it was erroring on nulltotext typemismatch
60:     pvForm.NOK = modConv.NullToText(RS("ReferralApproachNOK").Value)

        'ccarroll 10/23/2007 Get Donor registry data if exists
        pvForm.DonorSearchState = UIServices.Donor.Search.DonorSearchFormState.CreateFromPersistedState(
            donorRegistryTypeSelection:=modConv.NullToZero(RS("DonorRegistryType").Value),
            donorRegId:=modConv.NullToZero(RS("DonorRegID").Value),
            donorDmvId:=modConv.NullToZero(RS("DonorDMVID").Value),
            donorDsnId:=modConv.NullToZero(RS("DonorDSNID").Value))

70:     If pvForm.NOKID > 0 Then

80:         vQuery = "EXEC SelectNOK @NOKID = " & pvForm.NOKID & ";"

            Try
                Result = modODBC.Exec(vQuery, ResultsArray)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

100:        If Result = SUCCESS _
                AndAlso ObjectIsValidArray(ResultsArray, 2, 0, 8) Then
110:            pvForm.NOKFirstName = ResultsArray(0, 1)
120:            pvForm.NOKLastName = ResultsArray(0, 2)
130:            pvForm.NOKRefPhone = ResultsArray(0, 3)
140:            pvForm.NOKCity = ResultsArray(0, 5)
150:            pvForm.NOKStateID = ResultsArray(0, 6)
160:            pvForm.NOKZip = ResultsArray(0, 7)
170:            pvForm.NOKApproachRelation = ResultsArray(0, 8)

180:        End If
190:    End If

200:    vQuery = "EXEC SelectState @StateID = " & pvForm.NOKStateID & ";"

        Try
            Result = modODBC.Exec(vQuery, ResultsArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

220:    If Result = SUCCESS Then
230:        pvForm.vStateAbbr = ResultsArray(0, 1)
240:    End If

        'Set the referral information
        'drh FSMod 06/23/03 - Org Notes for Body Care tab
250:    pvForm.rtfOrgSpecialNotes.Text = modConv.NullToText(RS("OrganizationNotes").Value)

        'Call Info
260:    pvForm.CallPhoneNumberID = modConv.NullToText(RS("ReferralCallerPhoneID").Value)

        'Get the phone number based on the ID
270:    Call modStatRefQuery.RefQueryPhone(vReturn, pvForm.CallPhoneNumberID)
280:    For I = 0 To UBound(CtlList, 2)
290:        If CtlList(2, I) = "ReferralCallerPhoneID" Then
300:            pvForm.DataTextArray(CtlList(0, I)).Text = modUtility.BuildPhone(vReturn)
310:            Exit For
320:        End If
330:    Next I

340:    pvForm.OrganizationId = modConv.NullToText(RS("ReferralCallerOrganizationID").Value)

        'Get the organization name
350:    For I = 0 To UBound(CtlList, 2)
360:        If CtlList(2, I) = "ReferralCallerOrganizationID" Then
                'Get the organization name
370:            Call modStatRefQuery.RefQueryOrganization(vResultArray, pvForm.OrganizationId)
                If ObjectIsValidArray(vResultArray, 2, 0, 1) Then
                    'Set the Location text box
380:                pvForm.DataTextArray(CtlList(0, I)).Text = vResultArray(0, 1)
390:                pvForm.txtHospitalName.Text = vResultArray(0, 1)
                    'Set the OrganizationId
400:                pvForm.OrganizationId = vResultArray(0, 0)
                End If

                'Get the time zone of the organization
410:            Call modStatQuery.QueryOrganizationTimeZone(pvForm)
420:            Exit For
430:        End If
440:    Next I

450:    pvForm.SubLocationID = modConv.NullToText(RS("ReferralCallerSubLocationID").Value)

        'Set the Sub Location combo box
460:    For I = 0 To UBound(CtlList, 2)
470:        If CtlList(2, I) = "ReferralCallerSubLocationID" Then
480:            Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), pvForm.SubLocationID)
490:            Exit For
500:        End If
510:    Next I


        For I = 0 To UBound(CtlList, 2)
520:        If CtlList(2, I) = "ReferralCallerSubLocationLevel" Then
530:            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralCallerSubLocationLevel").Value)
540:            Exit For
550:        End If
560:    Next I

580:    pvForm.PersonID = modConv.NullToText(RS("ReferralCallerPersonID").Value)

590:    For I = 0 To UBound(CtlList, 2)
600:        If CtlList(2, I) = "ReferralCallerPersonID" Then

                'Fill the person combo box based on the location ID
610:            Call modStatQuery.QueryLocationPerson(pvForm, , pvForm.DataComboArray(CtlList(0, I)))

620:            If modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), pvForm.PersonID) = False And pvForm.PersonID <> -1 And pvForm.PersonID <> 0 Then
                    'There is a person ID, but it is not in the person list because
                    'the person has been inactivated. Add the person to the list

                    'First get the name of the person
630:                Call modStatRefQuery.RefQueryPerson(vPersonResults, pvForm.PersonID)

                    'Next add the person to the list
640:                Call modControl.SetTextIDItem(pvForm.DataComboArray(CtlList(0, I)), vPersonResults(0, 0), vPersonResults(0, 1))

                    'Last, select the newly added id
650:                Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), pvForm.PersonID)
660:            End If

670:            Exit For
680:        End If
690:    Next I

700:    For I = 0 To UBound(CtlList, 2)
710:        If CtlList(2, I) = "SecondaryPatientContactTitle" Then
                'Get Contact Title (Role/Type)
720:            Call modStatQuery.QueryPersonPersonType(pvForm, pvForm.DataTextArray(CtlList(0, I)))

730:            Exit For
740:        End If
750:    Next I

        'Donor Info
760:    For I = 0 To UBound(CtlList, 2)
770:        If CtlList(2, I) = "ReferralDonorLastName" Then
780:            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorLastName").Value)
790:            Exit For
800:        End If
810:    Next I

820:    For I = 0 To UBound(CtlList, 2)
830:        If CtlList(2, I) = "ReferralDonorFirstName" Then
840:            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorFirstName").Value)
850:            Exit For
860:        End If
870:    Next I

880:    If modConv.NullToText(RS("ReferralDonorLastName").Value) <> "" And modConv.NullToText(RS("ReferralDonorFirstName").Value) <> "" Then
890:        pvForm.Text = pvForm.Text & "     Patient: " & modConv.NullToText(RS("ReferralDonorLastName").Value) & ", " & modConv.NullToText(RS("ReferralDonorFirstName").Value)
900:    End If

910:    For I = 0 To UBound(CtlList, 2)
920:        If CtlList(2, I) = "ReferralDonorRecNumber" Then
930:            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorRecNumber").Value)
940:            Exit For
950:        End If
960:    Next I

970:    For I = 0 To UBound(CtlList, 2)
980:        If CtlList(2, I) = "ReferralDonorSSN" Then
990:            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorSSN").Value)
1000:           Exit For
1010:       End If
1020:   Next I

1030:   For I = 0 To UBound(CtlList, 2)
1040:       If CtlList(2, I) = "ReferralDonorAge" Then
1050:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorAge").Value)
1060:           Exit For
1070:       End If
1080:   Next I

1090:   For I = 0 To UBound(CtlList, 2)
1100:       If CtlList(2, I) = "ReferralDonorAgeUnit" Then
1110:           Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralDonorAgeUnit").Value))
1120:           Exit For
1130:       End If
1140:   Next I

1150:   For I = 0 To UBound(CtlList, 2)
1160:       If CtlList(2, I) = "ReferralDonorRaceID" Then
1170:           Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), CInt(modConv.NullToText(RS("ReferralDonorRaceID").Value)))
1180:           Exit For
1190:       End If
1200:   Next I

1210:   For I = 0 To UBound(CtlList, 2)
1220:       If CtlList(2, I) = "ReferralDonorGender" Then
1230:           Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralDonorGender").Value))
1240:           Exit For
1250:       End If
1260:   Next I

1270:   For I = 0 To UBound(CtlList, 2)
1280:       If CtlList(2, I) = "ReferralDonorWeight" Then
1290:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorWeight").Value)
1300:           Exit For
1310:       End If
1320:   Next I

1330:   For I = 0 To UBound(CtlList, 2)
1340:       If CtlList(2, I) = "ReferralDonorAdmitDate" Then
1350:           pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS("ReferralDonorAdmitDate").Value), "mm/dd/yy")
1360:           Exit For
1370:       End If
1380:   Next I

1390:   For I = 0 To UBound(CtlList, 2)
1400:       If CtlList(2, I) = "ReferralDonorAdmitTime" Then
1410:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorAdmitTime").Value)
1420:           Exit For
1430:       End If
1440:   Next I

1450:   For I = 0 To UBound(CtlList, 2)
1460:       If CtlList(2, I) = "ReferralDonorDeathDate" Then
1470:           pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS("ReferralDonorDeathDate").Value), "mm/dd/yy")
1480:           Exit For
1490:       End If
1500:   Next I

1510:   For I = 0 To UBound(CtlList, 2)
1520:       If CtlList(2, I) = "ReferralDonorDeathTime" Then
1530:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorDeathTime").Value)
1540:           Exit For
1550:       End If
1560:   Next I


        'Char Chaput 05/09/06 added braindeathdatetime for release 8.0
1570:   For I = 0 To UBound(CtlList, 2)
1580:       If CtlList(2, I) = "ReferralDonorBrainDeathDate" Then
1590:           pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS("ReferralDonorBrainDeathDate").Value), "mm/dd/yy")
1600:           Exit For
1610:       End If
1620:   Next I

1630:   For I = 0 To UBound(CtlList, 2)
1640:       If CtlList(2, I) = "ReferralDonorBrainDeathTime" Then
1650:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorBrainDeathTime").Value)
1660:           Exit For
1670:       End If
1680:   Next I


1690:   For I = 0 To UBound(CtlList, 2)
1700:       If CtlList(2, I) = "ReferralDOB" Then
1710:           pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS("ReferralDOB").Value), "mm/dd/yyyy")
1720:           Exit For
1730:       End If
1740:   Next I

1750:   If pvForm.NOKID > 0 Or pvForm.NOK = "" Or IsDBNull(pvForm.NOKID) Then 'No new NOK and no old NOK
            'If pvForm.NOKID > 0 Then
1760:       For I = 0 To UBound(CtlList, 2)
1770:           If CtlList(2, I) = "ReferralNOKStreetAddress" Then
1780:               pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralNOKAddress").Value)
1790:               Exit For
1800:           End If
1810:       Next I

1820:   Else
1830:       For I = 0 To UBound(CtlList, 2)
1840:           If CtlList(2, I) = "ReferralNOKAddress" Then
1850:               pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralNOKAddress").Value)
1860:               Exit For
1870:           End If
1880:       Next I
1890:   End If

1900:   If pvForm.NOKID > 0 Or pvForm.NOK = "" Or IsDBNull(pvForm.NOKID) Then 'No new NOK and no old NOK
1910:       For I = 0 To UBound(CtlList, 2)
1920:           If CtlList(2, I) = "ReferralNOKCity" Then
1930:               pvForm.DataTextArray(CtlList(0, I)).Text = pvForm.NOKCity
1940:               Exit For
1950:           End If
1960:       Next I

1970:       For I = 0 To UBound(CtlList, 2)
1980:           If CtlList(2, I) = "ReferralNOKState" Then
                    'select the state id
1990:               Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), pvForm.NOKStateID)
2000:               Exit For
2010:           End If
2020:       Next I

2030:       For I = 0 To UBound(CtlList, 2)
2040:           If CtlList(2, I) = "ReferralNOKZip" Then
2050:               pvForm.DataTextArray(CtlList(0, I)).Text = pvForm.NOKZip
2060:               Exit For
2070:           End If
2080:       Next I
2090:   End If

2100:   For I = 0 To UBound(CtlList, 2)
2110:       If CtlList(2, I) = "ReferralApproachRelation" Then
2120:           If pvForm.NOKID > 0 Then
2130:               Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), pvForm.NOKApproachRelation)
2140:               Exit For
2150:           Else
2160:               Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralApproachRelation").Value))
2170:               Exit For
2180:           End If
2190:       End If
2200:   Next I


2210:   If pvForm.NOKID > 0 Or pvForm.NOK = "" Or IsDBNull(pvForm.NOKID) Then 'No new NOK and no old NOK

2220:       For I = 0 To UBound(CtlList, 2)
2230:           If CtlList(2, I) = "ReferralNOKFirstName" Then
2240:               pvForm.DataTextArray(CtlList(0, I)).Text = pvForm.NOKFirstName
2250:               Exit For
2260:           End If
2270:       Next I

2280:       For I = 0 To UBound(CtlList, 2)
2290:           If CtlList(2, I) = "ReferralNOKLastName" Then
2300:               pvForm.DataTextArray(CtlList(0, I)).Text = pvForm.NOKLastName
2310:               Exit For
2320:           End If
2330:       Next I

2340:   Else

2350:       For I = 0 To UBound(CtlList, 2)
2360:           If CtlList(2, I) = "ReferralApproachNOK" Then
2370:               pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralApproachNOK").Value)
2380:               Exit For
2390:           End If
2400:       Next I

2410:   End If

2420:   For I = 0 To UBound(CtlList, 2)
2430:       If CtlList(2, I) = "ReferralNOKPhone" Then
2440:           If pvForm.NOKID > 0 Or pvForm.NOK = "" Or IsDBNull(pvForm.NOKID) Then 'No new NOK and no old NOK
2450:               pvForm.DataTextArray(CtlList(0, I)).Text = pvForm.NOKRefPhone
2460:               Exit For
2470:           Else
2480:               pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralNOKPhone").Value)
2490:               Exit For
2500:           End If
2510:       End If
2520:   Next I


        'drh FSMod 06/17/03 - Add for Pt. Ventilated
2530:   For I = 0 To UBound(CtlList, 2)
2540:       If CtlList(2, I) = "ReferralDonorOnVentilator" Then
2550:           Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralDonorOnVentilator").Value))
2560:           Exit For
2570:       End If
2580:   Next I


2590:   For I = 0 To UBound(CtlList, 2)
2600:       If CtlList(2, I) = "ReferralCoronersCase" Then
2610:           If modConv.DBTrueValueToChkValue(modConv.NullToText(RS("ReferralCoronersCase").Value)) = 1 Then
2620:               Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), 1)
2630:           Else
2640:               Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), 3) '9/20/02 drh - Used to select "2"; changed to select "3"
2650:           End If

2660:           Exit For
2670:       End If
2680:   Next I

2690:   For I = 0 To UBound(CtlList, 2)
2700:       If CtlList(2, I) = "ReferralCoronerOrganization" Then
2710:           Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralCoronerOrganization").Value))

2720:           If modConv.NullToText(RS("ReferralCoronerOrganization").Value) <> "" And pvForm.DataComboArray(CtlList(0, I)).Text = "" Then
                    'The selected coroner is not currently in the coroner list
                    'First get the state of the selected coroner, then selected in the state list
2730:               If modStatQuery.QueryCoronerState(RS("ReferralCoronerOrganization").Value, vCoronerState) = SUCCESS Then

2740:                   For j = 0 To UBound(CtlList, 2)
2750:                       If CtlList(2, j) = "ReferralCoronerState" Then
2760:                           Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, j)), vCoronerState(0, 0))
2770:                       End If
2780:                   Next j
2790:               End If
                    'Reset the coroner selection
2800:               Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS("ReferralCoronerOrganization").Value))
2810:           End If

2820:           If pvForm.DataComboArray(CtlList(0, I)).Text <> "" Then
                    'Fill the list with coroner names from the selected coroner
2830:               For j = 0 To UBound(CtlList, 2)
2840:                   If CtlList(2, j) = "ReferralCoronerName" Then
2850:                       pvForm.DataComboArray(CtlList(0, j)).Items.Clear()
2860:                       If modStatQuery.QueryCoroner(modControl.GetID(pvForm.DataComboArray(CtlList(0, I))), vCoronerReturn) = SUCCESS Then
2870:                           Call modControl.SetTextID(pvForm.DataComboArray(CtlList(0, j)), vCoronerReturn)
2880:
                                'ccarroll 11/10/2010 was insert(-1 changed to insert(0
                                pvForm.DataComboArray(CtlList(0, j)).Items.Insert(0, "Not Available")
2890:
2900:                           Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, j)), modConv.NullToText(RS("ReferralCoronerName").Value))
2910:                       End If
2920:                   End If
2930:               Next j

2940:           End If

2950:           Exit For
2960:       End If
2970:   Next I

2980:   For I = 0 To UBound(CtlList, 2)
2990:       If CtlList(2, I) = "ReferralCoronerPhone" Then
3000:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralCoronerPhone").Value)
3010:           Exit For
3020:       End If
3030:   Next I

3040:   For I = 0 To UBound(CtlList, 2)
3050:       If CtlList(2, I) = "ReferralNotesCase" Then
3060:           pvForm.DataRTFArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralNotesCase").Value)
3070:           Exit For
3080:       End If
3090:   Next I

        'drh FSMod 07/16/03 - Added for Attending MD (Referral/Secondary linked)
3100:   For I = 0 To UBound(CtlList, 2)
3110:       If CtlList(2, I) = "ReferralAttendingMD" Then
3120:           Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), CInt(modConv.NullToText(RS("ReferralAttendingMD").Value)))
3130:           Exit For
3140:       End If
3150:   Next I

        'Char Chaput FSMod 05/09/06 Add Triage Specific COD
3160:   For I = 0 To UBound(CtlList, 2)
3170:       If CtlList(2, I) = "ReferralDonorSpecificCOD" Then
3180:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralDonorSpecificCOD").Value)
3190:           Exit For
3200:       End If
3210:   Next I

3220:   For I = 0 To UBound(CtlList, 2)
3230:       If CtlList(2, I) = "ReferralCallerExtension" Then
3240:           pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS("ReferralCallerExtension").Value)
3250:           Exit For
3260:       End If
3270:   Next I
        'pvForm.CallPhoneNumberExt = modConv.NullToText(RS("ReferralCallerExtension").Value)

3280:   pvForm.FormLoad = False
    End Function
    Public Function QuerySecondarySecData(ByRef pvForm As FrmReferralView, ByRef CtlList As Object, ByRef CtlList2 As Object) As Short
        'FSProj drh 6/15/02 - Get Triage Data for Secondary Referral View

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vPersonResults As New Object
        Dim RS As New ADODB.Recordset
        Dim I As Integer
        Dim j As Integer


        'BUILD/RUN THE QUERY (SECONDARY TABLE 1)
        '**************************************************************
        'Add the SELECT Clause
        vQuery = ""

        'Add the FROM/WHERE Clauses
        vQuery = vQuery & "SelectSecondary @CallID = " & pvForm.CallId

        'Run the Query
        Try
            QuerySecondarySecData = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        '**************************************************************

        'drh FSMod 06/13/03 - Updated all index/ranges
        'GET/SET THE SECONDARY INFORMATION FOR THE VARIOUS FIELD TYPES (SECONDARY TABLE 1)
        '**************************************************************
        'Plain Text Format
        For I = 0 To 45
            pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS(I).Value)
        Next I

        'Date Format
        For I = 46 To 57
            If I = 47 Then
                If modConv.NullToText(RS(I).Value) = "" Then
                    'Do nothing
                Else
                    pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS(I).Value), "mm/dd/yy")
                End If
            Else
                pvForm.DataTextArray(CtlList(0, I)).Text = VB6.Format(modConv.NullToText(RS(I).Value), "mm/dd/yy")
            End If
        Next I

        'Time Format
        For I = 58 To 73
            If I = 61 Then
                If modConv.NullToText(RS(I).Value) = "" Then
                    'Do nothing
                Else
                    pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS(I).Value)
                End If
            Else
                pvForm.DataTextArray(CtlList(0, I)).Text = modConv.NullToText(RS(I).Value)
            End If
        Next I

        'Combo SelectId Format
        For I = 74 To 107
            '9/19/02 drh - Added modConv.TextToLng to prevent Type Mismatch error
            'Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, i)), modConv.NullToText(RS(i).Value)
            Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), modConv.TextToLng(modConv.NullToText(RS(I).Value)))
        Next I

        '9/20/02 drh - Added Coroner Case
        'Combo SelectId Format (special case for Coroner Case field)
        For I = 108 To 108
            If modConv.NullToText(RS(I).Value) <> "" Then
                '9/19/02 drh - Added modConv.TextToLng to prevent Type Mismatch error
                'Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, i)), modConv.NullToText(RS(i).Value)
                Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), modConv.TextToLng(modConv.NullToText(RS(I).Value)))
            End If
        Next I

        'Combo/Text Format
        For I = 109 To 110
            If modConv.NullToText(RS(I).Value) = "-1" Then
                pvForm.DataComboArray(CtlList(0, I)).Text = modConv.NullToText(RS(CtlList(2, I)).Value)
            Else
                '9/19/02 drh - Added modConv.TextToLng to prevent Type Mismatch error
                'Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, i)), modConv.NullToText(RS(i).Value)
                Call modControl.SelectID(pvForm.DataComboArray(CtlList(0, I)), modConv.TextToLng(modConv.NullToText(RS(I).Value)))
            End If
        Next I

        'Combo SelectText Format
        For I = 111 To 114
            Call modControl.SelectText(pvForm.DataComboArray(CtlList(0, I)), modConv.NullToText(RS(I).Value))
        Next I

        'Rich Text Format
        For I = 115 To 120
            pvForm.DataRTFArray(CtlList(0, I)).Text = modConv.NullToText(RS(I).Value)
        Next I

        'drh FSMod 06/19/03 - New Format: Checkbox
        For I = 121 To 121
            pvForm.DataCheckboxArray(CtlList(0, I)).Checked = modConv.TextToInt(modConv.NullToText(RS(I).Value))
        Next I
        '**************************************************************








        'BUILD/RUN THE QUERY (SECONDARY2 TABLE 2)
        '**************************************************************
        'Add the SELECT Clause
        vQuery = "SELECT "

        'Add the Control DB fields
        For I = 0 To UBound(CtlList2, 2)
            vQuery = vQuery & IIf(I = 0, "", ",") & CtlList2(1, I)
        Next I

        'Add the FROM/WHERE Clauses
        vQuery = vQuery & " FROM Secondary2 WHERE CallID = " & pvForm.CallId

        'Run the Query
        Try
            QuerySecondarySecData = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        '**************************************************************


        'GET/SET THE SECONDARY INFORMATION FOR THE VARIOUS FIELD TYPES (SECONDARY2 TABLE 2)
        '**************************************************************
        'Plain Text Format
        For I = 0 To 23
            pvForm.DataTextArray(CtlList2(0, I)).Text = modConv.NullToText(RS(I).Value)
        Next I

        'Date Format
        For I = 24 To 35
            pvForm.DataTextArray(CtlList2(0, I)).Text = VB6.Format(modConv.NullToText(RS(I).Value), "mm/dd/yy")
        Next I

        'Time Format
        For I = 36 To 38
            pvForm.DataTextArray(CtlList2(0, I)).Text = modConv.NullToText(RS(I).Value)
        Next I

        'Combo SelectId Format
        For I = 39 To 39
            '9/19/02 drh - Added modConv.TextToLng to prevent Type Mismatch error
            'Call modControl.SelectID(pvForm.DataComboArray(CtlList2(0, i)), modConv.NullToText(RS(i).Value)
            Call modControl.SelectID(pvForm.DataComboArray(CtlList2(0, I)), modConv.TextToLng(modConv.NullToText(RS(I).Value)))
        Next I

        'Combo/Text Format
        For I = 40 To 51
            If modConv.NullToText(RS(I).Value) = "-1" Then
                pvForm.DataComboArray(CtlList2(0, I)).Text = modConv.NullToText(RS(CtlList2(2, I)).Value)
            Else
                '9/19/02 drh - Added modConv.TextToLng to prevent Type Mismatch error
                'Call modControl.SelectID(pvForm.DataComboArray(CtlList2(0, i)), modConv.NullToText(RS(i).Value)
                Call modControl.SelectID(pvForm.DataComboArray(CtlList2(0, I)), modConv.TextToLng(modConv.NullToText(RS(I).Value)))
            End If
        Next I

        'Combo SelectText Format
        For I = 52 To 69
            Call modControl.SelectText(pvForm.DataComboArray(CtlList2(0, I)), modConv.NullToText(RS(I).Value))
        Next I
        '**************************************************************



        'BUILD/RUN THE QUERY (SECONDARY MEDICATIONS)
        '**************************************************************
        Call modStatRefQuery.SecQueryAvailableMedication(pvForm)
        Call modStatRefQuery.SecQuerySelectedMedication(pvForm)
        '**************************************************************

        'drh FSMod 06/11/03 - Get Med types (ie. Steroid, Antibiotic, etc.)
        'BUILD/RUN THE QUERY (SECONDARY MEDICATION TYPES)
        '**************************************************************
        For forLoop As Short = 0 To pvForm.DataItemListArray.Count - 1
            If pvForm.DataItemListArray(forLoop).Enabled Then
                Call pvForm.DataItemListArray(forLoop).getSelected(pvForm.CallId)
            End If
        Next forLoop
        '**************************************************************

        'drh FSMod 06/23/03 - Get Eye Care Reminder
        'BUILD/RUN THE QUERY (SERVICELEVEL EYE CARE REMINDER)
        '**************************************************************
        Call modStatRefQuery.SecQueryServiceLevel(pvForm)
        '**************************************************************


        '04/03/03 drh - Commented this section out because the field was removed; Will probably add back later
        '    'BUILD/RUN THE QUERY (SECONDARY MISC)
        '    '**************************************************************
        '    'Add the SELECT Clause
        '    vQuery = "SELECT SecondaryWhoAreWe FROM Secondary WHERE CallID = " & pvForm.CallId
        '
        '    'Run the Query
        '    QuerySecondarySecData = modODBC.Exec(vQuery, vParams, , True, RS)
        '
        '    'Set the text field
        '    pvForm.txtWhoAreWe.Text = modConv.NullToText(RS("SecondaryWhoAreWe").Value)
        '    '**************************************************************

        'BUILD/RUN THE QUERY (FSCASE MISC)
        '**************************************************************
        'Add the SELECT Clause
        vQuery = "SELECT SecondaryManualBillPersonId, SecondaryUpdatedFlag FROM FSCase WHERE CallID = " & pvForm.CallId

        'Run the Query
        Try
            QuerySecondarySecData = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the variables
        pvForm.SecondaryAutoBill = IIf(modConv.TextToInt(modConv.NullToText(RS("SecondaryManualBillPersonId").Value)) > 0, False, True)
        pvForm.SecondaryUpdated = modConv.TextToInt(modConv.NullToText(RS("SecondaryUpdatedFlag").Value))
        '**************************************************************

    End Function



    Public Function QueryServiceLevelId(ByRef pvCallId As Integer) As Short
        'FSProj drh 6/15/02 See if Secondary records exist for this Call

        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Does the Secondary already exist?
        vQuery = "EXEC SelectServiceLevelByCallId @CallId = " & pvCallId & ";"
        Try
            QueryServiceLevelId = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryServiceLevelId = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
            QueryServiceLevelId = vReturn(0, 0)
        End If

    End Function

    Public Function QueryReferralTriageCriteria(ByRef pvForm As FrmReferral) As Short
        'FSProj drh 4/30/02 - New function to get Triage Criteria ID's for historical criteria purposes

        Dim vQuery As New Object
        Dim vParams As New Object
        Dim vReturn As New Object
        Dim vCoronerReturn As New Object
        Dim vCoronerState As New Object
        Dim vResultArray As New Object
        Dim vPersonResults As New Object
        Dim RS As New Object

        vQuery = "EXEC SelectCallCriteria @CallID = " & pvForm.CallId & ";"

        Try
            QueryReferralTriageCriteria = modODBC.Exec(vQuery, vParams, , True, RS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the referral criteria information

        'FSProj drh 4/30/02 - Before we start, loop through Triage Options and add the applicable Criteria to the Referral Criteria ID collection if necessary
        '*************************************************************************************
        Dim I As Integer
        'note: add clear collection
        If Not RS.EOF Then
            'Clear the Criteria
            Call pvForm.ClearCriteria()

            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("OrganCriteriaID").Value), CStr(ORGAN))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("BoneCriteriaID").Value), CStr(BONE))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("TissueCriteriaID").Value), CStr(TISSUE))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("SkinCriteriaID").Value), CStr(SKIN))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("ValvesCriteriaID").Value), CStr(VALVES))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("EyesCriteriaID").Value), CStr(EYES))
            Call pvForm.ReferralTriageCriteria.Add(CInt(RS("OtherCriteriaID").Value), CStr(RESEARCH))

            'Get Service LevelId
            pvForm.ServiceLevelId = CInt(RS("ServiceLevelID").Value)

        Else
            'Populate the collection with zero's
            For I = ORGAN To RESEARCH
                Call pvForm.ReferralTriageCriteria.Add(0, CStr(I))
            Next I
        End If
        '*************************************************************************************


        Exit Function

    End Function

#Region "Referral"
    Public Function QueryReferralID(ByVal pvCallId As Integer, Optional ByRef prReferralID As Integer = 0) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vReturn As New Object

        vQuery = "SELECT ReferralID FROM Referral " & "WHERE CallID = " & pvCallId & ";"

        Try
            QueryReferralID = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryReferralID = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            prReferralID = CInt(vParams(0, 0))
        End If

    End Function
#End Region
    Public Function QueryDonorTracClient(ByRef pvForm As FrmReferralView) As Short
        '***********************************************************************
        'T.T 01/15/2007
        'Module:modStatQuery.QueryDonorTracClient
        'Parameters:    pvform
        'Definition:    This function will identify whether an organization is a donortrac client
        '***********************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT SourcecodeDonorTracClient FROM SourceCode " & "WHERE SourcecodeID = " & pvForm.SourceCode.ID & ";"

        Try
            QueryDonorTracClient = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryDonorTracClient = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            pvForm.DonorTracClient = vParams(0, 0)
        End If

    End Function
    Public Function QueryCallWebPersonPass(ByRef pvForm As FrmReferralView) As String
        '***********************************************************************
        'T.T 05/10/2007
        'Module:modStatQuery.QueryCallWebPersonPass
        'Parameters:    pvform
        'Definition:    This function will return the user name
        '***********************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "select webpersonpassword from webperson where personID =  " & pvForm.CallOpenbyPersonID & ";"

        Try
            QueryCallWebPersonPass = CStr(modODBC.Exec(vQuery, vParams))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If CDbl(QueryCallWebPersonPass) = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            pvForm.CallOpenbyWebPersonPassword = vParams(0, 0)

        End If

    End Function
    Public Function QueryCallDonorTracURL(ByRef pvForm As FrmReferralView, ByRef SourceCode As String) As String
        '***********************************************************************
        'T.T 05/10/2007
        'Module:modStatQuery.QQueryCallDonorTracURL
        'Parameters:    pvform
        'Definition:    This function will return the QueryCallDonorTracURL
        '***********************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "select DonorTracProductionURL,SourceCode from DonorTracURL where Sourcecode = '" & SourceCode & "'"

        Try
            Call modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If CDbl(QueryCallDonorTracURL) = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 1) Then
            pvForm.URL = vParams(0, 0)
            pvForm.DonorTracSourceCode = vParams(0, 1)
        End If

    End Function
    Public Function QueryCallOpenByName(ByRef pvForm As FrmReferralView) As String
        '***********************************************************************
        'T.T 01/15/2007
        'Module:modStatQuery.QueryCallOpenbyName
        'Parameters:    pvform
        'Definition:    This function will return the user name
        '***********************************************************************

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "select StatEmployeeUserID,PersonID from statemployee where statemployeeID =  " & pvForm.CallOpenByID & ";"

        Try
            QueryCallOpenByName = CStr(modODBC.Exec(vQuery, vParams))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If CDbl(QueryCallOpenByName) = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 1) Then
            pvForm.CallOpenByName = vParams(0, 0)
            pvForm.CallOpenbyPersonID = vParams(0, 1)
        End If

    End Function
    Public Function QueryReferralOrganizationID(ByRef pvForm As FrmReferralView) As Short
        'drh FSMod 06/16/03 - New function

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT ReferralCallerOrganizationID FROM Referral " & "WHERE CallID = " & pvForm.CallId & ";"

        Try
            QueryReferralOrganizationID = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryReferralOrganizationID = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            pvForm.OrganizationId = vParams(0, 0)
        End If

    End Function




    Public Function QueryMessageID(ByVal pvCallId As Integer, Optional ByRef prMessageID As Integer = 0) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT MessageID FROM Message " & "WHERE CallID = " & pvCallId & ";"

        Try
            QueryMessageID = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryMessageID = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            prMessageID = CInt(vParams(0, 0))
        End If

    End Function


    Public Function QueryNoCallID(ByVal pvCallId As Integer, Optional ByRef prNoCallID As Integer = 0) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT NoCallID FROM NoCall " & "WHERE CallID = " & pvCallId & ";"

        Try
            QueryNoCallID = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryNoCallID = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 0) Then
            prNoCallID = CInt(vParams(0, 0))
        End If

    End Function


    Public Function QueryMessage(ByRef pvForm As FrmMessage) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim vResultArray As New Object

        vQuery = "EXEC SelectMessage @CallID = " & pvForm.CallId & ";"

        Try
            QueryMessage = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 15) Then
            'Set the message information
            pvForm.LblName.Text = vParams(0, 2)
            pvForm.LblPhone.Text = vParams(0, 3)
            pvForm.LblOrganization.Text = vParams(0, 4)
            Call modControl.SelectID(pvForm.CboMessageType, CInt(vParams(0, 7)))
            pvForm.OrganizationId = vParams(0, 5)
            Call modStatRefQuery.RefQueryOrganization(vResultArray, pvForm.OrganizationId)
            Call modControl.SetTextID(pvForm.CboOrganization, vResultArray, True)
            Call modControl.SelectID(pvForm.CboOrganization, pvForm.OrganizationId)

            If modControl.SelectID(pvForm.CboName, CInt(vParams(0, 6))) = False And CDbl(vParams(0, 6)) <> -1 And CDbl(vParams(0, 6)) <> 0 Then
                'There is a person ID, but it is not in the person list because
                'the person has been inactivated. Add the person to the list

                'First get the name of the person
                Call modStatRefQuery.RefQueryPerson(vResultArray, vParams(0, 6))

                'Next add the person to the list
                Call modControl.SetTextIDItem(pvForm.CboName, vResultArray(0, 0), vResultArray(0, 1))

                'Last, select the newly added id
                Call modControl.SelectID(pvForm.CboName, CInt(vParams(0, 6)))
            End If

            pvForm.MessageTypeID = vParams(0, 7)
            pvForm.ChkUrgent.Checked = modConv.DBTrueValueToChkValue(vParams(0, 8))
            pvForm.TxtMessage.Text = vParams(0, 9)

            pvForm.LblExtension.Text = vParams(0, 12)
            pvForm.TxtImportPatient.Text = vParams(0, 13)
            pvForm.TxtUNOSID.Text = vParams(0, 14)
            pvForm.TxtImportCenter.Text = vParams(0, 15)
        End If

    End Function
    Public Function QueryNoCall(ByRef pvForm As FrmNoCall) As Short

        Dim vQuery As String = ""
        Dim vParams As New Object

        vQuery = "EXEC SelectNoCall @CallID = " & pvForm.CallId & ";"

        Try
            QueryNoCall = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 3) Then
            'Retrieve the nocall information
            pvForm.CallId = vParams(0, 1)
            Call modControl.SelectID(pvForm.CboNoCallType, CInt(vParams(0, 2)))
            pvForm.TxtDescription.Text = vParams(0, 3)
        End If

    End Function
#Region "AppMain"
    Public Function QueryEmployeeLogin_Integrated(ByRef pvUserId As String, ByRef prResults As Object) As Short

        Dim vQuery As String = ""
        vQuery = "EXEC StatEmployeeLoginIntegratedSelect @StatEmployeeUserID = " & modODBC.BuildField(pvUserId) & ";"

        Try
            QueryEmployeeLogin_Integrated = modODBC.Exec(vQuery, prResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function LeaseOrganizationType(ByRef LeaseOrgNum As Short, ByRef prResults As Object) As String
        '***********************************************************************
        'T.T 05/18/2004
        'Module:modStatQuery.LeaseOrganization
        'Parameters:    LeaseOrgNum - Lease Organization number
        '               prResults   - Returned Results from query
        'Definition:    This Function accepts LeaseOrgNum and runs sps_LeaseOrganizationTypev
        '               Which checks a truth table to determine what kind of lease Organization
        '***********************************************************************
        'T.T added function to get bitwize lease Organization
        Dim vQuery As String = ""
        Dim LeaseOrgType As Short
        Dim vParam As New Object

        vQuery = "sps_LeaseOrganizationTypev "



        vQuery = vQuery & LeaseOrgNum & ";"

        Try
            LeaseOrganizationType = CStr(modODBC.Exec(vQuery, prResults))
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function QueryDBServerInfo(ByRef prDBServerInfo As String) As Short
        '1/14/03 drh - Use this function to get DB and Server name for the current connection

        Dim vQuery As String = ""
        Dim vParams As New Object
        vParams = New Object()

        vQuery = "EXEC sps_GetServerDB" & ";"

        Try
            QueryDBServerInfo = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryDBServerInfo = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 1) Then
            prDBServerInfo = vParams(0, 0) & "\" & vParams(0, 1)
        End If

    End Function
#End Region

#Region "MDIForm"
    Public Function QueryTimeZoneDif(ByRef timeZoneName As String, Optional ByRef setDate As String = "") As Short
        Dim vQuery As String = ""
        Dim tzDif As Short
        Dim vParam As New Object
        vParam = New Object()

        vQuery = "spf_StatTZDif " & IIf(Len(timeZoneName) > 0, timeZoneName, "MT")

        If (Len(setDate) > 0) Then
            vQuery = vQuery & ", " & setDate & ";"
        End If

        Try
            tzDif = modODBC.Exec(vQuery, vParam)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParam, 2, 0, 0) Then
            QueryTimeZoneDif = vParam(0, 0)
        End If

    End Function

#End Region
    Public Function QueryPersonPersonType(ByRef pvForm As Object, Optional ByRef pvCtl As Object = Nothing) As Short
        'FSProj drh 6/15/02 - Added pvCtl parameter

        Dim vQuery As String = ""
        Dim vResult As New Object


        vQuery = "SELECT DISTINCT PersonType.PersonTypeName " & "FROM Person INNER JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID " & "WHERE Person.PersonID = " & pvForm.PersonID & " ;"

        Try
            QueryPersonPersonType = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vResult, 2, 0, 0) Then
            'FSProj drh 6/15/02 - Control depends on form
            'Release 8.0 c.chaput 05/13/05 - Added "FrmNew"
            If pvForm.Name = "FrmNew" Then
                pvForm.TxtPersonType.Text = vResult(0, 0)
            ElseIf pvForm.Name = "FrmReferral" Then
                pvForm.LblPersonType.Text = vResult(0, 0)
            ElseIf pvForm.Name = "FrmReferralView" Then
                pvCtl.Text = vResult(0, 0)
            End If
        End If
    End Function




    Public Function QueryPendingEvents(ByRef pvForm As Object) As Short

        Dim vQuery As String = ""
        Dim vPendingList As New Object

        'Get the pending page events
        vQuery = "EXEC QueryPendingEventSelect @CallID = " & pvForm.CallId & ";"

        Try
            QueryPendingEvents = modODBC.Exec(vQuery, vPendingList)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            QueryPendingEvents = SQL_ERROR
        End Try

        If QueryPendingEvents = SUCCESS Then

            Call modControl.SetListViewRows(vPendingList, True, pvForm.LstViewPending, False, False, pvForm)

        End If

    End Function

    Public Function QueryCreateConsentPending(ByRef pvForm As FrmReferral, Optional ByRef prResult As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vResult As New Object
        Dim vReturn As Short

        'This procedure checks to see if a consent pending should be created for the
        'referral organization.

        'First, check if there is a current pending consent
        vQuery = "SELECT LogEventID FROM LogEvent " & "WHERE LogEventTypeID = " & CONSENT_PENDING & " " & "AND LogEvent.CallID = " & pvForm.CallId & " " & "AND LogEvent.LogEventCallbackPending = -1 " & "AND LogEvent.OrganizationID = " & pvForm.OrganizationId

        Try
            vReturn = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case vReturn

            Case NO_DATA
                'There is no current consent pending. Before creating one, check if there
                'is an existing consent outcome for the organization indicating a consent
                'pending has already been created and closed.
                vQuery = "SELECT LogEventID FROM LogEvent " & "WHERE LogEventTypeID = " & CONSENT_RESPONSE & " " & "AND LogEvent.CallID = " & pvForm.CallId & " " & "AND LogEvent.OrganizationID = " & pvForm.OrganizationId

                Try
                    vReturn = modODBC.Exec(vQuery, vResult)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                Select Case vReturn

                    Case NO_DATA
                        'There is no consent outcome so create a new consent pending
                        QueryCreateConsentPending = CREATE_CONSENT_PENDING

                    Case SUCCESS
                        'A consent pending has already been created and closed, so do not
                        'create another one.
                        QueryCreateConsentPending = CONSENT_PENDING_CLOSED

                    Case Else
                        QueryCreateConsentPending = CREATE_CONSENT_PENDING

                End Select

            Case SUCCESS
                'There is a current consent pending so do not create another one
                QueryCreateConsentPending = CONSENT_PENDING_CURRENT
                prResult = VB6.CopyArray(vResult)

            Case Else
                QueryCreateConsentPending = CREATE_CONSENT_PENDING

        End Select

    End Function


    Public Function QueryCreateStatlineConsentPending(ByRef pvForm As FrmReferral, Optional ByRef prResult As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vParams() As String
        Dim vResult As New Object
        Dim vReturn As Short

        'This procedure checks to see if a consent pending should be created for the
        'referral organization.

        'First, check if there is a current pending consent
        vQuery = "SELECT LogEventID FROM LogEvent " & "WHERE LogEventTypeID = " & CONSENT_PENDING & " " & "AND LogEvent.CallID = " & pvForm.CallId & " " & "AND LogEvent.LogEventCallbackPending = -1 " & "AND LogEvent.OrganizationID = 194 "

        Try
            vReturn = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case vReturn

            Case NO_DATA
                'There is no current consent pending. Before creating one, check if there
                'is an existing consent outcome for the organization indicating a consent
                'pending has already been created and closed.
                vQuery = "SELECT LogEventID FROM LogEvent " & "WHERE LogEventTypeID = " & CONSENT_RESPONSE & " " & "AND LogEvent.CallID = " & pvForm.CallId & " " & "AND LogEvent.OrganizationID = 194 "

                Try
                    vReturn = modODBC.Exec(vQuery, vResult)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                Select Case vReturn

                    Case NO_DATA
                        'There is no consent outcome so create a new consent pending
                        QueryCreateStatlineConsentPending = CREATE_CONSENT_PENDING

                    Case SUCCESS
                        'A consent pending has already been created and closed, so do not
                        'create another one.
                        QueryCreateStatlineConsentPending = CONSENT_PENDING_CLOSED

                    Case Else
                        QueryCreateStatlineConsentPending = CREATE_CONSENT_PENDING

                End Select

            Case SUCCESS
                'There is a current consent pending so do not create another one
                QueryCreateStatlineConsentPending = CONSENT_PENDING_CURRENT
                prResult = VB6.CopyArray(vResult)

            Case Else
                QueryCreateStatlineConsentPending = CREATE_CONSENT_PENDING

        End Select

    End Function
    Public Function QueryCreateSecondaryPending(ByRef pvForm As Object, Optional ByRef prResult As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturn As Short

        'This procedure checks to see if a Secondary pending should be created for the
        'referral organization.

        'First, check if there is a current pending Secondary
        vQuery = "EXEC SelectLogEvent @LogEventTypeID = " & SECONDARY_PENDING & ", @CallID = " & pvForm.CallId & ", @LogEventCallbackPending = -1, @OrganizationID = 194;"
        Try
            vReturn = modODBC.Exec(vQuery, vResult)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case vReturn

            Case NO_DATA
                'There is no current Secondary pending. Before creating one, check if there
                'is an existing Secondary outcome for the organization indicating a Secondary
                'pending has already been created and closed.
                vQuery = "Exec SelectLogEvent @LogEventTypeID = " & SECONDARY_RESPONSE & ", @CallID = " & pvForm.CallId & ", @OrganizationID = 194;"

                Try
                    vReturn = modODBC.Exec(vQuery, vResult)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                Select Case vReturn

                    Case NO_DATA
                        'There is no Secondary outcome so create a new Secondary pending
                        QueryCreateSecondaryPending = CREATE_SECONDARY_PENDING

                    Case SUCCESS
                        'A Secondary pending has already been created and closed, so do not
                        'create another one.
                        QueryCreateSecondaryPending = SECONDARY_PENDING_CLOSED

                    Case Else
                        QueryCreateSecondaryPending = CREATE_SECONDARY_PENDING

                End Select

            Case SUCCESS
                'There is a current Secondary pending so do not create another one
                QueryCreateSecondaryPending = SECONDARY_PENDING_CURRENT
                prResult = VB6.CopyArray(vResult)

            Case Else
                QueryCreateSecondaryPending = CREATE_SECONDARY_PENDING

        End Select

    End Function


    Public Function QueryCauseOfDeathPotential(ByRef pvCauseOfDeathID As Object, ByRef pvPotential As Boolean) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT CauseOfDeath.CauseOfDeathOrganPotential FROM CauseOfDeath " & "WHERE CauseOfDeath.CauseOfDeathID = " & pvCauseOfDeathID & ";"

        Try
            QueryCauseOfDeathPotential = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set the data
        If ObjectIsValidArray(vReturn, 2, 0, 0) _
            AndAlso vReturn(0, 0) = 0 Then
            pvPotential = False
        Else
            pvPotential = True
        End If

    End Function

    Public Function QueryCauseOfDeathCoronerCase(ByRef pvCauseOfDeathID As Object, ByRef pvCoronerCase As Boolean) As Short

        Dim vQuery As New Object
        Dim vReturn As New Object

        vQuery = "SELECT CauseOfDeath.CauseOfDeathCoronerCase FROM CauseOfDeath " & "WHERE CauseOfDeath.CauseOfDeathID = " & pvCauseOfDeathID & ";"

        Try
            QueryCauseOfDeathCoronerCase = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vReturn, 2, 0, 0) Then
            'Set the data
            If vReturn(0, 0) = 0 Then
                pvCoronerCase = False
            ElseIf vReturn(0, 0) = -1 Then
                pvCoronerCase = True
            End If
        End If

    End Function

    Public Sub QueryKeyCodePhrase(ByRef textBox As Object, ByRef KeyAscii As Short)

        Dim vEndPosition As Short
        Dim I As Short
        Dim vChar As String = ""
        Dim vLastWord As String = ""
        Dim vNewPhrase As String = ""
        Dim vCurrentText As String = ""
        Dim vStart As Short
        Dim Query As String = ""
        Dim vReturn As Short
        Dim vResultsArray As New Object

        I = 0
        vChar = ""
        vCurrentText = textBox.Text

        If KeyAscii = 32 Or KeyAscii = 44 Then

            'Find the current position
            vEndPosition = Len(vCurrentText)

            'Find the beginning of the last word
            While vChar <> " " And (vEndPosition - I <> 0)
                vChar = Mid(vCurrentText, vEndPosition - I, 1)
                I = I + 1
            End While

            'Get the last word
            If vEndPosition - I = 0 Then
                vStart = vEndPosition - I + 1
            Else
                vStart = vEndPosition - I + 2
            End If

            vLastWord = Mid(vCurrentText, vStart, I)

            'Lookup if there is a key code
            Query = "SELECT KeyCodeNote FROM KeyCode WHERE KeyCodeName = " & modODBC.BuildField(vLastWord)

            Try
                vReturn = modODBC.Exec(Query, vResultsArray)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vReturn = SUCCESS _
                AndAlso ObjectIsValidArray(vResultsArray, 2, 0, 0) Then
                vNewPhrase = vResultsArray(0, 0)
                textBox.Text = Left(vCurrentText, vStart - 1) & vNewPhrase
                'FIXIT: Whenever possible replace ActiveForm or ActiveControl with an early-bound variable     FixIT90210ae-R1614-RCFE85
                textBox.SelectionStart = Len(textBox.Text)
                KeyAscii = 0
            End If


        End If

    End Sub

    Public Function QueryScheduleOverlap(ByVal pScheduleGroupID As Object, ByVal pScheduleItemID As Object, ByVal pStartDateTime As Object, ByVal pEndDateTime As Object) As Short

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim prData As New Object
        Dim vTimeZoneDif As Short
        Dim vStartDateTime As New Object
        Dim vEndDateTime As New Object

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vStartDateTime = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, pStartDateTime)
        vEndDateTime = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, pEndDateTime)


        'First if any other schedule shifts start or end between the shift being checked
        vQuery = "SELECT ScheduleItemID, ScheduleGroupID, ScheduleItemName, " & "DATEADD(hh, " & vTimeZoneDif & ", ScheduleItemStartDate + ' ' + ScheduleItemStartTime), " & "DATEADD(hh, " & vTimeZoneDif & ", ScheduleItemEndDate + ' ' + ScheduleItemEndTime) " & "FROM ScheduleItem " & "WHERE ScheduleGroupID = " & pScheduleGroupID & " "

        If pScheduleItemID > 0 Then
            vQuery = vQuery & "AND ScheduleItemID <> " & pScheduleItemID & " "
        End If

        vQuery = vQuery & "AND ( " & "(CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS DateTime) > CAST('" & vStartDateTime & "' AS DateTime) " & "AND CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS DateTime) < CAST('" & vEndDateTime & "' AS DateTime)) " & "OR " & "(CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS DateTime) > CAST('" & vStartDateTime & "' AS DateTime) " & "AND CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS DateTime) < CAST('" & vEndDateTime & "' AS DateTime)) " & " ) "

        Try
            QueryScheduleOverlap = modODBC.Exec(vQuery, prData)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'If there are no overlaps by the new shift, check if there are any overlaps by existing shifts
        If QueryScheduleOverlap = 100 Then

            vQuery = "SELECT ScheduleItemID, ScheduleGroupID, ScheduleItemName, " & "DATEADD(hh, " & vTimeZoneDif & ", ScheduleItemStartDate + ' ' + ScheduleItemStartTime), " & "DATEADD(hh, " & vTimeZoneDif & ", ScheduleItemEndDate + ' ' + ScheduleItemEndTime) " & "FROM ScheduleItem " & "WHERE ScheduleGroupID = " & pScheduleGroupID & " "

            If pScheduleItemID > 0 Then
                vQuery = vQuery & "AND ScheduleItemID <> " & pScheduleItemID & " "
            End If

            vQuery = vQuery & "AND CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS DateTime) < CAST('" & vStartDateTime & "' AS DateTime) " & "AND CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS DateTime) > CAST('" & vEndDateTime & "' AS DateTime) "

            Try
                QueryScheduleOverlap = modODBC.Exec(vQuery, prData)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function



    Public Function QueryCallBack(ByRef prData As Object, ByRef pvOrganizationId As Object, Optional ByRef pvPhoneID As Object = Nothing, Optional ByRef pvCallBackID As Object = Nothing) As Object

        Dim vQuery As String = ""
        Dim vResult As New Object

        vQuery = "SELECT CallBack.PhoneID, CallBackID, OrganizationID, PhoneAreaCode, PhonePrefix, PhoneNumber " & "From CallBack JOIN Phone ON Phone.PhoneID = CallBack.PhoneID "

        If Not IsNothing(pvOrganizationId) Then
            vQuery = vQuery & "WHERE OrganizationID = '" & pvOrganizationId & "' "
        End If

        Try
            QueryCallBack = modODBC.Exec(vQuery, prData)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
    End Function

    Public Function QueryLOCall(ByRef pvForm As FrmReferral, Optional ByRef prReturn As Object = Nothing) As Short

        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT LOCallID, LOCallTotalTime FROM LOCall " & "WHERE CallID = " & pvForm.CallId & ";"

        Try
            QueryLOCall = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryLOCall = SUCCESS _
            AndAlso ObjectIsValidArray(vParams, 2, 0, 1) Then

            'Set the call data
            pvForm.LOCallID = vParams(0, 0)
            pvForm.LOCallTotalTime = vParams(0, 1)

            prReturn = VB6.CopyArray(vParams)

        End If

        Exit Function

    End Function

    Public Function QueryIndicationRuleOut(ByRef Ind As String, Optional ByRef prReturn As Object = Nothing) As Short
        '***********************************************************************
        'T.T 12/06/2006
        'Module:modStatQuery.QueryIndicationRuleOut
        'Parameters:    pvForm - NA
        '
        '
        'Definition:    This function will query the indication ruleout for age and weight
        '***********************************************************************
        Dim vQuery As New Object
        Dim vParams As New Object

        vQuery = "SELECT indicationID  from Indication " & "WHERE IndicationName = '" & Ind & "' and IndicationNote = 'RuleOut Reason'"

        Try
            QueryIndicationRuleOut = modODBC.Exec(vQuery, vParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(vParams, 2, 0, 0) Then
            QueryIndicationRuleOut = CShort(vParams(0, 0))
        End If

        prReturn = VB6.CopyArray(vParams)

    End Function


    Public Function QueryDonorDSN(ByRef DSNID As Short) As String
        '03/12/03 this query is used to query a known donors information for the logevent

        Dim vQuery As New Object 'query string
        Dim vRS As New Object 'record set of query from the registry database
        Dim vResult As New Object 'used to capture the result of the open connection and exec in ODBC




        vQuery = "SELECT DRDSNODBC FROM drdsn WHERE DRDSNID = " & DSNID


        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Not vRS.EOF Then
            'found
            vRS.MoveFirst()
            QueryDonorDSN = vRS("DRDSNODBC").Value
        Else
            'No registry database found
            QueryDonorDSN = ""
        End If




        Exit Function


    End Function



    Public Function LeaseOrgExists(ByRef OrgID As Short, ByRef OrgName As String, ByRef prResults As Object) As Short
        '***********************************************************************
        'T.T(5 / 18 / 2004)
        'Module:modStatQuery.LeaseOrgExists
        'Parameters:    OrgNum - Lease Organization number
        '               OrgName - Lease Organization Name
        '               prResults   - Returned Results from query
        'Definition:    This Function accepts OrgID and checks to see if the organization exists in the
        '               LeaseOrganization table (Bitwise) If the organization does not exists. It will
        '               put the organization into the table.
        '***********************************************************************


        Dim vReturnCode As New Object
        Dim vQuery As String = ""

        vQuery = "Select count(*) from LeaseOrganization where leaseOrganizationID = " & OrgID
        Try
            vReturnCode = modODBC.Exec(vQuery, prResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ObjectIsValidArray(prResults, 2, 0, 0) _
            AndAlso prResults(0, 0) < 1 Then 'This means the organization does NOT exist in the LeaseOrganization Table T.T 5/15/2004
            vQuery = "insert into LeaseOrganization values (" & OrgID & ", '" & OrgName & "',1,Default,Default)"
            vReturnCode = modODBC.Exec(vQuery)
        End If
    End Function

End Module
