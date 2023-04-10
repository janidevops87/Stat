using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.Referrals;
using Statline.StatTrac.App.ReferralProcessor;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/referrals/processor")]
[Authorize(AuthorizationPolicies.ReferralProcessorApiPolicy)]
[ApiController]
// Hide this api from swagger docs, its for internal usage only.
[ApiExplorerSettings(IgnoreApi = true)]
public class ReferralProcessorController : ControllerBase
{
    private readonly ReferralProcessorApplication processUpdatedReferralsApp;

    public ReferralProcessorController(
        ReferralProcessorApplication processUpdatedReferralsApp)
    {
        Check.NotNull(processUpdatedReferralsApp, nameof(processUpdatedReferralsApp));
        this.processUpdatedReferralsApp = processUpdatedReferralsApp;
    }

    [HttpPost]
    public async Task<ActionResult<ReferralProcessingResultViewModel>> ProcessUpdatedReferral(
        UpdatedReferralViewModel updatedReferralViewModel)
    {
        var webReportGroupId = new WebReportGroupId(
            updatedReferralViewModel.WebReportGroupId);

        var referralId = new ReferralId(
            updatedReferralViewModel.ReferralId);

        // For this case WRGID comes not from the access token,
        // but from the request payload. Since we use 
        // HttpContext-based WRGID accessor, we need to
        // inject received WRGID into the context (user claims).
        User.SetWebReportGroupId(webReportGroupId);

        ReferralProcessingResult processingResult=
            await processUpdatedReferralsApp.ProcessUpdatedReferralAsync(referralId);
       
        return Ok(
            new ReferralProcessingResultViewModel(processingResult.ProcessingStatus));
    }
}
