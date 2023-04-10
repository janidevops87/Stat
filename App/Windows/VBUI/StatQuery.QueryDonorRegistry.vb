Option Strict On
Option Explicit On
Option Infer On
Imports System.Collections.Generic
Imports System.Globalization
Imports System.Threading.Tasks
Imports Statline.Stattrac.Framework
Imports Statline.Stattrac.Networking.RegistryApiClient
Imports Statline.Stattrac.Networking.RegistryApiClient.Http.Compatibility
Imports Stattrac.DonorRegistry.RegistryApi
Imports Stattrac.DonorServices.Search

Partial Friend Module modStatQuery
    Friend Enum RegistrySearchStatus As Short
        Unknown = 0
        FoundInWebRegistry = 1
        FoundInStateRegistry = 2
        FoundInDlaRegistry = 6
        NotFound = 3
        NeedMoreInformation = 4
    End Enum

    Friend Enum DonorConfimed
        Undetermined
        No
        Yes
    End Enum

    Friend Class QueryDonorRegistryFormData
        Public ReadOnly Property Found As String
        Public ReadOnly Property FormName As String '.Name
        Public ReadOnly Property Locator As String
        Public ReadOnly Property DOB As String
        Public ReadOnly Property DonorFirstName As String
        Public ReadOnly Property DonorLastName As String
        Public ReadOnly Property DonorFoundCallback As Action(Of String)
        Public ReadOnly Property IsDonorData() As Boolean
            Get
                Return DonorData = 1
            End Get
        End Property


        Public Sub New(
            found As String,
            formName As String,
            locator As String,
            donorData As Integer,
            dOB As String,
            donorFirstName As String,
            donorLastName As String,
            donorFoundCallback As Action(Of String))
            _Found = found
            _FormName = formName
            _Locator = locator
            _DonorData = donorData
            _DOB = dOB
            _DonorFirstName = donorFirstName
            _DonorLastName = donorLastName
            _DonorFoundCallback = donorFoundCallback
        End Sub

        Public Shared Function CreateFromForm(form As Form) As QueryDonorRegistryFormData
            Dim referralForm As FrmReferral = TryCast(form, FrmReferral)
            If referralForm IsNot Nothing Then
                Return CreateFromForm(referralForm)
            End If

            Dim referralViewForm As FrmReferralView = TryCast(form, FrmReferralView)
            If referralViewForm IsNot Nothing Then
                Return CreateFromForm(referralViewForm)
            End If

            Throw New ArgumentException("Unknown form type", NameOf(form))
        End Function

        Public Shared Function CreateFromForm(form As FrmReferral) As QueryDonorRegistryFormData
            Return New QueryDonorRegistryFormData(
                found:="",'form.Found,
                formName:=form.Name,
                locator:="",'form.Locator,
                dOB:=form.TxtDOB.Text,
                donorFirstName:=form.TxtDonorFirstName.Text,
                donorLastName:=form.TxtDonorLastName.Text,
                donorFoundCallback:=AddressOf form.NotifyDonorFound)
        End Function

        Public Shared Function CreateFromForm(form As FrmReferralView) As QueryDonorRegistryFormData
            Return New QueryDonorRegistryFormData(
                found:="",'form.Found,
                formName:=form.Name,
                locator:="", 'form.Locator,
                dOB:=form.TxtDOB.Text,
                donorFirstName:=form.TxtDonorFirstName.Text,
                donorLastName:=form.TxtDonorLastName.Text,
                donorFoundCallback:=AddressOf form.NotifyDonorFound)
        End Function

    End Class

    Friend Class QueryDonorRegistryResult
        Public Property DonorRegId As Integer
        Public Property DonorDMVId As Integer
        Public Property DonorDSNID As Short
        Public Property RegistrySource As String
        Public Property SearchStatus As RegistrySearchStatus = RegistrySearchStatus.Unknown

        Public Sub ApplyToForm(form As BaseFormReferralData)
            Dim referralForm As FrmReferral = TryCast(form, FrmReferral)

            form.DonorRegId = DonorRegId
            form.DonorDMVId = DonorDMVId
            form.DonorDSNID = DonorDSNID

            If referralForm IsNot Nothing Then
                ApplyToForm(referralForm)
                Return
            End If

            Dim referralViewForm As FrmReferralView = TryCast(form, FrmReferralView)
            If referralViewForm IsNot Nothing Then
                ApplyToForm(referralViewForm)
                Return
            End If

            Throw New ArgumentException("Unknown form type", NameOf(form))
        End Sub

        Private Sub ApplyToForm(form As FrmReferral)
            form.RegistrySource = RegistrySource
            form.RegistrySearchStatus = SearchStatus
        End Sub

        Private Sub ApplyToForm(form As FrmReferralView)
            form.RegistrySource = RegistrySource
            form.RegistrySearchStatus = SearchStatus
        End Sub
    End Class

    Friend Class CheckRegistryResult
        Public Property DonorConfirmed As DonorConfimed
        Public Property Source As String
        Public Property SourceOwnerState As String
        Public Property Id As Integer
        Public Property RestrictionId As Integer

        Public Overrides Function ToString() As String
            Return $"Source: {Source}, Donor: {DonorConfirmed}, ID: {Id}, Restriction ID: {RestrictionId}"
        End Function

    End Class

    Public Class QueryDonorRegistry
        Private ReadOnly registryApiClient As IRegistryApiClient
        Private ReadOnly donorSearch As DonorSearch
        Private ReadOnly dataSourceLookup As IDataSourceLookup

        Sub New(
               registryApiClient As IRegistryApiClient,
               dataSourceLookup As IDataSourceLookup,
               donorSearchConfigurationProvider As IDonorSearchConfigurationProvider)
            donorSearch = New DonorSearch(
                New ApiDonorRegistry(registryApiClient),
                donorSearchConfigurationProvider)
            Me.registryApiClient = registryApiClient
            Me.dataSourceLookup = dataSourceLookup
        End Sub

        Sub New(serviceLevelId As Integer)
            Me.New(
                HttpRegistryApiClientFactory.Instance.CreateClient(),
                New DatabaseDataSourceLookup(serviceLevelId),
                New DatabaseDonorSearchConfigurationProvider(serviceLevelId))
        End Sub

        Public Async Function QueryAsync(formData As QueryDonorRegistryFormData) As Task(Of QueryDonorRegistryResult)

            Dim donorFoundReg As Boolean = False
            Dim donorFoundDmv As Boolean = False
            Dim donorFoundDla As Boolean = False

            Dim queryResult = New QueryDonorRegistryResult

            Dim results = Await CheckRegistryApiAsync(formData).ConfigureAwait(False)

            For Each resultItem In results

                Select Case resultItem.DonorConfirmed
                    'This basically means multiple items 
                    'were found in one source.
                    Case DonorConfimed.Undetermined
                        Return New QueryDonorRegistryResult With
                        {
                            .RegistrySource = resultItem.Source,
                            .SearchStatus = If(formData.IsDonorData,
                                RegistrySearchStatus.NotFound,
                                RegistrySearchStatus.NeedMoreInformation)
                        }
                    Case DonorConfimed.No 'TODO: Why not continue looking at other results?
                        If queryResult.DonorRegId = 0 And queryResult.DonorDMVId = 0 Then
                            Return New QueryDonorRegistryResult With
                            {
                                .RegistrySource = resultItem.Source,
                                .SearchStatus = RegistrySearchStatus.NotFound
                            }
                        ElseIf resultItem.Id <> 0 Then
                            Return New QueryDonorRegistryResult With
                            {
                                .RegistrySource = resultItem.Source,
                                .SearchStatus = RegistrySearchStatus.NeedMoreInformation
                            }
                        End If

                    Case DonorConfimed.Yes

                        If queryResult.DonorRegId = 0 And queryResult.DonorDMVId = 0 Then

                            Select Case resultItem.Source
                                Case RegistryNames.Web
                                    queryResult.SearchStatus = RegistrySearchStatus.FoundInWebRegistry
                                    queryResult.RegistrySource = resultItem.Source
                                    queryResult.DonorRegId = resultItem.Id

                                    NotifyDonorFound(formData, "Web", donorFoundReg)

                                Case RegistryNames.Dmv
                                    queryResult.SearchStatus = RegistrySearchStatus.FoundInStateRegistry
                                    queryResult.RegistrySource = resultItem.Source
                                    queryResult.DonorRegId = resultItem.RestrictionId
                                    queryResult.DonorDMVId = resultItem.Id

                                    NotifyDonorFound(formData, "State", donorFoundDmv)

                                Case RegistryNames.Dla
                                    queryResult.SearchStatus = RegistrySearchStatus.FoundInDlaRegistry
                                    queryResult.RegistrySource = resultItem.Source
                                    queryResult.DonorRegId = resultItem.RestrictionId
                                    queryResult.DonorDMVId = resultItem.Id 'TODO: How does this work?
                            End Select

                            'Dim dataSource = dataSourceLookup.GetDataSource(
                            '    resultItem.Source,
                            '    resultItem.SourceOwnerState)

                            'queryResult.DonorDSNID = dataSource.Id

                        Else 'If we previously already found a 'Yes' record.
                            Return New QueryDonorRegistryResult With
                            {
                                .RegistrySource = resultItem.Source,
                                .SearchStatus = If(formData.IsDonorData,
                                    RegistrySearchStatus.NotFound,
                                    RegistrySearchStatus.NeedMoreInformation)
                            }

                        End If
                End Select
            Next

            'Populate & select FrmReferral.cboRegistryStatus As needed
            If formData.FormName = "FrmReferral" And AppMain.pvregchoice = "" Then

                Dim foundIn As String = Nothing

                If donorFoundReg = True And donorFoundDmv = False And donorFoundDla = False Then
                    foundIn = "Web"
                ElseIf donorFoundReg = False And donorFoundDmv = True And donorFoundDla = False Then
                    foundIn = "State"
                ElseIf donorFoundReg = False And donorFoundDmv = False And donorFoundDla = True Then
                    foundIn = "DLA"
                End If

                If foundIn IsNot Nothing Then
                    formData.DonorFoundCallback?.Invoke(foundIn)
                End If
            End If

            '06/25/03 bjk
            'if registry is returning a yes  and no additional donor data is available and the registry state and
            ' hospital state are different change the reply to unknown.
            ' The goal here is to confirm the registry result when the hospital location state and the registry location
            ' state are different.
            Return queryResult
        End Function

        Public Async Function QueryDonorRegistryInformationAsync(
            parentForm As BaseFormReferralData) As Task(Of String)

            Return Await QueryDonorRegistryInformationAsync(
                parentForm.DonorRegId,
                parentForm.DonorDMVId,
                parentForm.DonorDSNID).ConfigureAwait(False)

        End Function

        Public Async Function QueryDonorRegistryInformationAsync(
            donorRegId As Integer,
            donorDmvId As Integer,
            donorDsnId As Integer) As Task(Of String)

            'TODO: Error handling
            Dim donorDetails = Await QueryDonorDetailsAsync(
                donorRegId,
                donorDmvId,
                donorDsnId).ConfigureAwait(False)

            'Don't pass the License/Registry value for DLA Registry donors
            Dim textMessage =
                $"Donor Name: {donorDetails.Name.FirstName} {donorDetails.Name.MiddleName} {donorDetails.Name.LastName}" &
                Environment.NewLine &
                $"DOB: {donorDetails.DateOfBirth}" &
                Environment.NewLine &
                $"Donor: {If(donorDetails.OnRegistry, "Y", "N")}" &
                Environment.NewLine &
                $"Address: {donorDetails.Address.Address1} {donorDetails.Address.Address2} " &
                $"{donorDetails.Address.City}, {donorDetails.Address.State} {donorDetails.Address.Zip}" &
                Environment.NewLine &
                $"RenewalDate: {donorDetails.FlagDate}" &
                Environment.NewLine &
                $"License/Registry: {If(donorDetails.RegistryName = RegistryNames.Dla, String.Empty, donorDetails.RegistryId)}" &
                Environment.NewLine &
                $"Restrictions: {donorDetails.Restriction}"

            Return textMessage

        End Function

        Private Async Function QueryDonorDetailsAsync(
            donorRegId As Integer,
            donorDmvId As Integer,
            donorDsnId As Integer) As Task(Of DonorDetails)

            'For DLA source the ID is stored in both RegId and DmvId.
            If donorRegId = donorDmvId And donorRegId <> 0 Then
                Return Await registryApiClient.GetDlaDonorDetailsAsync(donorRegId).ConfigureAwait(False)
            End If

            'The order of checks for Reg/DMV source is the
            'same as was in the stored procedure (sps_GetRegistryData).
            If donorDmvId <> 0 Then
                Dim dataSourceState = dataSourceLookup.GetDataSource(donorDsnId).GetState()
                Return Await registryApiClient.GetDmvDonorDetailsAsync(dataSourceState, donorDmvId).ConfigureAwait(False)
            End If

            If donorRegId <> 0 Then
                Return Await registryApiClient.GetWebDonorDetailsAsync(donorRegId).ConfigureAwait(False)
            End If

        End Function

        'TODO: Need better method name. I mainly guessed what it does.
        Private Sub NotifyDonorFound(
            formData As QueryDonorRegistryFormData,
            found As String,
            ByRef donorFoundFlag As Boolean)
            If AppMain.pvregchoice = "" Then
                If formData.FormName = "FrmReferral" Then
                    donorFoundFlag = True
                    'Populate & select cboRegistryStatus after all search results are known
                End If
                If formData.FormName = "FrmReferralView" Then
                    formData.DonorFoundCallback?.Invoke(found)
                End If
            End If

        End Sub

        Friend Async Function CheckRegistryApiAsync(
            formData As QueryDonorRegistryFormData) As Task(Of IEnumerable(Of CheckRegistryResult))

            With formData

                Dim donorFirstName = .DonorFirstName.Trim()
                Dim donorLastName = .DonorLastName.Trim()
                Dim dateOfBirth = Date.Parse(.DOB)

                Dim searchResults = Await SearchRegistryApiAsync(
                    donorFirstName,
                    donorLastName,
                    dateOfBirth).ConfigureAwait(False)

                'Here we resemble how parameters were
                'passed to the stored procedure. The method 
                'being called converts Registry API search results 
                'to aggregated results expected by 
                'Query method.

                'The Locator basically contains donor record ID (SourceID)
                'and is used as a sign that the donor was previously searched and
                'a particular one was chosen. In this case this search is
                'essentially used to fetch details about that chosen donor.
                'The Found property contains the Source Type (State, Web, DLA) 
                'For the chosen donor.
                If .Locator <> "" Then
                    Return SimulateCheckRegistryResults(searchResults, .Found, .Locator)
                Else
                    Return SimulateCheckRegistryResults(searchResults)
                End If

            End With
        End Function

        'The goal of this method is to make results obtained from
        'Registry API look like results which were previously
        'returned by a stored procedure (which was [sps_CheckRegistryv2]).
        'Theoretically, Registry API search results can be analyzed
        'directly by a much shorter and simpler code. However,
        'there is so much conditional logic which I don't 
        'fully understand that I prefer to retain compatibility
        'to not break something. Therefore, this (and deeper) code
        'is a "reflection" of corresponding stored procedures.
        'Once this code is proved to be working correctly, it
        'can (and should) be gradually refactored.
        Private Iterator Function SimulateCheckRegistryResults(
            searchResults As IEnumerable(Of SearchResult),
            Optional found As String = Nothing,
            Optional locator As String = Nothing) As IEnumerable(Of CheckRegistryResult)

            Dim regDmvSearchResults =
                From sr In searchResults
                Order By sr.DonorDate Descending
                Where Not String.Equals(sr.SourceName, RegistryNames.Dla, StringComparison.OrdinalIgnoreCase) AndAlso
                    (sr.SourceID = locator OrElse String.IsNullOrEmpty(locator))
                Group By sr.SourceOwnerState Into StateResults = Group

            'For each OWNER state (which resembles iterating over databases).
            For Each stateGroup In regDmvSearchResults
                Yield SimulateCheckRegistryRegDmvResults(stateGroup.StateResults, found)
            Next

            Dim dlaSearchResults =
                From sr In searchResults
                Where String.Equals(sr.SourceName, RegistryNames.Dla, StringComparison.OrdinalIgnoreCase) AndAlso
                    (sr.SourceID = locator OrElse String.IsNullOrEmpty(locator))

            'For DLA
            Yield SimulateCheckRegistryDlaResults(dlaSearchResults, found)

        End Function

        Private Function SimulateCheckRegistryRegDmvResults(
            searchResults As IEnumerable(Of SearchResult),
            found As String) As CheckRegistryResult

            Dim regSingleResult As SearchResult = Nothing

            If found = "Web" OrElse String.IsNullOrEmpty(found) Then
                Dim regResults =
                    (From sr In searchResults
                     Where sr.SourceName = RegistryNames.Web).ToArray()

                If regResults.Length > 1 Then
                    Return New CheckRegistryResult With
                    {
                        .Source = "Registration Undetermined",
                        .DonorConfirmed = DonorConfimed.Undetermined
                    }
                Else
                    regSingleResult = regResults.SingleOrDefault()
                End If

            End If


            Dim dmvSingleResult As SearchResult = Nothing

            If found = "State" OrElse String.IsNullOrEmpty(found) Then
                Dim dmvResults =
                    (From sr In searchResults
                     Where sr.SourceName = RegistryNames.Dmv).ToArray()

                If dmvResults.Length > 1 Then
                    Return New CheckRegistryResult With
                    {
                        .Source = "Registration Undetermined",
                        .DonorConfirmed = DonorConfimed.Undetermined
                    }
                Else
                    dmvSingleResult = dmvResults.SingleOrDefault()
                End If

            End If

            'No values were found in both sources.
            If regSingleResult Is Nothing And
               dmvSingleResult Is Nothing Then
                Return New CheckRegistryResult With
                {
                    .Source = "No Registration",
                    .DonorConfirmed = DonorConfimed.No
                }
            End If

            Dim singleResult As SearchResult = Nothing

            If regSingleResult Is Nothing Or
               dmvSingleResult Is Nothing Then

                singleResult = If(regSingleResult, dmvSingleResult)

            Else  'Results in both Reg and DMV found.
                Dim regDate = regSingleResult.DonorDate
                Dim dmvDate = dmvSingleResult.DonorDate

                'NOTE: Dates are nullable, so if it happens that at least 
                'one of the dates is Nothing, no one will be 
                'greater Or less than another.
                If regDate > dmvDate Then
                    singleResult = regSingleResult
                ElseIf dmvDate > regDate Then
                    singleResult = dmvSingleResult
                Else 'Equal dates OR one or both are Nothing.
                    If regSingleResult.DonorConfirmed And
                       dmvSingleResult.DonorConfirmed Then
                        'TODO: Check why we might have Nothing here.
                        singleResult = If(regSingleResult.SourceID Is Nothing, dmvSingleResult, regSingleResult)
                    End If
                End If
            End If

            If singleResult IsNot Nothing Then

                Dim restrictionId = 0 'Default ID value.

                If singleResult Is dmvSingleResult And
                   regSingleResult IsNot Nothing AndAlso
                   regSingleResult.DonorConfirmed AndAlso
                   regSingleResult.SourceID IsNot Nothing Then 'TODO: Check why we might have Nothing here.
                    restrictionId = ParseSourceID(regSingleResult.SourceID)
                End If

                Return New CheckRegistryResult With
                {
                    .Source = If(singleResult Is regSingleResult, RegistryNames.Web, RegistryNames.Dmv),
                    .SourceOwnerState = singleResult.SourceOwnerState,
                    .Id = ParseSourceID(singleResult.SourceID),
                    .DonorConfirmed = ConvertDonorConfirmed(singleResult.DonorConfirmed),
                    .RestrictionId = restrictionId
                }
            End If

            Return New CheckRegistryResult With
            {
                .Source = "Undetermined Registration",
                .DonorConfirmed = DonorConfimed.No
            }

        End Function

        Private Function SimulateCheckRegistryDlaResults(
            searchResults As IEnumerable(Of SearchResult),
            found As String) As CheckRegistryResult

            found = If(String.IsNullOrEmpty(found), "DLA", found)

            Dim dlaSingleResult As SearchResult = Nothing

            If found = "DLA" Then
                'TODO: Ensure it's OK to take just the first item.
                dlaSingleResult = searchResults.FirstOrDefault()
            End If

            If dlaSingleResult Is Nothing Then
                Return New CheckRegistryResult With
                {
                    .Source = "No Registration",
                    .DonorConfirmed = DonorConfimed.No
                }
            End If

            Dim dlaId = ParseSourceID(dlaSingleResult.SourceID)
            Dim dlaDonorConfirmed = dlaSingleResult.DonorConfirmed

            Return New CheckRegistryResult With
            {
                .Source = RegistryNames.Dla,
                .Id = dlaId,
                .DonorConfirmed = ConvertDonorConfirmed(dlaDonorConfirmed),
                .RestrictionId = If(dlaDonorConfirmed, dlaId, 0)
            }

        End Function

        Private Function ParseSourceID(sourceId As String) As Integer
            Return System.Convert.ToInt32(sourceId, CultureInfo.InvariantCulture)
        End Function

        Private Function ConvertDonorConfirmed(donorConfirmed As Boolean) As DonorConfimed
            Return If(donorConfirmed, DonorConfimed.Yes, DonorConfimed.No)
        End Function

        Private Async Function SearchRegistryApiAsync(
            donorFirstName As String,
            donorLastName As String,
            dateOfBirth As DateTime?) As Task(Of SearchResult())

            Dim results As SearchResult()

            Try
                'Return Await donorSearch.SearchRegistryAsync(
                '    New DonorSearchRequest(
                '        donorFirstName,
                '        donorLastName,
                '        dateOfBirth)).ConfigureAwait(False)
                Return Array.Empty(Of SearchResult)()

            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
                Throw
            End Try

        End Function

    End Class
End Module
