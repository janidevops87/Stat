Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmQuickLook
    Inherits System.Windows.Forms.Form

    Public OrganizationId As Integer
    Public OrganizationName As String
    Public CallingForm As String
    Public parentForm As Object
    'bret 02/01/11 
    Private uIMap As UIMap


    Private Sub CmdClose_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdClose.Click

        Select Case Me.CallingForm

            Case "FrmOrganizationProperties"

                parentForm.TxtTo.Text = Me.OrganizationName
                parentForm.TxtTo.Tag = Me.OrganizationId

            Case "FrmSchedule"

                parentForm.CboOrganization.Items.Add(New ValueDescriptionPair(Me.OrganizationId, Me.OrganizationName))
                Call modControl.SelectID((parentForm.CboOrganization), Me.OrganizationId)
            Case "FrmReport"

                parentForm.CboReportParent.Items.Add(New ValueDescriptionPair(Me.OrganizationId, Me.OrganizationName))
                modControl.SelectID(parentForm.CboReportParent, Me.OrganizationId)
        End Select


        Me.Close()

    End Sub


    Private Sub FrmQuickLook_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmQuickLook = Nothing
        Dispose()

    End Sub


    Private Sub LstOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstOrganization.SelectedIndexChanged

        TxtPersonFirst.Text = ""
        TxtPersonLast.Text = ""
        LstPerson.Items.Clear()

        Me.OrganizationId = modControl.GetID(LstOrganization)
        Me.OrganizationName = modControl.GetText(LstOrganization)

        'Fill list with Persons matching the personID
        Call modStatQuery.QueryOrganizationPerson(Me, True)

    End Sub


    Private Sub LstOrganization_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstOrganization.DoubleClick

        Dim I As Short
        Dim vOrgOpen As Boolean

        For I = 0 To Application.OpenForms.Count - 1

            If Application.OpenForms.Item(I).Name = "SecurePopupForm" Then
                vOrgOpen = True
            End If

        Next I

        If Not vOrgOpen Then

            If uIMap Is Nothing Then
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            End If
            uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, modControl.GetID(LstOrganization))

        End If

    End Sub


    Private Sub LstPerson_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstPerson.SelectedIndexChanged

        TxtOrganization.Text = ""
        LstOrganization.Items.Clear()

        'Fill list with organizations matching the personID
        Call modStatQuery.QueryPersonOrganization(Me)

    End Sub

    Private Sub LstPerson_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstPerson.DoubleClick

        Dim vPersonID As Integer
        vPersonID = modControl.GetID(LstPerson)
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If
        uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, vPersonID)
    End Sub


    Private Sub TxtOrganization_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrganization.TextChanged

        If TxtOrganization.Text <> "" And Len(TxtOrganization.Text) > 2 Then
            Call modStatQuery.QuerySearchOrganizations(Me)
        Else
            LstOrganization.Items.Clear()
        End If

    End Sub

    Public Function Display() As Object

        Dim dialogResult As DialogResult = Me.ShowDialog()
        AppMain.frmQuickLook = Nothing
        Return True
    End Function

    Private Sub TxtOrganization_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrganization.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtPersonFirst_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonFirst.TextChanged

        If TxtPersonFirst.Text = "" And TxtPersonLast.Text = "" Then
            LstPerson.Items.Clear()
        Else
            If Len(TxtPersonFirst.Text) > 2 Then
                Call modStatQuery.QuerySearchPerson(Me)
            End If
        End If

    End Sub


    Private Sub TxtPersonFirst_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonFirst.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtPersonLast_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonLast.TextChanged

        If TxtPersonFirst.Text = "" And TxtPersonLast.Text = "" Then
            LstPerson.Items.Clear()
        Else
            If Len(TxtPersonLast.Text) > 2 Then
                Call modStatQuery.QuerySearchPerson(Me)
            End If
        End If

    End Sub


    Private Sub txtPersonLast_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonLast.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
End Class