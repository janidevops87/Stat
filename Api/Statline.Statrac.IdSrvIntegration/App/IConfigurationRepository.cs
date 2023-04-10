using System.Threading.Tasks;

namespace Statline.Statrac.IdentityServerIntegration.App
{
    public interface IConfigurationRepository
    {
        Task<int?> AddConfiguration(int webReportGroupId);
    }
}
