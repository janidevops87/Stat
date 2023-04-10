using Stattrac.Services.Donor.Registry.Model;
using System.Threading.Tasks;

namespace Stattrac.Services.Donor
{
    public interface IDonorServiceConfigurationProvider
    {
        Task<DonorServiceConfiguration> GetConfigurationAsync();
    }
}
