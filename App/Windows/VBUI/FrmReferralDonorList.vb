Option Strict Off
Option Explicit On
Option Infer On
Imports System.Collections.Generic
Imports Statline.Common.Utilities
Imports Stattrac.Services.Donor.Registry.Model

Friend Class FrmReferralDonorList
    Inherits Form

    Private ReadOnly searchResults As IReadOnlyCollection(Of DonorSearchResult)
    Private ReadOnly searchRequest As DonorSearchRequest

    Public ReadOnly Property SelectedDonor As DonorSearchResult

    Sub New(searchResults As IReadOnlyCollection(Of DonorSearchResult),
            searchRequest As DonorSearchRequest)
        Check.NotNull(searchResults, NameOf(searchResults))
        Check.NotNull(searchRequest, NameOf(searchRequest))

        ' This call is required by the designer.
        InitializeComponent()
        ' Add any initialization after the InitializeComponent() call.

        'This fixes slow data grid rendering (effective only in non-terminal sessions).
        donorsDataGridView.SetDoubleBuffering(enabled:=True)

        Me.searchResults = searchResults
        Me.searchRequest = searchRequest
    End Sub

    Private Sub cmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click
        Me.Close()
    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSelect.Click
        _SelectedDonor = donorsDataGridView.SelectedRows.OfType(Of DataGridViewRow).FirstOrDefault()?.Tag
        Me.Close()
    End Sub

    Private Sub FrmReferralDonorList_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        FillDonorsDataGridView()
        UpdateInstancesFoundLabel()
    End Sub

    Private Sub UpdateInstancesFoundLabel()
        Dim numberOfInstances = searchResults.Count

        instancesFoundLabel.Text =
            $"{numberOfInstances} Instances of {searchRequest.DonorFirstName} {searchRequest.DonorLastName}  found."

        instancesFoundLabel.Font = VB6.FontChangeBold(instancesFoundLabel.Font, True)
        instancesFoundLabel.Font = VB6.FontChangeSize(instancesFoundLabel.Font, 12)
        instancesFoundLabel.ForeColor = Color.Red
    End Sub

    Private Sub FillDonorsDataGridView()
        'Not using data binding as we have a very simple scenario.
        For Each item As DonorSearchResult In searchResults

            Dim rowIndex = donorsDataGridView.Rows.Add(
                item.Person.Name.FirstName,
                item.Person.Name.MiddleName,
                item.Person.Address.Address1,
                item.Person.Address.City,
                item.Person.Address.State,
                item.Person.Address.Zip,
                FormatLicense(item),
                FormatDonorDate(item), 'DateEntered
                FormatDonorRegistryType(item.Registry.Type),
                FormatDonorOnRegistry(item.OnRegistry))

            donorsDataGridView.Rows(rowIndex).Tag = item
        Next
    End Sub

    Private Shared Function FormatLicense(item As DonorSearchResult) As String
        'DLA records have something in SID property which is not really a license.
        'Therefore we don't display SID in License column for DLA.
        Return If(item.Registry.Type = DonorRegistryType.Dla, Nothing, item.Person.Sid)
    End Function

    Private Function FormatDonorOnRegistry(onRegistry As Boolean) As String
        Return If(onRegistry, "Yes on Registry", "Not on Registry")
    End Function

    'TODO: This is presentation logic. Consider moving to a shared component.
    Private Function FormatDonorRegistryType(registryType As DonorRegistryType) As Object
        Select Case registryType
            Case DonorRegistryType.Web
                Return "Web"
            Case DonorRegistryType.Dmv
                Return "DMV"
            Case DonorRegistryType.Dla
                Return "DLA"
            Case Else
                Throw New ArgumentException($"Unknown registry type {registryType}", NameOf(Type))
        End Select
    End Function

    Private Sub donorsDataGridView_SelectionChanged(sender As Object, e As EventArgs) Handles donorsDataGridView.SelectionChanged
        cmdSelect.Enabled = donorsDataGridView.SelectedRows.Count <> 0
    End Sub

    Private Shared Function FormatDonorDate(
        searchResult As DonorSearchResult) As String

        If searchResult.DonorDate Is Nothing Then
            Return Nothing
        End If

        Dim donorDateString = searchResult.DonorDate.Value.ToString("d")

        Return If(searchResult.DonorDateType Is Nothing,
            donorDateString,
            $"{searchResult.DonorDateType}: {donorDateString}")

    End Function

End Class