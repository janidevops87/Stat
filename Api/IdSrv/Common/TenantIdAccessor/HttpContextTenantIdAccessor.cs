using System;
using Microsoft.AspNetCore.Http;
using Statline.Common.Utilities;
using Statline.IdentityServer.Common.Security;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;

namespace Statline.IdentityServer.Common.TenantIdAccessor
{
    public class HttpContextTenantIdAccessor :
        ITenantIdAccessor
    {
        private readonly IHttpContextAccessor httpContextAccessor;

        public HttpContextTenantIdAccessor(
            IHttpContextAccessor httpContextAccessor)
        {
            Check.NotNull(httpContextAccessor, nameof(httpContextAccessor));
            this.httpContextAccessor = httpContextAccessor;
        }

        public TenantId GetTenantId()
        {
            var httpContext = httpContextAccessor.HttpContext;

            if (httpContext == null)
            {
                throw new InvalidOperationException("HttpContext is not present.");
            }

            if (!httpContext.User.Identity.IsAuthenticated)
            {
                throw new InvalidOperationException("The user is not authenticated.");
            }

            return httpContext.User.GetTenantId();
        }
    }
}
