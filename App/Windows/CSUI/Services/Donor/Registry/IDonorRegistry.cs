using Stattrac.Services.Donor.Registry.Model;
using System.Threading.Tasks;

namespace Stattrac.Services.Donor.Registry
{
    public interface IDonorRegistry
    {
        Task<DonorSearchResult[]> SearchDonorsAsync(
            DonorSearchRequest searchrequest, 
            DonorSearchConfiguration config);

        Task<DonorDetails?> GetDonorDetailsAsync(
            DonorRegistryType registryType, 
            string? registryOwnerState, 
            int donorId);
    }
}
