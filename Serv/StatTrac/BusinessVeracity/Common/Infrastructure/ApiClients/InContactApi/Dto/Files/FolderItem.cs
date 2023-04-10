namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Files;
#pragma warning disable IDE1006 // Naming Styles

public class FolderItem
{
    public string fileName { get; set; } = default!;
    public string fileNameWithPath { get; set; } = default!;
    public bool isFolder { get; set; }
}
