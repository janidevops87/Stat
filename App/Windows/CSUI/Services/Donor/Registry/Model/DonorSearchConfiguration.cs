using System.Collections.Generic;
using Statline.Common.Utilities;

namespace Stattrac.Services.Donor.Registry.Model
{
    public class DonorSearchConfiguration
    {
        public bool IncludeDlaDonors { get; private set; }
        public IEnumerable<string> States { get; private set; }
        public IEnumerable<int> RegistryOwnerIds { get; private set; }

        public DonorSearchConfiguration(
            bool includeDlaDonors, 
            IEnumerable<string> states, 
            IEnumerable<int> registryOwnerIds)
        {
            IncludeDlaDonors = includeDlaDonors;
            States = Check.NotNull(states, nameof(states));
            RegistryOwnerIds = Check.NotNull(registryOwnerIds, nameof(registryOwnerIds));
        }
    }
}