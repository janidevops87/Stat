using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage.Local;

public class LocalFileStorageOptions
{
    [Required]
    public string BaseFolderPath { get; set; } = default!;
}
