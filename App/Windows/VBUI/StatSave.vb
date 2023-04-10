Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework
Imports Statline.Stattrac.Framework.Validater

Module modStatSave

    Public Function SaveNDRICallSheet(ByRef pvForm As FrmNDRICallSheet, Optional ByRef pvOther As Object = Nothing, Optional ByRef pvNote As Object = Nothing) As Integer

        Dim vValues As String = ""
        Dim vQuery As New Object
        Dim vReturn As Short
        Dim vLogEventID As String = ""
        Dim vResults As New Object
        Dim vArraySize As Short

        'Get the log data
        Dim vParams(31) As Object
        Dim vFields(31) As Object

        vParams(0) = pvForm.CallId
        vParams(1) = pvForm.TxtCallDate.Text
        vParams(2) = pvForm.txtCallTime.Text
        vParams(3) = pvForm.TxtDonorNumber.Text
        vParams(4) = pvForm.txtCoordName.Text
        vParams(5) = pvForm.txtSource.Text
        vParams(6) = pvForm.TxtSourcePhone.Text
        vParams(7) = pvForm.TxtAge.Text
        vParams(8) = pvForm.CboAgeUnit.Text
        vParams(9) = modControl.GetID(pvForm.cboRace)
        vParams(10) = pvForm.CboGender.Text
        vParams(11) = modControl.GetID(pvForm.cboABO_Rh)
        vParams(12) = modControl.GetID(pvForm.cboCOD_S)
        vParams(13) = pvForm.txtDOD.Text
        vParams(14) = pvForm.txtTOD.Text
        vParams(15) = pvForm.txtCD4.Text
        vParams(16) = pvForm.txtViralLoad.Text
        vParams(17) = pvForm.txtOtherDiseases.Text
        vParams(18) = modControl.GetID(pvForm.cboSepsis)
        vParams(19) = modControl.GetID(pvForm.cboRadiation)
        vParams(20) = modControl.GetID(pvForm.cboChemotherapy)
        vParams(21) = modControl.GetID(pvForm.cboSubstanceAbuse)
        vParams(22) = pvForm.txtMedHxOther.Text
        vParams(23) = pvForm.txtAttendingHospital.Text
        vParams(24) = pvForm.txtAttendingNurse.Text
        vParams(25) = pvForm.txtAttendingPhysician.Text
        vParams(26) = pvForm.TxtAttendingPhone.Text
        vParams(27) = modControl.GetID(pvForm.cboFamilyAtHospital)
        vParams(28) = modControl.GetID(pvForm.cboFamilyKnowsStatus)
        vParams(29) = pvForm.txtFuneralHome.Text
        vParams(30) = pvForm.txtAdditionalComments.Text
        vParams(31) = pvForm.cboCOD_S.Text

        'Specify the field names
        vFields(0) = "CallID"
        vFields(1) = "CallDate"
        vFields(2) = "CallTime"
        vFields(3) = "DonorNumber"
        vFields(4) = "CoordinatorName"
        vFields(5) = "Source"
        vFields(6) = "SourcePhone"
        vFields(7) = "Age"
        vFields(8) = "AgeUnit"
        vFields(9) = "RaceId"
        vFields(10) = "Gender"
        vFields(11) = "ABO_RH"
        vFields(12) = "COD_S"
        vFields(13) = "DOD"
        vFields(14) = "TOD"
        vFields(15) = "CD4"
        vFields(16) = "Viral_Load"
        vFields(17) = "OtherDiseases"
        vFields(18) = "Sepsis"
        vFields(19) = "Radiation"
        vFields(20) = "Chemotherapy"
        vFields(21) = "SubstanceAbuse"
        vFields(22) = "MedHxOther"
        vFields(23) = "AttendingHospital"
        vFields(24) = "AttendingNurse"
        vFields(25) = "AttendingPhysician"
        vFields(26) = "PhysicianPhone"
        vFields(27) = "FamilyAtHospital"
        vFields(28) = "FamilyHIVStatus"
        vFields(29) = "FuneralHome"
        vFields(30) = "AdditionalComments"
        vFields(31) = "COD_S_Other"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Or (pvForm.FormState = EXISTING_RECORD And Not IsNothing(pvOther)) Then

            'check what database is being used. If the database is the archive database get a logevent id from the
            'production database.
            If Connection = ARCHIVE_DATASOURCE Then ' Change TEST_CONN TO ARCHIVE after testing
                vQuery = GetArchiveLogEventvQuery(vParams, vFields)
                If Len(vQuery) < 1 Then
                    Exit Function
                End If
            Else
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO NDRICallSheet (" & vValues & ")"
            End If


            Try
                vReturn = modODBC.Exec(vQuery, vResults)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vReturn = SUCCESS _
                AndAlso ObjectIsValidArray(vResults, 2, 0, 0) Then
                SaveNDRICallSheet = vResults(0, 0)
            Else
                SaveNDRICallSheet = SQL_ERROR
            End If

        Else

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE NDRICallSheet SET " & vValues & " WHERE CallID = " & pvForm.CallId

            Try
                vReturn = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            SaveNDRICallSheet = vReturn

        End If

    End Function

    Public Function DeleteFax(ByRef pvFaxId As Integer) As Short

        Dim vQuery As String = ""

        vQuery = "DELETE Fax WHERE FaxID = " & pvFaxId

        Try
            DeleteFax = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteTemplateConditional(ByRef pvConditionalId As Integer) As Short

        Dim vQuery As String = ""

        vQuery = "DELETE CriteriaTemplate_ConditionalRO WHERE CriteriaTemplate_ConditionalROID = " & pvConditionalId

        Try
            DeleteTemplateConditional = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteSubCriteriaConditional(ByRef pvConditionalId As Integer) As Short

        Dim vQuery As String = ""

        vQuery = "DELETE ProcessorCriteria_ConditionalRO WHERE ProcessorCriteria_ConditionalROID = " & pvConditionalId

        Try
            DeleteSubCriteriaConditional = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
#Region "Call"

    Public Function DeleteCall(ByVal callId As Integer, Optional ByRef pvCallRCType As Short = 0) As Short
        '************************************************************************************
        'Name: DeleteCall
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Sends a call to the Recycle bin
        'Returns: Integer, result of vQuery
        'Params: pvForm = calling form,
        'Stored Procedures: spi_CallRecycleSuspend
        '====================================================================================
        'Date Changed: 5/26/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Changed to use recycling strategy, rather than deletion of call.
        '====================================================================================
        'Date Changed: 6/24/08                          Changed by: ccarroll
        'Release #: 8.4.6                               Task:
        'Description:  Added StatEmployeeID to parameter list for AuditTrail. Modified sproc.
        '************************************************************************************

        Dim vQuery As String = ""

        vQuery = "EXEC spi_CallRecycleSuspend " & callId & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "

        Try
            DeleteCall = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function RestoreCall(ByRef pvForm As FrmOpenAll) As Short
        '************************************************************************************
        'Name: RestoreCall
        'Date Created: 5/25/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Restores a call from the Recycle bin by pulling its CallId
        '             back from CallRecycle into Call
        'Returns: Integer, result of vQuery
        'Params: pvForm = calling form,
        'Stored Procedures: spi_CallRecycleRestore
        '************************************************************************************

        Dim vQuery As String = ""

        vQuery = "EXEC spi_CallRecycleRestore " & pvForm.CallId & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            RestoreCall = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function SaveCall(ByRef pvForm As Object, Optional ByRef pvCallId As Object = Nothing) As Integer
        '************************************************************************************
        'Name: QueryReferral%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: None
        'Description: Queries the database for Referral information.
        'Returns: Return value of executed query.
        'Params: pvForm = calling form
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 4/25/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Added checking if saving from the New Call screen or Referral screen
        '====================================================================================
        'Date Changed: 8/03/06                          Changed by: Christopher Carroll
        'Release #: 8.0                              Release 8.0.1
        'Description:   Added field CallSaveLastByID. Used by Update Tab to determine
        '               Last Employee who saved call (Statline Or LO)
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '
        '====================================================================================
        'Date Changed: 01/30/17                       Changed by: Mike Berenson
        'Release #: 9.4                              Task: Changing from OnError to Try/Catch
        'Description:   Changed code to use Try/Catch blocks instead of On Error exception 
        '               handling.
        '====================================================================================
        '************************************************************************************



        Dim Values As String = ""
        Dim vCallOpenByID As Integer
        Dim Query As String = ""
        Dim Result As Short
        Dim vResponse As Short
        Dim ResultArray As New Object
        Dim Params() As Object
        Dim Fields() As Object
        Dim vReturn As New Object
        Dim vReturn2 As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        If pvForm.Name = "FrmOpenAll" Then


            If pvForm.vRecycledNC > 0 Then
                Query = " EXEC UPDATECall @CallID = " & pvCallId & ", @CallActive = -1, @RecycleNCFlag = -1, @CallSaveLastByID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            Else
                Query = " EXEC UPDATECall @CallID = " & pvCallId & ", @CallActive = -1, @CallSaveLastByID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            End If

            'Wrap database update in a try/catch block to trap any errors
            Try
                Result = modODBC.Exec(Query)
                SaveCall = pvCallId
            Catch ex As Exception
                'Log a detailed message when an attempt to save a call fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update call. Query: " & Query, ex)
                StatTracLogger.CreateInstance().Write(newEx)
            End Try

            Exit Function
        End If

        'ccarroll 07/10/2007 - changed to vpForm.FormState to include check for FrmMessage
        'This code test to see if a user is in the call or if a user got into the call after the user started using the call
        If pvForm.Name <> "FrmNew" And pvForm.FormState <> NEW_RECORD Then
            If modStatRefQuery.RefQueryCall(vReturn, pvCallId) = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 5) Then
                vCallOpenByID = CInt(vReturn(0, 5))
                'this code checks if a user is in the call
                If vCallOpenByID > 0 And vCallOpenByID <> AppMain.ParentForm.StatEmployeeID Then
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, modConv.TextToInt(CStr(vCallOpenByID))) = SUCCESS Then
                        vResponse = MsgBox("WARNING!" & Chr(10) & Chr(10) & vReturn2(0, 1) & " currently has this call open. To ensure no data is lost, please keep a record of the changes you" & Chr(10) & "made. " & vReturn2(0, 1) & " must first cancel out of the call before you can save your data." & Chr(10) & Chr(10) & "Are you sure you still want to save the call?", MsgBoxStyle.Exclamation + MsgBoxStyle.YesNoCancel, "Saving Call May Result in Lost Data")


                        'Log the 2 people in a case
                        Err.Description = "LOCKED CASE - 2 USERS: USER WITH PERMISSION: " & vCallOpenByID & " USER W/O PERMISSION TO SAVE: " & AppMain.ParentForm.StatEmployeeID
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

                        If vResponse = MsgBoxResult.Yes Then ' User chose Yes.
                            'Just exit and save the call
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = 0
                            End If
                        ElseIf vResponse = MsgBoxResult.No Then
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = -1 'Close the call without saving
                            End If
                            Exit Function
                        Else
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = 2 'Don't save the call but keep referral open
                            End If
                            Exit Function
                        End If
                    End If
                Else
                    'this code checks to see if a user saved the call after they entered the call
                    If vCallOpenByID = -1 Then
                        vResponse = MsgBox("WARNING!" & Chr(10) & Chr(10) & "Someone has entered this call while you made changes and saved out of the call. Their changes may be lost" & Chr(10) & "when you save. Are you sure you want to to still save the call?", MsgBoxStyle.Exclamation + MsgBoxStyle.YesNoCancel, "Saving Call May Result in Lost Data")

                        'Log the 2 people in a case
                        Err.Description = "LOCKED CASE - UNLOCKED CASE ON SAVE: USER WITH PERMISSION: " & vCallOpenByID & " USER W/O PERMISSION TO SAVE: " & AppMain.ParentForm.StatEmployeeID
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

                        If vResponse = MsgBoxResult.Yes Then ' User chose Yes.
                            'Just exit and save the call
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = 0
                            End If
                        ElseIf vResponse = MsgBoxResult.No Then
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = -1 'Close the call without saving
                            End If
                            Exit Function
                        Else
                            If pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage" Then
                                pvForm.vReturnSC = 2 'Don't save the call but keep referral open
                            End If
                            Exit Function
                        End If

                    End If
                End If
            End If
        End If

        'Get the call data
        'Bret 06/01/07 8.4.3.8 always send Extension and CallID so Redim to 15
        ReDim Params(15)

        Params(0) = IIf(IsNothing(pvForm.CallNumber), System.DBNull.Value, pvForm.CallNumber)
        Params(1) = pvForm.CallType
        Params(2) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
        If pvForm.Name = "FrmNew" Then
            Params(3) = AppMain.ParentForm.StatEmployeeID
        Else
            Params(3) = modControl.GetID(pvForm.CboCallByEmployee)
        End If

        If (pvForm.Name = "FrmReferral" Or pvForm.Name = "FrmMessage") And pvForm.TxtTotalTimeCounter.Text > "00:00:00" Then
            If pvForm.TimerTotalTime.Enabled = True Then
                Params(4) = pvForm.TxtTotalTimeCounter.Text
            Else
                Params(4) = System.DBNull.Value ' use null to use the existing value
            End If
        ElseIf pvForm.Name = "FrmNew" Or (pvForm.Name = "FrmCoalitionOnDonation") Then
            If pvForm.TimerTotalTime.Enabled = True Then
                Params(4) = pvForm.TxtTotalTimeCounter.Text
            Else
                Params(4) = System.DBNull.Value ' use null to use the existing value
            End If
        End If

        Params(5) = (Hour(pvForm.TxtTotalTimeCounter.Text) * 3600) + (Minute(pvForm.TxtTotalTimeCounter.Text) * 60) + (Second(pvForm.TxtTotalTimeCounter.Text))
        '02/10/03 drh - Limit CallSeconds to 32k in the db since it's a smallint (2 bytes)
        Params(5) = IIf(Params(5) > 32000, 32000, Params(5))
        If pvForm.Name <> "FrmNew" Then
            Params(6) = modConv.ChkValueToDBTrueValue(pvForm.ChkTemp.Checked)
        Else
            Params(6) = -1
        End If

        'Make sure we have a valid SourceCodeID
        If pvForm.SourceCode Is Nothing OrElse pvForm.SourceCode.ID <= 0 Then
            Params(7) = System.DBNull.Value
            Dim exMessage As String = "StatSave.SaveCall - Saving a call with an invalid SourceCode.  " +
                            "SourceCodeID: '" + pvForm.SourceCode.ID.ToString() +
                            "', CallID: " + pvCallId.ToString()
            Dim ex As Exception = New Exception("StatTrac Error: " + exMessage)
            StatTracLogger.CreateInstance().Write(ex)
        Else
            Params(7) = pvForm.SourceCode.ID
        End If

        Params(8) = pvForm.CallOpenByID

        If pvForm.Name <> "FrmNew" Then
            Params(9) = modConv.ChkValueToDBTrueValue(pvForm.ChkExclusive.Checked)
        Else
            Params(9) = -1
        End If

        If Params(6) = -1 Then
            Params(10) = AppMain.ParentForm.StatEmployeeID
        Else
            Params(10) = -1
        End If

        'RecycledNCFlag
        '-1 = FrmReferral and save
        '1 = FrmNewCall screen and hit cancel button
        '2 = FrmNewCall Screen and hit new button and cancel new referral send to recycle
        'Only make 1 if recycled new call
        If pvForm.Name <> "FrmNew" And pvForm.Saved = True Then
            Params(11) = -1
            'FrmReferral hit cancel on a recycled call
        ElseIf pvForm.Name <> "FrmNew" And pvForm.Saved = False And pvForm.RecycledNC = True Then
            Params(11) = -1
            'New Referral Open(load event) and also cancel send to recycle
        ElseIf pvForm.Name <> "FrmNew" And pvForm.Saved = False And pvForm.RecycledNC = False Then
            Params(11) = 2
        Else
            'FrmNewCall screen and hit cancel button
            Params(11) = 1
        End If

        'Params(12) 0 so you don't see on dashboard until new is saved or restored from cancel new referral or deleted referral
        'Params(12) -1 so you can see on dashboard once new is saved or restored from cancel new referral or deleted referral
        'Params(12) 2 it is only seen as a recycled case
        'FrmReferral or FrmMessage and New Record user selected save button
        If pvForm.Name <> "FrmNew" And (pvForm.FormState = NEW_RECORD) And pvForm.Saved = True Then
            Params(12) = -1
            'FrmReferral or FrmMessage or FrmNew and New Record user selected cancel button on FrmReferral and New button and FrmNew
        ElseIf pvForm.Name <> "FrmNew" And (pvForm.FormState = NEW_RECORD) And pvForm.Saved = False Then
            Params(12) = 0
            'FrmReferral or FrmMessage and Recycled case and user selected cancel button
        ElseIf pvForm.Name <> "FrmNew" And pvForm.RecycledNC = True And pvForm.Cancel = True Then
            Params(12) = -1
            'FrmReferral or FrmMessage and Recycled case and user selected save button or restores
        ElseIf pvForm.Name <> "FrmNew" And pvForm.RecycledNC = True And pvForm.Cancel = False Then
            Params(12) = -1
            'FrmReferral Save on existing records recycled or not
        ElseIf pvForm.Name <> "FrmNew" And pvForm.RecycledNC = False And pvForm.Cancel = False Then
            Params(12) = -1
        ElseIf pvForm.Name <> "FrmNew" And pvForm.RecycledNC = False And pvForm.Cancel = False Then
            Params(12) = -1
        Else
            'FrmNew creating a new record
            Params(12) = 0
        End If

        'ccarroll 08/03/2006 - added Last call saved by ID for Update tab
        Params(13) = AppMain.ParentForm.StatEmployeeID

        'Bret 05/01/2007 always send Extension but Update will not save it.
        Params(14) = AppMain.Extension

        'Bret 06/02/2007 make Params(15) callid

        Params(15) = IIf(IsNothing(pvCallId), System.DBNull.Value, pvCallId)

        'Specify the field names
        ReDim Fields(15)

        Fields(0) = "@CallNumber"
        Fields(1) = "@CallTypeID"
        Fields(2) = "@CallDateTime"
        Fields(3) = "@StatEmployeeID"
        Fields(4) = "@CallTotalTime"
        Fields(5) = "@CallSeconds"
        Fields(6) = "@CallTemp"
        Fields(7) = "@SourceCodeID"
        Fields(8) = "@CallOpenByID"
        Fields(9) = "@CallTempExclusive"
        Fields(10) = "@CallTempSavedByID"
        Fields(11) = "@RecycleNCFlag"
        Fields(12) = "@CallActive"
        Fields(13) = "@CallSaveLastByID"
        Fields(14) = "@CallExtension"
        Fields(15) = "@CallID"

        'Build and execute the query
        If IsNothing(pvCallId) Then

            'The record is new and should be inserted.
            'Bret 05/01/2007 call Build SQL with Existing record to build a string like @Field = Value
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "EXEC INSERTCall " & Values

            'Wrap database insert in a try/catch block to trap any errors
            Try
                Result = modODBC.Exec(Query, ResultArray)
                SaveCall = ResultArray(0, 0)
                pvForm.CallNumber = ResultArray(0, 1)
            Catch ex As Exception
                'Log a detailed message when an attempt to save a call fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update call. Query: " & Query, ex)
                StatTracLogger.CreateInstance().Write(newEx)
            End Try

            'Char Chaput 04/14/06 This code checks the incomplete and exclusive fields for a new referral
            If pvForm.Name <> "FrmNew" Then
                pvForm.ChkTemp.Checked = System.Windows.Forms.CheckState.Checked
            End If

        Else
            '10/24/01 drh Temporary code to trap mismatched callid/callnumber
            'If Trim$(pvCallId) <> Left$(Trim$(pvForm.CallNumber), InStr(1, Trim$(pvForm.CallNumber), "-") - 1) Then
            'Call Err.Raise(1, "modStatSave.SaveCall", "CallId: " & Trim$(pvCallId) & " CallNumber: " & Trim$(pvForm.CallNumber))
            'End If
            If pvForm.Name <> "FrmNew" And pvForm.RecycledNC = True And pvForm.Cancel = True Then
                Query = " EXEC UPDATECall @RecycleNCFlag = -1, @CallActive = -1, @CallID = " & pvCallId & ", @CallSaveLastByID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                'Wrap database update in a try/catch block to trap any errors
                Try
                    Result = modODBC.Exec(Query)
                    SaveCall = pvCallId
                Catch ex As Exception
                    'Log a detailed message when an attempt to save a call fails
                    Dim m = Reflection.MethodBase.GetCurrentMethod()
                    Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update call. Query: " & Query, ex)
                    StatTracLogger.CreateInstance().Write(newEx)
                End Try
            Else
                'The record exists and should be updated.

                'ccarroll 11/03/2006 - added to trap/correct blank callNumber issue
                If Trim(pvForm.CallNumber) = "" Then
                    'CallNumber is lost. re-construct from existing data
                    Params(0) = Trim(pvCallId) & "-" & Trim(AppMain.ParentForm.StatEmployeeID)

                    'Raise Error to capture call, user and form information
                    Err.Description = "Blank CallNumber on CallId: " & pvCallId & ", Sender: " & pvForm.Name & " , userID: " & AppMain.ParentForm.StatEmployeeID
                    Err.Source = "StatTrac"
                    LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
                End If


                Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

                Query = "EXEC UPDATECall " & Values

                'Wrap database update in a try/catch block to trap any errors
                Try
                    Result = modODBC.Exec(Query)
                    SaveCall = pvCallId
                Catch ex As Exception
                    'Log a detailed message when an attempt to save a call fails
                    Dim m = Reflection.MethodBase.GetCurrentMethod()
                    Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update call. Query: " & Query, ex)
                    StatTracLogger.CreateInstance().Write(newEx)
                End Try

                Dim callCompleteFieldInfo As Reflection.FieldInfo = pvForm.GetType().GetField("CallComplete")
                If (pvForm.Name = "FrmReferral") And pvForm.FormState = NEW_RECORD And callCompleteFieldInfo IsNot Nothing AndAlso pvForm.CallComplete = False Then
                    pvForm.ChkTemp.Checked = System.Windows.Forms.CheckState.Checked
                End If

                'Make sure pvForm.ChkTemp is a CheckBox and not a String
                If pvForm.ChkTemp.GetType().Name.Equals("CheckBox") Then
                    If (pvForm.Name = "FrmMessage") And pvForm.FormState = NEW_RECORD And callCompleteFieldInfo IsNot Nothing AndAlso pvForm.CallComplete = False Then
                        pvForm.ChkTemp.Checked = CheckState.Checked
                    End If
                    Query = "EXEC UpdateCallIncompleteDate @CallID = " & pvCallId & ", @StatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @IncompleteChecked = " & pvForm.ChkTemp.Checked.ToString()

                    'Wrap database update in a try/catch block to trap any errors.
                    Try
                        Result = modODBC.Exec(Query)
                    Catch ex As Exception
                        'Log a detailed message when an attempt to update a call fails
                        Dim m = Reflection.MethodBase.GetCurrentMethod()
                        Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update call. Query: " & Query, ex)
                        StatTracLogger.CreateInstance().Write(newEx)
                    End Try
                End If

                '7/23/07 Bret Empirix StatTrac 8.0 6708 StatTrac 8.4.3.8
                ' WHY IS THIS HERE IS IT NEEDED
                'If pvForm.Name = "FrmMessage" And FrmMessage.FormState = NEW_RECORD Then
                '    pvForm.ChkUrgent.Checked = vbUnchecked
                'End If
                '
            End If
        End If

    End Function
#End Region

    Public Function DeleteKeyCode(ByRef pvKeyCodeID As Integer) As Short

        Dim vQuery As String = ""

        vQuery = "DELETE KeyCode WHERE KeyCodeID = " & pvKeyCodeID

        Try
            DeleteKeyCode = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteSystemAlert(ByRef pvForm As FrmSystemAlert) As Short

        Dim vQuery As String = ""

        vQuery = "DELETE FROM SystemAlert WHERE SystemAlertID = " & pvForm.SystemAlertID

        Try
            DeleteSystemAlert = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function DeletePerson(ByRef pvForm As FrmOrganization) As Short
        '************************************************************************************
        'Name: DeletePerson%
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Deletes Person
        'Returns: Integer, result of vQuery
        'Stored Procedures: DeletePerson
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.8
        'Description:  Replace dynamic delete with call to DeletePerson
        '************************************************************************************

        Dim vQuery As String = ""

        '06/11/07 bret 8.4.3.8 AuditTrail and 8.4.3.9 LogEvent Order and delete flag
        vQuery = "EXEC DeletePerson @PersonID = " & pvForm.PersonID & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeletePerson = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Added errprod functionality to track changes until audit trail is in place for persons
        'Err.Description = "DELETE PERSONAME: " & pvForm.PersonName & " PERSONID: " & pvForm.PersonID & " USERID: " & AppMain.ParentForm.StatEmployeeID
        'Call modError.LogError("modStatSave.DeletePerson")


    End Function
    Public Function DeleteOrganization(ByVal organizationId As Integer) As Integer
        '************************************************************************************
        'Name: DeleteOrganization
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Deletes Organization
        'Returns: Integer, result of vQuery
        'Stored Procedures: DeletePerson
        '====================================================================================
        'Date Changed: 6/20/07                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.8
        'Description:  Replace dynamic delete with call to DeleteOrganization
        '************************************************************************************

        Dim vQuery As String = ""

        '06/11/07 bret 8.4.3.8 AuditTrail and 8.4.3.9 LogEvent Order and delete flag
        vQuery = "Exec DeleteOrganization @OrganizationID = " & organizationId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeleteOrganization = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'If pvForm.TxtName.Text <> pvForm.vOldTextOrganization Then

        'Added errprod functionality to track changes until audit trail is in place for organizations
        'Err.Description = "DELETE ORGNAME: " & pvForm.OrganizationName & " ORGID: " & pvForm.OrganizationId & " USERID: " & AppMain.ParentForm.StatEmployeeID
        'Call modError.LogError("modStatSave.DeleteOrganization")
        'End If

    End Function

    Public Function DeleteScheduleReferralOrganizations(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM ScheduleGroupOrganization WHERE ScheduleGroupOrganizationID = " & pvGridList(I, 0)
        Next I
        Try
            DeleteScheduleReferralOrganizations = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function DeleteSchedulePerson(ByRef pvGridList As Object, ByVal pvScheduleGroupID As Integer) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM ScheduleGroupPerson " & "WHERE PersonID = " & pvGridList(I, 0) & " " & "AND ScheduleGroupID = " & pvScheduleGroupID
        Next I

        Try
            DeleteSchedulePerson = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function DeleteCriteriaReferralOrganizations(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM CriteriaOrganization WHERE CriteriaOrganizationID = " & pvGridList(I, 0) & "; "
        Next I
        Try
            DeleteCriteriaReferralOrganizations = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteCriteriaProcessors(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM CriteriaProcessor WHERE CriteriaProcessorID = " & pvGridList(I, 0) & "; "
        Next I
        Try
            DeleteCriteriaProcessors = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteCriteriaSubtypes(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM CriteriaSubtype WHERE CriteriaSubtypeID = " & pvGridList(I, 0) & "; "
        Next I
        Try
            DeleteCriteriaSubtypes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteSubCriteria(ByRef pvForm As FrmCriteria) As Short

        Dim vQuery As String = ""
        Dim vSubCriteriaId As String = ""

        vSubCriteriaId = pvForm.LstViewSubtypeProcessors.FocusedItem.SubItems(2).Text

        'Delete conditionalro's
        vQuery = "DELETE processorcriteria_conditionalro WHERE SubCriteriaId = " & vSubCriteriaId
        Try
            DeleteSubCriteria = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If DeleteSubCriteria <> SUCCESS Then
            Exit Function
        Else
            'Delete subcriteria schedulegroups
            vQuery = "DELETE scschedulegroup WHERE SubCriteriaId = " & vSubCriteriaId
            Try
                DeleteSubCriteria = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If DeleteSubCriteria <> SUCCESS Then
                Exit Function
            End If
        End If

        'Delete SubCriteria
        vQuery = "DELETE subcriteria WHERE SubCriteriaId = " & vSubCriteriaId & ";"
        Try
            DeleteSubCriteria = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteAlertOrganizations(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM AlertOrganization WHERE AlertOrganizationID = " & pvGridList(I, 0) & "; "
        Next I
        Try
            DeleteAlertOrganizations = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function DeleteScheduleShift(ByRef pvGridList As Object) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM ScheduleShift WHERE ScheduleShiftID = " & pvGridList(I, 0) & " "
        Next I
        Try
            DeleteScheduleShift = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteWebReportAccessDate(ByRef pvForm As FrmReport) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete
        vQuery = vQuery & "DELETE WebReportGroupAccessDate " & "WHERE WebReportGroupAccessDateID = " & modConv.TextToLng(pvForm.LstViewDateAccess.SelectedItems(0).Tag)
        Try
            DeleteWebReportAccessDate = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function DeleteCriteriaGroupIndication(ByRef pvForm As FrmCriteria) As Short

        Dim vQuery As String = ""
        Dim I As Short
        Dim vGridList As New Object

        vGridList = pvForm.IndicationList

        'Delete each row
        For I = 0 To UBound(vGridList, 1)
            vQuery = vQuery & "DELETE FROM CriteriaIndication " & "WHERE IndicationID = " & vGridList(I, 0) & "AND CriteriaID = " & pvForm.CriteriaGroupID & "; "
        Next I

        Try
            DeleteCriteriaGroupIndication = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function



    Public Function DeletePersonPhone(ByRef pvForm As FrmPerson) As Short

        Dim vQuery As String = ""
        Dim I As Short
        'wasn't finding phone id and changed vquery to string and initialized jth 3/10
        'Delete each row
        vQuery = "DELETE PersonPhone WHERE PhoneID = " & modConv.TextToLng(pvForm.LstViewPhone.SelectedItems(0).Tag) & " AND PersonID = " & pvForm.PersonID & ";"

        Try
            DeletePersonPhone = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
    End Function
    Public Function DeleteTxCenter(ByRef pvForm As FrmSourceCode, ByRef SourceCodeID As Integer, ByRef TxCode As String) As Short

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        vQuery = vQuery & "DELETE sourcecodetransplantcenter " & "WHERE SourceCodeID = " & SourceCodeID & " and TransplantCode = '" & TxCode & "'"

        Try
            DeleteTxCenter = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function DeleteCriteriaGroupScheduleGroup(ByRef pvForm As FrmCriteria, Optional ByVal pvScheduleGroupID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vParams(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

        If IsNothing(pvScheduleGroupID) Then
            vParams(1) = modControl.GetID(pvForm.CboScheduleGroup)
        Else
            vParams(1) = pvScheduleGroupID
        End If

        vQuery = "DELETE CriteriaScheduleGroup " & "WHERE CriteriaID = " & vParams(0) & " " & "AND ScheduleGroupID = " & vParams(1)

        Try
            DeleteCriteriaGroupScheduleGroup = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 5/6/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking(pvForm)

    End Function

    Public Function DeleteSubCriteriaGroupScheduleGroup(ByRef pvForm As FrmCriteria, Optional ByVal pvSCScheduleGroupID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vParams(1) As Object

        vParams(0) = modControl.GetID(pvForm.cboSubtypeProcessor(1))

        If IsNothing(pvSCScheduleGroupID) Then
            vParams(1) = modControl.GetID(pvForm.cboScheduleGroupSub)
        Else
            vParams(1) = pvSCScheduleGroupID
        End If

        vQuery = "DELETE SCScheduleGroup " & "WHERE SubCriteriaID = " & vParams(0) & " " & "AND ScheduleGroupID = " & vParams(1)

        Try
            DeleteSubCriteriaGroupScheduleGroup = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 5/6/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking(pvForm)

    End Function
    Public Function DeleteLogEvent(ByRef pvForm As Object, Optional ByRef pvDeleteCoroner As Object = Nothing, Optional ByRef pvDeleteAll As Object = Nothing) As Short
        '************************************************************************************
        'Name: DeleteLogEvent
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Deletes LogEvent by calling DeleteLogEvent
        'Params: pvForm = calling form,
        '
        '        pvResults = returning results
        'Stored Procedures: DeleteLogEvent
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vLogEventID As String = "NULL"

        'Make sure we're only populating vLogEventID if necessary
        If IsNothing(pvDeleteAll) Then
            vLogEventID = pvForm.CurrentLogEventID
        End If
        vQuery = "EXEC DeleteLogEvent " & "@CallID = " & IIf(IsNothing(pvDeleteAll), pvForm.CallId, "NULL") & " ,@LogEventID = " & vLogEventID & " ,@LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeleteLogEvent = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function DeleteLogEventID(ByVal pvLogEventId As Integer, ByRef pvCallId As Integer) As Short
        '************************************************************************************
        'Name: DeleteLogEventID%
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Calls DeleteLogeVent which updates the deleteflag
        'Returns: Return value of executed query in pvResults.
        'Params: logEventID and CallID
        '
        'Stored Procedures: DeleteLogEvent
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use DeleteLogEvent
        '               Add LastStatEmployeeID
        '====================================================================================
        'Date Changed: 06/25/2007                      Changed by: Thien Ta
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Added CallID to vQuery because it was missing in call
        '====================================================================================
        Dim vQuery As String = ""

        '11/26/02 drh - Save Referral Audit Info
        'T.T 11/25/2007 commented out for now
        'Call modStatAudit.AuditLogEventDelete(pvLogEventId, pvCallId, AUDIT_DELETE)

        '06/11/07 bret 8.4.3.8 AuditTrail and 8.4.3.9 LogEvent Order and delete flag
        '06/26/07 T.T  8.4.3.8 AuditTrail and 8.4.3.9 LogEvent adding CallID because it was missing for stored procedure added commas
        vQuery = "EXEC DeleteLogEvent @LogEventID = " & pvLogEventId & " ,@CallID = " & pvCallId & " ,@LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeleteLogEventID = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function DeleteSecondaryMedication(ByRef pvMedicationID As Integer, ByRef pvCallId As Integer) As Short
        '************************************************************************************
        'Name: DeleteLogEventID%
        'Date Created: Unknown                          Created by: Bret Knoll
        'Release: Unknown                               Task: Unknown
        'Description: deletes secondarymedication records
        'Params: CallID
        '
        'Stored Procedures: DeleteSecondaryMedication
        '====================================================================================

        Dim vQuery As String = ""


        vQuery = "EXEC DeleteSecondaryMedication @CallID = " & pvCallId & ", @MedicationId = " & pvMedicationID & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeleteSecondaryMedication = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function DeleteSecondaryMedicationOther(ByRef pvSecondaryMedicationOtherID As Integer) As Short
        '************************************************************************************
        'Name: DeleteLogEventID%
        'Date Created: 7/02/07                         Created by: Bret Knoll
        'Release: 8.4                                  Task: 8.4.3.8 AuditTrail
        'Description: deletes secondarymedicationother
        'Params: CallID
        '
        'Stored Procedures: DeleteSecondaryMedicationOther
        '====================================================================================

        Dim vQuery As String = ""

        vQuery = "EXEC DeleteSecondaryMedicationOther @SecondaryMedicationOtherId = " & pvSecondaryMedicationOtherID & " ,@LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            DeleteSecondaryMedicationOther = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
    End Function

    '	'7/2/01 drh Added extra logic for FS Events
    Public Function SaveFSLogEvent(ByRef pvForm As Object, ByRef pvResults As Object) As Integer
        '************************************************************************************
        'Name: SaveFSLogEvent
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
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vReturn As New Object
        Dim vQuery As New Object
        Dim vResults As New Object
        Dim vValues As New Object
        Dim Params(0) As Object
        Dim Fields(0) As Object

        Dim vFmState As Integer
        If ObjectIsValidArray(pvResults, 2, 0, 12) Then
            ReDim Params(6)
            ReDim Fields(6)

            'If Case is Open, not Final, and SysEvents is not checked, then update SysEvents
            If pvResults(0, 4) <> 0 And pvResults(0, 6) = 0 And pvResults(0, 12) = 0 Then

                Params(0) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                Params(1) = Now
                Params(2) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                Params(3) = Now
                Params(4) = pvForm.CallId
                Params(5) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                Params(6) = AppMain.ParentForm.TimeZone

                Fields(0) = "@FSCaseSysEventsUserId"
                Fields(1) = "@FSCaseSysEventsDateTime"
                Fields(2) = "@FSCaseUserId"
                Fields(3) = "@FSCaseUpdate"
                Fields(4) = "@CallID"
                Fields(5) = "@LastStatEmployeeID"
                Fields(6) = "@timeZone"

                Try
                    vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, Params, Fields)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                vQuery = "EXEC UpdateFSCase " & vValues
                Try
                    vReturn = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        Else

            ReDim Params(5)
            ReDim Fields(5)
            Params(0) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            Params(1) = Now
            Params(2) = Now
            Params(3) = pvForm.CallId
            Params(4) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            Params(5) = AppMain.ParentForm.TimeZone

            Fields(0) = "@FSCaseCreateUserId"
            Fields(1) = "@FSCaseCreateDateTime"
            Fields(2) = "@FSCaseUpdate"
            Fields(3) = "@CallID"
            Fields(4) = "@LastStatEmployeeID"
            Fields(5) = "@timeZone"

            Try
                vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, Params, Fields)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            vQuery = "EXEC InsertFSCase " & vValues

            Try
                vReturn = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'FSProj drh 6/15/02 Create the Secondary
            vFmState = pvForm.FormState
            pvForm.FormState = NEW_RECORD
            Try
                Call modStatSave.SaveSecondary(pvForm)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            pvForm.FormState = vFmState
        End If



        Exit Function

    End Function
#Region "LogEvent"

    Public Function SaveLogEvent(ByRef pvForm As Object, Optional ByRef pvOther As Object = Nothing, Optional ByRef pvNote As Object = Nothing, Optional ByRef pvCallType As Object = Nothing) As Integer
        '************************************************************************************
        'Name: SaveLogEvent
        'Date Created: Unknown                          Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Creates the SQL to save a LogEvent to the DB and executes it.
        'Returns: Return value of executed query.
        'Params: pvForm = calling form,
        '        pvOther(Optional) = LogEventTypeId,
        '        pvNote(Optional) = Note - a string containing descriptive info.
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/16/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added the ability to save LogEventNumber as a randomly generated
        '              long to help identify emails and auto response pages.
        '              Changed array numbers to use constants.
        '====================================================================================
        'Date Changed: 05/1/06                         Changed by: Char Chaput
        'Release #: 8.0                              Task:
        'Description:  Added saving the logevent in the newcall screen for autosave functionality
        '        Added param pvcalltype(Optional) = descriptive call type from newcall screen.
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertLogEvent and UpdateLogEvent
        '               Added LastStatemployeeID, AuditLogTypeID, LogEventOrderNumber
        '               Change AutoReponse to save to a new table AutoResponseCode
        '====================================================================================


        Dim vValues As String = ""
        Dim vQuery As New Object
        Dim vReturn As Short
        Dim vLogEventID As String = ""
        Dim vResults As New Object
        Dim vTimeZoneDif As Short
        Dim vArraySize As Short
        Dim RegValue As Short
        Dim hasAutoResponseCode As Boolean
        Dim isNewEvent As Boolean = False

        'default the hasAutoResponseCode  to false
        hasAutoResponseCode = False

        'ccarroll 06/11/2007 StatTrac 8.4 release requirement 3.6 - TBI Number
        'Assign TBI event name for GENERAL note type
        'If not TBI apply Donor Registry as default
        Dim EventName As String = ""
        If (Not IsNothing(pvNote)) Then


            If InStr(pvNote.ToString(), "CTDN") > 0 Then
                EventName = "CTDN Number"
            Else
                EventName = "Donor Registry"
            End If
        End If

        Try
            vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Get the log data
        Dim vParams(18) As Object
        Dim vFields(18) As Object

        'set new params
        vParams(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(LOGEVENT_FIELD_LOGEVENTDELETED) = 0
        If (pvForm.GetType().GetField("ContactLogEventID") IsNot Nothing AndAlso (pvForm.Name <> "FrmOnCallEvent" And pvForm.Name <> "FrmReferralView" And pvForm.Name <> "FrmReferral" And pvForm.Name <> "FrmOpenAll" And pvForm.Name <> "FrmDonorIntentFax")) Then
            vParams(LOGEVENT_FIELD_LOGEVENTID) = pvForm.ContactLogEventID
        End If


        Select Case pvForm.Name

            Case "FrmReferral", "FrmReferralView"
                If pvForm.FormState = NEW_RECORD And IsNothing(pvOther) Then
                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = INCOMING
                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.LblName.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Recorded patient information."
                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                ElseIf Not IsNothing(pvOther) Then
                    Select Case pvOther

                        Case CONSENT_PENDING

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = CONSENT_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.LblName.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for family consent."
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.OrganizationId
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = pvForm.PersonID
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If pvForm.Name <> "FrmReferral" Then

                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            End If

                        Case SECONDARY_PENDING

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = SECONDARY_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for secondary medical screening."
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case DECLARED_CTOD_PENDING
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = DECLARED_CTOD_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "N/A"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = "(000) 000-0000"
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = Statline.Stattrac.Constant.StattracIdentity.Identity.UserOrganizationName.ToString()
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = ""
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = modConv.TextToLng(pvForm.OrganizationId)
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = 0
                            vParams(LOGEVENT_FIELD_PERSONID) = 0
                            vParams(LOGEVENT_FIELD_PHONEID) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case ORGAN_MED_RO_PENDING
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = ORGAN_MED_RO_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "N/A"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = "(000) 000-0000"
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = Statline.Stattrac.Constant.StattracIdentity.Identity.UserOrganizationName.ToString()
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = ""
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = modConv.TextToLng(pvForm.OrganizationId)
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = 0
                            vParams(LOGEVENT_FIELD_PERSONID) = 0
                            vParams(LOGEVENT_FIELD_PHONEID) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case STATLINE_CONSENT_PENDING

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = CONSENT_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Family Services"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for family consent."
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case NOTE, CASE_HAND_OFF

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = 1
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Recycled Call"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case QA_Note
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = 25
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "QA Note"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "StatLine"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(Today & " " & TimeOfDay))
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case IM_Conversation

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = IM_Conversation
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = EventName
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case CASE_HAND_OFF

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = GENERAL
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = EventName 'ccarroll 06/11/2007 was: "Donor Registry"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If (pvForm.Name <> "FrmReferralView" And pvForm.Name <> "FrmReferral") Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            Else
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = System.DBNull.Value
                            End If

                        Case GENERAL

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = GENERAL
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = EventName 'ccarroll 06/11/2007 was: "Donor Registry"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If (pvForm.Name <> "FrmReferralView" And pvForm.Name <> "FrmReferral") Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            Else
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = System.DBNull.Value
                            End If

                    End Select

                Else
                    'Do not update the log event
                    Exit Function
                End If

            Case "FrmMessage"

                If pvForm.FormState = NEW_RECORD And IsNothing(pvOther) Then
                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = INCOMING
                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.LblName.Text
                    If pvForm.TxtExtension.Text <> "" Then
                        vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.TxtCallerPhone.Text & " x" & pvForm.TxtExtension.Text
                    Else
                        vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.TxtCallerPhone.Text & " x" & pvForm.TxtExtension.Text
                    End If
                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Recorded message information."
                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                    vParams(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                ElseIf Not IsNothing(pvOther) Then
                    Select Case pvOther
                        Case NOTE, CASE_HAND_OFF
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = 1
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Recycled Call"
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If pvForm.GetType().GetField("LogEventNumber") IsNot Nothing Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            End If

                    End Select
                Else
                    'Do not update the log event
                    Exit Function
                End If

            Case "FrmNew"

                Select Case pvCallType
                    Case "REFERRAL"
                        If pvForm.FormState = NEW_RECORD And IsNothing(pvOther) Then
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = INCOMING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.CboName.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.TxtPhone.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.CboOrganization.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Recorded patient information."
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If pvForm.name = "FrmOnCallEvent" Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            Else
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = System.DBNull.Value
                            End If

                        ElseIf Not IsNothing(pvOther) Then
                            Select Case pvOther

                                Case CONSENT_PENDING

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = CONSENT_PENDING
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.LblName.Text
                                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for family consent."
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.OrganizationId
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = pvForm.PersonID
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber

                                Case SECONDARY_PENDING

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = SECONDARY_PENDING
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = ""
                                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for secondary medical screening."
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber

                                Case STATLINE_CONSENT_PENDING

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = CONSENT_PENDING
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Family Services"
                                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Waiting for family consent."
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber




                                Case NOTE

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = 1
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Recycled Call"
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                                    'Make sure fields are available before referencing them
                                    If Not IsNothing(pvForm.GetType().GetField("LblPhone")) Then
                                        vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.LblPhone.Text
                                    End If
                                    If Not IsNothing(pvForm.GetType().GetField("LblOrganization")) Then
                                        vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.LblOrganization.Text
                                    End If
                                    If Not IsNothing(pvForm.GetType().GetField("LogEventNumber")) Then
                                        vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                                    End If

                                Case GENERAL

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = GENERAL
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Donor Registry"
                                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber


                                Case CASE_HAND_OFF

                                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = GENERAL
                                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Case Hand Off"
                                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = ""
                                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = "Statline"
                                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                                    vParams(LOGEVENT_FIELD_PERSONID) = -1
                                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                                    vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber

                            End Select

                        Else
                            'Do not update the log event
                            Exit Function
                        End If
                    Case "Message/RFI", "Import"

                        If pvForm.FormState = NEW_RECORD Then
                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = INCOMING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.TxtCallerName.Text
                            If pvForm.CallPhoneExtension <> "" Then
                                vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.CallPhoneNumber & " x" & pvForm.CallPhoneExtension
                            Else
                                vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.CallPhoneNumber
                            End If
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.TxtCallerOrganization.Text
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = "Recorded message information."
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = -1
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If (pvForm.Name <> "FrmNew") Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            End If



                        Else
                            'Do not update the log event
                            Exit Function
                        End If
                End Select

            Case "FrmLogEvent"
                vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = pvForm.ContactLogEventTypeID
                vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.CboName.Text
                vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.TxtContactPhone.Text
                vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.TxtContactOrg.Text
                vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvForm.TxtContactDesc.Text
                vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(pvForm.ContactEmployeeID)
                vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtContactDate.Text))
                vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = pvForm.CallbackPending
                vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.OrganizationId
                vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = pvForm.ScheduleGroupID
                vParams(LOGEVENT_FIELD_PERSONID) = pvForm.PersonID
                vParams(LOGEVENT_FIELD_PHONEID) = pvForm.PhoneID
                vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = System.Math.Abs(CInt(DirectCast(pvForm.ChkConfirmed, CheckBox).Checked))
                If (Len(pvForm.TxtCalloutDate.Text) > 0) Then
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtCalloutDate.Text))
                End If

                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = Nothing

            Case "FrmOnCallEvent"
                vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = pvForm.ContactLogEventTypeID
                vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.TxtContactName.Text
                vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.TxtContactPhone.Text
                vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.TxtContactOrg.Text
                'Populate the Description from the appropriate source
                vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvForm.LogEventDescription
                If String.IsNullOrWhiteSpace(vParams(LOGEVENT_FIELD_LOGEVENTDESC)) Then
                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvForm.TxtContactDesc.Text
                End If
                vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(pvForm.ContactEmployeeID)
                vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtContactDate.Text))
                vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = pvForm.CallbackPending
                Dim organzationID As Integer
                Try
                    organzationID = modConv.TextToLng(modControl.GetID(pvForm.CboOrganization))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                vParams(LOGEVENT_FIELD_ORGANIZATIONID) = IIf(organzationID = -1, 0, organzationID)
                Dim scheduleGroupID As Integer
                Try
                    scheduleGroupID = modConv.TextToLng(modControl.GetID(pvForm.CboScheduleGroup))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = IIf(scheduleGroupID = -1, 0, scheduleGroupID)
                If pvForm.LstViewPerson.SelectedItems.Count > 0 Then
                    Dim personID = modConv.TextToLng(pvForm.LstViewPerson.SelectedItems(0).Tag)
                    vParams(LOGEVENT_FIELD_PERSONID) = IIf(personID = -1, 0, personID)
                End If
                If pvForm.LstViewContact.SelectedItems.Count > 0 Then
                    Dim phoneID = modConv.TextToLng(pvForm.LstViewContact.SelectedItems(0).Tag)
                    vParams(LOGEVENT_FIELD_PHONEID) = IIf(phoneID = -1, 0, phoneID)
                Else
                    If pvForm.LstViewContact.items.count > 0 Then
                        vParams(LOGEVENT_FIELD_PHONEID) = modConv.TextToLng(pvForm.LstViewContact.items(0).Tag)
                    End If
                End If
                'In the case of EmailPending, EmailSent or PageSent log event, always set LogEventContactConfirmed to 1 to
                'clear the "Contact Req" in the pending events list.  Ver. 7.7.2, 12/21/04 - SAP
                If pvForm.ContactLogEventTypeID = EMAIL_PENDING _
                    Or pvForm.ContactLogEventTypeID = EMAIL_SENT _
                    Or pvForm.ContactLogEventTypeID = PAGE_SENT Then
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 1
                Else
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = System.Math.Abs(CInt(pvForm.ChkConfirmed.Checked))
                End If
                If Len(pvForm.TxtCalloutDate.Text) > 0 Then
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtCalloutDate.Text))
                End If

                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber

                'set the value to true
                hasAutoResponseCode = True

            Case "FrmDonorIntentFax"
                If Not IsNothing(pvOther) Then
                    Select Case pvOther
                        Case OUTGOING_FAX, Verification_Form_Sent

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.vParentForm.CallId 'drh 06/12/03 - Changed to reference vParentForm
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = pvOther
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.vPerson
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.vFaxNum
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.vOrganization
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0 'drh 06/12/03 - Outgoing fax doesn't require a callback
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.OrganizationId
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = pvForm.vPersonID
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value

                        Case FAX_PENDING

                            vParams(LOGEVENT_FIELD_CALLID) = pvForm.vParentForm.CallId 'drh 06/12/03 - Changed to reference vParentForm
                            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = FAX_PENDING
                            vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.vPerson
                            vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.vFaxNum
                            vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.vOrganization
                            vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                            vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                            vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = -1
                            vParams(LOGEVENT_FIELD_ORGANIZATIONID) = 194
                            vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                            vParams(LOGEVENT_FIELD_PERSONID) = pvForm.vPersonID
                            vParams(LOGEVENT_FIELD_PHONEID) = -1
                            vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                            vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                            If (pvForm.GetType().GetProperty("LogEventNumber") IsNot Nothing) Then
                                vParams(LOGEVENT_FIELD_LOGEVENTNUMBER) = pvForm.LogEventNumber
                            End If
                    End Select
                End If
            Case "FrmOpenAll"
                Select Case pvOther
                    Case NOTE, CASE_HAND_OFF

                        vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                        vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = 1
                        vParams(LOGEVENT_FIELD_LOGEVENTNAME) = "Recycled Call"
                        vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvNote
                        vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                        vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.fvCallDate))
                        vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                        vParams(LOGEVENT_FIELD_ORGANIZATIONID) = -1
                        vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                        vParams(LOGEVENT_FIELD_PERSONID) = -1
                        vParams(LOGEVENT_FIELD_PHONEID) = -1
                        vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                        vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = System.DBNull.Value
                        vParams(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                End Select

            Case "FrmEmail"

                If pvForm.FormParent IsNot Nothing AndAlso pvForm.FormParent.Name = "FrmOnCallEvent" Then

                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = pvForm.FormParent.ContactLogEventTypeId
                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.FormParent.txtContactName.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvForm.txtAddendum.Text
                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, DateTime.Now)
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.FormParent.OrganizationName
                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.FormParent.OrganizationId
                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                    vParams(LOGEVENT_FIELD_PERSONID) = pvForm.FormParent.PersonId
                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.FormParent.DefaultContactPhone
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.FormParent.CurrentDate))
                    vParams(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                End If

            Case "FrmAlphaMsg"

                If pvForm.FormParent IsNot Nothing AndAlso pvForm.FormParent.Name = "FrmOnCallEvent" Then

                    vParams(LOGEVENT_FIELD_CALLID) = pvForm.CallId
                    vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = pvForm.FormParent.ContactLogEventTypeId
                    vParams(LOGEVENT_FIELD_LOGEVENTNAME) = pvForm.FormParent.txtContactName.Text
                    vParams(LOGEVENT_FIELD_LOGEVENTDESC) = pvForm.AlphaMsg
                    vParams(LOGEVENT_FIELD_STATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                    vParams(LOGEVENT_FIELD_LOGEVENTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.FormParent.CurrentDate))
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTORG) = pvForm.FormParent.OrganizationName
                    vParams(LOGEVENT_FIELD_ORGANIZATIONID) = pvForm.FormParent.OrganizationId
                    vParams(LOGEVENT_FIELD_SCHEDULEGROUPID) = -1
                    vParams(LOGEVENT_FIELD_PERSONID) = pvForm.FormParent.PersonId
                    vParams(LOGEVENT_FIELD_PHONEID) = -1
                    vParams(LOGEVENT_FIELD_LOGEVENTPHONE) = pvForm.FormParent.DefaultContactPhone
                    vParams(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = 0
                    vParams(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.FormParent.CurrentDate))
                    vParams(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                End If

        End Select

        'Make sure we don't pass 4000 for a LogEventTypeID
        If vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = FAMILY_SERVICES_ALERT Then

            vParams(LOGEVENT_FIELD_LOGEVENTTYPEID) = OUTGOING

            'Log a detailed message when app tries to save a LogEvent record with a LogEventTypeID of 4000
            Dim exMessage As String = "StatSave.SaveLogEvent - Tried to save with a LogEventTypeID of 4000.  " +
                            "CallID: " + vParams(LOGEVENT_FIELD_CALLID)
            Dim ex As Exception = New Exception("StatTrac Error: " + exMessage)
            StatTracLogger.CreateInstance().Write(ex)

        End If

        'Specify the field names
        vFields(LOGEVENT_FIELD_CALLID) = "@CallID"
        vFields(LOGEVENT_FIELD_LOGEVENTTYPEID) = "@LogEventTypeID"
        vFields(LOGEVENT_FIELD_LOGEVENTNAME) = "@LogEventName"
        vFields(LOGEVENT_FIELD_LOGEVENTPHONE) = "@LogEventPhone"
        vFields(LOGEVENT_FIELD_LOGEVENTORG) = "@LogEventOrg"
        vFields(LOGEVENT_FIELD_LOGEVENTDESC) = "@LogEventDesc"
        vFields(LOGEVENT_FIELD_STATEMPLOYEEID) = "@StatEmployeeID"
        vFields(LOGEVENT_FIELD_LOGEVENTDATETIME) = "@LogEventDateTime"
        vFields(LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING) = "@LogEventCallbackPending"
        vFields(LOGEVENT_FIELD_ORGANIZATIONID) = "@OrganizationID"
        vFields(LOGEVENT_FIELD_SCHEDULEGROUPID) = "@ScheduleGroupID"
        vFields(LOGEVENT_FIELD_PERSONID) = "@PersonID"
        vFields(LOGEVENT_FIELD_PHONEID) = "@PhoneID"
        vFields(LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED) = "@LogEventContactConfirmed"
        vFields(LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME) = "@LogEventCalloutDateTime"
        vFields(LOGEVENT_FIELD_LOGEVENTNUMBER) = "@LogEventNumber"
        vFields(LOGEVENT_FIELD_LASTSTATEMPLOYEEID) = "@LastStatEmployeeID"
        vFields(LOGEVENT_FIELD_LOGEVENTDELETED) = "@LogEventDeleted"
        vFields(LOGEVENT_FIELD_LOGEVENTID) = "@LogEventID"

        If (IsNothing(vParams(LOGEVENT_FIELD_LOGEVENTID))) Then
            vParams(LOGEVENT_FIELD_LOGEVENTID) = 0
        End If

        'Build and execute the query
        Dim vTempLogEventId As Integer 'Need Non-variant variable to pass as argument
        If (vParams(LOGEVENT_FIELD_LOGEVENTID) = 0) Then
            vParams(LOGEVENT_FIELD_LOGEVENTID) = System.DBNull.Value
        End If

        If (IsDBNull(vParams(LOGEVENT_FIELD_LOGEVENTID)) And (pvForm.Name = "FrmOpenAll" Or pvForm.Name = "FrmDonorIntentFax" Or pvForm.Name = "FrmEmail" Or pvForm.Name = "FrmAlphaMsg")) Then
            isNewEvent = True
        ElseIf (pvForm.FormState = EXISTING_RECORD And Not IsNothing(pvOther)) Then
            isNewEvent = True
        ElseIf (IsDBNull(vParams(LOGEVENT_FIELD_LOGEVENTID)) And pvForm.FormState = NEW_RECORD) Then
            isNewEvent = True
        End If

        If isNewEvent Then

            'check what database is being used. If the database is the archive database get a logevent id from the
            'production database.
            If Connection = ARCHIVE_DATASOURCE Then ' Change TEST_CONN TO ARCHIVE after testing
                vQuery = GetArchiveLogEventvQuery(vParams, vFields)
                If Len(vQuery) < 1 Then
                    Exit Function
                End If
            Else
                'The record is new and should be inserted.
                Try
                    vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                vQuery = "EXEC INSERTLogEvent " & vValues
            End If

            Try
                vReturn = modODBC.Exec(vQuery, vResults)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vReturn = SUCCESS _
                AndAlso ObjectIsValidArray(vResults, 2, 0, 0) Then
                SaveLogEvent = vResults(0, 0)
                If hasAutoResponseCode Then
                    If pvForm.AutoResponseCode > 0 Then
                        vQuery = "EXEC InsertAutoResponseCode " & "@CallID = " & pvForm.CallId & ", @AutoResponseCode = " & pvForm.AutoResponseCode & ", @LogEventID = " & SaveLogEvent
                        Try
                            vReturn = modODBC.Exec(vQuery, vResults)
                            'We're saving the AutoResponseCode record now and may need to come back and update it with a valid SaveLogEvent value
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try
                    End If
                End If
                vTempLogEventId = vResults(0, 0)
            Else
                SaveLogEvent = SQL_ERROR
            End If

        Else

            'The record exists and should be updated.
            Try
                vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            vQuery = "EXEC UPDATELogEvent " & vValues

            Try
                vReturn = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            SaveLogEvent = vReturn

        End If
        Exit Function
    End Function

    Public Function SetLogEventNumber() As Integer
        '************************************************************************************
        'Name: SetLogEventNumber
        'Date Created: 12/16/04                         Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates a random LogEventNumber to be used as an identifier for
        '             email and auto response pager log events.
        'Returns: Long - a random number between 1 and 1000
        'Params: None
        'Stored Procedures: None
        '************************************************************************************

        Randomize() ' Initialize random-number generator.
        SetLogEventNumber = CInt((1000 * Rnd()) + 1) ' Generate random value between 1 and 6.

    End Function
#End Region


    Public Function SaveReferral(ByRef pvParentForm As Object) As Integer
        '************************************************************************************
        'Name: SaveReferral
        'Date Created: Unknown                          Created by: Unknown
        'Release: 7.7.2                                 Task: 312
        'Description: Generates a random LogEventNumber to be used as an identifier for
        '             email and auto response pager log events.
        'Returns: Long - the ReferralId of the saved referral
        'Params: pvForm
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/18/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 417
        'Description:  Changed referral type to save in CurrentReferralTypeId, added sproc
        '               to save initial ReferralType.
        '====================================================================================
        'Date Changed: 5/24/05                          Changed by: Char Chaput
        'Release #: 8.0                               Task: 400
        'Description:  Referral Screen Redesign changed contact information to labels.
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
        'Description:  Added QA Review Complete (Req.# 4.9.2)
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertReferral and UpdateReferral
        '               Add LastStatEmployeeID
        '               A major reformat of the code was done. As of 8.0 the code did not work
        '               properly. All field assignments and parameter setttings have been pulled into
        '               one of two Select / case statements. In each of these statements is a FrmReferral
        '               section and a FrmNew section. FrmReferral has 80 + viefields and FrmReferral
        '               Only has 8+ fields
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/28/2007                       Changed by: thien Ta
        'Release #: 8.4                              Task: code fix
        'Description:   Changed RegStatus save from vRS(0,0) to vRS("ID").Value , vRS(0,0) was not working.
        '====================================================================================
        'Date Changed: 01/30/17                       Changed by: Mike Berenson
        'Release #: 9.4                              Task: Changing from OnError to Try/Catch
        'Description:   Changed code to use Try/Catch blocks instead of On Error exception 
        '               handling.
        '====================================================================================
        '************************************************************************************
        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim vGridValues As New Object
        Dim vResult As Short
        Dim I As Integer = 0
        Dim vReturn As New Object
        Dim vRS As New Object 'T.T 09/15/2004 added for Registry Status Recordset
        Dim RegValue As New Object
        Dim vParams As New Object
        Dim vFields As New Object

        'Call Info
        Select Case pvParentForm.Name
            Case "FrmReferral"
                'Get the referral information
                'bjk 10/29/02 changed vParams from 84 to 76
                'mds 01/07/04 changed vParams from 77 to 78 for heartbeat addition
                ReDim vParams(98)
                Dim pvForm As FrmReferral = pvParentForm

                vPhoneID = modConv.TextToLng(modStatSave.SavePhone(pvForm.LblPhone.Text, WORK_NUM))

                vParams(0) = pvForm.CallId
                vParams(modUtility.Increment(I)) = vPhoneID
                vParams(modUtility.Increment(I)) = pvForm.LblExtension.Text
                vParams(modUtility.Increment(I)) = pvForm.OrganizationId
                vParams(modUtility.Increment(I)) = pvForm.SubLocationID
                vParams(modUtility.Increment(I)) = pvForm.LblLevel.Text
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.LblLevel)
                vParams(modUtility.Increment(I)) = pvForm.PersonID

                'Donor Info
                vParams(modUtility.Increment(I)) = pvForm.TxtDonorFirstName.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtDonorLastName.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtDonorFirstName.Text & " " & pvForm.TxtDonorLastName.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtRecNum.Text
                vParams(modUtility.Increment(I)) = RemoveInvalidChars(pvForm.TxtRecNum.Text)
                vParams(modUtility.Increment(I)) = pvForm.TxtSSN.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtAge.Text
                vParams(modUtility.Increment(I)) = pvForm.CboAgeUnit.Text
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboRace)
                vParams(modUtility.Increment(I)) = pvForm.CboGender.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtWeight.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtAdmitDate.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtAdmitTime.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtDeathDate.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtDeathTime.Text

                'Add LSA Date Time CCRST151 ccarroll 09/06/2011
                vParams(modUtility.Increment(I)) = pvForm.TxtLSADate.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtLSATime.Text

                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboCauseOfDeath)
                vParams(modUtility.Increment(I)) = pvForm.CboVent.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtExtubated.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtDOB.Text
                vParams(modUtility.Increment(I)) = modConv.ChkValueToDBTrueValue(pvForm.ChkDOA.Checked)
                vParams(modUtility.Increment(I)) = pvForm.TxtNotesCase.Text

                'Type and Approach Info
                vParams(modUtility.Increment(I)) = pvForm.pvPrelimReferralType
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboReferralType)
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboApproachType)
                vParams(modUtility.Increment(I)) = pvForm.ApproachedByID
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboGeneralConsent)
                vParams(modUtility.Increment(I)) = pvForm.NOK
                vParams(modUtility.Increment(I)) = pvForm.NOKRelation
                vParams(modUtility.Increment(I)) = pvForm.NOKPhone
                vParams(modUtility.Increment(I)) = pvForm.NOKRefAddress
                vParams(modUtility.Increment(I)) = pvForm.AttendingMDID
                vParams(modUtility.Increment(I)) = pvForm.PronouncingMDID
                vParams(modUtility.Increment(I)) = modConv.ChkValueToDBTrueValue(pvForm.ChkCoronerCase.Checked)
                vParams(modUtility.Increment(I)) = pvForm.CboCoronerName.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtCoronerPhone.Text
                vParams(modUtility.Increment(I)) = pvForm.CboCoronerOrg.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtCoronerNote.Text

                'Options Info
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(ORGAN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(ORGAN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(ORGAN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(ORGAN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(BONE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(BONE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(BONE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(BONE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(TISSUE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(TISSUE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(TISSUE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(TISSUE)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(SKIN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(SKIN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(SKIN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(SKIN)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(VALVES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(VALVES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(VALVES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(VALVES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(EYES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(EYES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(EYES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(EYES)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboAppropriate(RESEARCH)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboApproach(RESEARCH)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboConsent(RESEARCH)))
                vParams(modUtility.Increment(I)) = modConv.TextToLng(modControl.GetID(pvForm.CboRecovery(RESEARCH)))

                vParams(modUtility.Increment(I)) = pvForm.DonorSearchState.DonorRegistryTypeSelection
                vParams(modUtility.Increment(I)) = pvForm.DonorSearchState.DonorRegId
                vParams(modUtility.Increment(I)) = pvForm.DonorSearchState.DonorDMVId
                vParams(modUtility.Increment(I)) = 0 'DonorDMVTable
                vParams(modUtility.Increment(I)) = pvForm.DonorIntentDone
                vParams(modUtility.Increment(I)) = pvForm.DonorFaxSent
                vParams(modUtility.Increment(I)) = pvForm.DonorSearchState.DonorDSNID

                'mds 01/07/04 Added Heartbeat field
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboHeartBeat)

                '06/24/05 C.Chaput New fields for Release 8.0
                vParams(modUtility.Increment(I)) = pvForm.TxtBrainDeathDate.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtBrainDeathTime.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtPronouncingPhone.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtAttendingPhone.Text
                vParams(modUtility.Increment(I)) = modConv.ChkValueToDBTrueValue(pvForm.ChkDOB.Checked)
                vParams(modUtility.Increment(I)) = pvForm.TxtDonorMI.Text
                vParams(modUtility.Increment(I)) = pvForm.TxtSpecificCOD.Text
                vParams(modUtility.Increment(I)) = IIf(IsNothing(pvForm.NOKID), System.DBNull.Value, pvForm.NOKID)

                'ccarroll 06/02/2006 - Added QA Review Complete
                'ccarroll 10/19/2007 - Empirix 7012, 7017. Changed to actual value to allow both ASP and Statline QA
                vParams(modUtility.Increment(I)) = vQAResetSwitch 'modConv.ChkValueToDBTrueValue(pvForm.ChkQAReview.Checked)

                'T.T 09/01/2005 Added for CoronerOrgID
                vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboCoronerOrg)

                'bret 06/07/2007 - add LastStatEmployeeID
                vParams(modUtility.Increment(I)) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

                If pvForm.bolDCDPotentialSelected Then
                    vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.cboDCDPotential)
                Else
                    vParams(modUtility.Increment(I)) = DBNull.Value
                End If

                If pvForm.CallerOrg.ServiceLevel.PendingCase Then
                    vParams(modUtility.Increment(I)) = modConv.ChkValueToDBTrueValue(pvForm.ChkPendingCase.Checked)
                    vParams(modUtility.Increment(I)) = modControl.GetID(pvForm.CboPendingCaseCoordinator)
                    vParams(modUtility.Increment(I)) = pvForm.TxtPendingCaseComment.Text
                Else
                    vParams(modUtility.Increment(I)) = 0
                    vParams(modUtility.Increment(I)) = DBNull.Value
                    vParams(modUtility.Increment(I)) = DBNull.Value
                End If
                vParams(modUtility.Increment(I)) = DBNull.Value

            Case "FrmNew"
                Dim frmNew As FrmNew = DirectCast(pvParentForm, FrmNew)

                ReDim vParams(10)

                vPhoneID = modConv.TextToLng(modStatSave.SavePhone(frmNew.TxtPhone.Text, WORK_NUM))
                vParams(0) = frmNew.CallId
                vParams(modUtility.Increment(I)) = vPhoneID
                vParams(modUtility.Increment(I)) = frmNew.TxtExtension.Text
                vParams(modUtility.Increment(I)) = frmNew.OrganizationId
                vParams(modUtility.Increment(I)) = frmNew.SubLocationID
                vParams(modUtility.Increment(I)) = frmNew.TxtLevel.Text
                vParams(modUtility.Increment(I)) = modControl.GetID(frmNew.TxtLevel)
                vParams(modUtility.Increment(I)) = frmNew.PersonID
                vParams(modUtility.Increment(I)) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
                vParams(modUtility.Increment(I)) = IIf(frmNew.ReferralId = 0, System.DBNull.Value, frmNew.ReferralId)
                vParams(modUtility.Increment(I)) = 0

        End Select

        'Specify the fields
        Select Case pvParentForm.Name
            Case "FrmReferral"
                'bjk 10/29/02 changed vFields from 84 to 76
                'mds 01/07/04 changed vFields from 77 to 78
                ReDim vFields(98)

                I = 0

                'Call Info
                vFields(0) = "@CallID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerPhoneID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerExtension"
                vFields(modUtility.Increment(I)) = "@ReferralCallerOrganizationID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerSubLocationID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerSubLocationLevel"
                vFields(modUtility.Increment(I)) = "@ReferralCallerLevelID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerPersonID"

                'Donor Info
                vFields(modUtility.Increment(I)) = "@ReferralDonorFirstName"
                vFields(modUtility.Increment(I)) = "@ReferralDonorLastName"
                vFields(modUtility.Increment(I)) = "@ReferralDonorName"
                vFields(modUtility.Increment(I)) = "@ReferralDonorRecNumber"
                vFields(modUtility.Increment(I)) = "@ReferralDonorRecNumberSearchable"
                vFields(modUtility.Increment(I)) = "@ReferralDonorSSN"
                vFields(modUtility.Increment(I)) = "@ReferralDonorAge"
                vFields(modUtility.Increment(I)) = "@ReferralDonorAgeUnit"
                vFields(modUtility.Increment(I)) = "@ReferralDonorRaceID"
                vFields(modUtility.Increment(I)) = "@ReferralDonorGender"
                vFields(modUtility.Increment(I)) = "@ReferralDonorWeight"
                vFields(modUtility.Increment(I)) = "@ReferralDonorAdmitDate"
                vFields(modUtility.Increment(I)) = "@ReferralDonorAdmitTime"
                vFields(modUtility.Increment(I)) = "@ReferralDonorDeathDate"
                vFields(modUtility.Increment(I)) = "@ReferralDonorDeathTime"

                'Add LSA Date Time CCRST151 ccarroll 09/06/2011
                vFields(modUtility.Increment(I)) = "@ReferralDonorLSADate"
                vFields(modUtility.Increment(I)) = "@ReferralDonorLSATime"

                vFields(modUtility.Increment(I)) = "@ReferralDonorCauseOfDeathID"
                vFields(modUtility.Increment(I)) = "@ReferralDonorOnVentilator"
                vFields(modUtility.Increment(I)) = "@ReferralExtubated"
                vFields(modUtility.Increment(I)) = "@ReferralDOB"
                vFields(modUtility.Increment(I)) = "@ReferralDOA"
                vFields(modUtility.Increment(I)) = "@ReferralNotesCase"

                'Type and Approach Info
                ' Changed ReferralTypeId to CurrentReferralTypeId.  v.8.0 5/18/05 - SAP
                vFields(modUtility.Increment(I)) = "@ReferralTypeID"
                vFields(modUtility.Increment(I)) = "@CurrentReferralTypeId"
                vFields(modUtility.Increment(I)) = "@ReferralApproachTypeID"
                vFields(modUtility.Increment(I)) = "@ReferralApproachedByPersonID"
                vFields(modUtility.Increment(I)) = "@ReferralGeneralConsent"
                vFields(modUtility.Increment(I)) = "@ReferralApproachNOK"
                vFields(modUtility.Increment(I)) = "@ReferralApproachRelation"
                vFields(modUtility.Increment(I)) = "@ReferralNOKPhone"
                vFields(modUtility.Increment(I)) = "@ReferralNOKAddress"
                vFields(modUtility.Increment(I)) = "@ReferralAttendingMD"
                vFields(modUtility.Increment(I)) = "@ReferralPronouncingMD"
                vFields(modUtility.Increment(I)) = "@ReferralCoronersCase"
                vFields(modUtility.Increment(I)) = "@ReferralCoronerName"
                vFields(modUtility.Increment(I)) = "@ReferralCoronerPhone"
                vFields(modUtility.Increment(I)) = "@ReferralCoronerOrganization"
                vFields(modUtility.Increment(I)) = "@ReferralCoronerNote"

                'Options Info
                vFields(modUtility.Increment(I)) = "@ReferralOrganAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralOrganApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralOrganConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralOrganConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralBoneAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralBoneApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralBoneConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralBoneConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralTissueAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralTissueApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralTissueConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralTissueConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralSkinAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralSkinApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralSkinConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralSkinConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralValvesAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralValvesApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralValvesConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralValvesConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesTransAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesTransApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesTransConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesTransConversionID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesRschAppropriateID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesRschApproachID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesRschConsentID"
                vFields(modUtility.Increment(I)) = "@ReferralEyesRschConversionID"
                vFields(modUtility.Increment(I)) = "@DonorRegistryType"
                vFields(modUtility.Increment(I)) = "@DonorRegId"
                vFields(modUtility.Increment(I)) = "@DonorDMVId"
                vFields(modUtility.Increment(I)) = "@DonorDMVTable"
                vFields(modUtility.Increment(I)) = "@DonorIntentDone"
                vFields(modUtility.Increment(I)) = "@DonorFaxSent"
                vFields(modUtility.Increment(I)) = "@DonorDSNID"

                '01/07/04 mds Added HeartBeat field
                vFields(modUtility.Increment(I)) = "@ReferralDonorHeartBeat"

                '06/24/05 C.Chaput New fields for Release 8.0
                vFields(modUtility.Increment(I)) = "@ReferralDonorBrainDeathDate"
                vFields(modUtility.Increment(I)) = "@ReferralDonorBrainDeathTime"
                vFields(modUtility.Increment(I)) = "@ReferralPronouncingMDPhone"
                vFields(modUtility.Increment(I)) = "@ReferralAttendingMDPhone"
                vFields(modUtility.Increment(I)) = "@ReferralDOB_ILB"
                vFields(modUtility.Increment(I)) = "@ReferralDonorNameMI"
                vFields(modUtility.Increment(I)) = "@ReferralDonorSpecificCOD"
                vFields(modUtility.Increment(I)) = "@ReferralNOKID"

                'ccarroll 06/02/06 - Added QA Review Complete
                vFields(modUtility.Increment(I)) = "@ReferralQAReviewComplete"

                'T.T 09/01/2005 added CoronerOrgID
                vFields(modUtility.Increment(I)) = "@ReferralCoronerOrgID"

                'bret 06/07/2007 - add LastStatEmployeeID
                vFields(modUtility.Increment(I)) = "@LastStatEmployeeID"

                vFields(modUtility.Increment(I)) = "@ReferralDCDPotential"

                vFields(modUtility.Increment(I)) = "@ReferralPendingCase"
                vFields(modUtility.Increment(I)) = "@ReferralPendingCaseCoordinator"
                vFields(modUtility.Increment(I)) = "@ReferralPendingCaseComment"
                vFields(modUtility.Increment(I)) = "@IsERferralCase"

            Case "FrmNew"

                ReDim vFields(10)

                I = 0

                'Call Info
                vFields(0) = "@CallID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerPhoneID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerExtension"
                vFields(modUtility.Increment(I)) = "@ReferralCallerOrganizationID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerSubLocationID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerSubLocationLevel"
                vFields(modUtility.Increment(I)) = "@ReferralCallerLevelID"
                vFields(modUtility.Increment(I)) = "@ReferralCallerPersonID"

                vFields(modUtility.Increment(I)) = "@LastStatEmployeeID"
                vFields(modUtility.Increment(I)) = "@ReferralID"
                vFields(modUtility.Increment(I)) = "@IsERferralCase"

        End Select

        'Build and execute the query
        If pvParentForm.Name = "FrmNew" And pvParentForm.ReferralId <= 0 Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)
            vQuery = "EXEC ReferralInsert " & vValues

            'Wrap database insert in a try/catch block to trap any errors
            Try
                vResult = modODBC.Exec(vQuery, vReturn)
                SaveReferral = vReturn(0, 0)
            Catch ex As Exception
                'Log a detailed message when an attempt to save a referral fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to insert referral. vQuery: " & vQuery, ex)
                StatTracLogger.CreateInstance().Write(newEx)
                SaveReferral = SQL_ERROR
            End Try


        ElseIf (pvParentForm.Name = "FrmReferral") Or (pvParentForm.Name = "FrmNew" And pvParentForm.ReferralId > 0) Then


            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
            vQuery = "EXEC ReferralUpdate " & vValues

            'Wrap database update in a try/catch block to trap any errors
            Try
                vResult = modODBC.Exec(vQuery)
                SaveReferral = pvParentForm.ReferralId
            Catch ex As Exception
                'Log a detailed message when an attempt to save a referral fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update referral. vQuery: " & vQuery, ex)
                StatTracLogger.CreateInstance().Write(newEx)
                SaveReferral = SQL_ERROR
            End Try

        End If


        'ccarroll 09/12/06 StatTrac 8.2 release (4.1.4.3.1.1)
        'This updates FS Initial approach information (SecondaryApproach)
        If pvParentForm.Name <> "FrmNew" Then 'Char Chaput added for release 8.0 autosave from FrmNew
            'bret 05/09/07 8.4.3.8 should not call FSInitialApproach if FrmNew
            vQuery = "Exec spu_UpdateFSInitialApproach " & pvParentForm.CallId & ", " & modControl.GetID(pvParentForm.CboApproachType) & ", " & pvParentForm.ApproachedByID & ", " & modControl.GetID(pvParentForm.CboGeneralConsent)

            'Wrap database update in a try/catch block to trap any errors
            Try
                modODBC.Exec(vQuery)
            Catch ex As Exception
                'Log a detailed message when an attempt to update FS Initial Approach fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update FS Initial Approach. vQuery: " & vQuery, ex)
                StatTracLogger.CreateInstance().Write(newEx)
            End Try

            'T.T 09/13/2004 added to save registry status in a different table
            'If FrmReferral.cboRegistryStatus.Visible = True Then       'Commented out for recycle tab

            Dim registryStatusText As String
            registryStatusText = pvParentForm.cboRegistryStatus.Text

            If registryStatusText <> "" Then
                vQuery = "Select ID from RegistryStatusType where RegistryType = " & "'" & registryStatusText & "'"
            Else
                vQuery = "Select ID from RegistryStatusType where RegistryType = " & "'Not Checked'"
            End If

            'Wrap database select in a try/catch block to trap any errors
            Try
                Call modODBC.Exec(vQuery, vResult, , True, vRS)
            Catch ex As Exception
                'Log a detailed message when an attempt to select a registry status type fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to select registry status type. vQuery: " & vQuery, ex)
                StatTracLogger.CreateInstance().Write(newEx)
            End Try
            RegValue = vRS("ID").Value
            vRS = Nothing
            vQuery = "Select * from RegistryStatus where CallID = " & pvParentForm.CallId

            'Wrap database select in a try/catch block to trap any errors
            Try
                Call modODBC.Exec(vQuery, vResult, , True, vRS)
            Catch ex As Exception
                'Log a detailed message when an attempt to select a registry status fails
                Dim m = Reflection.MethodBase.GetCurrentMethod()
                Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to select registry status. vQuery: " & vQuery, ex)
                StatTracLogger.CreateInstance().Write(newEx)
            End Try

            'check if there are any records
            Dim registryStatusID As Object
            If (vRS.EOF) Then
                registryStatusID = System.DBNull.Value
            Else
                registryStatusID = vRS("ID").Value
            End If

            ReDim vParams(3)
            vParams(0) = pvParentForm.CallId
            vParams(1) = RegValue
            vParams(2) = registryStatusID 'T.T 06/29/2007 changed from vRS(0,0) to vRS("ID").Value was not working
            vParams(3) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

            ReDim vFields(3)
            vFields(0) = "@CallID"
            vFields(1) = "@RegistryStatus"
            vFields(2) = "@ID"
            vFields(3) = "@LastStatEmployeeID"

            'The record exists and should be updated.
            vValues = ""
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            If vRS.EOF = True Then
                vQuery = "EXEC InsertRegistryStatus " & vValues

                'Wrap database insert in a try/catch block to trap any errors
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    'Log a detailed message when an attempt to insert a registry status fails
                    Dim m = Reflection.MethodBase.GetCurrentMethod()
                    Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to insert registry status. vQuery: " & vQuery, ex)
                    StatTracLogger.CreateInstance().Write(newEx)
                End Try
            Else
                vQuery = "EXEC UpdateRegistryStatus " & vValues

                'Wrap database update in a try/catch block to trap any errors
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    'Log a detailed message when an attempt to update a registry status fails
                    Dim m = Reflection.MethodBase.GetCurrentMethod()
                    Dim newEx = New Exception(m.ReflectedType.Name & "." & m.Name & " - Failed to update registry status. vQuery: " & vQuery, ex)
                    StatTracLogger.CreateInstance().Write(newEx)
                End Try
            End If
            'End If
        End If
    End Function

    Public Function SaveRegStatusFS(ByRef pvForm As FrmReferralView) As Object
        Dim vQuery As New Object
        Dim vResult As New Object
        Dim vRS As New Object
        Dim RegValue As New Object
        Dim vValues As New Object
        Dim statusText As String

        statusText = pvForm.cboRegistryStatusFS.SelectedItem
        'T.T 09/13/2004 added to save registry status in a different table
        'If FrmReferral.cboRegistryStatus.Visible = True Then       'Commented out for recycle tab
        If statusText <> Nothing Then
            vQuery = "Select ID from RegistryStatusType where RegistryType = " & "'" & statusText & "'"
        Else
            vQuery = "Select ID from RegistryStatusType where RegistryType = " & "'Not Checked'"
        End If
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        RegValue = vRS.Fields("ID").Value
        vRS = Nothing
        vQuery = "EXEC SelectRegistryStatus @CallID = " & pvForm.CallId & " ;"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim vParams(3) As Object
        vParams(0) = pvForm.CallId
        vParams(1) = RegValue
        vParams(2) = vRS.Fields("ID").Value 'T.T 06/29/2007 changed from vRS(0,0) to vRS("ID").Value was not working
        vParams(3) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Dim vFields(3) As Object
        vFields(0) = "@CallID"
        vFields(1) = "@RegistryStatus"
        vFields(2) = "@ID"
        vFields(3) = "@LastStatEmployeeID"

        'The record exists and should be updated.
        vValues = ""
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        If vRS.EOF = True Then
            vQuery = "EXEC InsertRegistryStatus " & vValues
            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            vQuery = "EXEC UpdateRegistryStatus " & vValues
            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If
        'End If

    End Function

    Public Function UpdateCurrentReferralType(ByRef callId As Integer, ByRef serviceLevelId As Integer, ByRef lastStatEmployeeId As Integer) As Integer

        Dim vQuery As String = "EXEC UpdateCurrentReferralType @CallId=" & callId & ", @ServiceLevelID=" & serviceLevelId & ", @LastStatEmployeeID=" & lastStatEmployeeId & ";"

        Dim vResult As Short
        Dim vReturn As New Object

        'Execute the query
        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
            UpdateCurrentReferralType = vReturn(0, 0)
        Else
            UpdateCurrentReferralType = SQL_ERROR
        End If

    End Function

    Public Function SaveSecondaryTriage(ByRef pvForm As FrmReferralView, ByRef CtlList As Object) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim vGridValues As New Object
        Dim vResult As Short
        Dim I As Integer
        Dim vReturn As New Object


        '***************************************************************
        'BEGIN - UPDATE REFERRAL TABLE*********************************
        '***************************************************************
        'Get the referral information
        Dim vParams(39) As Object 'ccarroll 01/28/2013 wi5458 - Increased array declaration value

        'Call Info
        vParams(0) = pvForm.CallId

        'Textbox/Phone (special)
        For I = 0 To 0
            vParams(I + 1) = modConv.TextToLng(modStatSave.SavePhone(pvForm.DataTextArray(CtlList(0, I)).Text, WORK_NUM))
        Next I

        'Textbox/DB Varchar
        For I = 1 To 19
            vParams(I + 1) = pvForm.DataTextArray(CtlList(0, I)).Text
        Next I

        'Combobox/DB Integer
        For I = 20 To 24
            vParams(I + 1) = modControl.GetID(pvForm.DataComboArray(CtlList(0, I)))
        Next I

        'Combobox/DB Integer (special case - ie. checkbox in Triage)
        For I = 24 To 24
            If modControl.GetID(pvForm.DataComboArray(CtlList(0, I))) = 1 Then
                vParams(I + 1) = -1
            Else
                '9/20/02 drh - Anything other than a Yes in Secondary is No in Triage
                'vParams(i + 1) = modControl.GetID(pvForm.DataComboArray(CtlList(0, i)))
                vParams(I + 1) = 0
            End If
        Next I

        'Combobox/DB Text
        For I = 25 To 30
            vParams(I + 1) = pvForm.DataComboArray(CtlList(0, I)).Text
        Next I



        vParams(31) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(32) = pvForm.NOKID

        'ccarroll 10/23/2007 - added Donor registry data
        vParams(33) = pvForm.DonorSearchState.DonorDSNID
        vParams(34) = pvForm.DonorSearchState.DonorDMVId
        vParams(35) = pvForm.DonorSearchState.DonorRegId

        'ccarroll 09/08/2011 LSA Date Time - CCRST151 
        vParams(36) = pvForm.DataTextArray(CtlList(0, 30)).Text '@ReferralDonorLSADate
        vParams(37) = pvForm.DataTextArray(CtlList(0, 31)).Text '@ReferralDonorLSATime

        'ccarroll 01/28/2013 Capture ReferralCoronerOrgId and update Triage
        vParams(38) = pvForm.CoronerOrgID  '@ReferralCoronerOrgID

        vParams(39) = pvForm.DataTextArray(CtlList(0, 32)).Text

        'Specify the fields
        Dim vFields(39) As Object 'ccarroll 01/28/2013 wi5458 - Increased array declaration value
        I = 0

        'Call Info
        vFields(0) = "@CallID"

        For I = 0 To 30
            vFields(I + 1) = "@" & CtlList(2, I)
        Next I

        vFields(31) = "@LastStatEmployeeID"
        vFields(32) = "@ReferralNOKID"

        'ccarroll 10/23/2007 - added Donor registry data
        vFields(33) = "@DonorDSNID"
        vFields(34) = "@DonorDMVId"
        vFields(35) = "@DonorRegId"

        'ccarroll 09/08/2011 LSA Date Time - CCRST151
        vFields(36) = "@ReferralDonorLSADate"
        vFields(37) = "@ReferralDonorLSATime"

        'ccarroll 01/28/2013 Capture ReferralCoronerOrgId and update Triage
        vFields(38) = "@ReferralCoronerOrgID"
        vFields(39) = "@ReferralCallerExtension"

        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "EXEC UpdateReferralFS " & vValues

        'Execute the query
        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'bjk 10/29/02 call update to SaveDispositions
        '07/02/07 bret 8.4.3.8 removed for AuditTrail UpdateReferral Updates disposition
        'SaveDisposition (pvForm.CallId)

        '****************************************************************
        'END - UPDATE REFERRAL TABLE************************************
        '****************************************************************


        If vResult = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
            SaveSecondaryTriage = vReturn(0, 0)
        Else
            SaveSecondaryTriage = SQL_ERROR
        End If

    End Function
    Public Function SaveReferralTriageCriteria(ByRef pvForm As FrmReferral) As Integer
        'FSProj drh 5/01/02 - New function to save Triage Criteria ID's for historical criteria purposes

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim vGridValues As New Object
        Dim vResult As Short
        Dim I As Integer
        Dim vReturn As New Object


        'FSProj drh 5/3/02 - Check if Triage Criteria is valid
        '********************************************************************************************
        If Not pvForm.CriteriaValid Then
            'Clear Criteria collection
            Call pvForm.ClearCriteria()

            'Add zeros
            For I = ORGAN To RESEARCH
                Call pvForm.ReferralTriageCriteria.Add(0, CStr(I))
            Next I
        End If
        '********************************************************************************************

        'Get the referral information
        Dim vParams(8) As Object

        I = 0

        'Call Info
        vParams(0) = pvForm.CallId
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("1"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("2"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("3"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("4"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("5"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("6"))
        vParams(modUtility.Increment(I)) = pvForm.ReferralTriageCriteria.Item(CStr("7"))

        'ServiceLevelId
        vParams(modUtility.Increment(I)) = pvForm.ServiceLevelId

        'Specify the fields
        Dim vFields(8) As Object

        I = 0

        'Call Info
        vFields(0) = "@CallId"
        vFields(modUtility.Increment(I)) = "@OrganCriteriaId"
        vFields(modUtility.Increment(I)) = "@BoneCriteriaId"
        vFields(modUtility.Increment(I)) = "@TissueCriteriaId"
        vFields(modUtility.Increment(I)) = "@SkinCriteriaId"
        vFields(modUtility.Increment(I)) = "@ValvesCriteriaId"
        vFields(modUtility.Increment(I)) = "@EyesCriteriaId"
        vFields(modUtility.Increment(I)) = "@OtherCriteriaId"

        'Service LevelId
        vFields(modUtility.Increment(I)) = "@ServiceLevelId"


        'Build and execute the query
        Try
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        vQuery = "CallCriteriaMerge " & vValues & ";"

        'Execute the query
        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Make sure we got a successful result with an object array returned
        If vResult = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
            Try
                SaveReferralTriageCriteria = vReturn(0, 0)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                SaveReferralTriageCriteria = SQL_ERROR
            End Try
        Else
            SaveReferralTriageCriteria = SQL_ERROR
        End If

    End Function


    Public Function SaveMessage(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: SaveMessage
        'Date Created: Unknown                          Created by: Tim Klug
        'Release: Unknown                               Task: Unknown
        'Description: Saves and Updates Message and Import Information
        'Returns:
        'Params: pvForm = calling form,
        'Stored Procedures: UpdateMessage and InsertMessage
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use UpdateMessage and InsertMessage
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vResult As Short
        Dim vReturn As New Object
        Dim prResults As New Object

        'Get the Message information
        Dim vParams(13) As Object

        'Call Info
        Select Case pvForm.Name
            Case "FrmMessage"
                vParams(0) = pvForm.CallId
                vParams(1) = pvForm.LblName.Text
                vParams(2) = pvForm.LblPhone.Text
                vParams(3) = pvForm.LblOrganization.Text
                vParams(4) = modControl.GetID(pvForm.CboOrganization)
                vParams(5) = pvForm.PersonID
                vParams(6) = pvForm.MessageTypeID
                vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkUrgent.Checked)

            Case "FrmNew"
                vParams(0) = pvForm.CallId
                vParams(1) = pvForm.TxtCallerName.Text
                vParams(2) = pvForm.TxtPhone.Text
                vParams(3) = pvForm.TxtCallerOrganization.Text
                vParams(4) = pvForm.OrganizationId
                vParams(5) = pvForm.PersonID
                vParams(6) = pvForm.MessageTypeID
                'ccarroll 09/19/2008 added IIf statement for AuditTrail
                'if the message is an Import offer make CallBackASAP default (-1, Yes) if not make it (0, No.)
                'was hardcoded: vParams(7) = -1 for all message types.
                vParams(7) = IIf(pvForm.MessageTypeID = 2, -1, 0)
        End Select


        'If the message is an import offer and it is a new record,
        'then append the import fields to the
        'message text so it appears on reports
        If pvForm.MessageTypeID = 2 And pvForm.FormState = NEW_RECORD Then
            vParams(8) = pvForm.TxtMessage.Text & Chr(10) & " - Center:  " & pvForm.TxtImportCenter.Text & ",   " & "Patient:  " & pvForm.TxtImportPatient.Text & ",   " & "UNOS ID:  " & pvForm.TxtUNOSID.Text
        ElseIf Not IsNothing(pvForm.GetType().GetProperty("TxtMessage")) Then
            vParams(8) = pvForm.TxtMessage.Text
        End If


        If pvForm.Name = "FrmMessage" Then
            vParams(9) = pvForm.LblExtension.Text
        Else
            vParams(9) = pvForm.TxtExtension.Text
        End If
        If Not IsNothing(pvForm.GetType().GetProperty("TxtImportPatient")) Then
            vParams(10) = pvForm.TxtImportPatient.Text
        End If
        If Not IsNothing(pvForm.GetType().GetProperty("TxtUNOSID")) Then
            vParams(11) = pvForm.TxtUNOSID.Text
        End If
        If Not IsNothing(pvForm.GetType().GetProperty("TxtImportCenter")) Then
            vParams(12) = pvForm.TxtImportCenter.Text
        End If
        vParams(13) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        'Specify the fields
        Dim vFields(13) As Object

        'Call Info
        vFields(0) = "@CallID"
        vFields(1) = "@MessageCallerName"
        vFields(2) = "@MessageCallerPhone"
        vFields(3) = "@MessageCallerOrganization"
        vFields(4) = "@OrganizationID"
        vFields(5) = "@PersonID"
        vFields(6) = "@MessageTypeID"
        vFields(7) = "@MessageUrgent"
        vFields(8) = "@MessageDescription"
        vFields(9) = "@MessageExtension"
        vFields(10) = "@MessageImportPatient"
        vFields(11) = "@MessageImportUNOSID"
        vFields(12) = "@MessageImportCenter"
        vFields(13) = "@LastStatEmployeeID"

        'Build and execute the query
        'If pvForm.FormState = NEW_RECORD Then
        If pvForm.Name = "FrmNew" And pvForm.ReferralId <= 0 Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

            vQuery = "EXEC InsertMessage " & vValues

            'Execute the query
            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveMessage = vReturn(0, 0)
            Else
                SaveMessage = SQL_ERROR
            End If

            'ElseIf pvForm.FormState = EXISTING_RECORD Then
        ElseIf (pvForm.Name = "FrmMessage") Or (pvForm.Name = "FrmNew" And pvForm.ReferralId > 0) Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdateMessage " & vValues

            'Execute the query
            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then
                SaveMessage = SUCCESS
            Else
                SaveMessage = SQL_ERROR
            End If
        End If



    End Function





    Public Function SaveNoCall(ByRef pvForm As Object) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the NoCall information
        Dim vParams(2) As Object

        'Call Info
        vParams(0) = pvForm.CallId
        vParams(1) = pvForm.NoCallTypeID
        vParams(2) = pvForm.TxtDescription.Text

        'Specify the fields
        Dim vFields(2) As Object

        'Call Info
        vFields(0) = "CallID"
        vFields(1) = "NoCallTypeID"
        vFields(2) = "NoCallDescription"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO NoCall (" & vValues & ")"

        ElseIf pvForm.FormState = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE NoCall SET " & vValues & " WHERE CallID = " & pvForm.CallId

        End If

        'Execute the query
        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function




    Public Function SaveSecondaryCall(ByRef pvForm As FrmReferralView, ByRef pvCallId As Object) As Integer
        '************************************************************************************
        'Name: SaveSecondaryCall
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Save Call data from the fs form
        'Returns: result
        'Params: pvForm = calling form,
        '        pvCallID
        '
        'Stored Procedures: UpdateFSCase and UpdateCall
        '====================================================================================
        'Date Changed: 07/02/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateFSCase and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim Values As String = ""
        Dim Query As String = ""
        Dim Result As Short
        Dim ResultArray As New Object
        Dim Params() As Object
        Dim Fields() As Object
        Dim vTimeZoneDif As Short
        Dim Org As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'T.T 7/6/04 Update the StatEmployeeID to reflect the change to a Lease Organization FS
        Org = 0
        Org = InStr(AppMain.ParentForm.LeaseOrganizationType, "FamilyServices")

        'Get the call data
        ReDim Params(11)

        Params(0) = pvForm.CallNumber
        Params(1) = pvForm.CallType
        Params(2) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CallDate))
        '7/2/07 bret 8.4.3.8 moved here to prevent two saves
        If Org > 0 Then
            Params(3) = AppMain.ParentForm.StatEmployeeID
        Else
            Params(3) = modControl.GetID(pvForm.CboCallByEmployee)
        End If
        Params(4) = modConv.ChkValueToDBTrueValue(pvForm.ChkTemp.Checked)

        'Make sure we have a valid SourceCodeID
        If pvForm.SourceCode Is Nothing OrElse pvForm.SourceCode.ID <= 0 Then
            Params(5) = System.DBNull.Value
            Dim exMessage As String = "StatSave.SaveSecondaryCall - Saving a call with an invalid SourceCode.  " +
                            "SourceCodeID: '" + pvForm.SourceCode.ID.ToString() +
                            "', CallID: " + pvCallId.ToString()
            Dim ex As Exception = New Exception("StatTrac Error: " + exMessage)
            StatTracLogger.CreateInstance().Write(ex)
        Else
            Params(5) = pvForm.SourceCode.ID
        End If

        Params(6) = IIf(pvForm.CloseAfterSave, -1, AppMain.ParentForm.StatEmployeeID)
        Params(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkExclusive.Checked)

        If Params(4) = -1 Then
            Params(8) = AppMain.ParentForm.StatEmployeeID
        Else
            Params(8) = -1
        End If

        If IsNothing(pvCallId) Then
            Params(9) = AppMain.Extension
        End If

        Params(10) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        Params(11) = pvCallId
        'Specify the field names
        ReDim Fields(11)

        Fields(0) = "@CallNumber"
        Fields(1) = "@CallTypeID"
        Fields(2) = "@CallDateTime"
        Fields(3) = "@StatEmployeeID"
        Fields(4) = "@CallTemp"
        Fields(5) = "@SourceCodeID"
        Fields(6) = "@CallOpenByID"
        Fields(7) = "@CallTempExclusive"
        Fields(8) = "@CallTempSavedByID"

        Fields(9) = "@CallExtension"
        Fields(10) = "@CallSaveLastByID"
        Fields(11) = "@CallID"


        '10/24/01 drh Temporary code to trap mismatched callid/callnumber
        If Trim(pvCallId) <> Left(Trim(pvForm.CallNumber), InStr(1, Trim(pvForm.CallNumber), "-") - 1) Then
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "CallId: " & Trim(pvCallId) & " CallNumber: " & Trim(pvForm.CallNumber))
        End If

        'The record exists and should be updated.
        Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

        Query = "EXEC UpdateCall " & Values

        Try
            Result = modODBC.Exec(Query)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Result = SUCCESS Then
            SaveSecondaryCall = pvCallId

            Query = "EXEC UpdateFSCase @FSCaseTotalTime = '" & pvForm.TxtTotalTimeCounter.Text & "' " & ", @FSCaseSeconds = " & (Hour(pvForm.TxtTotalTimeCounter.Text) * 3600) + (Minute(pvForm.TxtTotalTimeCounter.Text) * 60) + (Second(pvForm.TxtTotalTimeCounter.Text)) & ", @CallID = " & pvCallId & ", @timeZone = " & AppMain.ParentForm.TimeZone

            Try
                Result = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Result = SUCCESS Then
                SaveSecondaryCall = pvCallId
            Else
                LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to update fscase. Query = " & Query)
            End If
        Else
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to update call. Query = " & Query)
        End If

    End Function

    Public Function SaveSecondaryApproach(ByRef pvForm As FrmReferralView) As Integer
        '************************************************************************************
        'Name: SaveSecondaryApproach
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: Saves SecondaryApproach data
        'Returns: result
        'Params: pvForm = calling form
        '
        'Stored Procedures: UpdateSecondaryApproach and InsertSecondaryApproach
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim Values As String = ""
        Dim Query As String = ""
        Dim Result As Short
        Dim ResultArray As New Object
        Dim Params() As Object
        Dim Fields() As Object

        ReDim Params(17)

        Params(0) = pvForm.CallId
        Params(1) = modControl.GetID(pvForm.cboApproached)
        Params(2) = modControl.GetID(pvForm.cboApproachedBy)
        Params(3) = modControl.GetID(pvForm.cboApproachType)
        Params(4) = modControl.GetID(pvForm.cboApproachOutcome)
        Params(5) = modControl.GetID(pvForm.cboApproachReason)
        Params(6) = modControl.GetID(pvForm.cboConsent)
        Params(7) = modControl.GetID(pvForm.cboConsentBy)
        Params(8) = modControl.GetID(pvForm.cboConsentResearch)

        'drh FSMod 05/28/03 - New Approach/Consent fields
        Params(9) = modControl.GetID(pvForm.cboHospitalApproachType)
        Params(10) = modControl.GetID(pvForm.cboHospitalApproachedBy)
        Params(11) = modControl.GetID(pvForm.cboHospitalApproachOutcome)
        Params(12) = modControl.GetID(pvForm.cboConsentMedSocPaperwork)
        Params(13) = modControl.GetID(pvForm.cboConsentMedSocObtainedBy)
        Params(14) = modControl.GetID(pvForm.cboConsentFuneralPlan)
        Params(15) = pvForm.cboConsentFuneralPlan.Text
        Params(16) = modControl.GetID(pvForm.cboConsentLongSleeves)
        Params(17) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        'drh FSMod 05/28/03 - No longer using these flds
        'Params(8) = modControl.GetID(pvForm.cboConsentOutcome)
        'Params(10) = pvForm.txtRecoveryLocation.Text

        'Specify the field names
        ReDim Fields(17)

        Fields(0) = "@CallId"
        Fields(1) = "@SecondaryApproached"
        Fields(2) = "@SecondaryApproachedBy"
        Fields(3) = "@SecondaryApproachType"
        Fields(4) = "@SecondaryApproachOutcome"
        Fields(5) = "@SecondaryApproachReason"
        Fields(6) = "@SecondaryConsented"
        Fields(7) = "@SecondaryConsentBy"
        Fields(8) = "@SecondaryConsentResearch"

        'drh FSMod 05/28/03 - New Approach/Consent fields
        Fields(9) = "@SecondaryHospitalApproach"
        Fields(10) = "@SecondaryHospitalApproachedBy"
        Fields(11) = "@SecondaryHospitalOutcome"
        Fields(12) = "@SecondaryConsentMedSocPaperwork"
        Fields(13) = "@SecondaryConsentMedSocObtainedBy"
        Fields(14) = "@SecondaryConsentFuneralPlans"
        Fields(15) = "@SecondaryConsentFuneralPlansOther"
        Fields(16) = "@SecondaryConsentLongSleeves"
        Fields(17) = "@LastStatEmployeeID"

        'drh FSMod 05/28/03 - No longer using these flds
        'Fields(8) = "SecondaryConsentOutcome"
        'Fields(10) = "SecondaryRecoveryLocation"

        'See if a record exists
        '**************************************************************
        Dim vResult As New Object
        Dim vResultSet As New Object

        'Add the FROM/WHERE Clauses
        Query = "Select * FROM SecondaryApproach WHERE CallID = " & pvForm.CallId

        'Run the Query
        Try
            vResult = modODBC.Exec(Query, vResultSet)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        '**************************************************************

        'Build and execute the query
        If vResult = NO_DATA Then

            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, Params, Fields)

            Query = "EXEC InsertSecondaryApproach " & Values

            Try
                Result = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        ElseIf vResult = SUCCESS Then

            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "EXEC UpdateSecondaryApproach " & Values

            Try
                Result = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

        'ccarroll 09/14/2006 - Updates Triage approach information
        'replaces spu_TriageApproach1
        If Result = SUCCESS Then
            Query = "exec spu_TriageApproach " & pvForm.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            Try
                Result = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

    End Function
    Public Function SaveReferralCancel(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: SaveReferralCancel
        'Date Created: 06/08/07                          Created by: Bret Knoll
        'Release: 8.4                                    Task: AudiTrail
        'Description: This save method will complete all tasks related to Referral that were previously
        '             kicked off by the canel method of the FrmReferral. The goal is to reduce
        '             the number of saves.
        'Params: pvForm = calling form,
        '
        'Stored Procedures: UpdateReferral and InsertReferral
        '====================================================================================

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the call data
        Dim vParams(3) As Object

        If pvForm.GetType().GetField("ReferralId") IsNot Nothing Then
            vParams(0) = pvForm.ReferralId
        End If
        vParams(1) = pvForm.CallId
        vParams(2) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(3) = 2 ' 2 = Read

        'Specify the field names
        Dim vFields(3) As Object

        vFields(0) = "@ReferralID"
        vFields(1) = "@CallID"
        vFields(2) = "@LastStatEmployeeID"
        vFields(3) = "@AuditLogTypeID"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "EXEC UpdateReferralCancel " & vValues

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function SaveCallCancel(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: SaveCallCancel
        'Date Created: 06/08/07                          Created by: Bret Knoll
        'Release: 8.4                                    Task: AudiTrail
        'Description: This save method will complete all tasks related to Call that were previously
        '             kicked off by the canel method of the FrmReferral or FrmMessage. The goal is to reduce
        '             the number of saves.
        'Params: pvForm = calling form,
        '
        'Stored Procedures: UpdateCall and InsertCall
        '====================================================================================

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the call data
        Dim vParams(6) As Object

        vParams(0) = IIf(pvForm.CallOpenByID = 0, System.DBNull.Value, pvForm.CallOpenByID)
        vParams(1) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(2) = pvForm.CallId
        vParams(3) = pvForm.CallTotalTime
        vParams(4) = 2 ' 2 = Read
        vParams(5) = -1 'FrmReferral hit cancel on a recycled call
        vParams(6) = -1 'FrmReferral hit cancel on a recycled call

        'Specify the field names
        Dim vFields(6) As Object

        vFields(0) = "@CallOpenByID"
        vFields(1) = "@CallSaveLastByID"
        vFields(2) = "@CallID"
        vFields(3) = "@CallTotalTime"
        vFields(4) = "@AuditLogTypeID"
        vFields(5) = "@RecycleNCFlag"
        vFields(6) = "@CallActive"
        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "EXEC UpdateCall " & vValues




        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveTotalTime(ByRef pvForm As FrmNoCall) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the call data
        Dim vParams(0) As Object

        vParams(0) = pvForm.CallTotalTime

        'Specify the field names
        Dim vFields(0) As Object

        vFields(0) = "CallTotalTime"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE Call SET " & vValues & " WHERE " & "Call.CallID = " & pvForm.CallId

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function SaveCallOpenBy(ByRef pvForm As Object, Optional ByRef pvunlock As Short = 0) As Object
        '************************************************************************************
        'Name: SaveCallOpenBy
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Retrieves Call information from DB
        'Params: pvForm
        'Stored Procedures: spu_Update_Transaction
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple into a referral. Added a transaction
        'on the record along with modifying so that the call to modStatSave.SaveCallOpenBy
        'occured when the form was open. Added write to errorprod.
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add CallSaveLastBY
        '====================================================================================
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vResult As Short

        'Get the call data
        Dim vParams(4) As Object

        vParams(0) = pvForm.CallOpenByID
        vParams(1) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(2) = pvForm.CallId
        vParams(3) = IIf(pvunlock = 1, System.DBNull.Value, -1)
        vParams(4) = -1 ' set the WebCallOpenByID = 0
        'Specify the field names
        Dim vFields(4) As Object

        vFields(0) = "@CallOpenByID"
        vFields(1) = "@CallSaveLastByID"
        vFields(2) = "@CallID"
        vFields(3) = "@CheckCallOpenByID"
        vFields(4) = "@CallOpenByWebPersonId"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        'bret 06/09/07 8.4.3.8 this method is only called when a user open a call (referral, message, fs)
        vQuery = "EXEC UpdateCall " & vValues

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS Then
            SaveCallOpenBy = pvForm.CallId
        Else
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to update call. Query = " & vQuery)
            MsgBox("Warning! A database error has occurred.  This call may be locked. " & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Please reopen the call and save to unlock the call.", MsgBoxStyle.Critical, "Database Error")
        End If

    End Function
    Public Function UpdateReferralQAComplete(ByRef pvForm As Object) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vParams(0) As Object
        'ccarroll 06/12/2006 StatTrac 8.0 release - New events Update tab
        'ccarroll 10/19/2007 - Empirix 7012, 7017. Changed scope of vQAresetSwitch
        'Clear the QA Review complete flag because a new event was added to the referral
        'When this flag is set to 2, it will only allow ASP users to view the event under the Update tab, When
        'the flag is set to 1 only Statline users are allowed to view the referral in the Update tab.

        vParams(0) = vQAResetSwitch

        'Specify the field names
        Dim vFields(0) As Object

        vFields(0) = "ReferralQAReviewComplete"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE Referral SET " & vValues & " WHERE " & "Referral.CallID = " & pvForm.CallId

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function UpdateScheduleLock(ByRef pvForm As FrmSchedule, Optional ByRef pvRemovelock As Boolean = False) As Short
        '************************************************************************************
        'Name: UpdateScheduleLock
        'Date Created: 10/08/2008                       Created by: ccarroll
        'Release: 8.4.7                                 Task: Requirements for Update Screen on Reporting Site
        'Description: Retrieves Sechedule Lock information from ScheduleLock table
        'Params: pvForm
        'Stored Procedures: UpdateScheduleLock
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vResult As Short
        Dim vResultArray As New Object

        'Get data
        Dim vParams(2) As Object
        vParams(0) = pvForm.ScheduleGroupID
        vParams(1) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(2) = IIf(pvRemovelock = True, 1, 0)

        'Specify the field names
        Dim vFields(2) As Object
        vFields(0) = "@ScheduleGroupID"
        vFields(1) = "@StatEmployeeID"
        vFields(2) = "@RemoveLock"

        'Build and execute query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "EXEC UpdateScheduleLock " & vValues

        Try
            vResult = modODBC.Exec(vQuery, vResultArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim vReturn2 As New Object
        Dim vStatEmployeeID As New Object
        If vResult = SUCCESS _
            AndAlso ObjectIsValidArray(vResultArray, 2, 0, 3) Then

            If modConv.TextToInt(vResultArray(0, 3)) = 1 And modConv.TextToLng(vResultArray(0, 1)) <> modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) Then

                'Set lock status - If Schedule is locked, vResultArray(0, 3) will be 1, else 0
                UpdateScheduleLock = modConv.TextToInt(vResultArray(0, 3))

                vStatEmployeeID = vResultArray(0, 1)

                If modStatRefQuery.RefQueryStatEmployee(vReturn2, vStatEmployeeID) = SUCCESS _
                    AndAlso ObjectIsValidArray(vReturn2, 2, 0, 1) Then
                    MsgBox("Warning! This schedule is currently open by " & Chr(13) & Chr(10) & vReturn2(0, 1) & ". Please try again at a later time.", MsgBoxStyle.Exclamation, "Schedule locked for edit")
                End If

            Else
                'Set lock status - Either user has just opened schedule or already has schedule open and
                'pressed GetSchedule again
                UpdateScheduleLock = 0
            End If

        Else
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to update Sechedule Lock. Query = " & vQuery)
        End If

    End Function

    Public Function UpdateSecondaryAutoBillFamilyApproach(ByRef pvForm As FrmLogEvent) As Object
        '************************************************************************************
        'Name: UpdateSecondaryAutoBillFamilyApproach
        'Date Created: 06/06/2007                         Created by: Christopher Carroll
        'Release: StatTrac 8.4                            Task: requirement 3.2 - AutoBill
        'Description:   Increments Family Approach billing count when approach event occurs.
        '
        'Params: pvForm
        'Stored Procedures: spu_SecondaryAutoBillFamilyApproach
        '====================================================================================
        'Date Changed:                                    Changed by:
        'Release #:                                       Task:
        'Description:
        '====================================================================================

        Dim vQuery As New Object

        vQuery = "spu_SecondaryAutoBillFamilyApproach " & pvForm.CallId & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function UpdateSecondaryTBI(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: UpdateSecondaryTBI
        'Date Created: 06/06/2007                         Created by: Christopher Carroll
        'Release: StatTrac 8.4                            Task: requirement 3.6 - TBI Number
        'Description:   Updates TBI NotNeeded checkbox status, saves NotNeeded comment and
        '               records StatEmployee making change.
        'Params: pvForm
        'Stored Procedures: UpdateTBI
        '====================================================================================
        'Date Changed:                                    Changed by:
        'Release #:                                       Task:
        'Description:
        '====================================================================================

        Dim vQuery As New Object
        Dim TBIComment As String = ""

        TBIComment = Replace(pvForm.txtSecondaryTBIComment.Text, "'", " ")

        vQuery = "UpdateTBI " & pvForm.CallId & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", " & IIf(pvForm.chkSecondaryTBINotNeeded.Checked, -1, 0) & ", " & Chr(39) & TBIComment & Chr(39)

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function UpdateSecondaryAutoBillMedSoc(ByRef pvForm As FrmReferralView) As Object
        '************************************************************************************
        'Name: UpdateSecondaryAutoBillMedSoc
        'Date Created: 06/06/2007                         Created by: Christopher Carroll
        'Release: StatTrac 8.4                            Task: requirement 3.2 - AutoBill
        'Description:   Increments MedSoc billing count when DonorTrac button is pressed.
        '
        'Params: pvForm
        'Stored Procedures: spu_SecondaryAutoBillMedSoc
        '====================================================================================
        'Date Changed:                                    Changed by:
        'Release #:                                       Task:
        'Description:
        '====================================================================================

        Dim vQuery As New Object

        vQuery = "spu_SecondaryAutoBillMedSoc " & pvForm.CallId & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function UpdateSystemAlert(ByRef pvForm As FrmSystemAlert) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        'Get the call data
        Dim vParams(0) As Object

        If pvForm.SetResolved = True Then
            vParams(0) = -1
        Else
            vParams(0) = 1
        End If

        'Specify the field names
        Dim vFields(0) As Object

        vFields(0) = "SystemAlertResolved"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE SystemAlert SET " & vValues & " WHERE " & "SystemAlert.SystemAlertID = " & pvForm.SystemAlertID

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SavePendingEvent(ByRef pvForm As FrmLogEvent) As Object
        '************************************************************************************
        'Name: SavePendingEvent
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves pending events, by setting the CallbackPending
        'Returns: Return value of executed query in pvResults.
        'Params: pvForm = calling form,
        '
        'Stored Procedures: UpdateLogEvent
        '====================================================================================
        'Date Changed: 07/19/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use UpdateLogEvent
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the call data
        Dim vParams(2) As Object

        vParams(0) = pvForm.CallbackPending
        vParams(1) = pvForm.LogEventID
        vParams(2) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        'Specify the field names
        Dim vFields(2) As Object

        vFields(0) = "@LogEventCallbackPending"
        vFields(1) = "@LogEventID"
        vFields(2) = "@LastStatEmployeeID"
        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "EXEC UpdateLogEventClose " & vValues

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Exit Function

    End Function
    Public Function SaveOrganization(ByRef pvForm As FrmOrganization) As Integer
        '************************************************************************************
        'Name: SaveOrganization
        'Date Created: Unknown                          Created by: Tim Klug
        'Release: Unknown                               Task: Unknown
        'Description: Saves and Updates Organization
        'Params: pvForm = calling form,
        '
        '        pvResults = success status
        'Stored Procedures: UpdateOrganization and InsertOrganization
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use UpdateOrganization and InsertOrganization
        '               Add LastStatEmployeeID
        '====================================================================================

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim vOrganizationId As Integer
        Dim Result As New Object
        Dim ResultArray As New Object

        'First save the phone number
        'and get the ID.
        vPhoneID = modStatSave.SavePhone(pvForm.TxtCentralPhone.Text, WORK_NUM)

        'Get the call data
        Dim vParams(14) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.TxtAddress1.Text
        vParams(2) = pvForm.TxtAddress2.Text
        vParams(3) = pvForm.TxtCity.Text
        vParams(4) = modControl.GetID(pvForm.CboState)
        vParams(5) = pvForm.TxtZipCode.Text
        vParams(6) = modControl.GetID(pvForm.CboCounty)
        vParams(7) = modControl.GetID(pvForm.CboOrganizationType)
        vParams(8) = vPhoneID
        vParams(9) = pvForm.CboTimeZone.Text
        vParams(10) = pvForm.TxtNotes.Text
        vParams(11) = modConv.ChkValueToDBTrueValue(pvForm.ChkVerified.Checked)
        vParams(12) = pvForm.TxtCode.Text
        vParams(13) = IIf(pvForm.OrganizationId = 0, System.DBNull.Value, pvForm.OrganizationId)
        vParams(14) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        'Specify the table fields
        Dim vFields(14) As Object

        vFields(0) = "@OrganizationName"
        vFields(1) = "@OrganizationAddress1"
        vFields(2) = "@OrganizationAddress2"
        vFields(3) = "@OrganizationCity"
        vFields(4) = "@StateID"
        vFields(5) = "@OrganizationZipCode"
        vFields(6) = "@CountyID"
        vFields(7) = "@OrganizationTypeID"
        vFields(8) = "@PhoneID"
        vFields(9) = "@OrganizationTimeZone"
        vFields(10) = "@OrganizationNotes"
        vFields(11) = "@Verified"
        vFields(12) = "@OrganizationUserCode"
        vFields(13) = "@OrganizationID"
        vFields(14) = "@LastStatEmployeeID"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

            vQuery = "EXEC InsertOrganization " & vValues

            Try
                Result = modODBC.Exec(vQuery, ResultArray)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Result = SUCCESS _
                AndAlso ObjectIsValidArray(ResultArray, 2, 0, 0) Then
                SaveOrganization = modConv.TextToLng(ResultArray(0, 0))
                pvForm.OrganizationId = modConv.TextToLng(ResultArray(0, 0))
            End If

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdateOrganization " & vValues

            Try
                Result = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Result = SUCCESS Then
                SaveOrganization = pvForm.OrganizationId
            End If

            If pvForm.TxtName.Text <> pvForm.vOldTextOrganization Then
                'Added errprod functionality to track changes until audit trail is in place for organizations
                Err.Description = "ORGNAME: " & pvForm.vOldTextOrganization & " NEWNAME: " & pvForm.TxtName.Text & " ORGID: " & pvForm.OrganizationId & " USERID: " & AppMain.ParentForm.StatEmployeeID
                LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
            End If

        End If

    End Function

    Public Function SaveOrganizationProperties(ByRef pvForm As Object) As Integer
        '************************************************************************************
        'Name: SaveOrganizationProperties
        'Date Created: Unknown                          Created by: Tim Klug
        'Release: Unknown                               Task: Unknown
        'Description: Saves and Updates Organization
        'Params: pvForm = calling form,
        '
        '        pvResults = success status
        'Stored Procedures: UpdateOrganization and InsertOrganization
        '====================================================================================
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Set form field correctly by adding RTF to pvform.field.textRTF
        ' for FrmSchedule see end of function
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use UpdateOrganization and InsertOrganization
        '               Add LastStatEmployeeID
        '====================================================================================
        '====================================================================================
        'Date Changed: 01/08                       Changed JTH
        'Release #: 8.4                              Task: Ticket
        'Description:   Changed code to use UpdateOrganization and InsertOrganization
        '               Add LastStatEmployeeID
        '====================================================================================
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim ASPType() As Short 'T.T 5/15/2004 added for bitwise array
        Dim vLOBitwise As Short 'T.T 5/17/2004 bitwise value after all is added
        Dim vOrganizationId As Integer
        Dim I As Short
        Dim vReturn As New Object
        Dim vReturn1 As Object = New Object
        Dim vParams() As Object
        Dim vFields() As Object
        Dim vReturnCode As New Object 'T.T 5/17/2004 added for returncode

        If pvForm.Name = "FrmOrganizationProperties" Then

            'Get the data
            ReDim vParams(12)

            vParams(0) = modConv.ChkValueToDBTrueValue(pvForm.ChkNoPatientName.Checked)
            vParams(1) = modConv.ChkValueToDBTrueValue(pvForm.ChkNoMedRecord.Checked)
            vParams(2) = modConv.ChkValueToDBTrueValue(pvForm.ChkNoAdmitDateTime.Checked)
            vParams(3) = modConv.ChkValueToDBTrueValue(pvForm.ChkNoWeight.Checked)
            vParams(4) = modConv.TextToInt(pvForm.TxtPageInterval.Text)
            vParams(5) = modConv.TextToInt(pvForm.TxtConsentInterval.Text)
            vParams(6) = modConv.ChkValueToDBTrueValue(pvForm.ChkConfCall.Checked)
            vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkLeaseOrganization.Checked)
            vParams(8) = pvForm.OrganizationId
            vParams(9) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)


            'Specify the table fields
            ReDim vFields(12)

            vFields(0) = "@OrganizationNoPatientName"
            vFields(1) = "@OrganizationNoRecordNum"
            vFields(2) = "@OrganizationNoAdmitDateTime"
            vFields(3) = "@OrganizationNoWeight"
            vFields(4) = "@OrganizationPageInterval"
            vFields(5) = "@OrganizationConsentInterval"
            vFields(6) = "@OrganizationConfCallCust"
            vFields(7) = "@OrganizationLO"
            vFields(8) = "@OrganizationID"
            vFields(9) = "@LastStatEmployeeID"
            vFields(10) = "@OrganizationLOTriageEnabled"
            vFields(11) = "@OrganizationLOFSEnabled"
            vFields(12) = "@OrganizationLOType"

            'T.T 5/15/2004 added for bitwise calculations
            '********************************************
            If pvForm.ChkLeaseOrganization.Checked = 1 Then
                'T.T 5/19/2004 Check to see if Org exists in bitwise tables
                vReturnCode = modStatQuery.LeaseOrgExists(pvForm.OrganizationId, pvForm.OrganizationName, vReturn1)

                ReDim ASPType(1)
                vLOBitwise = 0
                'T.T 5/19/2004 add bitwise values to determine final bitwise type
                If pvForm.ChkTriageLO.Checked = 1 Then
                    ASPType(0) = 2 'T.T 6/3/2004 Triage bitwise number
                Else
                    vParams(10) = 0
                End If

                If pvForm.ChkFamilyServicesLO = 1 Then
                    ASPType(1) = 4 'T.T 6/1/2004 Family Services bitwise number
                Else
                    vParams(11) = 0

                End If

                For I = 0 To UBound(ASPType)
                    vLOBitwise = ASPType(I) + vLOBitwise
                Next I

                vParams(12) = vLOBitwise

                If vLOBitwise = 0 Then
                    vLOBitwise = 1
                    MsgBox("Warning! You must select a Lease Organization Type!", MsgBoxStyle.Critical)
                End If

                vQuery = "Update LeaseOrganization Set LeaseOrganizationType = " & vLOBitwise & " Where LeaseOrganization.LeaseOrganizationID = " & pvForm.OrganizationId

                Try
                    Call modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Else
                vParams(10) = 0
                vParams(11) = 0
                vParams(12) = 0
            End If
            '********************************************
            'T.T End Bitwize Calculations

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdateOrganizationProperties " & vValues


        ElseIf pvForm.Name = "FrmSchedule" Then

            'Get the data
            ReDim vParams(3)

            vParams(0) = pvForm.TxtReferralNotes.Rtf
            vParams(1) = pvForm.txtMessageNotes.Rtf
            vParams(2) = pvForm.OrganizationId
            vParams(3) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            'Specify the table fields
            ReDim vFields(3)

            vFields(0) = "@OrganizationReferralNotes"
            vFields(1) = "@OrganizationMessageNotes"
            vFields(2) = "@OrganizationID"
            vFields(3) = "@LastStatEmployeeID"

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdateOrganizationNote " & vValues

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Pass back the organization ID
        SaveOrganizationProperties = pvForm.OrganizationId

    End Function

    Public Function SavePersonProperties(ByRef pvForm As FrmPersonProperties) As Integer
        '************************************************************************************
        'Name: SavePersonProperties
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves info from the frmPersonProperties
        'Returns: Long
        'Params: pvForm = calling form,
        'Stored Procedures: InserStatEmployee and UpdateStatEmployee
        '====================================================================================
        'Date Changed: 5/27/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Changed to add new field,
        '====================================================================================
        'Date Changed: 6/11/06                        Changed by: Bret Knoll
        'Release #: 8.0                               Task: 8.4.3.9 LogEventDelete
        'Description:  change insert and update to InserStatEmployee and UpdateStatEmployee
        '====================================================================================
        'Date Changed: 2/19/08                        Changed by: ccarroll
        'Release #: 8.4.5                               Task:
        'Description:  change webPerson insert/update to sproc
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vParams() As Object
        Dim vFields() As Object

        If modStatSecurity.IsStatTracPerson(pvForm) Then

            'Get the data
            ReDim vParams(18)

            vParams(0) = pvForm.TxtUserID.Text
            vParams(1) = pvForm.TxtPassword.Text
            vParams(2) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowDeleteCall.Checked)
            vParams(3) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowMaintain.Checked)
            vParams(4) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowSecurityAccess.Checked)
            vParams(5) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowStopTimer.Checked)
            vParams(6) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowIncomplete.Checked)
            vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowScheduleAccess.Checked)
            vParams(8) = pvForm.PersonID
            vParams(9) = pvForm.PersonFirst
            vParams(10) = pvForm.PersonLast
            vParams(11) = pvForm.TxtEmail.Text
            vParams(12) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowRecovery.Checked)
            vParams(13) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowInternetAccess.Checked)
            'Added ChkAllowCloseReferral to param list.  v. 8.0, 5/27/05 - SAP
            vParams(14) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowCloseReferral.Checked)
            'Added ChkAllowRecycleCase to param list T.T 05/17/2006
            vParams(15) = modConv.ChkValueToDBTrueValue(pvForm.chkAllowRecycleCase.Checked)

            'ccarroll 06/06/2006 Added QA Review
            vParams(16) = modConv.ChkValueToDBTrueValue(pvForm.ChkAllowQAReview.Checked)

            'T.T 11/13/2006 added asp save
            vParams(17) = modConv.ChkValueToDBTrueValue(pvForm.chkAllowASPSave.Checked)

            'bret 06/11/2007 8.4.3.9 LogEvent Deleted
            vParams(18) = modConv.ChkValueToDBTrueValue(pvForm.chkAllowViewDeletedLogEvents.Checked)

            'Specify the table fields
            ReDim vFields(18)

            vFields(0) = "@StatEmployeeUserID"
            vFields(1) = "@StatEmployeePassword"
            vFields(2) = "@AllowCallDelete"
            vFields(3) = "@AllowMaintainAccess"
            vFields(4) = "@AllowSecurityAccess"
            vFields(5) = "@AllowStopTimerAccess"
            vFields(6) = "@AllowIncompleteAccess"
            vFields(7) = "@AllowScheduleAccess"
            vFields(8) = "@PersonID"
            vFields(9) = "@StatEmployeeFirstName"
            vFields(10) = "@StatEmployeeLastName"
            vFields(11) = "@StatEmployeeEmail"
            vFields(12) = "@AllowRecoveryAccess"
            vFields(13) = "@AllowInternetAccess"
            'Added AllowCloseReferral to fields list.  v. 8.0, 5/27/05 - SAP
            vFields(14) = "@AllowCloseReferral"
            vFields(15) = "@AllowRecycleCase"

            'ccarroll 06/06/2006 Added QA Review
            vFields(16) = "@AllowQAReview"

            'T.T 11/13/2006 added enable asp save
            vFields(17) = "@AllowASPSave"

            'bret 06/11/2007 8.4.3.9 LogEvent Deleted
            vFields(18) = "@AllowViewDeletedLogEvents"

            'confirm FormState for LO Person
            '04/30/02 BJK removed... was preventing Statline Employees from saving password.
            'If pvForm.fvLeaseOrganization = -1 Then
            If modStatRefQuery.RefQueryStatEmployee(vReturn, , , , , pvForm.PersonID) = SUCCESS Then
                pvForm.FormState = EXISTING_RECORD
            Else
                pvForm.FormState = NEW_RECORD
            End If
            ' End If


            'Build and execute the query
            If pvForm.FormState = NEW_RECORD Then
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

                vQuery = "EXEC InsertStatEmployee " & vValues

            Else
                'The record exists and should be updated.
                vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

                vQuery = "EXEC UpdateStatEmployee " & vValues

            End If

            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


            '************BEGIN - UPDATE BIT-WISE SECURITY FIELD**********
            'drh FSMod 07/24/03 - Update Person table for security bit (note: this will need to be revamped later when other fields are included)
            'bret 06/11/07 8.4.3.8 add PersonID and laststatemployeeID
            'Get the data
            ReDim vParams(2)

            vParams(0) = IIf(pvForm.ChkAllowAddMedication.Checked, 256, 0)
            vParams(1) = pvForm.PersonID
            vParams(1) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

            'Specify the table fields
            ReDim vFields(2)

            vFields(0) = "@PersonSecurity"
            vFields(1) = "@PersonID"
            vFields(2) = "@LastStatEmployeeID"

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdatePerson " & vValues
            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '************END - UPDATE BIT-WISE SECURITY FIELD************

        End If


        'Get the data
        'ccarroll 02/019/2008 - added parameters for Audit Trail
        ReDim vParams(5)

        vParams(0) = pvForm.WebPersonID
        vParams(1) = pvForm.TxtUserID.Text
        vParams(2) = pvForm.PersonID
        vParams(3) = pvForm.TxtPassword.Text
        vParams(4) = pvForm.TxtEmail.Text
        vParams(5) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        'Specify the table fields
        ReDim vFields(5)

        vFields(0) = "@WebPersonID"
        vFields(1) = "@WebPersonUserName"
        vFields(2) = "@PersonID"
        vFields(3) = "@WebPersonEmail"
        vFields(4) = "@LastStatEmployeeID"

        'Build and execute the query
        If pvForm.WebPersonID = 0 Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

            'ccarroll 02/20/2008 - moved dynamic SQL to sproc
            vQuery = "EXEC InsertWebPerson " & vValues
        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            'ccarroll 02/20/2008 - moved dynamic SQL to sproc
            vQuery = "EXEC UpdateWebPerson " & vValues

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Function




    Public Function SaveWebReportOrganizations(ByRef pvForm As Object, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        If pvForm.Name = "FrmReport" Then

            vParams(0) = pvForm.ReportGroupID

            vFields(0) = "WebReportGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row of the Report group organizations
            For I = 0 To UBound(vGridList, 1)
                vParams(1) = modConv.TextToLng(vGridList(I, 0))
                'Check if the item to be added already exists
                If modReport.QueryWebReportOrganization(pvForm, vParams, vReturn) = NO_DATA Then
                    'The record is new and should be inserted.
                    vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                    vQuery = vQuery & "INSERT INTO WebReportGroupOrg (" & vValues & ") "
                End If
            Next I

            If vQuery <> "" Then
                Try
                    SaveWebReportOrganizations = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Else
                SaveWebReportOrganizations = NO_DATA
            End If

        ElseIf pvForm.Name = "FrmOrganization" Then

            vFields(0) = "WebReportGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row
            For I = 0 To UBound(vGridList, 1)

                vParams(0) = modConv.TextToLng(vGridList(I, 0))
                vParams(1) = modConv.TextToLng(vGridList(I, 1))

                'Insert the record
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO WebReportGroupOrg (" & vValues & ")"

                Try
                    SaveWebReportOrganizations = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function


    Public Function SaveWebReportAccessDate(ByRef pvForm As FrmReport) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        Dim vParams(2) As Object
        Dim vFields(2) As Object

        vParams(0) = modControl.GetID(pvForm.CboReportGroup)
        vParams(1) = pvForm.TxtStartActive.Text
        vParams(2) = pvForm.TxtEndActive.Text

        vFields(0) = "WebReportGroupID"
        vFields(1) = "AccessStartDate"
        vFields(2) = "AccessEndDate"

        'Insert the record
        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

        vQuery = "INSERT INTO WebReportGroupAccessDate (" & vValues & ")"

        Try
            SaveWebReportAccessDate = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Function


    Public Function SaveAlertGroup(ByRef pvForm As FrmAlertGroup) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim ErrorReturn As New Object
        Dim vText As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.AlertType

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "AlertGroupName"
        vFields(1) = "AlertTypeID"

        vQuery = "Select * From Alert WHERE AlertGroupName = " & modODBC.BuildField(vParams(0))

        Try
            ErrorReturn = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If ErrorReturn = SUCCESS Then
            'This name already exists for this Organization
            vText = "This name already exists. You may not create this group."
            Call MsgBox(vText, MsgBoxStyle.Exclamation, "Duplicate Group Name")
            If pvForm.FormState = NEW_RECORD Then
                SaveAlertGroup = 0
            Else
                SaveAlertGroup = pvForm.AlertGroupID
            End If
            Exit Function
        End If

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Alert (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Alert SET " & vValues & " WHERE AlertID = " & pvForm.AlertGroupID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryAlertGroup(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveAlertGroup = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            SaveAlertGroup = pvForm.AlertGroupID
        End If

    End Function



    Public Function SavePerson(ByRef pvForm As FrmPerson) As Integer
        '************************************************************************************
        'Name: SavePerson
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves info from the frmPerson
        'Returns: Long
        'Params: pvForm = calling form,
        'Stored Procedures: None
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertPerson and UpdatePerson
        '               Add LastStatEmployeeID
        '====================================================================================
        Dim vTimeZoneDif As Short = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPersonID As Integer
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(14) As Object

        vParams(0) = pvForm.TxtFirst.Text
        vParams(1) = pvForm.TxtMI.Text
        vParams(2) = pvForm.TxtLast.Text
        vParams(3) = modControl.GetID(pvForm.CboPersonType)
        vParams(4) = modControl.GetID(pvForm.CboOrganization)
        vParams(5) = pvForm.TxtNotes.Text
        vParams(6) = modConv.ChkValueToDBTrueValue(pvForm.ChkBusy.Checked)
        vParams(7) = pvForm.Verified
        vParams(8) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtBusyUntil.Text))
        vParams(9) = modConv.ChkValueToDBTrueValue(pvForm.ChkTempNote.Checked)
        vParams(10) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.TxtTempExpires.Text))
        vParams(11) = pvForm.TxtTempNotes.Text
        vParams(12) = pvForm.ChkInactive.CheckState
        vParams(13) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(14) = IIf(pvForm.PersonID = 0, System.DBNull.Value, pvForm.PersonID)

        'Specify the table fields
        Dim vFields(14) As Object

        vFields(0) = "@PersonFirst"
        vFields(1) = "@PersonMI"
        vFields(2) = "@PersonLast"
        vFields(3) = "@PersonTypeID"
        vFields(4) = "@OrganizationID"
        vFields(5) = "@PersonNotes"
        vFields(6) = "@PersonBusy"
        vFields(7) = "@Verified"
        vFields(8) = "@PersonBusyUntil"
        vFields(9) = "@PersonTempNoteActive"
        vFields(10) = "@PersonTempNoteExpires"
        vFields(11) = "@PersonTempNote"
        vFields(12) = "@Inactive"
        vFields(13) = "@LastStatEmployeeID"
        vFields(14) = "@PersonID"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

            vQuery = "EXEC InsertPerson " & vValues

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SavePerson = modConv.TextToLng(vReturn(0, 0))
                pvForm.PersonID = modConv.TextToLng(vReturn(0, 0))
            End If

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdatePerson " & vValues

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Pass back the ID
            If vResult = SUCCESS Then
                SavePerson = pvForm.PersonID
            End If

        End If

    End Function

    Public Function SaveMedication(ByRef pvMedName As String) As Boolean

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vQueryNew As String = ""
        Dim vPersonID As Integer
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(1) As Object

        vParams(0) = pvMedName
        vParams(1) = "medication"

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "MedicationName"
        vFields(1) = "MedicationTypeUse"

        'Check if med already exists
        'drh 1/1/04 - NDRI: added ndri_med clause
        vQuery = "SELECT MedicationId FROM Medication " & "WHERE MedicationName = '" & vParams(0) & "' " & "AND MedicationTypeUse <> 'antibiotic' " & "AND MedicationTypeUse <> 'steroid' " & "AND MedicationTypeUse <> 'ndri_medication'"
        Try
            vResult = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


        If vResult = NO_DATA Then
            'The record doesn't exist and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQueryNew = "INSERT INTO Medication (" & vValues & ")"
            Try
                vResult = modODBC.Exec(vQueryNew)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then
                SaveMedication = True
            End If

        ElseIf vResult = SUCCESS Then
            Call MsgBox("Medication already exists.")
        End If

    End Function

    Public Function SavePersonBasic(ByRef pvParams As Object, ByRef pvState As Short) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPersonID As Integer
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(5) As Object

        vParams(0) = pvParams(0)
        vParams(1) = pvParams(1)
        vParams(2) = modConv.TextToLng(pvParams(2))
        vParams(3) = modConv.TextToLng(pvParams(3))
        vParams(4) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
        vParams(5) = IIf(IsNothing(pvParams(4)), System.DBNull.Value, pvParams(4))

        'Specify the table fields
        Dim vFields(5) As Object

        vFields(0) = "@PersonFirst"
        vFields(1) = "@PersonLast"
        vFields(2) = "@PersonTypeID"
        vFields(3) = "@OrganizationID"
        vFields(4) = "@LastStatEmployeeID"
        vFields(5) = "@PersonID"

        'Build and execute the query
        If pvState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

            vQuery = "EXEC InsertPerson " & vValues

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SavePersonBasic = modConv.TextToLng(vReturn(0, 0))
            End If

        Else

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdatePerson " & vValues

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Pass back the ID
            If vResult = SUCCESS Then
                SavePersonBasic = pvParams(4)
            End If

        End If

    End Function
    Public Function SaveCriteria(ByRef pvForm As FrmCriteria) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim vRowReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(19) As Object

        vParams(0) = modControl.GetID(pvForm.CboDonorCategory)
        vParams(1) = modControl.GetText(pvForm.CboCriteriaGroup)
        vParams(2) = IIf(pvForm.TxtMaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleUpper.Text))
        vParams(3) = IIf(pvForm.TxtMaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleLower.Text))
        vParams(4) = IIf(pvForm.TxtFemaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpper.Text))
        vParams(5) = IIf(pvForm.TxtFemaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLower.Text))
        If pvForm.DonorCategoryID = 0 Then
            vParams(6) = pvForm.TxtVerifyMessage.Text
        Else
            vParams(6) = pvForm.TxtGeneralRuleout.Text
        End If
        vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateMale.Checked)
        vParams(8) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateFemale.Checked)
        vParams(9) = modConv.ChkValueToDBTrueValue(pvForm.ChkReferNonPotential.Checked)
        vParams(10) = IIf(pvForm.TxtUpperWeight.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtUpperWeight.Text)) 'T.T 10/02/2006 changed to dbl for decimal
        vParams(11) = IIf(pvForm.TxtLowerWeight.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtLowerWeight.Text))
        If pvForm.Lable(10).Text = "Lower              yrs." Then
            vParams(12) = "Years"
        Else
            vParams(12) = "Months"
        End If
        If pvForm.Lable(15).Text = "Lower              yrs." Then
            vParams(13) = "Years"
        Else
            vParams(13) = "Months"
        End If
        If pvForm.Lable(11).Text = "Upper              yrs." Then
            vParams(14) = "Years"
        Else
            vParams(14) = "Months"
        End If
        If pvForm.Lable(13).Text = "Upper              yrs." Then
            vParams(15) = "Years"
        Else
            vParams(15) = "Months"
        End If

        'FSProj drh 5/6/02 - Added fields for historical criteria
        vParams(16) = WORKING_CRITERIA
        vParams(17) = 1
        vParams(18) = IIf(pvForm.FormState = NEW_RECORD, 0, pvForm.CriteriaGroupID)
        'T.T 08/19/2005 donorTrac criteria mapping
        vParams(19) = modControl.GetID(pvForm.CboDonorTracCriteriaGroup)
        'Specify the table fields
        Dim vFields(19) As Object

        vFields(0) = "DonorCategoryID"
        vFields(1) = "CriteriaGroupName"
        vFields(2) = "CriteriaMaleUpperAge"
        vFields(3) = "CriteriaMaleLowerAge"
        vFields(4) = "CriteriaFemaleUpperAge"
        vFields(5) = "CriteriaFemaleLowerAge"
        vFields(6) = "CriteriaGeneralRuleout"
        vFields(7) = "CriteriaMaleNotAppropriate"
        vFields(8) = "CriteriaFemaleNotAppropriate"
        vFields(9) = "CriteriaReferNonPotential"
        vFields(10) = "CriteriaUpperWeight"
        vFields(11) = "CriteriaLowerWeight"
        vFields(12) = "CriteriaMaleLowerAgeUnit"
        vFields(13) = "CriteriaFemaleLowerAgeUnit"
        vFields(14) = "CriteriaMaleUpperAgeUnit"
        vFields(15) = "CriteriaFemaleUpperAgeUnit"

        'FSProj drh 5/6/02 - Added fields for historical criteria
        vFields(16) = "CriteriaStatus"
        vFields(17) = "WorkingStatusUpdatedFlag"
        vFields(18) = "WorkingCriteriaId"

        'T.T 08/19/2005 DonorTrac criteria mapping
        vFields(19) = "CriteriaDonorTracMap"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Criteria (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        ElseIf pvForm.FormState = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Criteria SET " & vValues & " WHERE CriteriaID = " & pvForm.CriteriaID

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function

    Public Function SaveCriteriaTemplate(ByRef pvForm As FrmCriteriaTemplate) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim vRowReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(17) As Object

        vParams(0) = pvForm.vProcessorId
        vParams(1) = pvForm.txtCriteriaTemplateName.Text
        vParams(2) = IIf(pvForm.TxtMaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleUpper.Text))
        vParams(3) = IIf(pvForm.TxtMaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleLower.Text))
        vParams(4) = IIf(pvForm.TxtFemaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpper.Text))
        vParams(5) = IIf(pvForm.TxtFemaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLower.Text))
        vParams(6) = pvForm.TxtGeneralRuleout.Text
        vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateMale.Checked)
        vParams(8) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateFemale.Checked)
        vParams(9) = modConv.ChkValueToDBTrueValue(pvForm.ChkReferNonPotential.Checked)
        vParams(10) = IIf(pvForm.TxtUpperWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtUpperWeight.Text))
        vParams(11) = IIf(pvForm.TxtLowerWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtLowerWeight.Text))
        If pvForm.Lable(10).Text = "Lower              yrs." Then
            vParams(12) = "Years"
        Else
            vParams(12) = "Months"
        End If
        If pvForm.Lable(15).Text = "Lower              yrs." Then
            vParams(13) = "Years"
        Else
            vParams(13) = "Months"
        End If
        If pvForm.Lable(11).Text = "Upper              yrs." Then
            vParams(14) = "Years"
        Else
            vParams(14) = "Months"
        End If
        If pvForm.Lable(13).Text = "Upper              yrs." Then
            vParams(15) = "Years"
        Else
            vParams(15) = "Months"
        End If
        vParams(16) = IIf(pvForm.TxtFemaleUpperWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpperWeight.Text))
        vParams(17) = IIf(pvForm.TxtFemaleLowerWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLowerWeight.Text))

        'Specify the table fields
        Dim vFields(17) As Object

        vFields(0) = "ProcessorID"
        vFields(1) = "CriteriaTemplateName"
        vFields(2) = "SubCriteriaMaleUpperAge"
        vFields(3) = "SubCriteriaMaleLowerAge"
        vFields(4) = "SubCriteriaFemaleUpperAge"
        vFields(5) = "SubCriteriaFemaleLowerAge"
        vFields(6) = "SubCriteriaGeneralRuleout"
        vFields(7) = "SubCriteriaMaleNotAppropriate"
        vFields(8) = "SubCriteriaFemaleNotAppropriate"
        vFields(9) = "SubCriteriaReferNonPotential"
        vFields(10) = "SubCriteriaUpperWeight"
        vFields(11) = "SubCriteriaLowerWeight"
        vFields(12) = "SubCriteriaMaleLowerAgeUnit"
        vFields(13) = "SubCriteriaFemaleLowerAgeUnit"
        vFields(14) = "SubCriteriaMaleUpperAgeUnit"
        vFields(15) = "SubCriteriaFemaleUpperAgeUnit"
        vFields(16) = "SubCriteriaFemaleUpperWeight"
        vFields(17) = "SubCriteriaFemaleLowerWeight"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO CriteriaTemplate (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        ElseIf pvForm.FormState = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE CriteriaTemplate SET " & vValues & " WHERE CriteriaTemplateID = " & pvForm.vCriteriaTemplateId

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function

    Public Function SaveExistingSubCriteria(ByRef pvForm As FrmCriteria) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim vRowReturn As New Object
        Dim vResult As New Object
        Dim vSubCriteriaId As Integer

        vSubCriteriaId = modControl.GetID(pvForm.cboSubtypeProcessor(0))

        'Get the data
        Dim vParams(15) As Object

        vParams(0) = IIf(pvForm.TxtMaleUpperSub.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleUpperSub.Text))
        vParams(1) = IIf(pvForm.TxtMaleLowerSub.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleLowerSub.Text))
        vParams(2) = IIf(pvForm.TxtFemaleUpperSub.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpperSub.Text))
        vParams(3) = IIf(pvForm.TxtFemaleLowerSub.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLowerSub.Text))
        vParams(4) = pvForm.TxtGeneralRuleoutSub.Text
        vParams(5) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateMaleSub.Checked)
        vParams(6) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateFemaleSub.Checked)
        vParams(7) = modConv.ChkValueToDBTrueValue(pvForm.ChkReferNonPotentialSub.Checked)
        vParams(8) = IIf(pvForm.TxtUpperWeightSub.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtUpperWeightSub.Text)) 'T.T 10/04/2006 added for decimal
        vParams(9) = IIf(pvForm.TxtLowerWeightSub.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtLowerWeightSub.Text))
        If pvForm.LableSub(10).Text = "Lower              yrs." Then
            vParams(10) = "Years"
        Else
            vParams(10) = "Months"
        End If
        If pvForm.LableSub(15).Text = "Lower              yrs." Then
            vParams(11) = "Years"
        Else
            vParams(11) = "Months"
        End If
        If pvForm.LableSub(11).Text = "Upper              yrs." Then
            vParams(12) = "Years"
        Else
            vParams(12) = "Months"
        End If
        If pvForm.LableSub(13).Text = "Upper              yrs." Then
            vParams(13) = "Years"
        Else
            vParams(13) = "Months"
        End If
        vParams(14) = IIf(pvForm.TxtFemaleUpperWeightSub.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtFemaleUpperWeightSub.Text))
        vParams(15) = IIf(pvForm.TxtFemaleLowerWeightSub.Text = "", System.DBNull.Value, modConv.TextToDbl(pvForm.TxtFemaleLowerWeightSub.Text))

        'Specify the table fields
        Dim vFields(15) As Object

        vFields(0) = "SubCriteriaMaleUpperAge"
        vFields(1) = "SubCriteriaMaleLowerAge"
        vFields(2) = "SubCriteriaFemaleUpperAge"
        vFields(3) = "SubCriteriaFemaleLowerAge"
        vFields(4) = "SubCriteriaGeneralRuleout"
        vFields(5) = "SubCriteriaMaleNotAppropriate"
        vFields(6) = "SubCriteriaFemaleNotAppropriate"
        vFields(7) = "SubCriteriaReferNonPotential"
        vFields(8) = "SubCriteriaUpperWeight"
        vFields(9) = "SubCriteriaLowerWeight"
        vFields(10) = "SubCriteriaMaleLowerAgeUnit"
        vFields(11) = "SubCriteriaFemaleLowerAgeUnit"
        vFields(12) = "SubCriteriaMaleUpperAgeUnit"
        vFields(13) = "SubCriteriaFemaleUpperAgeUnit"
        vFields(14) = "SubCriteriaFemaleUpperWeight"
        vFields(15) = "SubCriteriaFemaleLowerWeight"

        'The record exists and should be updated.
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE SubCriteria SET " & vValues & " WHERE SubCriteriaID = " & vSubCriteriaId

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveSubCriteria(ByRef pvForm As FrmCriteria, ByRef pvSubCriteriaState As Short, Optional ByRef pvUseTemplate As Boolean = False) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vDonorCategoryId As Integer
        Dim vSubtypeId As Integer
        Dim vProcessorId As Integer
        Dim vCriteriaTemplateId As Integer
        Dim vSubCriteriaId As Integer
        Dim vReturn As New Object
        Dim vTemplateReturn As New Object
        Dim vConditionalReturn As New Object
        Dim vRowReturn As New Object
        Dim vResult As New Object
        Dim I As Integer

        'Set local variables
        vCriteriaId = pvForm.CriteriaGroupID
        vDonorCategoryId = pvForm.DonorCategoryID
        vSubtypeId = pvForm.LstViewSubtypeProcessors.FocusedItem.Tag
        vProcessorId = pvForm.LstViewCriteriaTemplates.Items(pvForm.LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text
        'pvForm.LstViewCriteriaTemplates.SelectedItems(0).SubItems(2).Text
        vCriteriaTemplateId = pvForm.LstViewCriteriaTemplates.FocusedItem.Tag

        'vSubtypeId = pvForm.LstViewSubtypeProcessors.SelectedItem.Tag
        'vProcessorId = pvForm.LstViewCriteriaTemplates.ListItems(pvForm.LstViewCriteriaTemplates.FocusedItem.Index).ListSubItems(2)
        'vCriteriaTemplateId = pvForm.LstViewCriteriaTemplates.SelectedItem.Tag

        Dim vParams(20) As Object
        If Not IsNothing(pvUseTemplate) Then
            If pvUseTemplate Then

                'Get the template data
                vQuery = "SELECT * " & "FROM CriteriaTemplate " & "WHERE CriteriaTemplateID = " & vCriteriaTemplateId & ";"

                Try
                    Call modODBC.Exec(vQuery, vTemplateReturn)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If ObjectIsValidArray(vTemplateReturn, 2, 0, 20) Then
                    'Set the data fields
                    vParams(0) = vCriteriaId
                    vParams(1) = vDonorCategoryId
                    vParams(2) = vSubtypeId
                    vParams(3) = vProcessorId
                    vParams(4) = 0
                    vParams(5) = vTemplateReturn(0, 3)
                    vParams(6) = vTemplateReturn(0, 4)
                    vParams(7) = vTemplateReturn(0, 5)
                    vParams(8) = vTemplateReturn(0, 6)
                    vParams(9) = vTemplateReturn(0, 7)
                    vParams(10) = vTemplateReturn(0, 8)
                    vParams(11) = vTemplateReturn(0, 9)
                    vParams(12) = vTemplateReturn(0, 10)
                    vParams(13) = vTemplateReturn(0, 12)
                    vParams(14) = vTemplateReturn(0, 11)
                    vParams(15) = vTemplateReturn(0, 16)
                    vParams(16) = vTemplateReturn(0, 18)
                    vParams(17) = vTemplateReturn(0, 15)
                    vParams(18) = vTemplateReturn(0, 17)
                    vParams(19) = vTemplateReturn(0, 19)
                    vParams(20) = vTemplateReturn(0, 20)
                End If

            Else
                'Set the default data
                vParams(0) = vCriteriaId
                vParams(1) = vDonorCategoryId
                vParams(2) = vSubtypeId
                vParams(3) = vProcessorId
                vParams(4) = 0
                vParams(5) = System.DBNull.Value
                vParams(6) = System.DBNull.Value
                vParams(7) = System.DBNull.Value
                vParams(8) = System.DBNull.Value
                vParams(9) = System.DBNull.Value
                vParams(10) = System.DBNull.Value
                vParams(11) = System.DBNull.Value
                vParams(12) = System.DBNull.Value
                vParams(13) = System.DBNull.Value
                vParams(14) = System.DBNull.Value
                vParams(15) = System.DBNull.Value
                vParams(16) = System.DBNull.Value
                vParams(17) = System.DBNull.Value
                vParams(18) = System.DBNull.Value
                vParams(19) = System.DBNull.Value
                vParams(20) = System.DBNull.Value
            End If

        Else
            'Get the form data
            vParams(0) = vCriteriaId
            vParams(1) = vDonorCategoryId
            vParams(2) = vSubtypeId
            vParams(3) = vProcessorId
            vParams(4) = 0
            vParams(5) = IIf(pvForm.TxtMaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleUpper.Text))
            vParams(6) = IIf(pvForm.TxtMaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtMaleLower.Text))
            vParams(7) = IIf(pvForm.TxtFemaleUpper.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpper.Text))
            vParams(8) = IIf(pvForm.TxtFemaleLower.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLower.Text))
            vParams(9) = pvForm.TxtGeneralRuleout.Text
            vParams(10) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateMale.Checked)
            vParams(11) = modConv.ChkValueToDBTrueValue(pvForm.ChkNotAppropriateFemale.Checked)
            vParams(12) = modConv.ChkValueToDBTrueValue(pvForm.ChkReferNonPotential.Checked)
            vParams(13) = IIf(pvForm.TxtUpperWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtUpperWeight.Text))
            vParams(14) = IIf(pvForm.TxtLowerWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtLowerWeight.Text))
            If pvForm.Lable(10).Text = "Lower              yrs." Then
                vParams(15) = "Years"
            Else
                vParams(15) = "Months"
            End If
            If pvForm.Lable(15).Text = "Lower              yrs." Then
                vParams(16) = "Years"
            Else
                vParams(16) = "Months"
            End If
            If pvForm.Lable(11).Text = "Upper              yrs." Then
                vParams(17) = "Years"
            Else
                vParams(17) = "Months"
            End If
            If pvForm.Lable(13).Text = "Upper              yrs." Then
                vParams(18) = "Years"
            Else
                vParams(18) = "Months"
            End If
            'vParams(19) = IIf(pvForm.TxtFemaleUpperWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleUpperWeight.Text))
            vParams(19) = System.DBNull.Value
            'vParams(20) = IIf(pvForm.TxtFemaleLowerWeight.Text = "", System.DBNull.Value, modConv.TextToInt(pvForm.TxtFemaleLowerWeight.Text))
            vParams(20) = System.DBNull.Value
        End If

        'Specify the table fields
        Dim vFields(20) As Object

        vFields(0) = "CriteriaID"
        vFields(1) = "DonorCategoryID"
        vFields(2) = "SubtypeID"
        vFields(3) = "ProcessorID"
        vFields(4) = "ProcessorPrecedence"
        vFields(5) = "SubCriteriaMaleUpperAge"
        vFields(6) = "SubCriteriaMaleLowerAge"
        vFields(7) = "SubCriteriaFemaleUpperAge"
        vFields(8) = "SubCriteriaFemaleLowerAge"
        vFields(9) = "SubCriteriaGeneralRuleout"
        vFields(10) = "SubCriteriaMaleNotAppropriate"
        vFields(11) = "SubCriteriaFemaleNotAppropriate"
        vFields(12) = "SubCriteriaReferNonPotential"
        vFields(13) = "SubCriteriaUpperWeight"
        vFields(14) = "SubCriteriaLowerWeight"
        vFields(15) = "SubCriteriaMaleLowerAgeUnit"
        vFields(16) = "SubCriteriaFemaleLowerAgeUnit"
        vFields(17) = "SubCriteriaMaleUpperAgeUnit"
        vFields(18) = "SubCriteriaFemaleUpperAgeUnit"
        vFields(19) = "SubCriteriaFemaleUpperWeight"
        vFields(20) = "SubCriteriaFemaleLowerWeight"

        'Build and execute the query
        If pvSubCriteriaState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO SubCriteria (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        ElseIf pvSubCriteriaState = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE SubCriteria SET " & vValues & " WHERE SubCriteriaID = " & vSubCriteriaId

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If


        'If we're creating from a template, we need to create the conditionals also
        If Not IsNothing(pvUseTemplate) Then
            If pvUseTemplate Then

                'Get the new SubCriteriaId
                vQuery = "EXEC CriteriaConditionalROInsert @CriteriaTemplateId = " & vCriteriaTemplateId & ";"
                Try
                    Call modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            End If
        End If

    End Function

    Public Function SaveAlert(ByRef pvForm As FrmAlert) As Object
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vAlertID As Integer
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the data
        Dim vParams(5) As Object

        vParams(0) = modControl.GetText(pvForm.CboAlertGroup)
        vParams(1) = pvForm.TxtAlerts(0).Rtf
        vParams(2) = pvForm.TxtAlerts(1).Rtf
        vParams(3) = pvForm.TxtAlerts(2).Rtf
        vParams(4) = pvForm.TxtAlerts(3).Rtf
        vParams(5) = pvForm.TxtAlerts(4).Rtf

        'Specify the table fields
        Dim vFields(5) As Object

        vFields(0) = "AlertGroupName"
        vFields(1) = "AlertMessage1"
        vFields(2) = "AlertMessage2"
        vFields(3) = "AlertScheduleMessage"
        vFields(4) = "AlertQAMessage1"
        vFields(5) = "AlertQAMessage2"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Alert (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        ElseIf pvForm.FormState = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Alert SET " & vValues & " WHERE AlertID = " & pvForm.AlertID

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function



    Public Function SaveScheduleReferralOrganizations(ByRef pvForm As Object, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vScheduleID As Integer
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        If pvForm.Name = "FrmSchedule" Then

            vParams(0) = modControl.GetID(pvForm.CboScheduleGroup)

            vFields(0) = "ScheduleGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row of the group organizations
            For I = 0 To UBound(vGridList, 1)
                vParams(1) = modConv.TextToLng(vGridList(I, 0))
                'Check if the item to be added already exists
                If modStatQuery.QueryScheduleReferralOrganization(pvForm, vParams, vReturn) = NO_DATA Then
                    'The record is new and should be inserted.
                    vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                    vQuery = vQuery & "INSERT INTO ScheduleGroupOrganization (" & vValues & ") "
                End If
            Next I

            If vQuery <> "" Then
                Try
                    SaveScheduleReferralOrganizations = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Else
                SaveScheduleReferralOrganizations = NO_DATA
            End If

        ElseIf pvForm.Name = "FrmOrganization" Then

            vFields(0) = "ScheduleGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row
            For I = 0 To UBound(vGridList, 1)

                vParams(0) = modConv.TextToLng(vGridList(I, 0))
                vParams(1) = modConv.TextToLng(vGridList(I, 1))

                'Insert the record
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO ScheduleGroupOrganization (" & vValues & ")"

                Try
                    vReturn = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function



    Public Function SaveSchedulePerson(ByVal pvScheduleGroupID As Integer, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vScheduleID As Integer
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object


        vParams(0) = pvScheduleGroupID

        vFields(0) = "ScheduleGroupID"
        vFields(1) = "PersonID"

        'Get and save each row of the group organizations
        For I = 0 To UBound(vGridList, 1)

            vParams(1) = modConv.TextToLng(vGridList(I, 0))

            'Check if the item to be added already exists
            If modStatQuery.QuerySchedulePerson(pvScheduleGroupID, vReturn, vParams(1)) = NO_DATA Then
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = vQuery & "INSERT INTO ScheduleGroupPerson (" & vValues & ") "
            End If

        Next I

        If vQuery <> "" Then
            Try
                SaveSchedulePerson = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            SaveSchedulePerson = NO_DATA
        End If


    End Function

    Public Function SaveAlertOrganizations(ByRef pvForm As Object, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vScheduleID As Integer
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        If pvForm.Name = "FrmAlert" Then

            vParams(0) = modControl.GetID(pvForm.CboAlertGroup)

            vFields(0) = "AlertID"
            vFields(1) = "OrganizationID"

            'Get and save each row of the group organizations
            For I = 0 To UBound(vGridList, 1)
                vParams(1) = modConv.TextToLng(vGridList(I, 0))
                'Check if the item to be added already exists
                If modStatQuery.QueryAlertOrganization(pvForm, vParams, vReturn) = NO_DATA Then
                    'The record is new and should be inserted.
                    vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                    vQuery = "INSERT INTO AlertOrganization (" & vValues & ");"
                    Try
                        SaveAlertOrganizations = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                Else
                    SaveAlertOrganizations = NO_DATA
                End If
            Next I

        ElseIf pvForm.Name = "FrmOrganization" Then

            vFields(0) = "AlertID"
            vFields(1) = "OrganizationID"

            'Get and save each row
            For I = 0 To UBound(vGridList, 1)

                vParams(0) = modConv.TextToLng(vGridList(I, 0))
                vParams(1) = modConv.TextToLng(vGridList(I, 1))

                'Insert the record
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO AlertOrganization (" & vValues & ")"

                Try
                    Call modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function



    Public Function SaveAlertSourceCodes(ByRef pvForm As FrmAlert) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboAlertGroup)

        vQuery = "DELETE AlertSourceCode " & "WHERE AlertSourceCode.AlertID = " & vParams(0)

        Try
            SaveAlertSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If SaveAlertSourceCodes = SUCCESS Then

            vFields(0) = "AlertID"
            vFields(1) = "SourceCodeID"

            For I = 0 To pvForm.LstViewSourceCodes.Items.Count - 1

                vParams(1) = pvForm.SourceCodes.Item(pvForm.LstViewSourceCodes.Items(I).Tag).ID

                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = "INSERT INTO AlertSourceCode (" & vValues & ");"
                Try
                    SaveAlertSourceCodes = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function

    Public Function DeleteWebReportGroupSourceCodes(ByRef pvForm As FrmReport) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vParams(19) As Object
        Dim vFields(19) As Object

        vFields(0) = "WebReportGroupID"
        vFields(1) = "SourceCodeID"

        vParams(0) = modControl.GetID(pvForm.CboReportGroup)
        vParams(1) = pvForm.SourceCodes.Item(pvForm.LstViewSourceCodes.FocusedItem.Tag).ID

        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
        vQuery = "EXEC WebReportGroupSourceCodeDelete @WebReportGroupID = " & vParams(0) & ", @SourceCodeId = " & vParams(1)

        Try
            DeleteWebReportGroupSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function InsertWebReportGroupSourceCodes(ByRef pvForm As FrmReport) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vParams(19) As Object
        Dim vFields(19) As Object

        vFields(0) = "@WebReportGroupID"
        vFields(1) = "@SourceCodeID"
        vFields(2) = "@AccessOrgans"
        vFields(3) = "@AccessBone"
        vFields(4) = "@AccessTissue"
        vFields(5) = "@AccessSkin"
        vFields(6) = "@AccessValves"
        vFields(7) = "@AccessEyes"
        vFields(8) = "@AccessResearch"
        vFields(9) = "@AccessOrgansUpdate"
        vFields(10) = "@AccessBoneUpdate"
        vFields(11) = "@AccessTissueUpdate"
        vFields(12) = "@AccessSkinUpdate"
        vFields(13) = "@AccessValvesUpdate"
        vFields(14) = "@AccessEyesUpdate"
        vFields(15) = "@AccessResearchUpdate"
        vFields(16) = "@AccessTypeOTE"
        vFields(17) = "@AccessTypeTE"
        vFields(18) = "@AccessTypeEOnly"
        vFields(19) = "@AccessTypeRuleout"

        vParams(0) = modControl.GetID(pvForm.CboReportGroup)
        vParams(1) = pvForm.sourceCodeId

        'The record is new and should be inserted.
        vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)
        vQuery = "EXEC WebReportGroupSourceCodeInsert " & vValues & ";"

        Try
            InsertWebReportGroupSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function UpdateWebReportGroupSourceCodes(ByRef pvForm As FrmReport, ByVal selectedSourceCodeId As Integer) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short
        Dim vParams(19) As Object
        Dim vFields(19) As Object

        vFields(0) = "@WebReportGroupID"
        vFields(1) = "@SourceCodeID"
        vFields(2) = "@AccessOrgans"
        vFields(3) = "@AccessBone"
        vFields(4) = "@AccessTissue"
        vFields(5) = "@AccessSkin"
        vFields(6) = "@AccessValves"
        vFields(7) = "@AccessEyes"
        vFields(8) = "@AccessResearch"
        vFields(9) = "@AccessOrgansUpdate"
        vFields(10) = "@AccessBoneUpdate"
        vFields(11) = "@AccessTissueUpdate"
        vFields(12) = "@AccessSkinUpdate"
        vFields(13) = "@AccessValvesUpdate"
        vFields(14) = "@AccessEyesUpdate"
        vFields(15) = "@AccessResearchUpdate"
        vFields(16) = "@AccessTypeOTE"
        vFields(17) = "@AccessTypeTE"
        vFields(18) = "@AccessTypeEOnly"
        vFields(19) = "@AccessTypeRuleout"

        vParams(0) = modControl.GetID(pvForm.CboReportGroup)
        vParams(1) = selectedSourceCodeId
        vParams(2) = pvForm.ChkOrgans(0).CheckState
        vParams(3) = pvForm.ChkBone(0).CheckState
        vParams(4) = pvForm.ChkSoftTissue(0).CheckState
        vParams(5) = pvForm.ChkSkin(0).CheckState
        vParams(6) = pvForm.ChkHeartValves(0).CheckState
        vParams(7) = pvForm.ChkEyes(0).CheckState
        vParams(8) = pvForm.ChkResearch(0).CheckState
        vParams(9) = pvForm.ChkOrgans(1).CheckState
        vParams(10) = pvForm.ChkBone(1).CheckState
        vParams(11) = pvForm.ChkSoftTissue(1).CheckState
        vParams(12) = pvForm.ChkSkin(1).CheckState
        vParams(13) = pvForm.ChkHeartValves(1).CheckState
        vParams(14) = pvForm.ChkEyes(1).CheckState
        vParams(15) = pvForm.ChkResearch(1).CheckState
        vParams(16) = pvForm.ChkOTE.CheckState
        vParams(17) = pvForm.ChkTE.CheckState
        vParams(18) = pvForm.ChkEyeOnly.CheckState
        vParams(19) = pvForm.ChkRuleout.CheckState

        'The record is new and should be inserted.
        vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)
        vQuery = "EXEC WebReportGroupSourceCodeUpdate " & vValues & ";"

        Try
            UpdateWebReportGroupSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveScheduleGroupSourceCodes(ByRef pvForm As FrmSchedule) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboScheduleGroup)

        vQuery = "DELETE ScheduleGroupSourceCode " & "WHERE ScheduleGroupSourceCode.ScheduleGroupID = " & vParams(0)

        Try
            SaveScheduleGroupSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If SaveScheduleGroupSourceCodes = SUCCESS Then

            vFields(0) = "ScheduleGroupID"
            vFields(1) = "SourceCodeID"

            For I = 0 To pvForm.LstViewSourceCodes.Items.Count - 1

                vParams(1) = pvForm.SourceCodes.Item(pvForm.LstViewSourceCodes.Items(I).Tag).ID

                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = "INSERT INTO ScheduleGroupSourceCode (" & vValues & ");"
                Try
                    SaveScheduleGroupSourceCodes = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function

    Public Function SaveCriteriaSourceCodes(ByRef pvForm As FrmCriteria) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

        vQuery = "DELETE CriteriaSourceCode " & "WHERE CriteriaSourceCode.CriteriaID = " & vParams(0)

        Try
            SaveCriteriaSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If SaveCriteriaSourceCodes = SUCCESS Then

            vFields(0) = "CriteriaID"
            vFields(1) = "SourceCodeID"

            For I = 0 To pvForm.LstViewSourceCodes.Items.Count - 1

                vParams(1) = pvForm.SourceCodes.Item(pvForm.LstViewSourceCodes.Items(I).Tag).ID

                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = "INSERT INTO CriteriaSourceCode (" & vValues & ");"
                Try
                    SaveCriteriaSourceCodes = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

            'FSProj drh 5/6/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(pvForm)

        End If


    End Function
    Public Function SaveServiceLevelSourceCodes(ByRef pvForm As FrmServiceLevel) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboServiceLevelGroup)

        vQuery = "DELETE ServiceLevelSourceCode " & "WHERE ServiceLevelSourceCode.ServiceLevelID = " & vParams(0)

        Try
            SaveServiceLevelSourceCodes = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If SaveServiceLevelSourceCodes = SUCCESS Then

            vFields(0) = "ServiceLevelID"
            vFields(1) = "SourceCodeID"

            For I = 0 To pvForm.LstViewSourceCodes.Items.Count - 1

                vParams(1) = pvForm.SourceCodes.Item(pvForm.LstViewSourceCodes.Items(I).Tag).ID

                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = "INSERT INTO ServiceLevelSourceCode (" & vValues & ");"
                Try
                    SaveServiceLevelSourceCodes = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

            Call modStatSave.SaveServiceLevelWorking(pvForm)

        End If

    End Function

    Public Function SaveCriteriaScheduleGroups(ByRef pvForm As FrmCriteria) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)
        vParams(1) = modControl.GetID(pvForm.CboScheduleGroup)

        'Delete the schedule group if it already exists
        SaveCriteriaScheduleGroups = DeleteCriteriaGroupScheduleGroup(pvForm)

        If SaveCriteriaScheduleGroups = SUCCESS Then

            vFields(0) = "CriteriaID"
            vFields(1) = "ScheduleGroupID"

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQuery = "INSERT INTO CriteriaScheduleGroup (" & vValues & ");"
            Try
                SaveCriteriaScheduleGroups = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'FSProj drh 5/6/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(pvForm)

        End If

    End Function

    Public Function SaveSubCriteriaScheduleGroups(ByRef pvForm As FrmCriteria) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.cboSubtypeProcessor(1))
        vParams(1) = modControl.GetID(pvForm.cboScheduleGroupSub)

        'Delete the schedule group if it already exists
        SaveSubCriteriaScheduleGroups = DeleteSubCriteriaGroupScheduleGroup(pvForm)

        If SaveSubCriteriaScheduleGroups = SUCCESS Then

            vFields(0) = "SubCriteriaID"
            vFields(1) = "ScheduleGroupID"

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQuery = "INSERT INTO SCScheduleGroup (" & vValues & ");"

            Try
                SaveSubCriteriaScheduleGroups = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'FSProj drh 5/17/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(pvForm)

        End If

    End Function

    Public Function SaveCriteriaReferralOrganizations(ByRef pvForm As Object, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim vTemp As New Object
        Dim I As Short
        Dim vResult As Short
        Dim vDuplicatesList As New Object

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        If pvForm.Name = "FrmCriteria" Then

            vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

            vFields(0) = "CriteriaID"
            vFields(1) = "OrganizationID"

            'Get and save each row of the group organizations
            For I = 0 To UBound(vGridList, 1)
                vParams(1) = modConv.TextToLng(vGridList(I, 0))
                'Check if the item to be added already exists
                If modStatQuery.QueryCriteriaReferralOrganization(pvForm, vParams, vReturn) = NO_DATA Then
                    'The record is new and should be inserted.
                    vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                    vQuery = vQuery & "INSERT INTO CriteriaOrganization (" & vValues & ") "
                End If
            Next I

            If vQuery <> "" Then
                Try
                    SaveCriteriaReferralOrganizations = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Else
                SaveCriteriaReferralOrganizations = NO_DATA
            End If

        ElseIf pvForm.Name = "FrmOrganization" Then

            vFields(0) = "CriteriaID"
            vFields(1) = "OrganizationID"

            'Get and save each row
            For I = 0 To UBound(vGridList, 1)

                vParams(0) = modConv.TextToLng(vGridList(I, 0))
                vParams(1) = modConv.TextToLng(vGridList(I, 1))

                'Insert the record
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO CriteriaOrganization (" & vValues & ")"

                Try
                    Call modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function

    Public Function SaveCriteriaProcessors(ByRef pvForm As FrmCriteria, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim vReturn2 As Object
        Dim vTemp As New Object
        Dim I As Short
        Dim vResult As Short
        Dim vDuplicatesList As New Object

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

        vFields(0) = "CriteriaID"
        vFields(1) = "OrganizationID"

        'Get and save each row of the group processors
        For I = 0 To UBound(vGridList, 1)
            vParams(1) = modConv.TextToLng(vGridList(I, 0))
            'Check if the item to be added already exists
            If modStatQuery.QueryCriteriaProcessor(pvForm, vParams, vReturn) = NO_DATA Then
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = vQuery & "INSERT INTO CriteriaProcessor (" & vValues & ") "
            End If
        Next I

        If vQuery <> "" Then
            Try
                SaveCriteriaProcessors = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            SaveCriteriaProcessors = NO_DATA
        End If

    End Function

    Public Function SaveCriteriaSubtypes(ByRef pvForm As FrmCriteria, ByRef vGridList As Object) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaId As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vDuplicatesList As New Object

        Dim vParams(2) As Object
        Dim vFields(2) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

        vFields(0) = "CriteriaID"
        vFields(1) = "SubtypeID"
        vFields(2) = "SubCriteriaPrecedence"

        'Get and save each row of the group organizations
        For I = 0 To UBound(vGridList, 1)
            vParams(1) = modConv.TextToLng(vGridList(I, 0))
            'Make the precedence zero
            vParams(2) = 0
            'Check if the item to be added already exists
            If modStatQuery.QueryCriteriaSubtype(pvForm, vParams, vReturn) = NO_DATA Then
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = vQuery & "INSERT INTO CriteriaSubtype (" & vValues & ") "
            End If
        Next I

        If vQuery <> "" Then
            Try
                SaveCriteriaSubtypes = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            SaveCriteriaSubtypes = NO_DATA
        End If


    End Function

    Public Function SaveOrganizationAssociations(ByRef pvForm As FrmOrganization) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vOrganizationId As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vMsg As String = ""
        Dim MatchedOrg As New clsOrganization
        Dim SourceCode As New clsSourceCode
        Dim NewOrganization As New clsOrganization
        Dim TempSourceCodes As New colSourceCodes

        NewOrganization.ID = pvForm.OrganizationId
        NewOrganization.Key = "k" & pvForm.OrganizationId

        'First check if there are any other organizations that are in the same city and state
        If QueryCityOrganization(pvForm, vReturn) = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 1) Then
            'Get the organization ID of the first match in the list
            MatchedOrg.ID = vReturn(0, 0)

            '09/05/02 drh - Save the matched org as a system alert
            vMsg = "Matched organization '" & pvForm.TxtName.Text & "' on '" & vReturn(0, 1) & "' by city/state"
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            vMsg = ""

            'If there are no city matches, try the county
        ElseIf QueryCountyOrganization(pvForm, vReturn) = SUCCESS Then
            'Get the organization ID of the first match in the list
            MatchedOrg.ID = vReturn(0, 0)

            '09/05/02 drh - Save the matched org as a system alert
            vMsg = "Matched organization '" & pvForm.TxtName.Text & "' on '" & vReturn(0, 1) & "' by county"
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            vMsg = ""

            'If there are no county matches, try the area code
        ElseIf QueryAreaOrganization(pvForm, vReturn) = SUCCESS Then
            'Get the organization ID of the first match in the list
            MatchedOrg.ID = vReturn(0, 0)
            MsgBox("A similar organization was found at the area code level. " & "Because there may be more than one criteria group available for an area code, the automatic assignments may not be correct. " & "Please contact the supervisor on call to determine the appropriate criteria for this organization.", MsgBoxStyle.OkOnly, "Organization Match")

            'If there are no area code matches, try the state
        ElseIf QueryStateOrganization(pvForm, vReturn, True) = SUCCESS Then
            'Get the organization ID of the first match in the list
            MatchedOrg.ID = vReturn(0, 0)
            MsgBox("A similar organization was found at the state level. " & "Because there may be more than one criteria group available for state, the automatic assignments may not be correct. " & "Please contact the supervisor on call to determine the appropriate criteria for this organization.", MsgBoxStyle.OkOnly, "Organization Match")
            'If there is no match, return no data found
        Else
            SaveOrganizationAssociations = NO_DATA
            Exit Function

        End If

        vReturn = Nothing

        'Using the matched organization ID, first create the criteria organization associations
        'Get all the criteria group organization rows with the organization ID
        'FSProj drh 5/3/02 - Added parameter so we only get Working Criteria
        If modStatQuery.QueryCriteriaGroupOrganization((MatchedOrg.ID), vReturn, pvForm.SourceCode, WORKING_CRITERIA) = SUCCESS Then

            'Replace the matched organization ID with the new organization ID
            For I = 0 To UBound(vReturn, 1)
                vReturn(I, 1) = pvForm.OrganizationId
            Next I

            'Save the criteria organization rows
            Call SaveCriteriaReferralOrganizations(pvForm, vReturn)

            '09/05/02 drh - Save the criteria list as a system alert
            vMsg = "Matched WORKING criteria groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            For I = 0 To UBound(vReturn, 1)
                vMsg = "WKG Criteria " & vReturn(I, 2) & " = " & vReturn(I, 3)
                Call modStatSave.SaveSystemAlert(vMsg, -1)
            Next I
            vMsg = ""

            'drh 09/04/02 - Set vReturn to Empty so we can get/update CURRENT Criteria
            vReturn = Nothing
            'drh 09/04/02 - Added this entire if/else/end clause to update Current Criteria
            If modStatQuery.QueryCriteriaGroupOrganization((MatchedOrg.ID), vReturn, pvForm.SourceCode, CURRENT_CRITERIA) = SUCCESS Then

                'Replace the matched organization ID with the new organization ID
                For I = 0 To UBound(vReturn, 1)
                    vReturn(I, 1) = pvForm.OrganizationId
                Next I

                'Save the criteria organization rows
                Call SaveCriteriaReferralOrganizations(pvForm, vReturn)

                '09/05/02 drh - Save the criteria list as a system alert
                vMsg = "Matched CURRENT criteria groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
                Call modStatSave.SaveSystemAlert(vMsg, -1)
                For I = 0 To UBound(vReturn, 1)
                    If ObjectIsValidArray(vReturn, 2, I, 3) Then
                        vMsg = "CUR Criteria " & vReturn(I, 2) & " = " & vReturn(I, 3)
                    End If
                    Call modStatSave.SaveSystemAlert(vMsg, -1)
                Next I
                vMsg = ""

            Else

                MsgBox("There are no CURRENT criteria groups available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Criteria for the saved organization will not be available." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate criteria groups.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Criteria Available")

                'Save the unverified organization as a system alert
                vMsg = "No matched CURRENT criteria groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
                Call modStatSave.SaveSystemAlert(vMsg, 1)
                vMsg = ""

            End If

        Else

            MsgBox("There are no criteria groups available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Criteria for the saved organization will not be available." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate criteria groups.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Criteria Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched criteria groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

        vReturn = Nothing

        'Next, create the schedule organization associations
        'Get all the schedule group organization rows with the matched organization ID
        If modStatQuery.QueryScheduleGroupOrganization((MatchedOrg.ID), vReturn, pvForm.SourceCode) = SUCCESS Then

            'Replace the matched organization ID with the new organization ID
            For I = 0 To UBound(vReturn, 1)
                vReturn(I, 1) = pvForm.OrganizationId
            Next I

            'Save the schedule organization rows
            Call SaveScheduleReferralOrganizations(pvForm, vReturn)

        Else

            MsgBox("There are no schedule groups available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "An on call schedule for the saved organization will not be available." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate schedule groups.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No On Call Schedule Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched schedule groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

        vReturn = Nothing

        'Next, create the report organization associations
        'Get all the report group organization rows with the organization ID
        If modStatQuery.QueryWebReportGroupOrganization((MatchedOrg.ID), vReturn) = SUCCESS Then

            'Replace the matched organization ID with the new organization ID
            For I = 0 To UBound(vReturn, 1)
                vReturn(I, 1) = pvForm.OrganizationId
            Next I

            'Save the report group organization rows
            Call SaveWebReportOrganizations(pvForm, vReturn)

        Else

            MsgBox("There are no report groups available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "The saved organization will not be available on any reports." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate report groups.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Report Groups Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched report groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

        vReturn = Nothing

        'Create the service level organization associations
        'Get all the service level organization rows with the organization ID
        'FSProj drh 5/2/02 - Only get the Working Service Level type (ServiceLevelStatus)
        If MatchedOrg.GetServiceLevel(pvForm.SourceCode.ID, WORKING_SERVICELEVEL) = SUCCESS Then

            Call MatchedOrg.ServiceLevel.SaveOrgAssociation(pvForm.OrganizationId)

            '09/05/02 drh - Save the service level as a system alert
            vMsg = "Matched WORKING service level: '" & pvForm.TxtName.Text & "' == '" & MatchedOrg.ServiceLevel.Name & "'"
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            vMsg = ""

            'drh 09/04/02 - Set vReturn to Empty so we can get/update CURRENT Service Level
            vReturn = Nothing
            'drh 09/04/02 - Added this entire if/else/end clause to update Current ServiceLevel
            If MatchedOrg.GetServiceLevel(pvForm.SourceCode.ID, CURRENT_SERVICELEVEL) = SUCCESS Then

                Call MatchedOrg.ServiceLevel.SaveOrgAssociation(pvForm.OrganizationId)

                '09/05/02 drh - Save the service level as a system alert
                vMsg = "Matched CURRENT service level: '" & pvForm.TxtName.Text & "' == '" & MatchedOrg.ServiceLevel.Name & "'"
                Call modStatSave.SaveSystemAlert(vMsg, -1)
                vMsg = ""

            Else

                MsgBox("There is no CURRENT service level available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "The saved organization will not be available.  Please copy the referral on paper and notify your supervisor." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate service level.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Service Level Available")

                'Save the unverified organization as a system alert
                vMsg = "No matched CURRENT service level group:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
                Call modStatSave.SaveSystemAlert(vMsg, 1)
                vMsg = ""

            End If

        Else

            MsgBox("There is no service level available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "The saved organization will not be available.  Please copy the referral on paper and notify your supervisor." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate service level.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Service Level Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched service level group:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

        vReturn = Nothing

        'Create the alert organization associations
        'Get all the alert organization rows with the organization ID
        If modStatQuery.QueryAlertOrganizations((MatchedOrg.ID), vReturn, pvForm.SourceCode) = SUCCESS Then

            'Replace the matched organization ID with the new organization ID
            For I = 0 To UBound(vReturn, 1)
                vReturn(I, 1) = pvForm.OrganizationId
            Next I

            'Save the organization rows
            Call SaveAlertOrganizations(pvForm, vReturn)

            '09/05/02 drh - Save the alert list as a system alert
            vMsg = "Matched alert groups:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            For I = 0 To UBound(vReturn, 1)
                vMsg = "Alert Group: '" & vReturn(I, 2) & "'"
                Call modStatSave.SaveSystemAlert(vMsg, -1)
            Next I
            vMsg = ""

        Else

            MsgBox("There are no alerts available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate alert group.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Alerts Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched alert group:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

        'Create the alert organization associations
        'Get all the source code organization rows with the organization ID
        If MatchedOrg.GetSourceCodes = SUCCESS Then

            TempSourceCodes = MatchedOrg.SourceCodes

            '09/05/02 drh - Save the source code list as a system alert
            vMsg = "Matched source code:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, -1)
            vMsg = ""

            For I = 0 To TempSourceCodes.count - 1
                Call TempSourceCodes.Item(I).Organizations.AddItem(NewOrganization)
                Call TempSourceCodes.Item(I).Organizations.Item((NewOrganization.Key)).Save()

                '09/05/02 drh - Save the source code list as a system alert
                vMsg = "Source Code: '" & TempSourceCodes.Item(I).Name & "'"
                Call modStatSave.SaveSystemAlert(vMsg, -1)
                vMsg = ""
            Next I

        Else

            MsgBox("There are no source codes available for the matched organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "The saved organization will not be available via a source code.  Please copy the referral on paper and notify your supervisor." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenence manager to associate the organization to the appropriate service level.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "No Source Code Available")

            'Save the unverified organization as a system alert
            vMsg = "No matched source code:  " & pvForm.TxtName.Text & " - " & pvForm.CboState.Text
            Call modStatSave.SaveSystemAlert(vMsg, 1)
            vMsg = ""

        End If

    End Function






    Public Function SaveCriteriaGroupIndication(ByRef pvForm As FrmCriteria) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vCriteriaGroupID As Integer
        Dim vReturn As New Object
        Dim vGridList As New Object
        Dim I As Short

        vGridList = pvForm.IndicationList

        'Get the data
        Dim vParams(1) As Object

        vParams(0) = modControl.GetID(pvForm.CboCriteriaGroup)

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "CriteriaID"
        vFields(1) = "IndicationID"

        'Get and save each row of the group organizations
        For I = 0 To UBound(vGridList, 1)
            vParams(1) = modConv.TextToLng(vGridList(I, 0))
            'Check if the item to be added already exists
            If modStatQuery.QueryCriteriaGroupIndication(pvForm, vParams, vReturn) = NO_DATA Then
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                vQuery = vQuery & "INSERT INTO CriteriaIndication (" & vValues & ") "
            End If
        Next I

        If vQuery <> "" Then
            Try
                SaveCriteriaGroupIndication = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        Else
            SaveCriteriaGroupIndication = NO_DATA
        End If

    End Function
    Public Function UpdateCriteriaScheduleGroupOption(ByVal pvCriteriaId As Integer, ByVal pvScheduleGroupID As Integer, ByVal pvOption As Short, ByVal pvValue As Short) As Short

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the data
        Dim vParams(0) As Object

        vParams(0) = pvValue

        'Specify the table fields
        Dim vFields(0) As Object

        Select Case pvOption
            Case ORGAN
                vFields(0) = "CriteriaScheduleGroupOrgan"
            Case BONE
                vFields(0) = "CriteriaScheduleGroupBone"
            Case TISSUE
                vFields(0) = "CriteriaScheduleGroupTissue"
            Case SKIN
                vFields(0) = "CriteriaScheduleGroupSkin"
            Case VALVES
                vFields(0) = "CriteriaScheduleGroupValves"
            Case EYES
                vFields(0) = "CriteriaScheduleGroupEyes"
            Case RESEARCH
                vFields(0) = "CriteriaScheduleGroupResearch"
            Case NO_CONTACT_ON_DENY
                vFields(0) = "CriteriaScheduleNoContactOnDny"
            Case CONTACT_ON_CONSENT
                vFields(0) = "CriteriaScheduleContactOnCnsnt"
            Case CONTACT_ON_APPROACH
                vFields(0) = "CriteriaScheduleContactOnAprch"
            Case CONTACT_ON_CORONER
                vFields(0) = "CriteriaScheduleContactOnCrnr"
            Case CONTACT_ON_STATLINE_SECONDARY
                vFields(0) = "CriteriaScheduleContactOnStatSec"
            Case CONTACT_ON_STATLINE_CONSENT
                vFields(0) = "CriteriaScheduleContactOnStatCnsnt"
            Case CONTACT_ON_CORONER_ONLY
                vFields(0) = "CriteriaScheduleContactOnCoronerOnly"

        End Select

        'The record is updated.
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
        vQuery = vQuery & "UPDATE CriteriaScheduleGroup SET " & vValues & " " & "WHERE CriteriaID = " & pvCriteriaId & " " & "AND ScheduleGroupID = " & pvScheduleGroupID

        Try
            UpdateCriteriaScheduleGroupOption = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 5/6/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking2(pvCriteriaId)


    End Function

    Public Function UpdateSubCriteriaScheduleGroupOption(ByVal pvSubCriteriaId As Integer, ByVal pvScheduleGroupID As Integer, ByVal pvOption As Short, ByVal pvValue As Short) As Short
        'FSProj drh 5/17/02

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the data
        Dim vParams(0) As Object

        vParams(0) = pvValue

        'Specify the table fields
        Dim vFields(0) As Object

        Select Case pvOption
            Case ORGAN
                vFields(0) = "SCScheduleGroupOrgan"
            Case BONE
                vFields(0) = "SCScheduleGroupBone"
            Case TISSUE
                vFields(0) = "SCScheduleGroupTissue"
            Case SKIN
                vFields(0) = "SCScheduleGroupSkin"
            Case VALVES
                vFields(0) = "SCScheduleGroupValves"
            Case EYES
                vFields(0) = "SCScheduleGroupEyes"
            Case RESEARCH
                vFields(0) = "SCScheduleGroupResearch"
            Case NO_CONTACT_ON_DENY
                vFields(0) = "SCScheduleNoContactOnDny"
            Case CONTACT_ON_CONSENT
                vFields(0) = "SCScheduleContactOnCnsnt"
            Case CONTACT_ON_APPROACH
                vFields(0) = "SCScheduleContactOnAprch"
            Case CONTACT_ON_CORONER
                vFields(0) = "SCScheduleContactOnCrnr"
            Case CONTACT_ON_STATLINE_SECONDARY
                vFields(0) = "SCScheduleContactOnStatSec"
            Case CONTACT_ON_STATLINE_CONSENT
                vFields(0) = "SCScheduleContactOnStatCnsnt"
            Case CONTACT_ON_CORONER_ONLY
                vFields(0) = "SCScheduleContactOnCoronerOnly"

        End Select

        'The record is updated.
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
        vQuery = vQuery & "UPDATE SCScheduleGroup SET " & vValues & " " & "WHERE SubCriteriaID = " & pvSubCriteriaId & " " & "AND ScheduleGroupID = " & pvScheduleGroupID

        Try
            UpdateSubCriteriaScheduleGroupOption = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'FSProj drh 5/6/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking2(pvSubCriteriaId)


    End Function
    Public Function SavePersonPhone(ByRef pvForm As FrmPersonPhone) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vPhoneID As Integer

        'Save the phone number
        vPhoneID = modStatSave.SavePhone(pvForm.TxtPhone.Text, modControl.GetID(pvForm.CboPhoneType))

        'Get the data
        Dim vParams(3) As Object

        vParams(0) = pvForm.PersonID
        vParams(1) = vPhoneID
        vParams(2) = pvForm.TxtPIN.Text
        vParams(3) = pvForm.TxtAlpha.Text

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "PersonID"
        vFields(1) = "PhoneID"
        vFields(2) = "PersonPhonePin"
        vFields(3) = "PhoneAlphaPagerEmail"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO PersonPhone (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE PersonPhone SET " & vValues & " " & "WHERE PersonID = " & pvForm.PersonID & " " & "AND PhoneID = " & pvForm.PhoneID & " "

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        SavePersonPhone = vPhoneID

    End Function

    Public Function SaveCounty(ByRef pvForm As FrmCounty) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the data
        Dim vParams(2) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = modControl.GetID(pvForm.CboState)
        vParams(2) = pvForm.Verified

        'Specify the table fields
        Dim vFields(2) As Object

        vFields(0) = "CountyName"
        vFields(1) = "StateID"
        vFields(2) = "Verified"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO County (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE County SET " & vValues & " WHERE CountyID = " & pvForm.CountyID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then

            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryCounty(vReturn, , pvForm.TxtName.Text)

            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveCounty = modConv.TextToLng(vReturn(0, 0))
            End If

        Else
            'Pass back the ID
            SaveCounty = pvForm.CountyID
        End If

    End Function
#Region "AppMain"
    Public Function SaveSystemAlert(ByRef pvMsg As String, ByRef pvStatus As Short) As Object
        ''
        '' Bret Knoll 
        '' Modifying function so that it does nothing. This functionality is not used any longer
        ''
        ''
        ''
        Exit Function
        ''
        ''
        ''

        '11/22/02 drh - Added pvStatus parameter and SystemAlertResolved field (1 = Unresolved; -1 = Resolved)

        Dim vValues As String = ""
        Dim vQuery As String = ""

        'Get the call data
        Dim vParams(3) As Object

        vParams(0) = Now
        vParams(1) = AppMain.ParentForm.StatEmployeeID
        vParams(2) = pvMsg
        vParams(3) = pvStatus

        'Specify the field names
        Dim vFields(3) As Object

        vFields(0) = "SystemAlertDate"
        vFields(1) = "StatEmployeeID"
        vFields(2) = "SystemAlertMessage"
        vFields(3) = "SystemAlertResolved"

        'Build and execute the query
        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

        vQuery = "INSERT INTO SystemAlert (" & vValues & ")"

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
#End Region

#Region "MDIForm"

    Public Function CommitClientChanges() As Object

        Dim vQuery As String = ""
        Dim Result As Short
        Dim ResultArray As New Object
        Dim DBName As String = ""

        ResultArray = New Object

        vQuery = "EXEC spu_CommitClientChanges 'Commit Historical Changes - '"
        Try
            Result = modODBC.Exec(vQuery, ResultArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Result = SUCCESS _
            AndAlso ObjectIsValidArray(ResultArray, 2, 0, 0) Then
            MsgBox(ResultArray(0, 0))
        End If

    End Function
#End Region
    Public Function SaveIndication(ByRef pvForm As FrmIndication) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the data
        Dim vParams(3) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.TxtNote.Text
        vParams(2) = pvForm.Verified
        vParams(3) = modConv.ChkValueToDBTrueValue(pvForm.ChkHighRisk.Checked)

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "IndicationName"
        vFields(1) = "IndicationNote"
        vFields(2) = "Verified"
        vFields(3) = "IndicationHighRisk"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Indication (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Indication SET " & vValues & " WHERE IndicationID = " & pvForm.IndicationID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then

            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryIndication(vReturn, , pvForm.TxtName.Text)

            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveIndication = modConv.TextToLng(vReturn(0, 0))
            End If

        Else
            'Pass back the ID
            SaveIndication = pvForm.IndicationID
        End If

    End Function

    Public Function SaveSecondary(ByRef pvForm As Object, Optional ByRef CtlList As Object = Nothing, Optional ByRef CtlList2 As Object = Nothing) As Integer
        '************************************************************************************
        'Name: SaveSecondary
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: save Secondary data (table 1 and table 2)
        'Returns:
        'Params:
        '
        'Stored Procedures: InsertSecondary, UpdateSecondary, InsertSecondary2, UpdateSecondary2,
        '                   InsertSecondaryApproach, InsertSecondaryMedication
        '====================================================================================
        '====================================================================================
        'Date Changed: 07/2/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed dynamic queries to sprocs
        '               Add LastStatEmployeeID
        '====================================================================================
        'FSProj drh 6/14/02 Insert/Update a Secondary/Secondary2 record

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vPhoneID As Integer
        Dim vGridValues As New Object
        Dim vResult As Short
        Dim I As Integer
        Dim LoopCount As Integer
        Dim vReturn As New Object

        Dim vParams() As Object
        Dim vFields() As Object
        Dim vParams2() As Object
        Dim vFields2() As Object
        Dim vApproachTypeId As Short
        Dim vApproachedById As Integer
        Dim vGeneralConsentId As Short
        Dim vRefForm As FrmReferral
        Dim vAttendingMDId As Integer
        If pvForm.Name = "FrmReferralView" Then

            '***************************************************************
            'BEGIN - UPDATE SECONDARY TABLE*********************************
            '***************************************************************
            'Get the secondary information
            ReDim vParams(126) 'drh FSMod 07/20/03 - Updated all indexes

            'Textbox/DB Varchar
            vParams(0) = pvForm.CallId
            For I = 0 To 73
                vParams(I + 1) = pvForm.DataTextArray(CtlList(0, I)).Text
            Next I

            'Combobox/DB Integer
            For I = 74 To 108
                Try
                    vParams(I + 1) = modControl.GetID(pvForm.DataComboArray(CtlList(0, I)))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Next I

            'Combobox/DB Text
            For I = 109 To 113
                vParams(I + 1) = pvForm.DataComboArray(CtlList(0, I)).Text
            Next I

            'Rich Text/DB Varchar
            For I = 114 To 119
                vParams(I + 1) = pvForm.DataRTFArray(CtlList(0, I)).Text
            Next I

            'drh FSMod 06/19/03 - New Format: Checkbox
            For I = 120 To 120
                vParams(I + 1) = pvForm.DataCheckboxArray(CtlList(0, I)).Checked
            Next I

            'Combobox (w/"other" text)/DB Integer
            For I = 121 To 122
                Try
                    vParams(I + 1) = modControl.GetID(pvForm.DataComboArray(CtlList(0, I)))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Next I

            'Combobox (w/"other" text)/DB Varchar
            For I = 121 To 122
                vParams(I + 3) = pvForm.DataComboArray(CtlList(0, I)).Text
            Next I

            '        'Add WhoAreWe param
            '        ReDim Preserve vParams(UBound(vParams, 1) + 1)
            '        vParams(UBound(vParams, 1)) = pvForm.txtWhoAreWe.Text

            '07/01/07 bret 8.4.3.8 manually set vParams. The value cannot be added to the CtlList
            ' because it is not a control
            vParams(126) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)


            'Specify the fields
            ReDim vFields(126) 'drh FSMod 07/20/03 - Updated all indexes

            'Call Info
            vFields(0) = "@CallID"

            For I = 0 To 122
                vFields(I + 1) = "@" & CtlList(1, I)
            Next I

            For I = 121 To 122
                vFields(I + 3) = "@" & CtlList(2, I)
            Next I

            '07/01/07 bret 8.4.3.8 manually set vFields. The value cannot be added to the CtlList
            ' because it is not a control
            vFields(126) = "@LastStatEmployeeID"

            '        'Add WhoAreWe field
            '        ReDim Preserve vFields(UBound(vFields, 1) + 1)
            '        vFields(UBound(vFields, 1)) = "SecondaryWhoAreWe"

            'Update the record
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "EXEC UpdateSecondary " & vValues

            'Execute the query
            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '****************************************************************
            'END - UPDATE SECONDARY TABLE************************************
            '****************************************************************




            '****************************************************************
            'BEGIN - UPDATE SECONDARY2 TABLE*********************************
            '****************************************************************
            'Get the secondary information
            ReDim vParams2(83) '07/20/03 drh FSMod - Updated all indexes
            '07/02/07 bret 8.4.3.8 changed to 83

            'Textbox/DB Varchar
            vParams2(0) = pvForm.CallId
            For I = 0 To 38
                vParams2(I + 1) = pvForm.DataTextArray(CtlList2(0, I)).Text
            Next I

            'Combobox/DB Integer
            For I = 39 To 39
                Try
                    vParams2(I + 1) = modControl.GetID(pvForm.DataComboArray(CtlList2(0, I)))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Next I

            'Combobox/DB Text
            For I = 40 To 57
                vParams2(I + 1) = pvForm.DataComboArray(CtlList2(0, I)).Text
            Next I

            'Combobox (w/"other" text)/DB Integer
            For I = 58 To 69
                Try
                    vParams2(I + 1) = modControl.GetID(pvForm.DataComboArray(CtlList2(0, I)))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            Next I

            'Combobox (w/"other" text)/DB Varchar
            For I = 58 To 69
                vParams2(I + 13) = pvForm.DataComboArray(CtlList2(0, I)).Text
            Next I

            '07/01/07 bret 8.4.3.8 manually set vParams. The value cannot be added to the CtlList
            ' because it is not a control
            vParams2(83) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

            'Specify the fields

            ReDim vFields2(83) '07/20/03 drh FSMod - Updated all indexes
            '07/2/07 bret 8.4.3.8 changed to 83

            'Call Info
            vFields2(0) = "@CallID"

            For I = 0 To 69
                vFields2(I + 1) = "@" & CtlList2(1, I)
            Next I

            For I = 58 To 69
                vFields2(I + 13) = "@" & CtlList2(2, I)
            Next I

            '07/01/07 bret 8.4.3.8 manually set vFields. The value cannot be added to the CtlList
            ' because it is not a control
            vFields2(83) = "@LastStatEmployeeID"

            'Update the record
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams2, vFields2)

            vQuery = "EXEC UpdateSecondary2 " & vValues

            'Execute the query
            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '****************************************************************
            'END - UPDATE SECONDARY2 TABLE***********************************
            '****************************************************************


            '****************************************************************
            'BEGIN - SAVE MEDICATIONS****************************************
            '****************************************************************
            '07/02/07 bret: The previous process removed and then reinserted the medication
            ' The Insert sproc has been modified to only insert medication that do not exist for the call

            'Add Secondary Meds for this CallId
            vQuery = ""
            For Each valueDescritionPair As ValueDescriptionPair In DirectCast(pvForm, FrmReferralView).lstSelectedMeds.Items

                vQuery = vQuery & "EXEC InsertSecondaryMedication @CallId = " & pvForm.CallId & ", " & "@MedicationId = " & valueDescritionPair.Value & " , " & "@LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "
            Next

            If vQuery <> "" Then
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

            '****************************************************************
            'END - SAVE MEDICATIONS******************************************
            '****************************************************************

            'drh FSMod 06/10/03 - Save Med types (ie. Steroid, Antibiotic, etc.)
            '****************************************************************
            'BEGIN - SAVE MEDICATION TYPES***********************************
            '****************************************************************
            For forLoop As Short = 0 To pvForm.DataItemListArray.Count - 1
                Call pvForm.DataItemListArray(forLoop).saveSelected(pvForm.CallId)
            Next forLoop
            '****************************************************************
            'END - SAVE MEDICATION TYPES*************************************
            '****************************************************************

        Else
            'Does the Secondary already exist?
            vQuery = "SELECT CallID from Secondary WHERE CallID = " & pvForm.CallId
            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = NO_DATA Then

                'drh FSMod 05/28/03 - Get Hospital Approach values

                'drh FSMod 06/16/03

                If pvForm.Name = "FrmReferral" Then
                    vRefForm = pvForm
                Else
                    vRefForm = pvForm.vParentForm
                End If

                Try
                    vApproachTypeId = modControl.GetID(vRefForm.cboApproachType)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Try
                    vApproachedById = modControl.GetID(vRefForm.CboApproachedBy)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Try
                    vGeneralConsentId = modControl.GetID(vRefForm.CboGeneralConsent)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
                Try
                    vAttendingMDId = modControl.GetID(vRefForm.CboPhysician(0))
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                'FSProj drh 6/14/02 - Insert Secondary/Secondary2 records
                'drh FSMod 06/16/03 - Added SecondaryMDAttendingId
                vQuery = "EXEC InsertSecondary " & "@CallId = " & pvForm.CallId & ", @SecondaryMDAttendingId = " & vAttendingMDId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "
                vQuery = vQuery & "Exec InsertSecondary2 " & "@CallId = " & pvForm.CallId & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "


                'drh FSMod 05/28/03 - Added columns to query to bring Hospital Approach values over from Triage
                vQuery = vQuery & "EXEC InsertSecondaryApproach @CallId = " & pvForm.CallId & ", @SecondaryHospitalApproach = " & vApproachTypeId & ", @SecondaryHospitalApproachedBy = " & vApproachedById & ", @SecondaryHospitalOutcome = " & vGeneralConsentId & ", @SecondaryConsentLongSleeves = " & "-1" & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "

                'Execute the query
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Else
                SaveSecondary = NO_DATA
                Exit Function
            End If
        End If


        If vResult = SUCCESS Then
            SaveSecondary = SUCCESS
        Else
            SaveSecondary = SQL_ERROR
        End If
        Exit Function

    End Function


    Public Function SaveKeyCode(ByRef pvForm As FrmKeyCode) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.TxtNote.Text

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "KeyCodeName"
        vFields(1) = "KeyCodeNote"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO KeyCode (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE KeyCode SET " & vValues & " WHERE KeyCodeID = " & pvForm.KeyCodeID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then

            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryKeyCode(vReturn, , pvForm.TxtName.Text)

            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveKeyCode = modConv.TextToLng(vReturn(0, 0))
            End If

        Else
            'Pass back the ID
            SaveKeyCode = pvForm.KeyCodeID
        End If

    End Function


    Public Function SaveDictionaryItem(ByRef pvForm As FrmDictionaryItem) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "DictionaryItemName"
        vFields(1) = "Verified"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO DictionaryItem (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE DictionaryItem SET " & vValues & " WHERE DictionaryItemID = " & pvForm.DictionaryItemID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then

            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryDictionaryItem(vReturn, , pvForm.TxtName.Text)

            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveDictionaryItem = modConv.TextToLng(vReturn(0, 0))
            End If

        Else
            'Pass back the ID
            SaveDictionaryItem = pvForm.DictionaryItemID
        End If

    End Function


    Public Function SavePhone(ByRef pvPhoneNumber As String, Optional ByRef pvPhoneTypeID As Object = Nothing) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vAreaCode As String = ""
        Dim vPrefix As String = ""
        Dim vNumber As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object
        Dim vRecord As Short
        Dim vPhoneID As Integer

        'Check to see if it is

        'already in the phone table
        'If pvPhoneTypeID <> 3 Then 'Type 3 is a hospital contact number(?) might needt o check only if type 8 (page-auto)
        If modStatRefQuery.RefQueryPhone(vReturn, , pvPhoneNumber, pvPhoneTypeID) = SUCCESS Then 'mjd 05/28/2002 Page-AutoResponse
            'The number already exists,
            'so set the id
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                vPhoneID = modConv.TextToLng(vReturn(0, 0))
            End If
            vRecord = EXISTING_RECORD
        Else
            'The phone number doesn't exist
            'so let the phone be inserted
            vRecord = NEW_RECORD
        End If
        'End If

        'Strip out the components of the phone number
        vAreaCode = Mid(pvPhoneNumber, 2, 3)
        vPrefix = Mid(pvPhoneNumber, 7, 3)
        vNumber = Mid(pvPhoneNumber, 11, 4)

        'Get the phone data
        Dim vParams(3) As Object

        vParams(0) = vAreaCode
        vParams(1) = vPrefix
        vParams(2) = vNumber
        vParams(3) = modConv.TextToLng(pvPhoneTypeID)

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "PhoneAreaCode"
        vFields(1) = "PhonePrefix"
        vFields(2) = "PhoneNumber"
        vFields(3) = "PhoneTypeID"

        If vRecord = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Phone (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SavePhone = modConv.TextToLng(vReturn(0, 0))
            End If


        ElseIf vRecord = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Phone SET " & vValues & " WHERE PhoneID = " & vPhoneID

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then
                'Pass back the phone ID
                SavePhone = vPhoneID
            End If

        End If

    End Function

    Public Function SaveFax(ByRef pvFaxId As Integer, ByRef pvFaxNumber As String, ByRef pvOrganizationId As Integer) As Integer

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object
        Dim vRecord As Short

        'Check if it's a new record
        If pvFaxId = 0 Then
            vRecord = NEW_RECORD
        Else
            vRecord = EXISTING_RECORD
        End If


        If vRecord = NEW_RECORD Then

            vQuery = "INSERT INTO Fax(FaxNumber, OrganizationId) "
            vQuery = vQuery & "VALUES('" & pvFaxNumber & "', " & pvOrganizationId & ")"

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try


        ElseIf vRecord = EXISTING_RECORD Then

            vQuery = "UPDATE Fax SET FaxNumber = '" & pvFaxNumber & "' "
            vQuery = vQuery & "WHERE FaxID = " & pvFaxId

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function




    Public Function SaveOrganizationType(ByRef pvForm As FrmOrganizationType) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "OrganizationTypeName"
        vFields(1) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO OrganizationType (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE OrganizationType SET " & vValues & " WHERE OrganizationTypeID = " & pvForm.OrganizationTypeID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryOrganizationType(vReturn, , , pvForm.TxtName.Text)
            SaveOrganizationType = modConv.TextToLng(vReturn(0, 0))
        Else
            'Pass back the ID
            SaveOrganizationType = pvForm.OrganizationTypeID
        End If

    End Function

    Public Function SaveMessageType(ByRef pvForm As FrmMessageType) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "MessageTypeName"
        vFields(1) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO MessageType (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE MessageType SET " & vValues & " WHERE MessageTypeID = " & pvForm.MessageTypeID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryMessageType(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveMessageType = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the ID
            SaveMessageType = pvForm.MessageTypeID
        End If

    End Function


    Public Function SaveReference(ByRef pvForm As FrmReference) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(2) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = modConv.TextToLng(pvForm.ReferenceTypeID)
        vParams(2) = pvForm.Verified

        'Specify the table fields
        Dim vFields(2) As Object

        vFields(0) = "ReferenceText"
        vFields(1) = "ReferenceTypeID"
        vFields(2) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Reference (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Reference SET " & vValues & " WHERE ReferenceID = " & pvForm.ReferenceID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryReference(vReturn, , pvForm.TxtName.Text, pvForm.ReferenceTypeID)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveReference = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the ID
            SaveReference = pvForm.ReferenceID
        End If

    End Function



    Public Function SaveNoCallType(ByRef pvForm As FrmNoCallType) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "NoCallTypeName"
        vFields(1) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO NoCallType (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE NoCallType SET " & vValues & " WHERE NoCallTypeID = " & pvForm.NoCallTypeID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryNoCallType(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveNoCallType = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the ID
            SaveNoCallType = pvForm.NoCallTypeID
        End If

    End Function


    Public Function SaveCauseOfDeath(ByRef pvForm As FrmCauseOfDeath) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(3) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = modConv.ChkValueToDBTrueValue(pvForm.ChkPotential.Checked)
        vParams(2) = modConv.ChkValueToDBTrueValue(pvForm.ChkCoronerCase.Checked)
        vParams(3) = pvForm.Verified

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "CauseOfDeathName"
        vFields(1) = "CauseOfDeathOrganPotential"
        vFields(2) = "CauseOfDeathCoronerCase"
        vFields(3) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO CauseOfDeath (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE CauseOfDeath SET " & vValues & " WHERE CauseOfDeathID = " & pvForm.CauseOfDeathID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryCauseOfDeath(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveCauseOfDeath = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveCauseOfDeath = pvForm.CauseOfDeathID
        End If

    End Function

    Public Function SaveDictionaryItemMisspelling(ByRef pvForm As FrmMisspelling) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(2) As Object

        vParams(0) = pvForm.DictionaryItemID
        vParams(1) = pvForm.TxtName.Text
        vParams(2) = pvForm.Verified

        'Specify the table fields
        Dim vFields(2) As Object

        vFields(0) = "DictionaryItemID"
        vFields(1) = "DictionaryItemMisspellingName"
        vFields(2) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO DictionaryItemMisspelling (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE DictionaryItemMisspelling SET " & vValues & " WHERE DictionaryItemMisspellingID = " & pvForm.DictionaryItemMisspellingID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryDictionaryItemMisspelling(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveDictionaryItemMisspelling = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveDictionaryItemMisspelling = pvForm.DictionaryItemMisspellingID
        End If

    End Function


    Public Function SaveScheduleGroup(ByRef pvForm As FrmScheduleGroup) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(3) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.OrganizationId
        vParams(2) = pvForm.Verified
        vParams(3) = pvForm.TxtCode.Text

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "ScheduleGroupName"
        vFields(1) = "OrganizationID"
        vFields(2) = "Verified"
        vFields(3) = "ScheduleGroupCode"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO ScheduleGroup (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE ScheduleGroup SET " & vValues & " WHERE ScheduleGroupID = " & pvForm.ScheduleGroupID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryScheduleGroup(vReturn, , pvForm.TxtName.Text, pvForm.OrganizationId)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveScheduleGroup = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveScheduleGroup = pvForm.ScheduleGroupID
        End If

    End Function

    Public Function SaveScheduleShift(ByRef pvForm As FrmScheduleShift) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the data
        Dim vParams(4) As Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        vParams(0) = pvForm.ScheduleGroupID
        vParams(1) = pvForm.TxtName.Text
        vParams(2) = modControl.GetID(pvForm.CboDay)
        vParams(3) = pvForm.TxtStart.Text
        vParams(4) = pvForm.TxtEnd.Text

        'Specify the table fields
        Dim vFields(4) As Object

        vFields(0) = "ScheduleGroupID"
        vFields(1) = "ScheduleShiftName"
        vFields(2) = "WeekdayID"
        vFields(3) = "ScheduleShiftStartTime"
        vFields(4) = "ScheduleShiftEndTime"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO ScheduleShift (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE ScheduleShift SET " & vValues & " WHERE ScheduleShiftID = " & pvForm.ScheduleShiftID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryScheduleShift(vReturn, , pvForm.TxtName.Text, pvForm.ScheduleGroupID)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveScheduleShift = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveScheduleShift = pvForm.ScheduleShiftID
        End If

    End Function
    Public Function SaveScheduleItem(ByRef pvForm As FrmScheduleShiftItem, ByRef prScheduleItemID As Object) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim ScheduleItemID As New Object

        'Get the data
        Dim vParams(5) As Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        pvForm.CurrentStartDate = DateAdd(Microsoft.VisualBasic.DateInterval.Day,
                                          -DateDiff(Microsoft.VisualBasic.DateInterval.Day, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CurrentStartDate + " " + pvForm.CurrentStartTime)),
                                                    CDate(pvForm.CurrentStartDate)), CDate(pvForm.CurrentStartDate))
        pvForm.CurrentEndDate = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -DateDiff(Microsoft.VisualBasic.DateInterval.Day,
                                                                                          DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CurrentEndDate + " " + pvForm.CurrentEndTime)), CDate(pvForm.CurrentEndDate)),
                                                                                          CDate(pvForm.CurrentEndDate))


        vParams(0) = pvForm.ScheduleGroupID
        vParams(1) = pvForm.CurrentShiftName
        vParams(2) = pvForm.CurrentStartDate
        'ccarroll 12/21/2010 was: vParams(3) = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CurrentStartTime)), "hh:mm")
        vParams(3) = CDate(pvForm.CurrentStartDate + " " + pvForm.CurrentStartTime).AddHours(-vTimeZoneDif).ToString("H:mm")
        vParams(4) = pvForm.CurrentEndDate
        'ccarroll 12/21/2010 was: vParams(5) = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(pvForm.CurrentEndTime)), "hh:mm")
        vParams(5) = CDate(pvForm.CurrentEndDate + " " + pvForm.CurrentEndTime).AddHours(-vTimeZoneDif).ToString("H:mm")

        'Specify the table fields
        Dim vFields(5) As Object

        vFields(0) = "ScheduleGroupID"
        vFields(1) = "ScheduleItemName"
        vFields(2) = "ScheduleItemStartDate"
        vFields(3) = "ScheduleItemStartTime"
        vFields(4) = "ScheduleItemEndDate"
        vFields(5) = "ScheduleItemEndTime"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO ScheduleItem (" & vValues & ")"

            Try
                SaveScheduleItem = modODBC.Exec(vQuery, ScheduleItemID)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If SaveScheduleItem = SUCCESS _
                AndAlso ObjectIsValidArray(ScheduleItemID, 2, 0, 0) Then
                prScheduleItemID = modConv.TextToLng(ScheduleItemID(0, 0))
            End If

        Else

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE ScheduleItem SET " & vValues & " WHERE ScheduleItemID = " & pvForm.ScheduleItemID

            'Pass back the  ID
            Try
                SaveScheduleItem = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            prScheduleItemID = pvForm.ScheduleItemID

        End If

    End Function

    Public Function SaveScheduleCopyShiftPerson(ByVal pvCopyFromShiftItemID As Integer, ByVal pvCopyToShiftItemID As Integer) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vData As New Object
        Dim vResult As Short
        Dim I As Short

        'First get a list of persons from the shift being copied
        vQuery = "SELECT PersonID, Priority FROM ScheduleItemPerson " & "WHERE ScheduleItemID = " & pvCopyFromShiftItemID & " ORDER BY Priority "

        Try
            vResult = modODBC.Exec(vQuery, vData)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Dim vFields(2) As Object
        Dim vParams(2) As Object
        If vResult = SUCCESS Then

            'Specify the table fields

            vFields(0) = "ScheduleItemID"
            vFields(1) = "PersonID"
            vFields(2) = "Priority"

            'Insert a shift person for each person selected
            For I = 0 To UBound(vData, 1)

                'Get the data

                vParams(0) = pvCopyToShiftItemID
                vParams(1) = vData(I, 0)
                vParams(2) = vData(I, 1)

                'Build and execute the query
                'The record is new and should be inserted.
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO ScheduleItemPerson (" & vValues & ")"

                Try
                    SaveScheduleCopyShiftPerson = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            Next I

        End If

    End Function

    Public Function SaveScheduleGroupNotes(ByRef pvForm As FrmSchedule) As Object
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Modified for RTF. Set form field correctly by adding RTF to pvform.field.textRTF
        '====================================================================================
        '************************************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(2) As Object

        vParams(0) = pvForm.TxtScheduleReferralNotes.Rtf
        vParams(1) = pvForm.TxtScheduleMessageNotes.Rtf
        vParams(2) = System.Math.Abs(CInt(DirectCast(pvForm.ChkActive, CheckBox).Checked))

        'Specify the table fields
        Dim vFields(2) As Object

        vFields(0) = "ScheduleGroupReferralNotes"
        vFields(1) = "ScheduleGroupMessageNotes"
        vFields(2) = "UseNewSchedule"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE ScheduleGroup SET " & vValues & " WHERE ScheduleGroupID = " & pvForm.ScheduleGroupID

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function SaveDynamicDonorCategory(ByRef pvForm As FrmEditDynamicDonorCategory) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.DynamicDonorCategoryID

        'Confirm the the dynamic donor category does not exist.
        Call RefQueryDynamicDonorCategory(vReturn, , vParams(0))


        'Build and execute the query
        If vParams(1) = 0 Then

            'Confirm the the dynamic donor category does not exist.
            'if it does exit else insert the new donor category
            If ObjectIsValidArray(vReturn, 2, 0, 0) _
                AndAlso IsNothing(vReturn(0, 0)) Then

                vQuery = "spi_DynamicDonorCategory " & Chr(39) & vParams(0) & Chr(39) & ";"
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            ElseIf ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveDynamicDonorCategory = vReturn(0, 0)
            End If
        Else
            'Confirm the the dynamic donor category name is not equal to an old name
            'if it does exit else check if it is the same

            If ObjectIsValidArray(vReturn, 2, 0, 1) _
                AndAlso vReturn(0, 1) <> vParams(0) Then
                vQuery = "spu_DynamicDonorCategory " & vParams(1) & "," & Chr(39) & vParams(0) & Chr(39) & ";"
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

            ElseIf ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveDynamicDonorCategory = vReturn(0, 0)
                vParams(1) = 0
            End If
        End If

        If vParams(1) = 0 Then
            'Get the ID the the record just inserted.
            Call RefQueryDynamicDonorCategory(vReturn, , vParams(0))
            SaveDynamicDonorCategory = vReturn(0, 0)

        Else
            'Pass back the phone ID
            SaveDynamicDonorCategory = pvForm.DynamicDonorCategoryID
        End If

    End Function
    Public Function SaveCriteriaDynamicDonorCategory(ByRef pvForm As FrmDynamicDonorCategory) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.CriteriaGroupID
        vParams(1) = pvForm.DynamicCategoryID

        'Build and execute the query
        vQuery = "spu_CriteriaDynamicDonorCategory " & vParams(0) & ", " & vParams(1) & ";"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        SaveCriteriaDynamicDonorCategory = vResult

    End Function
    Public Function SaveSecondaryTBINumber(ByRef pvForm As Object) As String
        '************************************************************************************
        'Name: SaveSecondaryTBINumber
        'Date Created: 06/15/2007                         Created by: Christopher Carroll
        'Release: StatTrac 8.4                            Task: requirement 3.6
        'Description: Generate, save and return new TBI number
        'Params: pvForm
        'Stored Procedures: InsertTBI
        '====================================================================================
        'Date Changed:                                    Changed by:
        'Release #:                                       Task:
        'Description:
        '====================================================================================

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vReturn As New Object

        vQuery = "InsertTBI " & pvForm.CallId & ", " & pvForm.TBIPrefix & ", " & pvForm.TBIDate & ", " & pvForm.CallOpenByID

        Try
            vResult = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 1) Then
            SaveSecondaryTBINumber = vReturn(0, 1)
        End If

        If ObjectIsValidArray(vResult, 2, 0, 1) Then
            Try
                SaveSecondaryTBINumber = CStr(modODBC.Exec(vQuery, vResult(0, 1)))
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

    End Function


    Public Function SaveCriteriaGroup(ByRef pvForm As FrmCriteriaGroup) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the call data
        Dim vParams(5) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.DonorCategoryID
        vParams(2) = pvForm.DonorCategoryID

        'FSProj drh 5/6/02 - Added fields for historical criteria
        vParams(3) = WORKING_CRITERIA
        vParams(4) = 1
        vParams(5) = IIf(pvForm.FormState = NEW_RECORD, 0, pvForm.CriteriaGroupID)

        'Specify the table fields
        Dim vFields(5) As Object

        vFields(0) = "CriteriaGroupName"
        vFields(1) = "DonorCategoryID"
        vFields(2) = "DynamicDonorCategoryID"

        'FSProj drh 5/6/02 - Added fields for historical criteria
        vFields(3) = "CriteriaStatus"
        vFields(4) = "WorkingStatusUpdatedFlag"
        vFields(5) = "WorkingCriteriaId"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO Criteria (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Criteria SET " & vValues & " WHERE CriteriaID = " & pvForm.CriteriaGroupID & " AND " & vFields(2) & " is null"

        End If

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            'FSProj drh 4/29/02 - Pass in Criteria Status so we get the correct Historical Criteria type (CriteriStatus)
            Call modStatRefQuery.RefQueryCriteriaGroup(vReturn, , pvForm.TxtName.Text, pvForm.DonorCategoryID, pvForm.CriteriaStatusID)

            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                'FSProj drh 5/6/02 - Update the new record's WorkingCriteriaId with the new CriteriaId
                vQuery = "UPDATE Criteria SET WorkingCriteriaId = " & modConv.TextToLng(vReturn(0, 0)) & " WHERE CriteriaId = " & modConv.TextToLng(vReturn(0, 0))
                Try
                    vResult = modODBC.Exec(vQuery)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                SaveCriteriaGroup = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveCriteriaGroup = pvForm.CriteriaGroupID
        End If

    End Function

    Public Function SaveCriteriaWorking(ByRef pvForm As FrmCriteria) As Object
        'FSProj drh 5/6/02 - New function to update Criteria.WorkingStatusUpdatedFlag

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "UPDATE Criteria SET WorkingStatusUpdatedFlag = 1" & " WHERE CriteriaID = " & pvForm.CriteriaGroupID

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveServiceLevelWorking(ByRef pvForm As FrmServiceLevel) As Object
        'FSProj drh 5/6/02 - New function to update ServiceLevel.WorkingStatusUpdatedFlag

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "UPDATE ServiceLevel SET WorkingStatusUpdatedFlag = 1" & " WHERE ServiceLevelID = " & pvForm.ServiceLevel.ID

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveSubtype(ByRef pvForm As FrmSubtype) As Object
        'FSProj drh 5/8/02 - New function to save new Subtype

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "INSERT Subtype(SubtypeName, SubtypeDescription) " & "VALUES('" & Trim(pvForm.txtSubtypeName.Text) & "', '" & Trim(pvForm.txtSubtypeDescription.Text) & "')"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveFSIndication(ByRef pvForm As FrmFSIndication) As Object
        'FSProj drh 5/10/02 - New function to save new Indication

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "INSERT FSIndication(FSIndicationName) " & "VALUES(" & modODBC.BuildField(Trim(pvForm.txtIndication.Text)) & ")"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveFSCondition(ByRef pvForm As FrmFSCondition) As Object
        'FSProj drh 5/10/02 - New function to save new Condition

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "INSERT FSCondition(FSConditionName) " & "VALUES(" & modODBC.BuildField(Trim(pvForm.txtCondition.Text)) & ")"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveTemplateConditional(ByRef pvForm As FrmConditional) As Object
        'FSProj drh 5/10/02 - New function to save new Conditional

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "INSERT CriteriaTemplate_ConditionalRO(CriteriaTemplateId, FSIndicationId, FSAppropriateId, FSConditionId) " & "VALUES(" & pvForm.vCriteriaTemplateId & "," & pvForm.vSelectedCriteriaId & "," & pvForm.vSelectedReasonId & "," & pvForm.vSelectedConditionId & ")"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveSubCriteriaConditional(ByRef pvForm As FrmConditional) As Object
        'FSProj drh 5/16/02 - New function to save new Conditional

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "INSERT ProcessorCriteria_ConditionalRO(SubCriteriaId, FSIndicationId, FSAppropriateId, FSConditionId) " & "VALUES(" & pvForm.vSubCriteriaId & "," & pvForm.vSelectedCriteriaId & "," & pvForm.vSelectedReasonId & "," & pvForm.vSelectedConditionId & ")"

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveSecondaryDataTree(ByRef pvForm As FrmServiceLevel, ByRef pvTree As System.Windows.Forms.TreeView) As Object
        'FSProj drh 5/22/02

        Dim vQuery As String = ""
        Dim vResult As Integer
        Dim I As Integer
        Dim vServiceLevelId As Integer
        Dim vString As String = ""
        Dim vSecondaryCtlsId As Integer

        vServiceLevelId = pvForm.ServiceLevel.ID

        If pvTree.Nodes.Count > 0 Then
            'First, initialize all items to visible
            vQuery = "UPDATE ServiceLevelSecondaryCtls " & "SET Visible = -1 " & "WHERE ServiceLevelId = " & vServiceLevelId & "; "

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then

                'Now, make all unchecked items not visible
                vQuery = ""
                'loop thru each tree node...old method would count all, but now only counts parents
                For Each a As TreeNode In pvTree.Nodes 'loop through parent nodes
                    If Not a.Checked Then
                        vString = a.Tag
                        vString = Left(vString, Len(vString) - 1)
                        vString = Right(vString, Len(vString) - 1)
                        vSecondaryCtlsId = CInt(vString)

                        vQuery = vQuery & "UPDATE ServiceLevelSecondaryCtls " & "SET Visible = 0 " & "WHERE ServiceLevelSecondaryCtlsID = " & vSecondaryCtlsId & " " & "AND ServiceLevelId = " & vServiceLevelId & "; "
                    End If
                    For Each b As TreeNode In a.Nodes 'loop through 1st child nodes
                        If Not b.Checked Then
                            vString = b.Tag
                            vString = Left(vString, Len(vString) - 1)
                            vString = Right(vString, Len(vString) - 1)
                            vSecondaryCtlsId = CInt(vString)

                            vQuery = vQuery & "UPDATE ServiceLevelSecondaryCtls " & "SET Visible = 0 " & "WHERE ServiceLevelSecondaryCtlsID = " & vSecondaryCtlsId & " " & "AND ServiceLevelId = " & vServiceLevelId & "; "
                        End If
                        For Each c As TreeNode In b.Nodes 'loop through 2nd child nodes
                            If Not c.Checked Then
                                vString = c.Tag
                                vString = Left(vString, Len(vString) - 1)
                                vString = Right(vString, Len(vString) - 1)
                                vSecondaryCtlsId = CInt(vString)

                                vQuery = vQuery & "UPDATE ServiceLevelSecondaryCtls " & "SET Visible = 0 " & "WHERE ServiceLevelSecondaryCtlsID = " & vSecondaryCtlsId & " " & "AND ServiceLevelId = " & vServiceLevelId & "; "
                            End If

                        Next
                    Next
                Next

                If vQuery <> "" Then
                    Try
                        vResult = modODBC.Exec(vQuery)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If
        End If

    End Function

    Public Function SaveCriteriaSubtypeOrder(ByRef pvCriteriaSubtypeId As Integer, ByRef pvOrder As Short) As Object
        'FSProj drh 5/8/02 - New function to update Subtype Order

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "UPDATE CriteriaSubtype SET SubCriteriaPrecedence = " & pvOrder & "WHERE CriteriaSubtypeId =  " & pvCriteriaSubtypeId

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveCriteriaSubtypeProcessorOrder(ByRef pvSubCriteriaId As Integer, ByRef pvOrder As Short) As Object
        'FSProj drh 5/15/02 - New function to update Subtype/Processor Order

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "UPDATE SubCriteria SET ProcessorPrecedence = " & pvOrder & " WHERE SubCriteriaId =  " & pvSubCriteriaId

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SaveCriteriaWorking2(ByRef pvCriteriaId As Integer) As Object
        'FSProj drh 5/6/02 - New function to update Criteria.WorkingStatusUpdatedFlag

        Dim vQuery As String = ""
        Dim vResult As Integer

        vQuery = "UPDATE Criteria SET WorkingStatusUpdatedFlag = 1" & " WHERE CriteriaID = " & pvCriteriaId

        Try
            vResult = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function SavePersonType(ByRef pvForm As FrmPersonType) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "PersonTypeName"
        vFields(1) = "Verified"

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO PersonType (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE PersonType SET " & vValues & " WHERE PersonTypeID = " & pvForm.PersonTypeID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryPersonType(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SavePersonType = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SavePersonType = pvForm.PersonTypeID
        End If

    End Function

    Public Function SaveSubLocation(ByRef pvForm As FrmSubLocation) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object

        'Get the call data
        Dim vParams(1) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.Verified

        'Specify the table fields
        Dim vFields(1) As Object

        vFields(0) = "SubLocationName"
        vFields(1) = "Verified"


        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO SubLocation (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE SubLocation SET " & vValues & " WHERE SubLocationID = " & pvForm.SubLocationID

        End If

        Try
            Call modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQuerySubLocation(vReturn, , pvForm.TxtName.Text)
            If ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveSubLocation = modConv.TextToLng(vReturn(0, 0))
            End If
        Else
            'Pass back the phone ID
            SaveSubLocation = pvForm.SubLocationID
        End If

    End Function
    Public Function SaveTxCenter(ByRef pvForm As FrmSourceCode, ByRef SourceCodeID As Integer, ByRef OrgID As Integer, ByRef TxCode As String) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the call data
        Dim vParams(2) As Object

        vParams(0) = SourceCodeID
        vParams(1) = OrgID
        vParams(2) = TxCode


        'Specify the table fields
        Dim vFields(2) As Object

        vFields(0) = "SourceCodeID"
        vFields(1) = "OrganizationID"
        vFields(2) = "TransplantCode"



        'Build and execute the query


        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

        vQuery = "INSERT INTO sourcecodetransplantcenter (" & vValues & ")"

        Try
            vResult = modODBC.Exec(vQuery, vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vResult = SUCCESS Then

            MsgBox(TxCode & " has been added.")
            pvForm.TxCenterCode.Text = ""
        End If

    End Function

    Public Function SaveNOK(ByRef pvForm As Object) As Object
        '************************************************************************************
        'Name: SaveNOK
        'Date Created: Unknown                          Created by: Char
        'Release: Unknown                               Task: Unknown
        'Description: Updates and Inserts Nok Information
        'Params: pvForm = calling form,
        '
        'Stored Procedures: UpdateNOK and InsertNOK
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertNOK and UpdateNOK
        '               Add LastEmployeeID
        '====================================================================================
        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object

        'Get the call data
        Dim vParams(8) As Object

        vParams(0) = pvForm.NOKFirstName
        vParams(1) = pvForm.NOKLastName
        vParams(2) = pvForm.NOKRefPhone
        'vParams(3) = pvForm.NOKRefAddress
        vParams(3) = pvForm.NOKCity
        vParams(4) = pvForm.NOKStateID
        vParams(5) = pvForm.NOKZip
        vParams(6) = pvForm.NOKApproachRelation
        vParams(7) = pvForm.NOKID
        vParams(8) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        'Specify the table fields
        Dim vFields(8) As Object

        vFields(0) = "@NOKFirstName"
        vFields(1) = "@NOKLastName"
        vFields(2) = "@NOKPhone"
        'vFields(3) = "NOKAddress"
        vFields(3) = "@NOKCity"
        vFields(4) = "@NOKStateID"
        vFields(5) = "@NOKZip"
        vFields(6) = "@NOKApproachRelation"
        vFields(7) = "@NOKID"
        vFields(8) = "@LastStatEmployeeID"


        'Build and execute the query
        If pvForm.ModNOK = NEW_RECORD Then

            'reset NOKID to NUll for new records
            vParams(7) = System.DBNull.Value

            'The record is new and should be inserted.
            Try
                vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            vQuery = "EXEC InsertNOK " & vValues

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveNOK = modConv.TextToLng(vReturn(0, 0))
                pvForm.NOKID = modConv.TextToLng(vReturn(0, 0))
            End If

        Else

            'The record exists and should be updated.
            Try
                vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            vQuery = "EXEC UpdateNOK " & vValues

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Pass back the ID
            If vResult = SUCCESS Then
                SaveNOK = pvForm.NOKID
            End If

        End If

    End Function
    Public Function UpdateReferralPhone(ByRef pvOldIDs As Object, ByRef pvNewIDs As Object) As Short

        Dim vReturn As New Object
        Dim vReturn2 As Object = New Object
        Dim vOldPhoneID As New Object
        Dim vOldSubLocationID As New Object
        Dim vOldSubLocationLevelID As New Object
        Dim vNewPhoneID As New Object
        Dim vNewSubLocationID As New Object
        Dim vNewSubLocationLevelID As New Object
        Dim vQuery As New Object
        Dim vValues As New Object

        vReturn = MsgBox("You are about to reassign the phone number and sublocation of a group of referrals. This action cannot be undone! Are you sure you want to continue?", MsgBoxStyle.OkCancel + MsgBoxStyle.DefaultButton2, "Update Referrals")

        Dim vParams(3) As Object
        Dim vFields(3) As Object
        If vReturn = MsgBoxResult.Cancel Then
            Exit Function
        Else

            If UBound(pvOldIDs, 1) = 2 Then
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = pvOldIDs(1)
                vOldSubLocationLevelID = pvOldIDs(2)
            ElseIf UBound(pvOldIDs, 1) = 1 Then
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = pvOldIDs(1)
                vOldSubLocationLevelID = -1
            Else
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = -1
                vOldSubLocationLevelID = -1
            End If

            '11/15/01 drh Change zero's to -1 since Referral's use -1 if no ID exists
            If vOldSubLocationID = 0 Then
                vOldSubLocationID = -1
            End If
            If vOldSubLocationLevelID = 0 Then
                vOldSubLocationLevelID = -1
            End If

            If UBound(pvNewIDs, 1) = 2 Then
                vNewPhoneID = pvNewIDs(0)
                vNewSubLocationID = pvNewIDs(1)
                vNewSubLocationLevelID = pvNewIDs(2)
            ElseIf UBound(pvNewIDs, 1) = 1 Then
                vNewPhoneID = pvNewIDs(0)
                vNewSubLocationID = pvNewIDs(1)
                vNewSubLocationLevelID = -1
            Else
                vNewPhoneID = pvNewIDs(0)
                vNewSubLocationID = -1
                vNewSubLocationLevelID = -1
            End If

            '11/15/01 drh Change zero's to -1 since Referral's use -1 if no ID exists
            If vNewSubLocationID = 0 Then
                vNewSubLocationID = -1
            End If
            If vNewSubLocationLevelID = 0 Then
                vNewSubLocationLevelID = -1
            End If

            'Get the call data

            vParams(0) = modConv.TextToLng(vNewPhoneID)
            vParams(1) = modConv.TextToLng(vNewSubLocationID)
            vParams(2) = modConv.TextToLng(vNewSubLocationLevelID)

            If modStatRefQuery.RefQuerySubLocationLevel(vReturn2, vParams(2)) = NO_DATA Then
                vParams(3) = ""
            Else
                vParams(3) = vReturn(0)
            End If

            'Specify the field names

            vFields(0) = "ReferralCallerPhoneID"
            vFields(1) = "ReferralCallerSubLocationID"
            vFields(2) = "ReferralCallerLevelID"
            vFields(3) = "ReferralCallerSubLocationLevel"

            'Build and execute the query
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Referral SET " & vValues & " WHERE " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

            Try
                Call modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

    End Function
    Public Function UpdateReferralOrganization(ByRef pvOldIDs As Object, ByRef pvNewIDs As Object) As Short

        Dim vReturn As New Object
        Dim vReturn2 As Object
        Dim vOldPhoneID As New Object
        Dim vOldSubLocationID As New Object
        Dim vOldSubLocationLevelID As New Object
        Dim vNewOrgID As Integer
        Dim vQuery As New Object
        Dim vValues As New Object
        Dim I As Short
        Dim vResult As New Object
        Dim vNewPersonID As Integer
        Dim vParams() As Object

        vReturn = MsgBox("You are about to reassign the phone number, sublocation, and callers of a group of referrals to another organization. Are you sure you want to continue?", MsgBoxStyle.OkCancel + MsgBoxStyle.DefaultButton2, "Update Referrals")

        Dim vFields(0) As Object
        If vReturn = MsgBoxResult.Cancel Then
            Exit Function
        Else

            If UBound(pvOldIDs, 1) = 2 Then
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = pvOldIDs(1)
                vOldSubLocationLevelID = pvOldIDs(2)
            ElseIf UBound(pvOldIDs, 1) = 1 Then
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = pvOldIDs(1)
                vOldSubLocationLevelID = -1
            Else
                vOldPhoneID = pvOldIDs(0)
                vOldSubLocationID = -1
                vOldSubLocationLevelID = -1
            End If

            '11/15/01 drh Change zero's to -1 since Referral's use -1 if no ID exists
            If vOldSubLocationID = 0 Then
                vOldSubLocationID = -1
            End If
            If vOldSubLocationLevelID = 0 Then
                vOldSubLocationLevelID = -1
            End If

            vNewOrgID = pvNewIDs(0)

            'Specify the update parameters
            ReDim vParams(0)

            vParams(0) = vNewOrgID

            'Specify the field names

            vFields(0) = "ReferralCallerOrganizationID"

            'Build and execute the query
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE Referral SET " & vValues & " WHERE " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            'Get a list of all the caller ids associated with the updated referrals
            vQuery = "SELECT DISTINCT ReferralCallerPersonID, PersonFirst, PersonLast, PersonTypeID " & "FROM Referral, Person WHERE " & "Referral.ReferralCallerPersonID = Person.PersonID AND Person.OrganizationID <> " & vNewOrgID & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then

                'For each caller id, see if the person already belongs to the new organization
                For I = 0 To UBound(vReturn, 1)

                    vQuery = "SELECT PersonID FROM Person " & "WHERE OrganizationID = " & vNewOrgID & " AND " & "PersonFirst = " & modODBC.BuildField(vReturn(I, 1)) & " AND " & "PersonLast = " & modODBC.BuildField(vReturn(I, 2))

                    Try
                        vResult = modODBC.Exec(vQuery, vReturn2)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try

                    'If the person does not exist for the new organization,
                    'then add the person to the new organization and update the
                    'referral caller id to the id of the added person
                    If vResult = NO_DATA Then

                        ReDim vParams(3)
                        vParams(0) = vReturn(I, 1)
                        vParams(1) = vReturn(I, 2)
                        vParams(2) = vReturn(I, 3)
                        vParams(3) = vNewOrgID

                        vNewPersonID = modStatSave.SavePersonBasic(vParams, NEW_RECORD)

                        vQuery = "UPDATE Referral SET ReferralCallerPersonID = " & vNewPersonID & " " & "WHERE Referral.ReferralCallerPersonID = " & modConv.TextToLng(vReturn(I, 0)) & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

                        Try
                            vResult = modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'If the person does exist in the new organization,
                        'then update the referral caller id to the id of
                        'the existing person
                    ElseIf ObjectIsValidArray(vReturn2, 2, 0, 0) Then

                        vQuery = "UPDATE Referral SET ReferralCallerPersonID = " & modConv.TextToLng(vReturn2(0, 0)) & " " & "WHERE Referral.ReferralCallerPersonID = " & modConv.TextToLng(vReturn(I, 0)) & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

                        Try
                            vResult = modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    End If

                Next I

            End If

            'Get a list of all the approach person ids associated with the updated referrals
            vQuery = "SELECT DISTINCT ReferralApproachedByPersonID, PersonFirst, PersonLast, PersonTypeID " & "FROM Referral, Person, Organization WHERE " & "Referral.ReferralApproachedByPersonID = Person.PersonID AND " & "Person.OrganizationID = Organization.OrganizationID AND " & "Organization.OrganizationTypeID <> 1 AND " & "Person.OrganizationID <> " & vNewOrgID & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID & ";"

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then

                'For each approach person id, see if the person already belongs to the new organization
                For I = 0 To UBound(vReturn, 1)

                    vQuery = "SELECT PersonID FROM Person " & "WHERE OrganizationID = " & vNewOrgID & " AND " & "PersonFirst = " & modODBC.BuildField(vReturn(I, 1)) & " AND " & "PersonLast = " & modODBC.BuildField(vReturn(I, 2)) & ";"

                    Try
                        vResult = modODBC.Exec(vQuery, vReturn2)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try

                    'If the person does not exist for the new organization,
                    'then add the person to the new organization and update the
                    'referral caller id to the id of the added person
                    If vResult = NO_DATA Then

                        ReDim vParams(3)
                        vParams(0) = vReturn(I, 1)
                        vParams(1) = vReturn(I, 2)
                        vParams(2) = vReturn(I, 3)
                        vParams(3) = vNewOrgID

                        vNewPersonID = modStatSave.SavePersonBasic(vParams, NEW_RECORD)

                        vQuery = "UPDATE Referral SET ReferralApproachedByPersonID = " & vNewPersonID & " " & "WHERE Referral.ReferralCallerPersonID = " & modConv.TextToLng(vReturn(I, 0)) & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

                        Try
                            vResult = modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                        'If the person does exist in the new organization,
                        'then update the referral caller id to the id of
                        'the existing person
                    ElseIf ObjectIsValidArray(vReturn2, 2, 0, 0) Then

                        vQuery = "UPDATE Referral SET ReferralApproachedByPersonID = " & modConv.TextToLng(vReturn2(0, 0)) & " " & "WHERE Referral.ReferralCallerPersonID = " & modConv.TextToLng(vReturn(I, 0)) & " AND " & "Referral.ReferralCallerPhoneID = " & vOldPhoneID & " AND " & "Referral.ReferralCallerSubLocationID = " & vOldSubLocationID & " AND " & "Referral.ReferralCallerLevelID = " & vOldSubLocationLevelID

                        Try
                            vResult = modODBC.Exec(vQuery)
                        Catch ex As Exception
                            StatTracLogger.CreateInstance().Write(ex)
                        End Try

                    End If

                Next I

            End If

        End If

    End Function


    '	'added 06/2001 bjk: save CallBack Phone in OrganizationProperties form
    Public Function SaveCallBack(ByRef pvForm As FrmOrganizationProperties) As Object

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim vResult As New Object
        Dim vRecord As Short
        Dim vPhoneID As Integer
        Dim vCallBackID As Integer
        Dim vParams(1) As Object
        Dim vFields(1) As Object

        'Save pvFormTxtPhone and GetID
        vPhoneID = SavePhone(pvForm.TxtPhone.Text, 3)

        'Save PhoneID and Organization to CallBack table
        If modStatQuery.QueryCallBack(vReturn, pvForm.OrganizationId, vPhoneID) = SUCCESS _
            AndAlso ObjectIsValidArray(vReturn, 2, 0, 1) Then
            vCallBackID = modConv.TextToLng(vReturn(0, 1))
            vRecord = EXISTING_RECORD
        Else
            vRecord = NEW_RECORD
        End If

        'Set Params
        vParams(0) = vPhoneID
        vParams(1) = pvForm.OrganizationId

        'set vFields

        vFields(0) = "PhoneID"
        vFields(1) = "OrganizationID"

        If vRecord = NEW_RECORD Then

            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO CallBack (" & vValues & ")"

            Try
                vResult = modODBC.Exec(vQuery, vReturn)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS _
                AndAlso ObjectIsValidArray(vReturn, 2, 0, 0) Then
                SaveCallBack = modConv.TextToLng(vReturn(0, 0))
            End If


        ElseIf vRecord = EXISTING_RECORD Then

            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE CallBack SET " & vValues & " WHERE CallBackID = " & vCallBackID

            Try
                vResult = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If vResult = SUCCESS Then
                'Pass back the CallBack ID
                SaveCallBack = vCallBackID
            End If

        End If

    End Function

    Public Function UpdateEnabledLOCalls(ByRef pvForm As FrmLeaseOrganizationCalls, ByRef vGridList As Object, ByRef pvValue As Short) As Short
        '***********************************************************************
        'T.T 06/01/2004
        'Module:modStatSave.UdateEnabledLOCalls
        'Parameters:    pvForm - LeaseOrganizationcalls Form
        '               vGridList   - Triage and FS values passed
        '               pvValue     - Triage and FS values on or off
        'Definition:    This Function Turns on or off the Triage and Family Services flags
        '               Within the organization table. It also turns on or off the OrganizationLO
        '               Enabled flag when Triage and FS are both turned off.
        '***********************************************************************

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vScheduleID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vCode As New Object
        Dim LOEnabled As New Object

        'T.T 5/28/2004 This code keeps the EnabledLO value at -1 if The triage or the FS LO is still enabled.
        'T.T 5/28/2004 This code is to send a null in the arument list for the spu_EnabledLOCalls
        For I = 0 To UBound(vGridList, 1)
            If Left(vGridList(I, 3), 2) = "TR" Then
                vGridList(I, 2) = "NULL" 'Null Family Services
                vGridList(I, 1) = pvValue '-1 = Turn On or 0 = Off Triage

            Else
                vGridList(I, 1) = "NULL" 'Null Triage
                vGridList(I, 2) = pvValue '-1 = Turn On or 0 = Off Family Services

            End If
        Next I


        For I = 0 To UBound(vGridList, 1)

            vQuery = "Exec SPU_EnableLOCallsv " & -1 & ", " & vGridList(I, 0) & ", " & vGridList(I, 1) & ", " & vGridList(I, 2) & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

            Try
                UpdateEnabledLOCalls = modODBC.Exec(vQuery)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        Next I
    End Function
    Public Function SaveLOCall(ByRef pvForm As FrmReferral) As Integer

        Dim Values As String = ""
        Dim Query As String = ""
        Dim Result As Short
        Dim ResultArray As New Object
        Dim Params(2) As Object
        Dim Fields(2) As Object


        Params(0) = pvForm.CallId
        Params(1) = AppMain.ParentForm.StatEmployeeID
        Params(2) = pvForm.LOCallTotalTime

        Fields(0) = "CallID"
        Fields(1) = "StatEmployeeID"
        Fields(2) = "LOCallTotalTime"


        'Build and execute the query
        If IsNothing(pvForm.LOCallID) Or pvForm.LOCallID = 0 Then

            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD, Params, Fields)

            Query = "INSERT INTO LOCall (" & Values & ")"

            Try
                Result = modODBC.Exec(Query, ResultArray)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Result = SUCCESS _
                AndAlso ObjectIsValidArray(ResultArray, 2, 0, 0) Then
                SaveLOCall = ResultArray(0, 0)
            Else
                LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to save Lease Organization call Information. Query = " & Query)
            End If

        Else
            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "UPDATE LOCall SET " & Values & " " & "WHERE LOCallID = " & pvForm.LOCallID

            Try
                Result = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

            If Result = SUCCESS Then
                SaveLOCall = pvForm.LOCallID
            Else
                LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Failed to update Lease Organization call information. Query = " & Query)
            End If

        End If

    End Function

    Public Function GetArchiveLogEventvQuery(ByRef pvParams As Object, ByRef pvFields As Object) As String
        '************************************************************************************
        'Name: GetArchiveLogEventvQuery$
        'Date Created: Unknown                          Created by: Bret Knoll
        'Release: Unknown                               Task: Unknown
        'Description: Creates a logeventid in the production database, allowing a record to be saved in the archive database
        'Returns: Return value of executed query in pvResults.
        'Params: pvParams()
        '        pvFields()
        '
        'Stored Procedures: InserLogEvent and DeleteLogEvent and Dynamically creates a record in archive
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add LastStatEmployeeID,
        '               DeleteLogEvent
        '====================================================================================

        Dim vValues As String = "" 'stores the parameter string for the insert, the return value from BuildSQL
        Dim vQuery As New Object 'stores the query string to pass to Exec.
        Dim vReturn As Short 'Return value from Exec
        Dim vLogEventID As Integer
        Dim vResults As New Object ' return array
        Dim vArraySize As Short ' array size variable
        Dim vLocalParams() As Object ' temporary array
        Dim vLocalFields() As Object ' temporary array
        Dim vForLoop As Short 'looping variable
        Dim vConnection As Short '

        vConnection = 2 'connection number
        'Build insert string for LogEvent on Production
        vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, pvParams, pvFields)

        vQuery = "EXEC InsertLogEvent " & vValues

        'Call ModODBC.Exec to get LogEventID
        Try
            vReturn = modODBC.Exec(vQuery, vResults, vConnection)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vReturn = SUCCESS _
            AndAlso ObjectIsValidArray(vResults, 2, 0, 0) Then
            vLogEventID = vResults(0, 0)
        Else
            vLogEventID = SQL_ERROR
            Exit Function
        End If


        'Call ModStatSave.DeleteLogEvent

        vQuery = "Delete LogEvent WHERE " & "LogEventID = " & vLogEventID

        Try
            vResults = modODBC.Exec(vQuery, , vConnection)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Rebuild vParams , add logevent id. Get size of vParam array. Create new array and copy vParam array to new array.
        ' redim vParam array as size + 1. loop through array add logeventid to top of array and add rest of array.
        vArraySize = UBound(pvParams)
        ReDim Preserve vLocalParams(vArraySize)

        For vForLoop = 0 To vArraySize
            vLocalParams(vForLoop) = pvParams(vForLoop)
        Next vForLoop
        vLocalParams(vArraySize) = vLogEventID
        'Rebuild vFields, add logevent id field
        vArraySize = UBound(pvFields)

        ReDim Preserve vLocalFields(vArraySize)

        For vForLoop = 0 To vArraySize
            vLocalFields(vForLoop) = pvFields(vForLoop)
        Next vForLoop

        'build query string for SaveLogEvent
        'Build insert string for LogEvent on Production
        vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vLocalParams, vLocalFields)
        'cannot convert this to EXEC InserLogevent because it manually setst he logeventid
        vQuery = "EXEC InsertLogEvent " & vValues & ""

        'return LogEventID
        GetArchiveLogEventvQuery = vQuery

    End Function

    Public Function SaveDocumentRequestQueue(ByRef pvForm As FrmDonorIntentFax) As Integer

        Dim vValues As String = ""
        Dim vQuery As New Object
        Dim vReturn As Short
        Dim vLogEventID As String = ""
        Dim vResults As New Object
        Dim vTimeZoneDif As Short
        Dim vArraySize As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'Get the log data
        Dim vParams(12) As Object
        Dim vFields(12) As Object


        vParams(0) = pvForm.vParentForm.CallId
        vParams(1) = AppMain.ParentForm.StatEmployeeID
        vParams(2) = pvForm.vPerson
        vParams(3) = pvForm.vOrganization
        vParams(4) = pvForm.OrganizationId
        vParams(5) = pvForm.vFaxNum
        vParams(6) = pvForm.vFaxEmail
        vParams(7) = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)
        vParams(8) = pvForm.vParentForm.DonorSearchState.DonorDMVId
        vParams(9) = pvForm.vParentForm.DonorSearchState.DonorRegId
        vParams(10) = pvForm.vDocumentName
        vParams(11) = AppMain.ParentForm.StatEmployeeID
        vParams(12) = pvForm.vParentForm.DonorSearchState.DonorDSNID

        'Specify the field names
        vFields(0) = "@CallId"
        vFields(1) = "@DocumentSentById"
        vFields(2) = "@DocumentTo"
        vFields(3) = "@DocumentOrganization"
        vFields(4) = "@DocumentOrganizationId"
        vFields(5) = "@FaxNumber"
        vFields(6) = "@Email"
        vFields(7) = "@SubmitDate"
        vFields(8) = "@DmvId"
        vFields(9) = "@RegId"
        vFields(10) = "@FormName"
        vFields(11) = "@UserID"
        vFields(12) = "@DSNID"

        'The record is new and should be inserted.
        vValues = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, vParams, vFields)

        vQuery = "EXEC InsertDocumentRequestQueue " & vValues

        Try
            vReturn = modODBC.Exec(vQuery)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If vReturn = SUCCESS _
            AndAlso ObjectIsValidArray(vResults, 2, 0, 0) Then
            SaveDocumentRequestQueue = vResults(0, 0)
        Else
            SaveDocumentRequestQueue = SQL_ERROR
        End If

    End Function

    Public Function InsertNote(ByRef CallId As String, ByRef logeventdesc As String, ByRef StatEmployeeID As String, ByRef OrganizationId As Integer) As Object
        '************************************************************************************
        'Name: modStatSave.InsertNote
        'Date Created: 09/27/2005                       Created by: Thien Ta
        'Release: Unknown                               Task: Unknown
        'Description: This function will insert a not into the log event for Webservices
        'Parameters:    pvForm - NA'
        '
        'Stored Procedures: InsertLogEvent
        '====================================================================================
        'Date Changed: 07/10/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to use InsertLogEvent
        '               Add LastStatEmployeeID
        '               Add call to QueryTimeZoneDif
        '====================================================================================
        Dim vQuery As String = ""
        Dim vResults As New Object
        Dim DateTime As String = ""
        Dim vReturn As New Object
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        DateTime = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(VB6.Format(Now, "mm/dd/yy  hh:mm"))))

        vQuery = "EXEC InsertLogEvent " & "@CallID = " & CallId & ", @LogEventTypeID = 1" & ", @LogEventName = NULL " & ", @LogEventPhone = NULL " & ", @LogEventOrg = NULL " & ", @LogEventDesc = '" & logeventdesc & "', @StatEmployeeID = " & StatEmployeeID & ", @LogEventDateTime = '" & DateTime & "', @LogEventCallbackPending = 0 " & ", @OrganizationID = " & OrganizationId & ", @ScheduleGroupID = 0 " & ", @PersonID = 0" & ", @PhoneID = 0" & ", @LogEventContactConfirmed = 0" & ", @LogEventCalloutDateTime = NULL " & ", @LogEventNumber = NULL " & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Try
            vReturn = modODBC.Exec(vQuery, vResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
    End Function
#Region "OrganizationPhone"
    Public Sub SaveOrganizationPhone(ByVal organizationId As Int32, ByVal subLocationID As Int32, ByVal subLocationLevel As String, ByVal phone As String)
        Dim query As String
        Dim Result As Short

        query = String.Format("EXEC OrganizationPhoneNewCallInsert @OrganizationID = {0}, @Phone = '{1}', @LastStatEmployeeId = {2}, @SubLocationID = {3}, @SubLocationLevel = '{4}';", organizationId, phone, AppMain.ParentForm.StatEmployeeID, subLocationID, subLocationLevel)

        Try
            Result = modODBC.Exec(query)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Sub
#End Region
End Module