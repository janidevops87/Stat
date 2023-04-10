Module modStatValidate
    Public Function LogEvent(ByVal pvForm As wfLogEvent)
        Dim strContactName As String

        strContactName = pvForm.cboName.SelectedItem.Text()
        

        Select Case modControl.GetID(pvForm.cboContactEventType)
            Case INCOMING
                'Validate key fields for values

                If strContactName = "" Then
                    'Call modMsgForm.FormValidate("Name", strContactName)
                    pvForm.PopValidationMessage("strContactName", modMsgForm.FormValidate("Name"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If
                'FSProj 6/25/02 drh - Added Funeral_Home
            Case OUTGOING, CORONER_CASE, FUNERAL_HOME
                'Validate key fields for values
                If strContactName = "" Then
                    'Call modMsgForm.FormValidate("Name", strContactName)
                    pvForm.PopValidationMessage("strContactName", modMsgForm.FormValidate("Name"), True)
                ElseIf strContactName = "" Then
                    'Call modMsgForm.FormValidate("Phone", pvForm.txtContactPhone)
                    pvForm.PopValidationMessage("txtContactPhone", modMsgForm.FormValidate("Phone"), True)
                    'Check to see if there is a contact phone and extention to lookup
                    'or if the contact phone or extention has changed.
                ElseIf Len(pvForm.txtContactPhone.Text) < 14 And Len(pvForm.txtContactPhone.Text) > 0 Then
                    'Validate there is a phone number
                    'Call modMsgForm.FormValidate("Contact Phone #", pvForm.txtContactPhone)
                    pvForm.PopValidationMessage("txtContactPhone", modMsgForm.FormValidate("Contact Phone #"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If
            Case CONSENT_PENDING, RECOVERY_PENDING, PAGE_PENDING
                'Validate key fields for values
                If strContactName = "" Then
                    'Call modMsgForm.FormValidate("Name", strContactName)
                    pvForm.PopValidationMessage("strContactName", modMsgForm.FormValidate("Name"), True)
                ElseIf pvForm.txtContactPhone.Text = "" Then
                    'Call modMsgForm.FormValidate("Phone", pvForm.txtContactPhone)
                    pvForm.PopValidationMessage("txtContactPhone", modMsgForm.FormValidate("Phone"), True)
                    'Check to see if there is a contact phone and extention to lookup
                    'or if the contact phone or extention has changed.
                ElseIf Len(pvForm.txtContactPhone.Text) < 14 And Len(pvForm.txtContactPhone.Text) > 0 Then
                    'Validate there is a phone number
                    'Call modMsgForm.FormValidate("Contact Phone #", pvForm.txtContactPhone)
                    pvForm.PopValidationMessage("txtContactPhone", modMsgForm.FormValidate("Contact Phone #"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If
                '10/8/01 drh Added Outgoing Fax validation
            Case CONSENT_RESPONSE, RECOVERY_RESPONSE, PAGE_RESPONSE, OUTGOING_FAX, FAX_PENDING, _
            NO_CONSENT_RESPONSE, NO_RECOVERY_RESPONSE, NO_PAGE_RESPONSE, SECONDARY_RESPONSE
                'Validate key fields for values
                If strContactName = "" Then
                    'Call modMsgForm.FormValidate("Name", strContactName)
                    pvForm.PopValidationMessage("strContactName", modMsgForm.FormValidate("Name"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If
            Case SECONDARY_PENDING
                'Validate key fields for values
                If pvForm.txtContactOrg.Text = "" Then
                    'Call modMsgForm.FormValidate("Organization", pvForm.txtContactOrg)
                    pvForm.PopValidationMessage("txtContactOrg", modMsgForm.FormValidate("Organization"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If
            Case GENERAL
                LogEvent = True
                Exit Function

            Case CALLBACK_PENDING
                If pvForm.txtCalloutDate.Text = "" Or pvForm.txtCalloutMins.Text = "" Then
                    'Call modMsgForm.FormValidate("Callout Minutes", pvForm.txtCalloutMins)
                    pvForm.PopValidationMessage("txtCalloutMins", modMsgForm.FormValidate("Callout Minutes"), True)
                Else
                    LogEvent = True
                    Exit Function
                End If

        End Select

        LogEvent = False


    End Function

End Module
