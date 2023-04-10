using Statline.Common.Utilities;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Text;

namespace Stattrac.Services.Donor
{
    public class DonorServiceConfiguration
    {
        public DonorSearchConfiguration Search { get; }
        public DmvStateMappingConfiguration DmvStateMapping { get; }

        public DonorServiceConfiguration(
            DonorSearchConfiguration searchConfig, 
            DmvStateMappingConfiguration dmvStateMappingConfig)
        {
            Check.NotNull(searchConfig, nameof(searchConfig));
            Check.NotNull(dmvStateMappingConfig, nameof(dmvStateMappingConfig));
            Search = searchConfig;
            DmvStateMapping = dmvStateMappingConfig;
        }
    }
}
