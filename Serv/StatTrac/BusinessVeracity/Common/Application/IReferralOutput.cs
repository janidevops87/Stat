namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public interface IReferralOutput<TReferral>
{
    Task PublishAsync(IAsyncEnumerable<TReferral> referrals, ApplicationRunContext runContext);
}
