using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using System.Globalization;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

internal static class AgentExtensions
{
    public static string GetIdForMetadata(this Agent agent)
    {
        return string.IsNullOrEmpty(agent.EmailAddress) ?
            agent.AgentId.ToString(CultureInfo.InvariantCulture) :
            agent.EmailAddress;
    }
}
