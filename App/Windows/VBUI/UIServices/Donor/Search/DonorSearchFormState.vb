Imports Statline.Common.Utilities

Namespace UIServices.Donor.Search
    Public Class DonorSearchFormState

        Public Shared ReadOnly NotChecked As DonorSearchFormState =
            CreateForUnknownRegistryType(DonorRegistrySearchStatus.NotChecked)

        Public Shared ReadOnly NotFound As DonorSearchFormState =
            CreateForUnknownRegistryType(DonorRegistrySearchStatus.NotFound)

        Public Shared ReadOnly FoundMultiple As DonorSearchFormState =
            CreateForUnknownRegistryType(DonorRegistrySearchStatus.FoundMultiple)

        Public ReadOnly Property DonorRegistrySearchStatus As DonorRegistrySearchStatus
        Public ReadOnly Property DonorRegistryTypeSelection As DonorRegistryTypeSelection
        Public ReadOnly Property DonorRegId As Integer
        Public ReadOnly Property DonorDMVId As Integer
        Public ReadOnly Property DonorDSNID As Short

        Public ReadOnly Property HasDonor() As Boolean
            Get
                Return DonorRegistryTypeSelection <> DonorRegistryTypeSelection.Unknown
            End Get
        End Property

        Public ReadOnly Property WasSearched() As Boolean
            Get
                Return DonorRegistrySearchStatus <> DonorRegistrySearchStatus.NotChecked
            End Get
        End Property

        Public ReadOnly Property HasWebRegistryDonor() As Boolean
            Get
                Return DonorRegistryTypeSelection = DonorRegistryTypeSelection.WebRegistry
            End Get
        End Property

        Public ReadOnly Property HasStateRegistryDonor() As Boolean
            Get
                Return DonorRegistryTypeSelection = DonorRegistryTypeSelection.StateRegistry
            End Get
        End Property

        Public ReadOnly Property HasDlaRegistryDonor() As Boolean
            Get
                Return DonorRegistryTypeSelection = DonorRegistryTypeSelection.DlaRegistry
            End Get
        End Property

        Public Sub New(
            donorRegistrySearchStatus As DonorRegistrySearchStatus,
            donorRegistryTypeSelection As DonorRegistryTypeSelection,
            donorRegId As Integer,
            donorDmvId As Integer,
            donorDsnId As Short)

            ValidateSearchStatusWithRegistryType(donorRegistrySearchStatus, donorRegistryTypeSelection)
            ValidateRegistryTypeWithIds(donorRegistryTypeSelection, donorRegId, donorDmvId, donorDsnId)

            Me.DonorRegistrySearchStatus = donorRegistrySearchStatus
            Me.DonorRegistryTypeSelection = donorRegistryTypeSelection
            Me.DonorRegId = donorRegId
            Me.DonorDMVId = donorDmvId
            Me.DonorDSNID = donorDsnId
        End Sub

        Public Shared Function CreateFoundInWebRegistry(donorId As Integer, dataSourceId As Integer) As DonorSearchFormState
            Return New DonorSearchFormState(
                        donorRegistrySearchStatus:=DonorRegistrySearchStatus.FoundSingle,
                        donorRegistryTypeSelection:=DonorRegistryTypeSelection.WebRegistry,
                        donorRegId:=donorId,
                        donorDmvId:=0,
                        donorDsnId:=dataSourceId)
        End Function

        Public Shared Function CreateFoundInStateRegistry(donorId As Integer, dataSourceId As Integer) As DonorSearchFormState
            Return New DonorSearchFormState(
                        donorRegistrySearchStatus:=DonorRegistrySearchStatus.FoundSingle,
                        donorRegistryTypeSelection:=DonorRegistryTypeSelection.StateRegistry,
                        donorRegId:=0,
                        donorDmvId:=donorId,
                        donorDsnId:=dataSourceId)
        End Function

        Public Shared Function CreateFoundInDlaRegistry(donorId As Integer, dataSourceId As Integer) As DonorSearchFormState
            'It's weird, but the sign of DLA source registry is
            'equal Reg ID and DMV ID.
            Return New DonorSearchFormState(
                        donorRegistrySearchStatus:=DonorRegistrySearchStatus.FoundSingle,
                        donorRegistryTypeSelection:=DonorRegistryTypeSelection.DlaRegistry,
                        donorRegId:=donorId,
                        donorDmvId:=donorId,
                        donorDsnId:=dataSourceId)
        End Function

        Public Shared Function CreateFromPersistedState(
            donorRegistryTypeSelection As DonorRegistryTypeSelection,
            donorRegId As Integer,
            donorDmvId As Integer,
            donorDsnId As Short) As DonorSearchFormState

            If donorRegistryTypeSelection = DonorRegistryTypeSelection.Unknown Then
                'TODO: Not sure which search status is the best when creating from 
                'persisted state. Leaving NotFound, as NotSearched may result in enabling
                'some search-related UI.
                Return CreateForUnknownRegistryType(DonorRegistrySearchStatus.NotFound)
            Else
                Return New DonorSearchFormState(
                    DonorRegistrySearchStatus.FoundSingle,
                    donorRegistryTypeSelection,
                    donorRegId,
                    donorDmvId,
                    donorDsnId)
            End If

        End Function


        Private Shared Function CreateForUnknownRegistryType(
            donorRegistrySearchStatus As DonorRegistrySearchStatus) As DonorSearchFormState
            Return New DonorSearchFormState(
                            donorRegistrySearchStatus,
                            donorRegistryTypeSelection:=DonorRegistryTypeSelection.Unknown,
                            donorRegId:=0,
                            donorDmvId:=0,
                            donorDsnId:=0)
        End Function

        Private Shared Sub ValidateRegistryTypeWithIds(
            donorRegistryTypeSelection As DonorRegistryTypeSelection,
            donorRegId As Integer,
            donorDmvId As Integer,
            donorDsnId As Short)

            Select Case donorRegistryTypeSelection
                Case DonorRegistryTypeSelection.Unknown
                    Check.Equal(donorDsnId, 0, NameOf(donorDsnId))
                    Check.Equal(donorRegId, 0, NameOf(donorRegId))
                    Check.Equal(donorDmvId, 0, NameOf(donorDmvId))
                Case DonorRegistryTypeSelection.WebRegistry
                    Check.Bigger(donorDsnId, 0, NameOf(donorDsnId))
                    Check.Bigger(donorRegId, 0, NameOf(donorRegId))
                    Check.Equal(donorDmvId, 0, NameOf(donorDmvId))
                Case DonorRegistryTypeSelection.StateRegistry
                    Check.Bigger(donorDsnId, 0, NameOf(donorDsnId))
                    Check.Bigger(donorDmvId, 0, NameOf(donorDmvId))
                    Check.Equal(donorRegId, 0, NameOf(donorRegId))
                Case DonorRegistryTypeSelection.DlaRegistry
                    Check.Bigger(donorDsnId, 0, NameOf(donorDsnId))
                    Check.Bigger(donorRegId, 0, NameOf(donorRegId))
                    Check.Equal(donorDmvId, donorRegId, NameOf(donorDmvId))
                Case Else
                    Throw New ArgumentOutOfRangeException(
                        "Unknown registry type selection",
                        NameOf(donorRegistryTypeSelection))
            End Select
        End Sub

        Private Shared Sub ValidateSearchStatusWithRegistryType(
            donorRegistrySearchStatus As DonorRegistrySearchStatus,
            donorRegistryTypeSelection As DonorRegistryTypeSelection)

            Select Case donorRegistrySearchStatus
                Case DonorRegistrySearchStatus.NotChecked,
                     DonorRegistrySearchStatus.NotFound,
                     DonorRegistrySearchStatus.FoundMultiple
                    Check.Equal(Of Integer)(
                        donorRegistryTypeSelection,
                        DonorRegistryTypeSelection.Unknown,
                        NameOf(donorRegistryTypeSelection))
                Case DonorRegistrySearchStatus.FoundSingle
                    Check.NotEqual(Of Integer)(
                        donorRegistryTypeSelection,
                        DonorRegistryTypeSelection.Unknown,
                        NameOf(donorRegistryTypeSelection))
                Case Else
                    Throw New ArgumentOutOfRangeException(
                        "Unknown registry search status",
                        NameOf(donorRegistrySearchStatus))
            End Select

        End Sub
    End Class
End Namespace
