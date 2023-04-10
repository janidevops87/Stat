using System;
using System.Collections.Generic;
using System.Linq;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;

namespace Statline.IdentityServer.Common.TenantIdAccessor
{
    /// <summary>
    /// Uses run-time tenant id accessor for regular application mode,
    /// and fall-backs to design-time accessor if app is run in design time.
    /// </summary>
    /// <remarks>
    /// Yes, implementation of the <see cref="ITenantIdAccessor"/> for run-time 
    /// could just do the same or simpler check,
    /// returning fall-back tenant id value if its not available. But I don't
    /// want to hard code such case into the implementation, since then we won't
    /// be able to configure its behavior from outside [of the implementation]. 
    /// Its better for the implementation to fail if its not able to do its job, 
    /// and the outer code to decide how to handle or work around this.
    /// </remarks>
    public class WithDesignTimeFallbackTenantIdAccessor : ITenantIdAccessor
    {
        private readonly ITenantIdAccessor runTimeTenantIdAccessor;
        private readonly ITenantIdAccessor designTimeTenantIdAccessor;
        private readonly IDesignTimeDetector designTimeDetector;

        public WithDesignTimeFallbackTenantIdAccessor(
            IEnumerable<ITenantIdAccessor> tenantIdAccessors,
            IDesignTimeDetector designTimeDetector)
        {
            Check.HasNoNulls(tenantIdAccessors, nameof(tenantIdAccessors));

            var tenantIdAccessorsArray = tenantIdAccessors.ToArray();

            Check.BiggerOrEqual(
                value: tenantIdAccessorsArray.Length,
                other: 2,
                // Not real name, but just to be informative.
                nameof(tenantIdAccessors) + ".Count()");

            Check.NotNull(designTimeDetector, nameof(designTimeDetector));

            this.runTimeTenantIdAccessor = tenantIdAccessorsArray[0];
            this.designTimeTenantIdAccessor = tenantIdAccessorsArray[1];
            this.designTimeDetector = designTimeDetector;

            // This is obviously an error in the client code.
            if (runTimeTenantIdAccessor == designTimeTenantIdAccessor)
            {
                throw new ArgumentException(
                    "Run time and design time tenant id accessors are the same.");
            }
        }

        public TenantId GetTenantId()
        {
            if (designTimeDetector.IsDesignTime)
            {
                return designTimeTenantIdAccessor.GetTenantId();
            }
            else
            {
                return runTimeTenantIdAccessor.GetTenantId();
            }
        }
    }
}
