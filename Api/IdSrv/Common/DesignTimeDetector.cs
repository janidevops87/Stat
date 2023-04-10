using Microsoft.AspNetCore.Http;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.IdentityServer.Common
{
    /// <summary>
    /// A trivial design time detector.
    /// </summary>
    /// <remarks>
    /// Design time means app being launched by tools like EF migrations. 
    /// We suppose that we're NOT in design time if code is called in a 
    /// context of an HTTP request, which works for our web app case, but 
    /// may not work in other cases (like console app).
    /// </remarks>
    public class DesignTimeDetector : IDesignTimeDetector
    {
        private readonly IHttpContextAccessor httpContextAccessor;

        public DesignTimeDetector(IHttpContextAccessor httpContextAccessor)
        {
            Check.NotNull(httpContextAccessor, nameof(httpContextAccessor));
            this.httpContextAccessor = httpContextAccessor;
        }

        public bool IsDesignTime => httpContextAccessor.HttpContext == null;
    }
}
