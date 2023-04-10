using Statline.Common.Utilities;
using Statline.Registry.Api.Client;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Collections.Generic;

namespace Stattrac.Services.Donor.Registry.RegistryApi
{
    internal static class DonorSearchRequestExtensions
    {
        public static SearchRequest ToSearchRequest(
            this DonorSearchRequest donorSearchRequest,
            DonorSearchConfiguration searchConfiguration)
        {
            Check.NotNull(donorSearchRequest, nameof(donorSearchRequest));
            
            var request = SearchRequest.GetDefaultSearchRequest();

            request.FirstName = donorSearchRequest.DonorFirstName;
            request.LastName = donorSearchRequest.DonorLastName;
            request.DOB = donorSearchRequest.DateOfBirth;
            request.DisplayDLADonors = searchConfiguration.IncludeDlaDonors;
            request.StateSelection.Add(searchConfiguration.States);
            request.RegistryOwnerIds.Add(searchConfiguration.RegistryOwnerIds);

            return request;
        }
    }
}
