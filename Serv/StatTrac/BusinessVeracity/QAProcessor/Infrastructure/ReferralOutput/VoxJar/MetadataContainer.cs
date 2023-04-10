using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

internal record struct MetadataContainer(
    CallMetadataContainer[] Calls,
    UserMetadataContainer[] Users,
    int ReferralId,
    int CallId)
{
    public static implicit operator (CallMetadataContainer[] CallMetadata, UserMetadataContainer[] Users, int ReferralId, int CallId)(MetadataContainer value)
    {
        return (value.Calls, value.Users, value.ReferralId, value.CallId);
    }

    public static implicit operator MetadataContainer((CallMetadataContainer[] CallMetadata, UserMetadataContainer[] Users, int ReferralId, int CallId) value)
    {
        return new MetadataContainer(value.CallMetadata, value.Users, value.ReferralId, value.CallId);
    }
}