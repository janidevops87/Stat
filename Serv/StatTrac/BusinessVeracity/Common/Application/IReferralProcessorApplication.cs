
namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public interface IReferralProcessorApplication
{
    Task RunAsync(ApplicationRunContext runContext);
}