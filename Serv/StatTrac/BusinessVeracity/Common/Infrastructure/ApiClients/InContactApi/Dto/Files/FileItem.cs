namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Files;
#pragma warning disable IDE1006 // Naming Styles

public class FileItem
{
    // The file body encoded in a Base64 format.
    public string file { get; set; } = default!;
    public string fileName { get; set; } = default!;

    // This property is not really returned in response,
    // but is assigned by the client code. I added it for convenience.
    public string fileNameWithPath { get; set; } = default!;
}
