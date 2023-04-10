using Microsoft.AspNetCore.Http;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Api.Common;

public class HttpContextWebReportGroupIdAccessor :
    IWebReportGroupIdAccessor
{
    private readonly IHttpContextAccessor httpContextAccessor;

    public HttpContextWebReportGroupIdAccessor(
        IHttpContextAccessor httpContextAccessor)
    {
        Check.NotNull(httpContextAccessor, nameof(httpContextAccessor));
        this.httpContextAccessor = httpContextAccessor;
    }

    public WebReportGroupId? GetWebReportGroupId()
    {
        var httpContext = httpContextAccessor.HttpContext;

        string? id = httpContext?.User.GetWebReportGroupId();

        if (string.IsNullOrEmpty(id))
        {
            // TODO: This should probably
            // throw an exception instead of returning null.
            return null;
        }

        return WebReportGroupId.Parse(id);
    }
}
