using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Text;

namespace Stattrac.Services.Donor
{
    public class DmvStateMappingConfiguration
    {
        private readonly IImmutableDictionary<short, string> dsnIdToStateMap;

        public DmvStateMappingConfiguration(IImmutableDictionary<short, string> dsnIdToStateMap)
        {
            Check.NotNull(dsnIdToStateMap, nameof(dsnIdToStateMap));
            this.dsnIdToStateMap = dsnIdToStateMap;
        }

        public string GetStateForDsnId(short dsnId)
        {
            if(!dsnIdToStateMap.TryGetValue(dsnId, out var state))
            {
                throw new ArgumentException($"Can't find state mapping for DSN ID {dsnId}");
            }

            return state;
        }
    }
}
