using Microsoft.AspNetCore.Http; // For docs.
using Microsoft.EntityFrameworkCore; // For docs.

namespace Statline.IdentityServer.Common
{
    /// <summary>
    /// Provides information whether an application
    /// is being used under a design-time tool like migrations. 
    /// </summary>
    /// <remarks>
    /// Unfortunately, neither runtime nor Entity Framework don't provide
    /// any API to detect "design mode". But this is a needed feature,
    /// because, for example, a <see cref="DbContext"/> may require some dependencies
    /// which may not work in such mode. For example, if a dependency
    /// needs to access an <see cref="HttpContext"/>, that one will
    /// only be present if <see cref="DbContext"/> is used in a context
    /// of an HTTP request.
    /// 
    /// An implementation should be just injected with DI to a 
    /// class which requires that information.
    /// </remarks>
    public interface IDesignTimeDetector
    {
        bool IsDesignTime { get; }
    }
}
