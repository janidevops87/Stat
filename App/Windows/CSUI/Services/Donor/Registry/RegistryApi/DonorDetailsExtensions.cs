using Statline.Common.Utilities;
using Statline.Registry.Api.Client;

namespace Stattrac.Services.Donor.Registry.RegistryApi
{
    internal static class DonorDetailsExtensions
    {
        public static Model.DonorDetails ToModelDonorDetails(
            this DonorDetails donorDetails)
        {
            Check.NotNull(donorDetails, nameof(donorDetails));

            return new Model.DonorDetails(
                CommonConverter.ParseId(donorDetails.Id),
                donorDetails.RegistryId,
                CommonConverter.RegistryNameToRegistryType(donorDetails.RegistryName),
                new Model.DonorPerson(
                    new Model.DonorName(
                        donorDetails.Name.FirstName,
                        donorDetails.Name.MiddleName,
                        donorDetails.Name.LastName),
                    new Model.DonorAddress(
                        address1: donorDetails.Address.Address1,
                        address2: null,
                        donorDetails.Address.City,
                        donorDetails.Address.State,
                        donorDetails.Address.Zip),
                    donorDetails.DateOfBirth,
                    sid: null,
                    ssn: null),
                donorDetails.OnRegistry,
                donorDetails.FlagDate,
                donorDetails.Restriction);
        }
    }
}
