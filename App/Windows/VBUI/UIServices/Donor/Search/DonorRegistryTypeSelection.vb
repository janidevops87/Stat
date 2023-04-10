Namespace UIServices.Donor.Search

    ''' <summary>
    ''' Represents types of donor registry where a donor was found.
    ''' </summary>
    ''' <remarks>
    ''' This enum is different compared to 
    ''' <see cref="Stattrac.Services.Donor.Registry.Model.DonorRegistryType"/>.
    ''' The former has different numerical values and represents the registry
    ''' type of *selected* donor, and is saved to DB along with referral. 
    ''' The latter represents donor registry type where particular search result originates from.
    ''' </remarks>
    'Other than listed values look to be not used in code and in the DB.
    Public Enum DonorRegistryTypeSelection As Short
        ''' <summary>
        ''' This type is used when donor wasn't found in any registry or
        ''' wasn't searched.
        ''' </summary>
        Unknown = 0

        ''' <summary>
        ''' Donor was found in Web (or Registry) registry.
        ''' </summary>
        WebRegistry = 1

        ''' <summary>
        ''' Donor was found in State (or DMV) registry.
        ''' </summary>
        StateRegistry = 2

        ''' <summary>
        ''' Donor was found in DLA registry.
        ''' </summary>
        DlaRegistry = 6
    End Enum

End Namespace