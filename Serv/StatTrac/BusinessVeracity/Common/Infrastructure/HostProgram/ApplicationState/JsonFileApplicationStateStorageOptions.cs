using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

internal class JsonFileApplicationStateStorageOptions
{
    [Required]
    public string BaseFolderPath { get; set; } = default!;
}
