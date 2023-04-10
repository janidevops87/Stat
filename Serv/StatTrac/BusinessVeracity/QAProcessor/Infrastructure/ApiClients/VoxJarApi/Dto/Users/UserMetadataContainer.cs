namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;

#pragma warning disable IDE1006 // Naming Styles

public class UserMetadataContainer
{
    public string id { get; set; } = default!;
    public string[] companyIds { get; set; } = default!;
}
