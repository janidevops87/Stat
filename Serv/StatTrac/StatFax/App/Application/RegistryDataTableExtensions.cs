using Statline.Registry.Api.Client;
using System.Globalization;
using static Statline.StatTrac.Data.Types.StatFaxData;

namespace Statline.StatTrac.StatFax.Application
{
    internal static class RegistryDataTableExtensions
    {
        public static RegistryDataRow AddRegistryDataRowFromDonorDetails(
            this RegistryDataDataTable registryDataDataTable,
            DonorDetails donorDetails)
        {
            return registryDataDataTable.AddRegistryDataRow(
                donorDetails.RegistryId,
                donorDetails.Name.FirstName,
                donorDetails.Name.MiddleName,
                donorDetails.Name.LastName,
                donorDetails.Name.Suffix,
                donorDetails.Gender,
                donorDetails.DateOfBirth?.ToString(CultureInfo.InvariantCulture),
                Limitations: null,
                LimitationsOther: null,
                donorDetails.License,
                Email: null,
                donorDetails.DonorConfirmed ? (short)1 : (short)0,
                Donor: donorDetails.OnRegistry ? "Y" : "N",
                donorDetails.FlagDate.Value, // TODO: Will it always have value?
                donorDetails.Restriction,
                donorDetails.Address.Address1,
                donorDetails.Address.Address2,
                donorDetails.Address.City,
                donorDetails.Address.State,
                donorDetails.Address.Zip,
                donorDetails.Address.AddressType,
                DonorYear: "",
                Source: donorDetails.RegistryName);
        }
    }
}
