Namespace UIServices.Donor.Search
    ''' <summary>
    ''' Represents the status of donor registry search
    ''' at particular step.
    ''' </summary>
    Public Enum DonorRegistrySearchStatus As Short
        ''' <summary>
        ''' The donor registry was either not checked or
        ''' an error happened during check.
        ''' </summary>
        NotChecked

        ''' <summary>
        ''' Couldn't find donor information in all types of donor registry.
        ''' </summary>
        NotFound

        ''' <summary>
        ''' Found single donor or the donor was chosen from 
        ''' multiple by the user.
        ''' </summary>
        FoundSingle

        ''' <summary>
        ''' Multiple donors were found in donor registry, and user
        ''' needs to select one of them.
        ''' </summary>
        FoundMultiple
    End Enum

End Namespace